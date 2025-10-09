import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../job_board/models/job_model.dart';


class MatchingRepository {
  static const String baseUrl = 'https://api-emconnect.empeo.com/api/v1';
  static const String apiKey = '3e1u2p9aB40V5a9uf+v9Cyb2T4CT8XIRKA6eZjY9Q4i/FZF0=';

  Map<String, String> get _headers => {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:142.0) Gecko/20100101 Firefox/142.0',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'th,en-US;q=0.7,en;q=0.3',
    'Authorization': 'bearer undefined',
    'Content-Type': 'application/json',
    'X-API-KEY-EMCONNECT': apiKey,
  };

  final String bookmarkUrl =
      'https://68dead5c898434f41355aa16.mockapi.io/v1/myJob';
  final String applyJobUrl =
      'https://68dead5c898434f41355aa16.mockapi.io/v1/applyJob';

  Future<List<JobModel>> fetchAllJobs({
    int skipRow = 0,
    int takeRow = 10,
    String? keyword,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'skipRow': skipRow,
        'takeRow': takeRow,
        'isEmjobs': true,
        'isSystem': true,
        'isRandom': true,
      };

      // เพิ่ม keyword ถ้ามี
      if (keyword != null && keyword.isNotEmpty) {
        requestBody['keyword'] = keyword;
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
        throw Exception('Failed to load recommended jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recommended jobs: $e');
    }
  }

  Future<List<JobModel>> fetchRecommendedJobs({
    int skipRow = 0,
    int takeRow = 20,
  }) {
    return fetchAllJobs(skipRow: skipRow, takeRow: takeRow);
  }


  // ✅ เพิ่ม: บันทึกงานไปยัง API
  Future<List<dynamic>> bookmarkJob(String jobId) async {
    try {
      final response = await http.post(
        Uri.parse(bookmarkUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'jobId': jobId, // ส่ง jobId ไปยัง API
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print('✅ Job bookmarked successfully: $jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to bookmark job: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to bookmark job: $e');
    }
  }

  // ✅ เพิ่ม: ดึงรายการงานที่บันทึกไว้
  Future<List<String>> fetchBookmarkedJobIds() async {
    try {
      final response = await http.get(
        Uri.parse(bookmarkUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // แปลง response เป็น list ของ jobId
        // ⚠️ แก้ไข: จัดการกรณีที่ jobId อาจเป็น null
        return jsonData
            .where((item) => item['jobId'] != null) // กรอง null ออก
            .map((item) => item['jobId'] as String)
            .toList();
      } else {
        throw Exception(
          'Failed to fetch bookmarked jobs: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ Error fetching bookmarked jobs: $e');
      throw Exception('Failed to fetch bookmarked jobs: $e');
    }
  }

  // ✅ เพิ่ม: ลบงานออกจาก bookmark
  Future<void> removeBookmark(String jobId) async {
    try {
      // หา bookmark ID จาก jobId
      final response = await http.get(
        Uri.parse(bookmarkUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // หา bookmark ที่ตรงกับ jobId
        final bookmark = jsonData.firstWhere(
          (item) => item['jobId'] == jobId || item['id'].toString() == jobId,
          orElse: () => null,
        );

        if (bookmark != null && bookmark['id'] != null) {
          // DELETE bookmark
          final deleteResponse = await http.delete(
            Uri.parse('$bookmarkUrl/${bookmark['id']}'),
            headers: {'Content-Type': 'application/json'},
          );

          if (deleteResponse.statusCode == 200) {
            print('✅ Bookmark removed successfully');
          } else {
            throw Exception(
              'Failed to remove bookmark: ${deleteResponse.statusCode}',
            );
          }
        }
      }
    } catch (e) {
      print('❌ Error removing bookmark: $e');
      throw Exception('Failed to remove bookmark: $e');
    }
  }

  // ✅ เพิ่ม: ตรวจสอบว่างานนี้ถูก bookmark หรือไม่
  Future<bool> isJobBookmarked(String jobId) async {
    try {
      final bookmarkedIds = await fetchBookmarkedJobIds();
      return bookmarkedIds.contains(jobId);
    } catch (e) {
      print('❌ Error checking bookmark status: $e');
      return false;
    }
  }

  Future<List<dynamic>> applyJob(JobModel job) async {
    try {
      final response = await http.post(
        Uri.parse(applyJobUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(job.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        print('✅ Job applied successfully: $jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to apply job: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to apply job: $e');
    }
  }

  // ✅ ดึงรายการงานที่สมัครแล้ว
  Future<List<JobModel>> fetchAppliedJobs() async {
    try {
      final response = await http.get(
        Uri.parse(applyJobUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        print('📥 Applied Jobs Response: ${jsonData.length} jobs');

        // แปลง response เป็น list ของ JobModel
        return jsonData.map((item) => JobModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch applied jobs: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching applied jobs: $e');
      return [];
    }
  }

  // ✅ เช็คว่าสมัครงานนี้แล้วหรือยัง
  Future<bool> isJobApplied(String jobId) async {
    try {
      final appliedJobs = await fetchAppliedJobs();
      return appliedJobs.any((job) => job.id == jobId);
    } catch (e) {
      debugPrint('❌ Error checking applied status: $e');
      return false;
    }
  }

  int _currentCardIndex = 0;
  void resetCardIndex() => _currentCardIndex = 0;
  int get currentCardIndex => _currentCardIndex;

}
