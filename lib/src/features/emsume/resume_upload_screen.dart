import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/config/app_routes.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:dotted_border/dotted_border.dart';

class ResumeUploadScreen extends StatelessWidget {
  const ResumeUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorResources.buttonColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("สร้าง emsume", style: fontHeader5),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "สร้าง emsume",
                style: fontBody.copyWith(color: ColorResources.colorPorpoise),
              ),
            ),
            const SizedBox(height: 24),

            // รูปภาพ
            Center(
              child: SvgPicture.asset(
                ImageResource.icCreateEmsume,
                height: 180,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "อัปโหลดเรซูเม่ของคุณ\nเพื่อการสมัครงานที่ง่ายขึ้น",
              style: fontTitleStrong.copyWith(
                color: ColorResources.colorCharcoal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "ระบบจะวิเคราะห์ Resume ของคุณ\nและนำข้อมูลมากรอกในโปรไฟล์ของคุณ",
              style: fontBody.copyWith(color: ColorResources.colorAnchor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Box อัปโหลดไฟล์
            GestureDetector(
              onTap: () {
                // TODO: handle file picker
              },
              child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
                dashPattern: [10, 5],
            strokeWidth: 1,
            radius: Radius.circular(6),
            color: ColorResources.colorSilver,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        ImageResource.icUpload,
                        width: 28,
                        height: 28,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Choose file or drag it here",
                        style: fontSmallStrong.copyWith( color: ColorResources.colorFlint,
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "อัปโหลดได้เฉพาะไฟล์ .pdf, .doc, .docx ขนาดไม่เกิน 20 MB",
                  style: fontSmall.copyWith(
                    color: ColorResources.colorPorpoise,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            // ปุ่ม
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text("ข้าม",style: fontTitleStrong.copyWith(color: ColorResources.colorLead),),
                ),
                ElevatedButton(
  onPressed: () {Navigator.pushNamed(context, AppRoutes.resumeProcess);},
  style: ElevatedButton.styleFrom(
    backgroundColor: ColorResources.colorSoftCloud,
    disabledForegroundColor: ColorResources.colorSoftCloud,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6), // มุมโค้ง 6
    ),
  ),
  child: Text(
    "ถัดไป",
    style: fontTitleStrong.copyWith(
      color: ColorResources.colorSilver,
    ),
  ),
)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
