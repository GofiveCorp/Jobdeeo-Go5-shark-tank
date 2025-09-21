import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

class LoadTopCompanies extends CompanyEvent {}

class LoadAllCompanies extends CompanyEvent {}

class LoadCompanyDetail extends CompanyEvent {
  final String companyId;

  const LoadCompanyDetail(this.companyId);

  @override
  List<Object?> get props => [companyId];
}