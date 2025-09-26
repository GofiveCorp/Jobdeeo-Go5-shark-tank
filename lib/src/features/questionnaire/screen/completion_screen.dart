import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../job_board/screen/job_board_screen.dart';
import '../models/questionnaire_models.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletionScreen extends StatelessWidget {
  final QuestionnaireCompleteData data;

  const CompletionScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'สำเร็จ !',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF11B6AB),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'คุณสามารถเปลี่ยนแปลง\nความสนใจได้ทุกเมื่อ ใน Profile ของคุณ',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF838395),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF24CAB1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'เริ่มหางาน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SvgPicture.asset('assets/success_screen_icon.svg')
          ],
        ),
      ),
    );
  }
}