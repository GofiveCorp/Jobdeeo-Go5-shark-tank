import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/authentication/login/login_screen.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/data/app_string.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? userId; // 👈 ยังไม่กำหนดค่า (ค่า default = null)

    if (userId == null) {
      return const LoginScreen(); // 👉 ไปหน้า login ถ้า userId เป็น null
    }

    // 👉 ถ้ามี userId
    return Scaffold(
      body: Center(
        child: Text("Welcome user: $userId"),
      ),
    );
  }
}
