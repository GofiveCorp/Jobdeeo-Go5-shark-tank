import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/job_model.dart';

class MatchingRepository {
  final String baseUrl = 'https://68dcea2b7cd1948060abb8d3.mockapi.io/v1';
  final String bookmarkUrl = 'https://68dcea2b7cd1948060abb8d3.mockapi.io/v1/myJob';
  final String applyJobUrl = 'https://68dcea2b7cd1948060abb8d3.mockapi.io/v1/applyJob'; // ✅ เพิ่ม


  int currentCardIndex = 1;
  final int maxCards = 9;

  Future<JobModel> fetchNextJob() async {
    if (currentCardIndex > maxCards) {
      throw Exception('No more jobs available');
    }


    debugPrint('current : $baseUrl/swipe$currentCardIndex');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/swipe$currentCardIndex'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        currentCardIndex++;
        return JobModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load job: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch job: $e');
    }
  }

  Future<List<JobModel>> fetchAllJobs() async {
    List<JobModel> jobs = [];
    currentCardIndex = 1;

    for (int i = 1; i <= maxCards; i++) {
      debugPrint('i = $baseUrl/swipe$i');
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/swipe$i'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          jobs.add(JobModel.fromJson(jsonData));
        }
      } catch (e) {
        print('Error fetching swipe$i: $e');
      }
    }

    if (jobs.isEmpty) {
      throw Exception('No jobs found');
    }

    return jobs;
  }

  // ✅ เพิ่ม: บันทึกงานไปยัง API
  Future<Map<String, dynamic>> bookmarkJob(String jobId) async {
    try {
      final response = await http.post(
        Uri.parse(bookmarkUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'jobId': jobId,  // ส่ง jobId ไปยัง API
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
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // แปลง response เป็น list ของ jobId
        // ⚠️ แก้ไข: จัดการกรณีที่ jobId อาจเป็น null
        return jsonData
            .where((item) => item['jobId'] != null)  // กรอง null ออก
            .map((item) => item['jobId'] as String)
            .toList();
      } else {
        throw Exception('Failed to fetch bookmarked jobs: ${response.statusCode}');
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
        headers: {
          'Content-Type': 'application/json',
        },
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
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (deleteResponse.statusCode == 200) {
            print('✅ Bookmark removed successfully');
          } else {
            throw Exception('Failed to remove bookmark: ${deleteResponse.statusCode}');
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

  Future<Map<String, dynamic>> applyJob(JobModel job) async {
    try {
      final response = await http.post(
        Uri.parse(applyJobUrl),
        headers: {
          'Content-Type': 'application/json',
        },
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
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        print('📥 Applied Jobs Response: ${jsonData.length} jobs');

        // แปลง response เป็น list ของ JobModel
        return jsonData
            .map((item) => JobModel.fromJson(item))
            .toList();
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
      print('❌ Error checking applied status: $e');
      return false;
    }
  }

  void resetCardIndex() {
    currentCardIndex = 1;
  }

  bool hasMoreJobs() {
    return currentCardIndex <= maxCards;
  }
}