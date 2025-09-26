import 'package:equatable/equatable.dart';

class QuestionnaireBasicData extends Equatable {
  final String? jobPosition;
  final String? expectedSalary;
  final List<String> jobLevels;
  final List<String> jobTypes;
  final List<String> workFormats;
  final List<String> workPlaceTypes;

  const QuestionnaireBasicData({
    this.jobPosition,
    this.expectedSalary,
    this.jobLevels = const [],
    this.jobTypes = const [],
    this.workFormats = const [],
    this.workPlaceTypes = const [],
  });

  QuestionnaireBasicData copyWith({
    String? jobPosition,
    String? expectedSalary,
    List<String>? jobLevels,
    List<String>? jobTypes,
    List<String>? workFormats,
    List<String>? workPlaceTypes,
  }) {
    return QuestionnaireBasicData(
      jobPosition: jobPosition ?? this.jobPosition,
      expectedSalary: expectedSalary ?? this.expectedSalary,
      jobLevels: jobLevels ?? this.jobLevels,
      jobTypes: jobTypes ?? this.jobTypes,
      workFormats: workFormats ?? this.workFormats,
      workPlaceTypes: workPlaceTypes ?? this.workPlaceTypes,
    );
  }

  @override
  List<Object?> get props => [jobPosition, expectedSalary, jobLevels, jobTypes, workFormats, workPlaceTypes];
}

class QuestionnaireDetailedData extends Equatable {
  final List<String> organizationTypes;
  final List<String> workVibes;
  final List<String> lifestylePreferences;
  final List<String> workMotivations;

  const QuestionnaireDetailedData({
    this.organizationTypes = const [],
    this.workVibes = const [],
    this.lifestylePreferences = const [],
    this.workMotivations = const [],
  });

  QuestionnaireDetailedData copyWith({
    List<String>? organizationTypes,
    List<String>? workVibes,
    List<String>? lifestylePreferences,
    List<String>? workMotivations,
  }) {
    return QuestionnaireDetailedData(
      organizationTypes: organizationTypes ?? this.organizationTypes,
      workVibes: workVibes ?? this.workVibes,
      lifestylePreferences: lifestylePreferences ?? this.lifestylePreferences,
      workMotivations: workMotivations ?? this.workMotivations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organizationTypes': organizationTypes,
      'workVibes': workVibes,
      'lifestylePreferences': lifestylePreferences,
      'workMotivations': workMotivations,
    };
  }

  @override
  List<Object?> get props => [organizationTypes, workVibes, lifestylePreferences, workMotivations];
}

class QuestionnaireCompleteData extends Equatable {
  final QuestionnaireBasicData basicData;
  final QuestionnaireDetailedData detailedData;

  const QuestionnaireCompleteData({
    required this.basicData,
    required this.detailedData,
  });

  Map<String, dynamic> toJson() {
    return {
      'basicData': {
        'jobPosition': basicData.jobPosition,
        'expectedSalary': basicData.expectedSalary,
        'jobLevels': basicData.jobLevels,
        'jobTypes': basicData.jobTypes,
        'workFormats': basicData.workFormats,
      },
      'detailedData': detailedData.toJson(),
    };
  }

  @override
  List<Object?> get props => [basicData, detailedData];
}