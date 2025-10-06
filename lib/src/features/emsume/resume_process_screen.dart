import 'package:flutter/material.dart';
import 'package:jobdeeo/src/config/app_routes.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';

class ResumeProcessingScreen extends StatelessWidget {
  const ResumeProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorResources.buttonColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "สร้าง emsume",
          style: fontHeader5,
        ),
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
              child: Image.asset(
                ImageResource.icProcessing,
                height: 180,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "กำลังประมวลผลเรซูเม่ของคุณ",
              style: fontTitleStrong.copyWith(
                color: ColorResources.colorCharcoal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "ระบบอยู่ระหว่างการประมวลผลข้อมูล\nอาจใช้เวลาประมาณ 1 นาที",
              style: fontBody.copyWith(color: ColorResources.colorAnchor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Box อัปโหลดไฟล์
        
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
  onPressed: () {Navigator.pushNamed(context, AppRoutes.emsumeInformation);},
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
