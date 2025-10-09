import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/config/app_routes.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:jobdeeo/src/shared/bottom_action_sheet.dart';

class ResumeUploadScreen extends StatefulWidget {
  const ResumeUploadScreen({super.key});

  @override
  State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
  final List<File> _attachment = [];

  final ImagePicker _picker = ImagePicker();

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
                print("object");
                _pickImage2();
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
                      if (_attachment.isNotEmpty)
                        Center(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'กำลังอัพโหลดเรซูเม่สุดเจ๋ง',
        style: fontBodyStrong,
      ),
      SizedBox(width: 4),
      SizedBox(
        width: 20,
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              '...',
              textStyle: fontBodyStrong,
              speed: Duration(milliseconds: 200),
            ),
          ],
          repeatForever: true,
          pause: Duration(milliseconds: 100),
        ),
      ),
    ],
  ),
)
                      else ...[
                        SvgPicture.asset(
                          ImageResource.icUpload,
                          width: 28,
                          height: 28,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Choose file or drag it here",
                          style: fontSmallStrong.copyWith(
                            color: ColorResources.colorFlint,
                          ),
                        ),
                      ],
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
                    Navigator.pushNamed(context, AppRoutes.dashboard);
                  },
                  child: Text(
                    "ข้าม",
                    style: fontTitleStrong.copyWith(
                      color: ColorResources.colorLead,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.resumeProcess);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.colorSoftCloud,
                    disabledForegroundColor: ColorResources.colorSoftCloud,
                    elevation: 0,
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
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    print("objectdfkfgdj : jnsfjsk");
    final selected = ["Gallery", "File"];
    final List<BaseActionSheetAction> actionSheet =
        selected.map((data) {
          return BaseActionSheetAction(
            text: data,
            onPressed: () async {
              final index = selected.indexOf(data);
              switch (index) {
                case 0:
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    setState(() => _attachment.add(File(pickedFile.path)));
                  }
                  break;
                case 1:
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() => _attachment.add(File(pickedFile.path)));
                  }
                  break;
                case 2:
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.single.path != null) {
                    setState(
                      () => _attachment.add(File(result.files.single.path!)),
                    );
                  }
                  break;
              }
            },
          );
        }).toList();

    // แสดง Bottom Sheet
  }

  Future<void> _pickImage2() async {
    print("objectdfkfgdj : jnsfjsk");
    final selected = ["Camera", "Gallery", "File"];
    final List<BaseActionSheetAction> actionSheet =
        selected.map((data) {
          return BaseActionSheetAction(
            text: data,
            onPressed: () async {
              Navigator.pop(context); // ปิด bottom sheet ก่อน
              final index = selected.indexOf(data);
              switch (index) {
                case 0:
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    setState(() => _attachment.add(File(pickedFile.path)));
                    _navigateAfterUpload(); // เพิ่มบรรทัดนี้
                  }
                  break;
                case 1:
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() => _attachment.add(File(pickedFile.path)));
                    _navigateAfterUpload(); // เพิ่มบรรทัดนี้
                  }
                  break;
                case 2:
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.single.path != null) {
                    setState(
                      () => _attachment.add(File(result.files.single.path!)),
                    );
                    _navigateAfterUpload(); // เพิ่มบรรทัดนี้
                  }
                  break;
              }
            },
          );
        }).toList();
    // แสดง Bottom Sheet (เพิ่มส่วนนี้)
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                actionSheet.map((action) {
                  return ListTile(
                    title: Text(action.text),
                    onTap: action.onPressed,
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _navigateAfterUpload() {
    if (_attachment.isNotEmpty) {
      // รอสักครู่เพื่อแสดงข้อความ "กำลังประมวล Resume ของคุณ..."
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamed(context, AppRoutes.resumeProcess);
      });
    }
  }
}
