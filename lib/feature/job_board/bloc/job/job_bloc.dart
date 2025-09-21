import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/mock_data.dart';
import '../../models/job_model.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc() : super(JobInitial()) {
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
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      final jobs = MockData.getRecommendedJobs();
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
      final jobs = MockData.getRecommendedJobs();
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
      final allJobs = MockData.getRecommendedJobs();
      final filteredJobs = allJobs
          .where((job) =>
      job.title.toLowerCase().contains(event.query.toLowerCase()) ||
          job.companyName.toLowerCase().contains(event.query.toLowerCase()))
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
        ..sort((a, b) => b.postedAt.compareTo(a.postedAt));
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
      final jobs = MockData.getRecommendedJobs();
      final job = jobs.firstWhere((job) => job.id == event.jobId);
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobError('Failed to load job detail'));
    }
  }
}