import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';
import 'package:jobdeeo/src/features/matching/screen/matching_screen.dart';

import '../../../config/app_routes.dart';
import '../models/questionnaire_models.dart';

class CompletionScreen extends StatelessWidget {
  final QuestionnaireCompleteData data;

  const CompletionScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Main content centered
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'สำเร็จ !',
                  style: fontHeader1.copyWith(
                    color: ColorResources.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'คุณสามารถเปลี่ยนแปลง\nความสนใจได้ทุกเมื่อ ใน Profile ของคุณ',
                  style: fontTitle.copyWith(color: ColorResources.text2Color),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 167.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MatchingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'เริ่มหางาน',
                      style: fontTitleStrong.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SVG at bottom without extra space
          Image.asset(
            'assets/success_img.png', // Convert SVG to PNG
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}