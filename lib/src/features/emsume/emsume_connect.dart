import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobdeeo/src/config/app_routes.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart'; // ใช้ถ้าโลโก้เป็น svg

class CreateEmsumeScreen extends StatelessWidget {
  const CreateEmsumeScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // โลโก้
            Column(
              children: [
                                const SizedBox(height: 24),

                // ถ้าโลโก้เป็น asset svg
                SvgPicture.asset(
                  ImageResource.icEmsume,
                ),
                // Image.asset("assets/images/emsume_logo.png", height: 60),
            
                const SizedBox(height: 24),
                 Text(
                  "เริ่มต้นสร้างโปรไฟล์ของคุณได้เลย ฟรีไม่มีค่าใช้จ่าย\nโอกาสที่ดีรอคุณอยู่",
                  textAlign: TextAlign.center,
                  style: fontBody.copyWith(color: ColorResources.colorCharcoal),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ปุ่ม Login ด้วย LINE
            _buildLoginButton(
              context,
              icon: ImageResource.icLine,
              text: "ดำเนินการต่อด้วย LINE",
              onTap: () {Navigator.pushNamed(context, AppRoutes.resumeUpload);},
            ),

            const SizedBox(height: 12),

            // ปุ่ม Login ด้วย Google
            _buildLoginButton(
              context,
              icon: ImageResource.icGoogle,
              text: "ดำเนินการต่อด้วย Google",
              onTap: () {Navigator.pushNamed(context, AppRoutes.resumeUpload);},
            ),

            const SizedBox(height: 12),

            // ปุ่ม Login ด้วย Facebook
            _buildLoginButton(
              context,
              icon: ImageResource.icFacebook,
              text: "ดำเนินการต่อด้วย Facebook",
              onTap: () {Navigator.pushNamed(context, AppRoutes.resumeUpload);},
            ),

            const SizedBox(height: 12),

            // ปุ่ม Login ด้วย Email
            _buildLoginButton(
              context,
              icon: ImageResource.icEmail,
              text: "ดำเนินการต่อด้วยอีเมล",
              onTap: () { Navigator.pushNamed(context, AppRoutes.resumeUpload);},
            ),

            const Spacer(),

            // ข้อความข้างล่าง
             Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text.rich(
                TextSpan(
                  text: "เมื่อดำเนินการต่อ จะถือว่าคุณได้อ่านและยอมรับ ",
                  style: fontBody.copyWith(color: ColorResources.colorAnchor),
                  children: [
                    TextSpan(
                      text: "\nข้อตกลงและเงื่อนไข",
                      style: fontBodyStrong.copyWith(color: ColorResources.colorLead),
                    ),
                    TextSpan(text: " และ "),
                    TextSpan(
                      text: "นโยบายความเป็นส่วนตัว",
                      style: fontBodyStrong.copyWith(color: ColorResources.colorLead),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context,
      {required String icon, required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side:  BorderSide(color: ColorResources.colorSmoke),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
        ),
        icon: SvgPicture.asset(icon, height: 22),
        label: Text(
          text,
          style: fontBody.copyWith(color: ColorResources.colorIron),
        ),
        onPressed: onTap,
      ),
    );
  }
}
