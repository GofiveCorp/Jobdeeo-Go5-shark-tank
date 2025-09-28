import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/mock_data.dart';
import '../../job_board/models/job_model.dart';
import 'matching_event.dart';
import 'matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  MatchingBloc() : super(MatchingInitial()) {
    on<LoadMatchingJobs>(_onLoadMatchingJobs);
    on<ChangeTab>(_onChangeTab);
    on<NextCard>(_onNextCard);
    on<PreviousCard>(_onPreviousCard);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);
    on<ResetCards>(_onResetCards);
  }

  Future<void> _onLoadMatchingJobs(
      LoadMatchingJobs event,
      Emitter<MatchingState> emit,
      ) async {
    emit(MatchingLoading());
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));
      final jobs = MockData.getRecommendedJobs();

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
      emit(MatchingError('Failed to load jobs'));
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
          currentTabIndex: 0, // Reset to first tab when changing card
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
          currentTabIndex: 0, // Reset to first tab when changing card
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
      // Remove the current job from the list
      final updatedJobs = List<JobModel>.from(currentState.jobs)
        ..removeWhere((job) => job.id == event.jobId);

      if (updatedJobs.isEmpty) {
        emit(MatchingEmpty());
      } else {
        // Adjust current index if needed
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
      // Similar to swipe left - remove current job
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

  void _onResetCards(
      ResetCards event,
      Emitter<MatchingState> emit,
      ) {
    add(LoadMatchingJobs());
  }
}