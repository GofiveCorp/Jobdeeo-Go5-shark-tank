import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../matching/models/job_model.dart';
import '../../../matching/repositories/matching_repositories.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final MatchingRepository jobRepository;

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
      // final jobs = await jobRepository.getRecommendedJobs();
      final jobs = await jobRepository.fetchAllJobs();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError('Failed to load recommended jobs'));
    }
  }

  Future<void> _onLoadAllJobs(
      LoadAllJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // final jobs = MockData.getRecommendedJobs();
      final jobs = await jobRepository.fetchAllJobs();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError('Failed to load jobs'));
    }
  }

  Future<void> _onSearchJobs(
      SearchJobs event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // final allJobs = MockData.getRecommendedJobs();
      final allJobs = await jobRepository.fetchAllJobs();
      final filteredJobs = allJobs
          .where((job) =>
      job.title.toLowerCase().contains(event.query.toLowerCase()) ||
          job.company.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(JobLoaded(filteredJobs));
    } catch (e) {
      emit(JobError('Failed to search jobs'));
    }
  }

  Future<void> _onSortJobsByDate(
      SortJobsByDate event,
      Emitter<JobState> emit,
      ) async {
    if (state is JobLoaded) {
      final currentJobs = (state as JobLoaded).jobs;
      final sortedJobs = List<JobModel>.from(currentJobs)
        ..sort((a, b) => b.postedAgo.compareTo(a.postedAgo));
      emit(JobLoaded(sortedJobs));
    }
  }

  Future<void> _onLoadJobDetail(
      LoadJobDetail event,
      Emitter<JobState> emit,
      ) async {
    emit(JobLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // final jobs = MockData.getRecommendedJobs();
      final jobs = await jobRepository.fetchAllJobs();
      final job = jobs.firstWhere((job) => job.id == event.jobId);
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobError('Failed to load job detail'));
    }
  }
}