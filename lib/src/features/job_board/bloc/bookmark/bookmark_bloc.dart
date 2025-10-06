import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../matching/repositories/matching_repositories.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final MatchingRepository repository;

  BookmarkBloc({required this.repository}) : super(BookmarkInitial()) {
    on<LoadBookmarkedJobs>(_onLoadBookmarkedJobs);
    on<RemoveBookmark>(_onRemoveBookmark);
  }

  Future<void> _onLoadBookmarkedJobs(
      LoadBookmarkedJobs event,
      Emitter<BookmarkState> emit,
      ) async {
    emit(BookmarkLoading());
    try {
      // 1. ดึง bookmarked job IDs จาก API
      final bookmarkedIds = await repository.fetchBookmarkedJobIds();

      if (bookmarkedIds.isEmpty) {
        emit(BookmarkEmpty());
        return;
      }

      // 2. ดึงข้อมูล jobs ทั้งหมด
      final allJobs = await repository.fetchAllJobs();

      // 3. กรองเฉพาะ jobs ที่ถูก bookmark
      final bookmarkedJobs = allJobs
          .where((job) => bookmarkedIds.contains(job.id))
          .toList();

      if (bookmarkedJobs.isEmpty) {
        emit(BookmarkEmpty());
      } else {
        emit(BookmarkLoaded(bookmarkedJobs));
      }
    } catch (e) {
      emit(BookmarkError('Failed to load bookmarked jobs: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveBookmark(
      RemoveBookmark event,
      Emitter<BookmarkState> emit,
      ) async {
    if (state is BookmarkLoaded) {
      final currentState = state as BookmarkLoaded;

      // TODO: เรียก API DELETE ถ้ามี
      // await repository.removeBookmark(event.jobId);

      final updatedJobs = currentState.jobs
          .where((job) => job.id != event.jobId)
          .toList();

      if (updatedJobs.isEmpty) {
        emit(BookmarkEmpty());
      } else {
        emit(BookmarkLoaded(updatedJobs));
      }
    }
  }
}