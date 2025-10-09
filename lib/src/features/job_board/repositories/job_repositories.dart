import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class JobRepositories {
  static const String baseUrl = 'https://api-emconnect.empeo.com/api/v1';
  static const String apiKey = '3e1u2p9aB40V5a9uf+v9Cyb2T4CT8XIRKA6eZjY9Q4i/FZF0=';

  // Headers สำหรับทุก request
  Map<String, String> get _headers => {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:142.0) Gecko/20100101 Firefox/142.0',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'th,en-US;q=0.7,en;q=0.3',
    'Authorization': 'bearer undefined',
    'Content-Type': 'application/json',
    'X-API-KEY-EMCONNECT': apiKey,
    'Origin': 'https://jobdeeo.com',
    'Referer': 'https://jobdeeo.com/',
  };

  /// ดึงรายการงานทั้งหมด
  Future<List<JobModel>> fetchAllJobs({
    int skipRow = 0,
    int takeRow = 100,
    bool isRandom = true,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Position/Jobs'),
        headers: _headers,
        body: jsonEncode({
          'skipRow': skipRow,
          'takeRow': takeRow,
          'isEmjobs': true,
          'isSystem': true,
          'isRandom': isRandom,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // ตรวจสอบ status code
        if (jsonResponse['status']['code'] == '1000') {
          final List<dynamic> jobsJson =
              jsonResponse['data']['positionAvailables'] ?? [];

          return jobsJson
              .map((json) => JobModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API Error: ${jsonResponse['status']['description']}');
        }
      } else {
        throw Exception('Failed to load jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching jobs: $e');
    }
  }

  /// ดึงข้อมูลงานตาม ID
  Future<JobModel> fetchJobById(String jobId) async {
    try {
      // เรียก API เพื่อหางานทั้งหมดแล้วกรอง (เพราะ API ไม่มี endpoint สำหรับงานเดียว)
      final jobs = await fetchAllJobs(takeRow: 1000);

      final job = jobs.firstWhere(
            (job) => job.id == jobId,
        orElse: () => throw Exception('Job not found'),
      );

      return job;
    } catch (e) {
      throw Exception('Error fetching job detail: $e');
    }
  }

  /// ค้นหางานตาม keyword
  Future<List<JobModel>> searchJobs({
    required String keyword,
    int skipRow = 0,
    int takeRow = 100,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Position/Jobs'),
        headers: _headers,
        body: jsonEncode({
          'skipRow': skipRow,
          'takeRow': takeRow,
          'keyword': keyword,
          'isEmjobs': true,
          'isSystem': true,
          'isRandom': false,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']['code'] == '1000') {
          final List<dynamic> jobsJson =
              jsonResponse['data']['positionAvailables'] ?? [];

          return jobsJson
              .map((json) => JobModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API Error: ${jsonResponse['status']['description']}');
        }
      } else {
        throw Exception('Failed to search jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching jobs: $e');
    }
  }

  /// กรองงานตาม criteria ต่างๆ
  Future<List<JobModel>> filterJobs({
    List<int>? provinceIds,
    List<int>? categoryIds,
    List<int>? employmentTypeIds,
    double? salaryStart,
    double? salaryEnd,
    int skipRow = 0,
    int takeRow = 100,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'skipRow': skipRow,
        'takeRow': takeRow,
        'isEmjobs': true,
        'isSystem': true,
        'isRandom': false,
      };

      if (provinceIds != null && provinceIds.isNotEmpty) {
        requestBody['provincesId'] = provinceIds;
      }
      if (categoryIds != null && categoryIds.isNotEmpty) {
        requestBody['categoriesId'] = categoryIds;
      }
      if (employmentTypeIds != null && employmentTypeIds.isNotEmpty) {
        requestBody['employmentTypeIds'] = employmentTypeIds;
      }
      if (salaryStart != null) {
        requestBody['salaryStart'] = salaryStart;
      }
      if (salaryEnd != null) {
        requestBody['salaryEnd'] = salaryEnd;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/Position/Jobs'),
        headers: _headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']['code'] == '1000') {
          final List<dynamic> jobsJson =
              jsonResponse['data']['positionAvailables'] ?? [];

          return jobsJson
              .map((json) => JobModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API Error: ${jsonResponse['status']['description']}');
        }
      } else {
        throw Exception('Failed to filter jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error filtering jobs: $e');
    }
  }

  /// ดึงงานแนะนำ (ใช้ isRecommend)
  Future<List<JobModel>> getRecommendedJobs({
    int skipRow = 0,
    int takeRow = 10,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Position/Jobs'),
        headers: _headers,
        body: jsonEncode({
          'skipRow': skipRow,
          'takeRow': takeRow,
          'isEmjobs': true,
          'isSystem': true,
          'isRandom': true,
          // 'isRecommend': true, // เน้นงานแนะนำ
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']['code'] == '1000') {
          final List<dynamic> jobsJson =
              jsonResponse['data']['positionAvailables'] ?? [];

          return jobsJson
              .map((json) => JobModel.fromJson(json))
              .toList();
        } else {
          throw Exception('API Error: ${jsonResponse['status']['description']}');
        }
      } else {
        throw Exception('Failed to load recommended jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recommended jobs: $e');
    }
  }

  // ============ Bookmark Methods ============
  // Note: ถ้า API ไม่มี endpoint สำหรับ bookmark ให้ใช้ local storage แทน

  Future<bool> isJobBookmarked(String jobId) async {
    // TODO: Implement with API หรือ local storage
    // ตอนนี้ return false ไปก่อน
    return false;
  }

  Future<void> bookmarkJob(String jobId) async {
    // TODO: Implement with API หรือ local storage
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> removeBookmark(String jobId) async {
    // TODO: Implement with API หรือ local storage
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<List<JobModel>> getBookmarkedJobs() async {
    // TODO: Implement with API หรือ local storage
    return [];
  }
}