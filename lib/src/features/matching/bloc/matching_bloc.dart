import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/preferences_service.dart';
import '../../job_board/models/job_model.dart';
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
      // 1) ดึงตำแหน่งงานที่ผู้ใช้สนใจจาก Preferences เพื่อทำเป็น keyword หลัก
      final jobPositions = await PreferencesService.getJobPositions();
      final keyword = jobPositions.isNotEmpty ? jobPositions.first : null;

      // 2) ยิงค้นรอบแรกด้วย keyword เต็ม (ถ้ามี) ไม่งั้นดึงทั่วไป
      final List<JobModel> results = [];

      if (keyword != null && keyword.isNotEmpty) {
        // รอบแรก
        final firstBatch = await repository.fetchAllJobs(
          skipRow: 0,
          takeRow: 20,
          keyword: keyword,
        );

// อันดับของงานในผลรอบแรก (index 0 = อันดับ 1)
        final Map<String, int> firstRank = {};
        for (int i = 0; i < firstBatch.length; i++) {
          firstRank[firstBatch[i].id] = i;
        }

        final List<JobModel> results = [...firstBatch];

// รอบสอง (ถ้าต้อง)
        Set<String> secondIds = <String>{};
        if (results.length < 10 && keyword != null && keyword.length >= 3) {
          final shortKeyword = keyword.substring(0, 3);
          final secondBatch = await repository.fetchAllJobs(
            skipRow: 0,
            takeRow: 20,
            keyword: shortKeyword,
          );

          // รวม + เดดดูพฯ (รักษาความสำคัญรอบแรก)
          final seen = results.map((e) => e.id).toSet();
          for (final j in secondBatch) {
            if (!seen.contains(j.id)) {
              results.add(j);
              seen.add(j.id);
              secondIds.add(j.id);
            }
          }
        }
// สร้างคะแนนตามกติกา + เรียงตามคะแนน
      final scored = _scoreAndSortJobs(
        results,
        firstRank: firstRank,
        secondIds: secondIds,
        keyword: keyword,
      );

// ตัด Top 10
      final top10 = scored.take(10).toList();

      if (top10.isEmpty) {
        emit(MatchingEmpty());
      } else {
        emit(MatchingLoaded(
          jobs: top10,
          currentJobIndex: 0,
          currentTabIndex: 0,
        ));
      }
      } else {
        final batch = await repository.fetchAllJobs(
          skipRow: 0,
          takeRow: 20,
        );
        results.addAll(batch);
      }

    } catch (e) {
      emit(MatchingError('Failed to load matching jobs: ${e.toString()}'));
    }
  }

  List<JobModel> _scoreAndSortJobs(
      List<JobModel> input, {
        required Map<String, int> firstRank,
        required Set<String> secondIds,
        String? keyword,
      }) {
    // เดดดูพฯ ตาม id และคงลำดับครั้งแรกที่พบ
    final seen = <String>{};
    final unique = <JobModel>[];
    for (final j in input) {
      if (!seen.contains(j.id)) {
        unique.add(j);
        seen.add(j.id);
      }
    }

    final rnd = Random();

    double _randIn(double min, double max) {
      final v = min + rnd.nextDouble() * (max - min);
      // ปัดทศนิยม 1 ตำแหน่ง
      return double.parse(v.toStringAsFixed(1));
    }

    // สร้างคะแนนตามกติกา:
    // 1) ถ้าเป็นงานจากรอบแรกและ "อยู่อันดับ 10 อันดับแรกของรอบแรก" → 8.0–9.8
    // 2) ถ้าเป็นงานจากรอบแรกแต่ "อยู่อันดับ > 10 ของรอบแรก" → 6.0–7.9
    // 3) ถ้าเป็นงานจากรอบสอง → 5.0–5.9
    // หมายเหตุ: งานที่ไม่อยู่ใน firstRank และไม่อยู่ใน secondIds (เช่น กรณีไม่มีรอบสอง)
    // ให้ถือเป็นรอบแรกแต่อยู่นอก Top 10 (ข้อ 2) เพื่อให้มีคะแนน
    List<JobModel> scored = unique.map((job) {
      double score;
      final rank = firstRank[job.id];

      if (rank != null && rank < 10) {
        score = _randIn(8.0, 9.8);
      } else if (rank != null) {
        score = _randIn(6.0, 7.9);
      } else if (secondIds.contains(job.id)) {
        score = _randIn(5.0, 5.9);
      } else {
        // เผื่อกรณีขอบ (ไม่มีใน firstRank แต่ก็มิใช่ secondIds) → ปฏิบัติเหมือนข้อ 2
        score = _randIn(6.0, 7.9);
      }

      // matchedSkills แบบง่าย ๆ จาก keyword (ถ้าอยากโชว์)
      final kw = (keyword ?? '').trim().toLowerCase();
      final tokens = kw.isEmpty
          ? <String>[]
          : kw.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

      final pool = [
        job.title,
        job.titleEn,
        job.company.name,
        job.company.nameEn,
        job.qualifications ?? '',
        job.responsibility ?? '',
      ].join(' ').toLowerCase();

      final matched = <String>[];
      for (final t in tokens) {
        if (t.isNotEmpty && pool.contains(t) && !matched.contains(t)) {
          matched.add(t);
        }
      }

      return job.copyWith(
        aiSkillMatch: job.aiSkillMatch.copyWith(
          score: score,
          matchedSkills: matched,
        ),
      );
    }).toList();

    // เรียงตามคะแนนมาก→น้อย (เสมอให้ date ใหม่กว่าอยู่ก่อน)
    scored.sort((a, b) {
      final c = b.aiSkillMatch.score.compareTo(a.aiSkillMatch.score);
      if (c != 0) return c;
      return b.dateCreated.compareTo(a.dateCreated);
    });

    return scored;
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

      repository.applyJob(currentJob).then((_) {
        debugPrint('✅ Job ${currentJob.id} applied successfully via swipe right');
      }).catchError((e) {
        debugPrint('❌ Error applying job via swipe right: $e');
      });

        emit(MatchingSuccess(job: currentJob));
        return;
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
        debugPrint('✅ Job ${event.jobId} bookmarked successfully');

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
        debugPrint('❌ Error bookmarking job: $e');
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