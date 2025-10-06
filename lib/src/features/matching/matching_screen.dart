import 'package:flutter/material.dart';
import 'package:jobdeeo/src/authentication/login/login_screen.dart';
import 'package:jobdeeo/src/core/services/preferences_service.dart';
import 'package:jobdeeo/src/features/matching/screen/matching_screen.dart' as matching;

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PreferencesService.isQuestionnaireCompleted(),
      builder: (context, snapshot) {
        // แสดง loading ระหว่างเช็ค
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // เช็คว่าทำ questionnaire เสร็จแล้วหรือยัง
        final isCompleted = snapshot.data ?? false;

        if (!isCompleted) {
          // ยังไม่ทำ -> ไปหน้า login
          return const LoginScreen();
        }

        // ทำเสร็จแล้ว -> ไปหน้า matching จริงๆ
        return const matching.MatchingScreen();
      },
    );
  }
}