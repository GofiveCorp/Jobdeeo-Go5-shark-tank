import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/company_repositories.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository repository;

  CompanyBloc({CompanyRepository? repository})
      : repository = repository ?? CompanyRepository(),
        super(CompanyInitial()) {
    on<LoadTopCompanies>(_onLoadTopCompanies);
    on<LoadAllCompanies>(_onLoadAllCompanies);
    on<LoadCompanyDetail>(_onLoadCompanyDetail);
  }

  Future<void> _onLoadTopCompanies(
      LoadTopCompanies event,
      Emitter<CompanyState> emit,
      ) async {
    emit(CompanyLoading());
    try {
      final companies = await repository.getTopCompanies(limit: 10);
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError('Failed to load top companies: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAllCompanies(
      LoadAllCompanies event,
      Emitter<CompanyState> emit,
      ) async {
    emit(CompanyLoading());
    try {
      final companies = await repository.getAllCompanies();
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError('Failed to load companies: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCompanyDetail(
      LoadCompanyDetail event,
      Emitter<CompanyState> emit,
      ) async {
    emit(CompanyLoading());
    try {
      final company = await repository.getCompanyById(event.companyId);
      emit(CompanyDetailLoaded(company));
    } catch (e) {
      emit(CompanyError('Failed to load company detail: ${e.toString()}'));
    }
  }
}