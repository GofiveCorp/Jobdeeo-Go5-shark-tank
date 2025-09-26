import 'package:equatable/equatable.dart';

abstract class QuestionnaireEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Basic Data Events
class UpdateJobPosition extends QuestionnaireEvent {
  final String jobPosition;
  UpdateJobPosition(this.jobPosition);
  @override
  List<Object?> get props => [jobPosition];
}

class UpdateExpectedSalary extends QuestionnaireEvent {
  final String salary;
  UpdateExpectedSalary(this.salary);
  @override
  List<Object?> get props => [salary];
}

class ToggleJobLevel extends QuestionnaireEvent {
  final String level;
  ToggleJobLevel(this.level);
  @override
  List<Object?> get props => [level];
}

class ToggleJobType extends QuestionnaireEvent {
  final String type;
  ToggleJobType(this.type);
  @override
  List<Object?> get props => [type];
}

class ToggleWorkFormat extends QuestionnaireEvent {
  final String format;
  ToggleWorkFormat(this.format);
  @override
  List<Object?> get props => [format];
}

class ToggleWorkPlaceType extends QuestionnaireEvent {
  final String format;
  ToggleWorkPlaceType(this.format);
  @override
  List<Object?> get props => [format];
}

// Detailed Data Events
class ToggleOrganizationType extends QuestionnaireEvent {
  final String type;
  ToggleOrganizationType(this.type);
  @override
  List<Object?> get props => [type];
}

class ToggleWorkVibe extends QuestionnaireEvent {
  final String vibe;
  ToggleWorkVibe(this.vibe);
  @override
  List<Object?> get props => [vibe];
}

class ToggleLifestylePreference extends QuestionnaireEvent {
  final String preference;
  ToggleLifestylePreference(this.preference);
  @override
  List<Object?> get props => [preference];
}

class ToggleWorkMotivation extends QuestionnaireEvent {
  final String motivation;
  ToggleWorkMotivation(this.motivation);
  @override
  List<Object?> get props => [motivation];
}

class SubmitBasicData extends QuestionnaireEvent {}
class SubmitCompleteData extends QuestionnaireEvent {}
