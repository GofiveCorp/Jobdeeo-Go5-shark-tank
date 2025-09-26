import 'package:equatable/equatable.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecommendedJobs extends JobEvent {}

class LoadAllJobs extends JobEvent {}

class SearchJobs extends JobEvent {
  final String query;

  const SearchJobs(this.query);

  @override
  List<Object?> get props => [query];
}

class SortJobsByDate extends JobEvent {}

class LoadJobDetail extends JobEvent {
  final String jobId;

  const LoadJobDetail(this.jobId);

  @override
  List<Object?> get props => [jobId];
}