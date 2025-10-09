import 'package:flutter_bloc/flutter_bloc.dart';
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
      // เรียกใช้ getRecommendedJobs แทน fetchAllJobs
      final jobs = await jobRepository.getRecommendedJobs(
        skipRow: 0,
        takeRow: 20, // แสดง 20 งานแนะนำ
      );
      emit(JobLoaded(jobs));
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
      // เรียกงานทั้งหมด
      final jobs = await jobRepository.fetchAllJobs(
        skipRow: 0,
        takeRow: 100, // ดึง 100 งานแรก
      );
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError('Failed to load jobs: ${e.toString()}'));
    }
  }

  Future<void> _onSearchJobs(
      SearchJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      // ใช้ searchJobs จาก repository
      final jobs = await jobRepository.searchJobs(
        keyword: event.query,
        skipRow: 0,
        takeRow: 100,
      );
      emit(JobLoaded(jobs));
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

      // เรียงตามวันที่ล่าสุด (dateCreated)
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
      // เรียก fetchJobById จาก repository
      final job = await jobRepository.fetchJobById(event.jobId);
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobError('Failed to load job detail: ${e.toString()}'));
    }
  }
}