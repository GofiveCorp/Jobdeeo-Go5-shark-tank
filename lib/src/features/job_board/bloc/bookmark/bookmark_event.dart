import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookmarkedJobs extends BookmarkEvent {}

class RemoveBookmark extends BookmarkEvent {
  final String jobId;

  const RemoveBookmark(this.jobId);

  @override
  List<Object?> get props => [jobId];
}