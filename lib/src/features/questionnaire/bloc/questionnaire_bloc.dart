import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/features/questionnaire/bloc/questionnaire_event.dart';
import 'package:jobdeeo/src/features/questionnaire/bloc/questionnaire_state.dart';

import '../models/questionnaire_models.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  QuestionnaireBasicData _basicData = const QuestionnaireBasicData();
  QuestionnaireDetailedData _detailedData = const QuestionnaireDetailedData();

  QuestionnaireBloc() : super(QuestionnaireInitial()) {
    on<UpdateJobPosition>((event, emit) {
      _basicData = _basicData.copyWith(jobPosition: event.jobPosition);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<UpdateExpectedSalary>((event, emit) {
      _basicData = _basicData.copyWith(expectedSalary: event.salary);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleJobLevel>((event, emit) {
      final levels = List<String>.from(_basicData.jobLevels);
      if (levels.contains(event.level)) {
        levels.remove(event.level);
      } else {
        levels.add(event.level);
      }
      _basicData = _basicData.copyWith(jobLevels: levels);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleJobType>((event, emit) {
      final types = List<String>.from(_basicData.jobTypes);
      if (types.contains(event.type)) {
        types.remove(event.type);
      } else {
        types.add(event.type);
      }
      _basicData = _basicData.copyWith(jobTypes: types);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleWorkFormat>((event, emit) {
      final formats = List<String>.from(_basicData.workFormats);
      if (formats.contains(event.format)) {
        formats.remove(event.format);
      } else {
        formats.add(event.format);
      }
      _basicData = _basicData.copyWith(workFormats: formats);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleWorkPlaceType>((event, emit) {
      final places = List<String>.from(_basicData.workPlaceTypes);
      if (places.contains(event.place)) {
        places.remove(event.place);
      } else {
        places.add(event.place);
      }
      _basicData = _basicData.copyWith(workPlaceTypes: places);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleOrganizationType>((event, emit) {
      final types = List<String>.from(_detailedData.organizationTypes);
      if (types.contains(event.type)) {
        types.remove(event.type);
      } else {
        types.add(event.type);
      }
      _detailedData = _detailedData.copyWith(organizationTypes: types);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleWorkVibe>((event, emit) {
      final vibes = List<String>.from(_detailedData.workVibes);
      if (vibes.contains(event.vibe)) {
        vibes.remove(event.vibe);
      } else {
        vibes.add(event.vibe);
      }
      _detailedData = _detailedData.copyWith(workVibes: vibes);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleLifestylePreference>((event, emit) {
      final preferences = List<String>.from(_detailedData.lifestylePreferences);
      if (preferences.contains(event.preference)) {
        preferences.remove(event.preference);
      } else {
        preferences.add(event.preference);
      }
      _detailedData = _detailedData.copyWith(lifestylePreferences: preferences);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<ToggleWorkMotivation>((event, emit) {
      final motivations = List<String>.from(_detailedData.workMotivations);
      if (motivations.contains(event.motivation)) {
        motivations.remove(event.motivation);
      } else {
        motivations.add(event.motivation);
      }
      _detailedData = _detailedData.copyWith(workMotivations: motivations);
      emit(QuestionnaireUpdated(_basicData, _detailedData));
    });

    on<SubmitBasicData>((event, emit) async {
      emit(QuestionnaireLoading());

      try {
        // Mock API call
        await Future.delayed(const Duration(seconds: 1));

        // Mock validation
        if (_basicData.jobPosition?.isEmpty ?? true) {
          emit(QuestionnaireError('กรุณาใส่ตำแหน่งงานที่ต้องการ'));
          return;
        }

        debugPrint('Basic data: ${_basicData.jobPosition}');
        emit(QuestionnaireBasicSubmitted(_basicData));
        emit(QuestionnaireUpdated(_basicData, _detailedData));
      } catch (e) {
        emit(QuestionnaireError('เกิดข้อผิดพลาด: ${e.toString()}'));
      }
    });

    on<SubmitCompleteData>((event, emit) async {
      emit(QuestionnaireLoading());

      try {
        // Mock API call
        await Future.delayed(const Duration(seconds: 1));

        final completeData = QuestionnaireCompleteData(
          basicData: _basicData,
          detailedData: _detailedData,
        );

        debugPrint('Submitting complete data: ${completeData.toJson()}');
        emit(QuestionnaireCompleted(completeData));
      } catch (e) {
        emit(QuestionnaireError('เกิดข้อผิดพลาด: ${e.toString()}'));
      }
    });
  }
}