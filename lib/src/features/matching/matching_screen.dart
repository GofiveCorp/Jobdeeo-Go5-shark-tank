import 'package:flutter/material.dart';
import 'package:jobdeeo/src/authentication/login/login_screen.dart';

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
