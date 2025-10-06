import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/config/app_routes.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/data/app_string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // BG Header เต็มจอด้านบน
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  ImageResource.bgHeaderEmsume,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // เนื้อหา
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120), // เว้นระยะให้ไม่ทับ header

                    Text(
                      AppString.dontHaveAccount,
                      style: fontHeader4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'เชื่อมต่อกับเราผ่าน emsume ได้เลย',
                      style: fontBody.copyWith(
                        color: ColorResources.colorPorpoise,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),
                    SvgPicture.asset(
                      ImageResource.icConnectEmsume,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 40),

                    // ปุ่มเข้าสู่ระบบ
                    SizedBox(
                      width: 210,
                      child: OutlinedButton(
                        onPressed: () {
              Navigator.pushNamed(context, AppRoutes.emsumeConnect);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(
                            color: ColorResources.colorSmoke,
                          ),
                        ),
                        child: Text(
                          'เข้าสู่ระบบ',
                          style: fontBodyStrong.copyWith(
                            color: ColorResources.colorLead,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ปุ่มสร้าง emsume
                    SizedBox(
                      width: 210,
                      child: ElevatedButton(
                        onPressed: () {
              Navigator.pushNamed(context, AppRoutes.emsumeConnect);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C4B3),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'สร้าง emsume',
                          style: fontBodyStrong.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
