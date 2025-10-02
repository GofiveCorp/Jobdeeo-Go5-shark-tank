import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import '../../config/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // จำลองโหลดข้อมูล 2 วินาที
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SizedBox.expand(  
      child: SvgPicture.asset(
        ImageResource.bgsplashScreen,
        fit: BoxFit.cover, 
      ),
    ),
  );

  }
}
