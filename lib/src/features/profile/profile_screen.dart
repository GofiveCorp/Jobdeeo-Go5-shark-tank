import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // เผื่อ scroll ได้
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Profile Header
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.infinity, // ✅ บังคับให้กินเต็มจอ
                        child: SvgPicture.asset(
                          ImageResource.icProfileHeader,
                          fit: BoxFit.cover, // ✅ ยืดให้เต็มกว้าง
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              ImageResource.icSettings,
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(height: 8),
                            // Avatar + Name
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: NetworkImage(
                                    "https://www.wfla.com/wp-content/uploads/sites/71/2023/05/GettyImages-1389862392.jpg?w=2560&h=1440&crop=1",
                                  ),
                                ),

                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      "วินิตรา แสงสร้อย",
                                      style: fontTitleStrong,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile Developer,",
                                          style: fontSmallStrong.copyWith(color: ColorResources.colorCaribbean)),
                                        
                                        Text(
                                      " 2 yrs experience",
                                      style: fontSmallStrong,
                                    ),
                                      ],
                                    ),
                                    
                                    Text("Bangkok", style: fontSmall),
                                    Text(
                                      "Winittra.works@gmail.com",
                                      style: fontSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                SvgPicture.asset(
                                  ImageResource.icEditProfile,
                                  width: 28,
                                  height: 28,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Profile Strength + Jobs
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "80% Profile Strength",
                                            style: fontTitleStrong,
                                          ),
                                          Text(
                                            "Update profile",
                                            style: fontTitleStrong,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: const [
                                          Text("1", style: fontTitleStrong),
                                          Text(
                                            "งานที่สมัคร",
                                            style: fontTitleStrong,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 AI Suggestion Box
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.pinkAccent, Colors.orangeAccent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("✨ AI Suggestion", style: fontTitleStrong),
                    SizedBox(height: 8),
                    Text(
                      "You have 85% Matches with Mobile Developer",
                      style: fontTitleStrong,
                    ),
                    SizedBox(height: 8),
                    Text("To get 100%, Try to", style: fontTitleStrong),
                    SizedBox(height: 8),
                    Text("1. Improve your resume", style: fontTitleStrong),
                    Text("2. Add more skills", style: fontTitleStrong),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Skill / Resume Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("Skill", style: fontTitleStrong),
                    SizedBox(width: 16),
                    Text("Resume", style: fontTitleStrong),
                    SizedBox(width: 16),
                    Text("Certifications", style: fontTitleStrong),
                    SizedBox(width: 16),
                    Text("Experience", style: fontTitleStrong),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Skill tags
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text("Swift สูง", style: fontBodyBold)),
                    Chip(label: Text("Kotlin กลาง", style: fontBodyBold)),
                    Chip(
                      label: Text("Firebase เบื้องต้น", style: fontBodyBold),
                    ),
                    Chip(
                      label: Text("+ Flutter กลาง", style: fontBodyBold),
                      backgroundColor: Colors.pink.shade100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Resume
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    title: const Text("Portfolio.pdf", style: fontTitleStrong),
                    subtitle: const Text("05/04/2023", style: fontBody),
                    trailing: const Text("Default", style: fontBodyBold),
                  ),
                ),
              ),

              const SizedBox(height: 80), // เผื่อ space ข้างล่าง
            ],
          ),
        ),
      ),
    );
  }
}
