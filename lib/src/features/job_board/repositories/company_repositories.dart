import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/api_constants.dart';
import '../models/company_model.dart';

class CompanyRepository {
  final http.Client? client;

  CompanyRepository({this.client});

  http.Client get _client => client ?? http.Client();

  /// ดึงข้อมูลบริษัททั้งหมดจาก API
  Future<List<CompanyModel>> getAllCompanies({
    int salaryStart = CompanyRequestParams.defaultSalaryStart,
    int salaryEnd = CompanyRequestParams.defaultSalaryEnd,
    int positionId = CompanyRequestParams.defaultPositionId,
    bool isActive = CompanyRequestParams.defaultIsActive,
    bool isSystem = CompanyRequestParams.defaultIsSystem,
    bool isEmjobs = CompanyRequestParams.defaultIsEmjobs,
    String keyword = CompanyRequestParams.defaultKeyword,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.companyProfileAll}');

      final response = await _client
          .post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode({
          'salaryStart': salaryStart,
          'salaryEnd': salaryEnd,
          'positionId': positionId,
          'isActive': isActive,
          'isSystem': isSystem,
          'isEmjobs': isEmjobs,
          'keyword': keyword,
        }),
      )
          .timeout(
        ApiConstants.connectionTimeout,
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);

        // ตรวจสอบว่าข้อมูลที่ได้มาเป็น List หรือไม่
        if (jsonData is List) {
          return jsonData
              .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
              .toList();
        } else if (jsonData is Map<String, dynamic>) {
          // กรณีที่ API ส่งกลับมาเป็น object ที่มี data array อยู่ข้างใน
          if (jsonData.containsKey('data') && jsonData['data'] is Map<String, dynamic>) {
            final data = jsonData['data'] as Map<String, dynamic>;

            // Check for companyProfiles inside data
            if (data.containsKey('companyProfiles') && data['companyProfiles'] is List) {
              return (data['companyProfiles'] as List)
                  .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
                  .toList();
            }
          } else if (jsonData.containsKey('data') && jsonData['data'] is List) {
            return (jsonData['data'] as List)
                .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else if (jsonData.containsKey('companies') && jsonData['companies'] is List) {
            return (jsonData['companies'] as List)
                .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
                .toList();
          }
        }

        throw Exception('Unexpected response format');
      } else {
        throw Exception('Failed to load companies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching companies: $e');
    }
  }

  /// ดึงข้อมูล Top Companies (ใช้ parameter เดียวกัน)
  Future<List<CompanyModel>> getTopCompanies({
    int limit = CompanyRequestParams.defaultTopCompaniesLimit,
  }) async {
    final companies = await getAllCompanies();
    return companies.take(limit).toList();
  }

  /// ดึงข้อมูลบริษัทเฉพาะจาก ID
  Future<CompanyModel> getCompanyById(String companyId) async {
    final companies = await getAllCompanies();
    return companies.firstWhere(
          (company) => company.companyId == companyId,
      orElse: () => throw Exception('Company not found'),
    );
  }

  /// ค้นหาบริษัทด้วย keyword
  Future<List<CompanyModel>> searchCompanies(String keyword) async {
    return await getAllCompanies(keyword: keyword);
  }
}