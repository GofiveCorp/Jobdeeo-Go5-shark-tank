import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';
import 'package:jobdeeo/src/features/matching/models/job_model.dart';

import '../../../config/app_routes.dart';
import '../bloc/matching_bloc.dart';
import '../bloc/matching_event.dart';
import '../repositories/matching_repositories.dart';

class MatchingSuccessScreen extends StatelessWidget {
  final JobModel job; // ✅ เพิ่ม field

  const MatchingSuccessScreen({super.key, required this.job}); // ✅ แก้ไข constructor

  Future<void> _quickApply(BuildContext context) async {
    try {
      final repository = MatchingRepository();
      await repository.applyJob(job);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('สมัครงานเรียบร้อยแล้ว!', style: fontBody.copyWith()),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // รอ 500ms แล้วกลับไปหน้าหลัก
        await Future.delayed(Duration(milliseconds: 500));
        Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      }
    } catch (e) {
      print('Error quick applying: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/common/bg/bg_match_success.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content with SafeArea
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Job Match !',
                      style: fontHeader1.copyWith(
                        color: ColorResources.darkColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Quick Apply Button
                    SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement quick apply logic
                          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorResources.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Quick Apply',
                          style: fontTitleStrong.copyWith(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Save for Later Button
                    SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          // ✅ บันทึกงานแล้วกลับไปหน้าหลัก
                          context.read<MatchingBloc>().add(BookmarkJob(job.id));

                          // แสดง snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('บันทึกงาน "${job.title}" แล้ว', style: fontBody),
                              backgroundColor: ColorResources.primaryColor,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // รอ 500ms แล้วกลับไปหน้าหลัก
                          await Future.delayed(Duration(milliseconds: 500));
                          Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: ColorResources.colorSmoke,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          'Save for later',
                          style: fontTitleStrong.copyWith(
                            color: ColorResources.colorLead,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}