import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/services/preferences_service.dart';
import 'package:jobdeeo/src/features/job_board/repositories/job_repositories.dart';
import '../../models/job_model.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepositories jobRepository;

  JobBloc(this.jobRepository) : super(JobInitial()) {
    on<LoadRecommendedJobs>(_onLoadRecommendedJobs);
    on<LoadAllJobs>(_onLoadAllJobs);
    on<SearchJobs>(_onSearchJobs);
    on<SortJobsByDate>(_onSortJobsByDate);
    on<LoadJobDetail>(_onLoadJobDetail);
  }

  Future<void> _onLoadRecommendedJobs(
      LoadRecommendedJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      // ดึง job positions จาก preferences
      final jobPositions = await PreferencesService.getJobPositions();
      final keyword = jobPositions.isNotEmpty ? jobPositions.first : null;

      List<JobModel> allJobs = [];

      // ค้นหาด้วย keyword เต็ม
      if (keyword != null && keyword.isNotEmpty) {
        final jobs = await jobRepository.getRecommendedJobs(
          skipRow: 0,
          takeRow: 20,
          keyword: keyword,
        );
        allJobs.addAll(jobs);

        // ถ้าได้น้อยกว่า 10 งาน ให้ค้นหาเพิ่มด้วย 3 ตัวอักษรแรก
        if (allJobs.length < 10 && keyword.length >= 3) {
          final shortKeyword = keyword.substring(0, 3);

          final additionalJobs = await jobRepository.getRecommendedJobs(
            skipRow: 0,
            takeRow: 20,
            keyword: shortKeyword,
          );

          // กรองงานที่ซ้ำออก (เช็คจาก id)
          final existingIds = allJobs.map((job) => job.id).toSet();
          final uniqueAdditionalJobs = additionalJobs
              .where((job) => !existingIds.contains(job.id))
              .toList();

          allJobs.addAll(uniqueAdditionalJobs);
        }
      } else {
        // ถ้าไม่มี keyword ให้ดึงงานแบบสุ่ม
        final jobs = await jobRepository.getRecommendedJobs(
          skipRow: 0,
          takeRow: 20,
        );
        allJobs.addAll(jobs);
      }

      // เพิ่ม AI match score โดยบอกจำนวนงานจากการค้นหาแรก
      final jobsWithScore = _addAiMatchScore(
        allJobs,
        firstSearchCount: keyword != null && keyword.isNotEmpty
            ? allJobs.take(20).where((job) => allJobs.indexOf(job) <
            (allJobs.length < 10 ? allJobs.length : 10)).length
            : 0,
      );

      // แสดงเฉพาะ 10 งานแรก
      final top10Jobs = jobsWithScore.take(10).toList();

      emit(JobLoaded(top10Jobs));
    } catch (e) {
      emit(JobError('Failed to load recommended jobs: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAllJobs(
      LoadAllJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      // ดึง job positions จาก preferences
      final jobPositions = await PreferencesService.getJobPositions();
      final keyword = jobPositions.isNotEmpty ? jobPositions.first : null;

      List<JobModel> allJobs = [];

      // ค้นหาด้วย keyword เต็ม
      if (keyword != null && keyword.isNotEmpty) {
        final jobs = await jobRepository.fetchAllJobs(
          skipRow: 0,
          takeRow: 100,
          keyword: keyword,
        );
        allJobs.addAll(jobs);

        // ถ้าได้น้อยกว่า 100 งาน ให้ค้นหาเพิ่มด้วย 3 ตัวอักษรแรก
        if (allJobs.length < 100 && keyword.length >= 3) {
          final shortKeyword = keyword.substring(0, 3);

          final additionalJobs = await jobRepository.fetchAllJobs(
            skipRow: 0,
            takeRow: 100,
            keyword: shortKeyword,
          );

          // กรองงานที่ซ้ำออก
          final existingIds = allJobs.map((job) => job.id).toSet();
          final uniqueAdditionalJobs = additionalJobs
              .where((job) => !existingIds.contains(job.id))
              .toList();

          allJobs.addAll(uniqueAdditionalJobs);
        }
      } else {
        // ถ้าไม่มี keyword ให้ดึงงานทั้งหมด
        final jobs = await jobRepository.fetchAllJobs(
          skipRow: 0,
          takeRow: 100,
        );
        allJobs.addAll(jobs);
      }

      // เพิ่ม AI match score
      final jobsWithScore = _addAiMatchScore(allJobs);

      emit(JobLoaded(jobsWithScore));
    } catch (e) {
      emit(JobError('Failed to load jobs: ${e.toString()}'));
    }
  }

  // ฟังก์ชันสร้าง AI match score เอง
  List<JobModel> _addAiMatchScore(
      List<JobModel> jobs, {
        int? firstSearchCount,
      }) {
    final random = Random();

    // คำนวณจำนวนงานจากการค้นหาแรก (ถ้าไม่ระบุให้ใช้ 10)
    final primaryJobsCount = firstSearchCount ?? (jobs.length >= 10 ? 10 : jobs.length);

    return jobs.asMap().entries.map((entry) {
      final index = entry.key;
      final job = entry.value;

      double newScore;

      if (index < primaryJobsCount && index < 10) {
        newScore = double.parse((8.0 + random.nextInt(19) * 0.1).toStringAsFixed(1));
      } else if (index < primaryJobsCount && index >= 10) {
        newScore = double.parse((6.0 + random.nextInt(20) * 0.1).toStringAsFixed(1));
      } else {
        newScore = double.parse((5.0 + random.nextInt(9) * 0.1).toStringAsFixed(1));
      }

      // อัพเดท aiSkillMatch score
      return job.copyWith(
        aiSkillMatch: job.aiSkillMatch.copyWith(
          score: newScore,
        ),
      );
    }).toList();
  }

  Future<void> _onSearchJobs(
      SearchJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      final jobs = await jobRepository.searchJobs(
        keyword: event.query,
        skipRow: 0,
        takeRow: 100,
      );

      // เพิ่ม AI match score
      final jobsWithScore = _addAiMatchScore(jobs);

      emit(JobLoaded(jobsWithScore));
    } catch (e) {
      emit(JobError('Failed to search jobs: ${e.toString()}'));
    }
  }

  Future<void> _onSortJobsByDate(
      SortJobsByDate event,
      Emitter<JobState> emit,
      ) async {
    if (state is JobLoaded) {
      final currentJobs = (state as JobLoaded).jobs;

      final sortedJobs = List<JobModel>.from(currentJobs)
        ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

      emit(JobLoaded(sortedJobs));
    }
  }

  Future<void> _onLoadJobDetail(
      LoadJobDetail event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      final job = await jobRepository.fetchJobById(event.jobId);
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobError('Failed to load job detail: ${e.toString()}'));
    }
  }
}