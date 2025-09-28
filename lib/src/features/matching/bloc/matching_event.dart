import 'package:equatable/equatable.dart';

abstract class MatchingEvent extends Equatable {
  const MatchingEvent();

  @override
  List<Object?> get props => [];
}

class LoadMatchingJobs extends MatchingEvent {}

class ChangeTab extends MatchingEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class NextCard extends MatchingEvent {}

class PreviousCard extends MatchingEvent {}

class SwipeLeft extends MatchingEvent {
  final String jobId;

  const SwipeLeft(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class SwipeRight extends MatchingEvent {
  final String jobId;

  const SwipeRight(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class ResetCards extends MatchingEvent {}