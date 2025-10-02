import 'package:flutter/material.dart';
import 'package:jobdeeo/src/app_start/presentation/splash_screen.dart';
import 'package:jobdeeo/src/authentication/login/login_screen.dart';
import 'package:jobdeeo/src/dashboard/dashboard_screen.dart';
import 'package:jobdeeo/src/features/emsume/emsume_connect.dart';
import 'package:jobdeeo/src/features/emsume/emsume_infomation.dart';
import 'package:jobdeeo/src/features/emsume/resume_process_screen.dart';
import 'package:jobdeeo/src/features/emsume/resume_upload_screen.dart';
import 'src/config/app_routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // เริ่มต้นที่ Splash
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.dashboard: (_) => const DashboardScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.emsumeConnect: (_) => const CreateEmsumeScreen(),
        AppRoutes.resumeUpload: (_) => const ResumeUploadScreen(),
        AppRoutes.resumeProcess: (_) => const ResumeProcessingScreen(),
        AppRoutes.emsumeInformation: (_) => const EmsumeInfomationScreen(),
      },
    );
  }
}
