import 'package:equatable/equatable.dart';

import '../../../matching/models/job_model.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<JobModel> jobs;

  const BookmarkLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class BookmarkEmpty extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object?> get props => [message];
}