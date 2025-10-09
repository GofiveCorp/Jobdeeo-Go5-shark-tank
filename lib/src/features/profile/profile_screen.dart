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
  final ScrollController _scrollController = ScrollController();

  // 🔹 Keys สำหรับแต่ละ section
  final GlobalKey _skillKey = GlobalKey();
  final GlobalKey _resumeKey = GlobalKey();
  final GlobalKey _certKey = GlobalKey();
  final GlobalKey _expKey = GlobalKey();
  final GlobalKey _eduKey = GlobalKey();

  // 🔹 ฟังก์ชันเลื่อน
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // เผื่อ scroll ได้
          child: Column(
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
                                  children: [
                                    Text(
                                      "วินิตรา แสงสร้อย",
                                      style: fontTitleStrong,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile Developer,",
                                          style: fontSmallStrong.copyWith(
                                            color:
                                                ColorResources.colorCaribbean,
                                          ),
                                        ),

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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorResources.colorWhite,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ), // สีเงา (จาง ๆ)
                                            blurRadius: 8, // 👈 ความเบลอของเงา
                                            offset: const Offset(
                                              0,
                                              2,
                                            ), // ตำแหน่งเงา (แนวตั้ง 2px)
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "80% ",
                                                      style: fontBodyStrong
                                                          .copyWith(
                                                            color: Colors.pink,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Profile Strength",
                                                      style: fontBodyStrong,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      ImageResource.icPencill,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Update profile",
                                                      style: fontSmall.copyWith(
                                                        color:
                                                            ColorResources
                                                                .colorCaribbean,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                SvgPicture.asset(
                                                  ImageResource
                                                      .icProfileStrength,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorResources.colorWhite,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ), // สีเงา (จาง ๆ)
                                            blurRadius: 8, // 👈 ความเบลอของเงา
                                            offset: const Offset(
                                              0,
                                              2,
                                            ), // ตำแหน่งเงา (แนวตั้ง 2px)
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Text("1", style: fontBodyStrong),
                                            Text(
                                              "งานที่สมัคร",
                                              style: fontSmall.copyWith(
                                                fontFamily: GofiveMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF426CFF).withOpacity(0.1),
                      Color(0xFFFF6EBD).withOpacity(0.1),
                      Color(0xFFFEB83C).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ รูปเต็มหน้าจอ
                    Container(
                      width: double.infinity,
                      child: SvgPicture.asset(
                        ImageResource.icProfileAiImprove,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // ✅ เนื้อหามี padding แยก
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "คุณ Match",
                                style: fontBody.copyWith(
                                  color: ColorResources.colorPorpoise,
                                ),
                              ),
                              Text(
                                " 85%",
                                style: fontTitleStrong.copyWith(
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                " กับตำแหน่ง",
                                style: fontBody.copyWith(
                                  color: ColorResources.colorPorpoise,
                                ),
                              ),
                              Text(
                                " Mobile Developer",
                                style: fontTitleStrong.copyWith(
                                  color: ColorResources.colorPorpoise,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "To get 100%, Try to",
                            style: fontBody.copyWith(
                              color: ColorResources.colorPorpoise,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 8),
                                child: CircleAvatar(minRadius: 12),
                              ),
                              Text(
                                "อัปเดต Resume",
                                style: fontBodyStrong,
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 8),
                                child: CircleAvatar(minRadius: 12),
                              ),
                              Text(
                                "เพิ่มสกิลใหม่",
                                style: fontBodyStrong,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

               Container(color: ColorResources.colorSoftCloud,height: 8),

              // 🔹 Skill / Resume Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children:  [
                    _buildTabButton("สกิล", () => _scrollToSection(_skillKey)),
                    _buildTabButton("Resume", () => _scrollToSection(_resumeKey)),
                    _buildTabButton("ใบรับรอง", () => _scrollToSection(_certKey)),
                    _buildTabButton("ประสบการณ์", () => _scrollToSection(_expKey)),
                    _buildTabButton("การศึกษา", () => _scrollToSection(_eduKey)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Skill tags
             
            const SizedBox(height: 24),

            // 🔹 Resume Section
            _sectionWrapper(
              key: _resumeKey,
              title: "Resume",
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: const Text("Portfolio.pdf"),
                  subtitle: const Text("05/04/2023"),
                  trailing: const Text("Default"),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Certifications Section
            _sectionWrapper(
              key: _certKey,
              title: "Certifications",
              child: const Text("Coming soon..."),
            ),

            const SizedBox(height: 24),

            // 🔹 Experience Section
            _sectionWrapper(
              key: _expKey,
              title: "Experience",
              child: const Text("Your work experience here..."),
            ),

            const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          
          child: Text(
            label,
            style: fontBody.copyWith(color: ColorResources.colorPorpoise),
          ),
        ),
      ),
    );
  }

  // 🔹 Helper: Section Wrapper
  Widget _sectionWrapper({
    required GlobalKey key,
    required String title,
    required Widget child,
  }) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
