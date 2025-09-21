import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/mock_data.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial()) {
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
      await Future.delayed(const Duration(milliseconds: 500));
      final companies = MockData.getTopCompanies();
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError('Failed to load top companies'));
    }
  }

  Future<void> _onLoadAllCompanies(
      LoadAllCompanies event,
      Emitter<CompanyState> emit,
      ) async {
    emit(CompanyLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final companies = MockData.getTopCompanies();
      emit(CompanyLoaded(companies));
    } catch (e) {
      emit(CompanyError('Failed to load companies'));
    }
  }

  Future<void> _onLoadCompanyDetail(
      LoadCompanyDetail event,
      Emitter<CompanyState> emit,
      ) async {
    emit(CompanyLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final companies = MockData.getTopCompanies();
      final company = companies.firstWhere((c) => c.id == event.companyId);
      emit(CompanyDetailLoaded(company));
    } catch (e) {
      emit(CompanyError('Failed to load company detail'));
    }
  }
}