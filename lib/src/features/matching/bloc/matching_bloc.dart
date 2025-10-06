import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/job_model.dart';
import '../repositories/matching_repositories.dart';
import 'matching_event.dart';
import 'matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  final MatchingRepository repository;

  MatchingBloc({required this.repository}) : super(MatchingInitial()) {
    on<LoadMatchingJobs>(_onLoadMatchingJobs);
    on<ChangeTab>(_onChangeTab);
    on<NextCard>(_onNextCard);
    on<PreviousCard>(_onPreviousCard);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);
    on<BookmarkJob>(_onBookmarkJob);
    on<ResetCards>(_onResetCards);
  }

  Future<void> _onLoadMatchingJobs(
      LoadMatchingJobs event,
      Emitter<MatchingState> emit,
      ) async {
    emit(MatchingLoading());
    try {
      final jobs = await repository.fetchAllJobs();

      if (jobs.isEmpty) {
        emit(MatchingEmpty());
      } else {
        emit(MatchingLoaded(
          jobs: jobs,
          currentJobIndex: 0,
          currentTabIndex: 0,
        ));
      }
    } catch (e) {
      emit(MatchingError('Failed to load jobs: ${e.toString()}'));
    }
  }

  void _onChangeTab(
      ChangeTab event,
      Emitter<MatchingState> emit,
      ) {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;
      emit(currentState.copyWith(currentTabIndex: event.tabIndex));
    }
  }

  void _onNextCard(
      NextCard event,
      Emitter<MatchingState> emit,
      ) {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;
      if (currentState.hasNextCard) {
        emit(currentState.copyWith(
          currentJobIndex: currentState.currentJobIndex + 1,
          currentTabIndex: 0,
        ));
      }
    }
  }

  void _onPreviousCard(
      PreviousCard event,
      Emitter<MatchingState> emit,
      ) {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;
      if (currentState.hasPreviousCard) {
        emit(currentState.copyWith(
          currentJobIndex: currentState.currentJobIndex - 1,
          currentTabIndex: 0,
        ));
      }
    }
  }

  void _onSwipeLeft(
      SwipeLeft event,
      Emitter<MatchingState> emit,
      ) {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;
      final updatedJobs = List<JobModel>.from(currentState.jobs)
        ..removeWhere((job) => job.id == event.jobId);

      if (updatedJobs.isEmpty) {
        emit(MatchingEmpty());
      } else {
        int newIndex = currentState.currentJobIndex;
        if (newIndex >= updatedJobs.length) {
          newIndex = updatedJobs.length - 1;
        }

        emit(currentState.copyWith(
          jobs: updatedJobs,
          currentJobIndex: newIndex,
          currentTabIndex: 0,
        ));
      }
    }
  }

  void _onSwipeRight(
      SwipeRight event,
      Emitter<MatchingState> emit,
      ) {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;

      final currentJob = currentState.currentJob;
      final shouldShowSuccess = currentJob.actionFromCompany;

      // ✅ เรียก API สมัครงานทันที
      repository.applyJob(currentJob).then((_) {
        print('✅ Job ${currentJob.id} applied successfully via swipe right');
      }).catchError((e) {
        print('❌ Error applying job via swipe right: $e');
      });

      final updatedJobs = List<JobModel>.from(currentState.jobs)
        ..removeWhere((job) => job.id == event.jobId);

      if (shouldShowSuccess) {
        emit(MatchingSuccess(job: currentJob));
        return;
      }

      if (updatedJobs.isEmpty) {
        emit(MatchingEmpty());
      } else {
        int newIndex = currentState.currentJobIndex;
        if (newIndex >= updatedJobs.length) {
          newIndex = updatedJobs.length - 1;
        }

        emit(currentState.copyWith(
          jobs: updatedJobs,
          currentJobIndex: newIndex,
          currentTabIndex: 0,
        ));
      }
    }
  }

  // ✅ แก้ไข: เรียก API เพื่อบันทึกงาน
  Future<void> _onBookmarkJob(
      BookmarkJob event,
      Emitter<MatchingState> emit,
      ) async {
    if (state is MatchingLoaded) {
      final currentState = state as MatchingLoaded;

      try {
        // เรียก API เพื่อบันทึกงาน
        await repository.bookmarkJob(event.jobId);
        print('✅ Job ${event.jobId} bookmarked successfully');

        // ลบการ์ดออกจาก list หลังจากบันทึก
        final updatedJobs = List<JobModel>.from(currentState.jobs)
          ..removeWhere((job) => job.id == event.jobId);

        if (updatedJobs.isEmpty) {
          emit(MatchingEmpty());
        } else {
          int newIndex = currentState.currentJobIndex;
          if (newIndex >= updatedJobs.length) {
            newIndex = updatedJobs.length - 1;
          }

          emit(currentState.copyWith(
            jobs: updatedJobs,
            currentJobIndex: newIndex,
            currentTabIndex: 0,
          ));
        }
      } catch (e) {
        print('❌ Error bookmarking job: $e');
        // ถ้า API ล้มเหลว ก็ยังคงลบการ์ดออก (optional: แสดง error message)
        final updatedJobs = List<JobModel>.from(currentState.jobs)
          ..removeWhere((job) => job.id == event.jobId);

        if (updatedJobs.isEmpty) {
          emit(MatchingEmpty());
        } else {
          int newIndex = currentState.currentJobIndex;
          if (newIndex >= updatedJobs.length) {
            newIndex = updatedJobs.length - 1;
          }

          emit(currentState.copyWith(
            jobs: updatedJobs,
            currentJobIndex: newIndex,
            currentTabIndex: 0,
          ));
        }
      }
    }
  }

  void _onResetCards(
      ResetCards event,
      Emitter<MatchingState> emit,
      ) {
    repository.resetCardIndex();
    add(LoadMatchingJobs());
  }
}