import 'package:equatable/equatable.dart';

import '../models/questionnaire_models.dart';

abstract class QuestionnaireState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionnaireInitial extends QuestionnaireState {}
class QuestionnaireLoading extends QuestionnaireState {}

class QuestionnaireUpdated extends QuestionnaireState {
  final QuestionnaireBasicData basicData;
  final QuestionnaireDetailedData detailedData;

  QuestionnaireUpdated(this.basicData, this.detailedData);
  @override
  List<Object?> get props => [basicData, detailedData];
}

class QuestionnaireBasicSubmitted extends QuestionnaireState {
  final QuestionnaireBasicData data;
  QuestionnaireBasicSubmitted(this.data);
  @override
  List<Object?> get props => [data];
}

class QuestionnaireCompleted extends QuestionnaireState {
  final QuestionnaireCompleteData data;
  QuestionnaireCompleted(this.data);
  @override
  List<Object?> get props => [data];
}

class QuestionnaireError extends QuestionnaireState {
  final String message;
  QuestionnaireError(this.message);
  @override
  List<Object?> get props => [message];
}