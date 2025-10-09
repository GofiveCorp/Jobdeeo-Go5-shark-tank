/// Constants สำหรับการเชื่อมต่อ API
class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://api-emconnect.empeo.com/api/v1';

  // API Key - ควรเก็บใน environment variables ใน production
  static const String apiKey = '3e1u2p9aB40V5a9uf+v9Cyb2T4CT8XIRKA6eZjY9Q4i/FZF0=';

  // Endpoints
  static const String companyProfileAll = '/CompanyProfile/All';

  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'X-API-KEY-EMCONNECT': apiKey,
    'Accept': 'application/json',
  };

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

/// Default request parameters
class CompanyRequestParams {
  static const int defaultSalaryStart = 0;
  static const int defaultSalaryEnd = 0;
  static const int defaultPositionId = 0;
  static const bool defaultIsActive = true;
  static const bool defaultIsSystem = true;
  static const bool defaultIsEmjobs = true;
  static const String defaultKeyword = '';
  static const int defaultTopCompaniesLimit = 10;
}