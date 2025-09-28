import 'package:equatable/equatable.dart';

import '../../job_board/models/job_model.dart';

abstract class MatchingState extends Equatable {
  const MatchingState();

  @override
  List<Object?> get props => [];
}

class MatchingInitial extends MatchingState {}

class MatchingLoading extends MatchingState {}

class MatchingLoaded extends MatchingState {
  final List<JobModel> jobs;
  final int currentJobIndex;
  final int currentTabIndex;

  const MatchingLoaded({
    required this.jobs,
    this.currentJobIndex = 0,
    this.currentTabIndex = 0,
  });

  JobModel get currentJob => jobs[currentJobIndex];

  bool get hasNextCard => currentJobIndex < jobs.length - 1;
  bool get hasPreviousCard => currentJobIndex > 0;

  MatchingLoaded copyWith({
    List<JobModel>? jobs,
    int? currentJobIndex,
    int? currentTabIndex,
  }) {
    return MatchingLoaded(
      jobs: jobs ?? this.jobs,
      currentJobIndex: currentJobIndex ?? this.currentJobIndex,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [jobs, currentJobIndex, currentTabIndex];
}

class MatchingError extends MatchingState {
  final String message;

  const MatchingError(this.message);

  @override
  List<Object?> get props => [message];
}

class MatchingEmpty extends MatchingState {}