import 'package:equatable/equatable.dart';

import '../../models/company_model.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyLoaded extends CompanyState {
  final List<CompanyModel> companies;

  const CompanyLoaded(this.companies);

  @override
  List<Object?> get props => [companies];
}

class CompanyError extends CompanyState {
  final String message;

  const CompanyError(this.message);

  @override
  List<Object?> get props => [message];
}

class CompanyDetailLoaded extends CompanyState {
  final CompanyModel company;

  const CompanyDetailLoaded(this.company);

  @override
  List<Object?> get props => [company];
}