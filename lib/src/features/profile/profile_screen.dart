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

  // 🔹 เพิ่มตัวแปรเก็บ active tab (default คือ "สกิล")
  String _activeTab = "สกิล";

  // 🔹 ฟังก์ชันเลื่อน
  void _scrollToSection(GlobalKey key, String tabName) {
    setState(() {
      _activeTab = tabName;
    });
    
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
      backgroundColor: Colors.white,
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
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: NetworkImage(
                                    "https://media.discordapp.net/attachments/951012805170061322/1425926853641638044/image.png?ex=68e95d5e&is=68e80bde&hm=c23e2b3a10d908d88cd85ceab89af4646aae0dac0022e28ab1426dcbffa3f24e&=&format=webp&quality=lossless&width=1200&height=1200"
                                  ),
                                ),

                                const SizedBox(width: 16),
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
                                const SizedBox(width: 80),
                                // SvgPicture.asset(
                                //   ImageResource.icEditProfile,
                                //   width: 28,
                                //   height: 28,
                                // ),
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
                                        padding: const EdgeInsets.all(21.0),
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
                        Image.asset(ImageResource.imgUpdateRem),
                         Image.asset(ImageResource.imgSkillAdd)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(color: ColorResources.colorSoftCloud, height: 8),

              // 🔹 Skill / Resume Tabs (ปรับใหม่)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildTabButton("สกิล", () => _scrollToSection(_skillKey, "สกิล")),
                    _buildTabButton("Resume", () => _scrollToSection(_resumeKey, "Resume")),
                    _buildTabButton("ใบรับรอง", () => _scrollToSection(_certKey, "ใบรับรอง")),
                    _buildTabButton("ประสบการณ์", () => _scrollToSection(_expKey, "ประสบการณ์")),
                    _buildTabButton("การศึกษา", () => _scrollToSection(_eduKey, "การศึกษา")),
                  ],
                ),
              ),

              Container(height: 8, color: ColorResources.colorSoftCloud),
              const SizedBox(height: 16),

              // 🔹 Skill tags
              _sectionWrapper(
                key: _skillKey,
                title: "สกิล",
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3AA8AF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Swift',
                            style: fontSmallStrong.copyWith(
                              color: Color(0xFF3AA8AF),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF3AA8AF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "สูง",
                              style: fontExtraSmallStrong.copyWith(
                                color: ColorResources.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7E4FFE).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Kotlin',
                            style: fontSmallStrong.copyWith(
                              color: Color(0xFF7E4FFE),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF7E4FFE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "กลาง",
                              style: fontExtraSmallStrong.copyWith(
                                color: ColorResources.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),

                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF4C97F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Firebase',
                            style: fontSmallStrong.copyWith(
                              color: Color(0xFF4C97F1),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF4C97F1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "เบื้องต้น",
                              style: fontExtraSmallStrong.copyWith(
                                color: ColorResources.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(height: 8, color: ColorResources.colorSoftCloud),
              const SizedBox(height: 16),

              // 🔹 Resume Section
              _sectionWrapper(
                key: _resumeKey,
                title: "Resume",
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey, // สีของเส้นกรอบ
                      width: 0.1, // ความหนาของเส้น
                    ),
                    borderRadius: BorderRadius.circular(8), // มุมโค้งของการ์ด
                  ),
                  elevation: 0,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      ImageResource.icPdf, // path ของไฟล์ svg
                    ),
                    title: const Text("Portfolio.pdf", style: fontBodyStrong),
                    subtitle: const Text("05/04/2023", style: fontExtraSmall),
                    trailing: const Text("Default", style: fontExtraSmall),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(height: 8, color: ColorResources.colorSoftCloud),

              // 🔹 Certifications Section
                            const SizedBox(height: 16,),

              _sectionWrapper(
                key: _certKey,
                title: "หลักสูตรและใบรับรอง",
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey, // สีของเส้นกรอบ
                      width: 0.1, // ความหนาของเส้น
                    ),
                    borderRadius: BorderRadius.circular(8), // มุมโค้งของการ์ด
                  ),
                  elevation: 0,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      ImageResource.icCer, // path ของไฟล์ svg
                    ),
                    title: const Text(
                      "AWS Cloud Practitioner",
                      style: fontBodyStrong,
                    ),
                    subtitle: const Text("Jul 2025", style: fontExtraSmall),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(height: 8, color: ColorResources.colorSoftCloud),

              // 🔹 Experience Section
              _sectionWrapper(
                key: _expKey,
                child: Image.asset(
                  ImageResource.icExp,
                  width: MediaQuery.of(context).size.width, // กว้างเต็มหน้าจอ
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              Container(height: 8, color: ColorResources.colorSoftCloud),

              _sectionWrapper(
                key: _eduKey,
                child: Image.asset(
                  ImageResource.icEdu,
                  width: MediaQuery.of(context).size.width, // กว้างเต็มหน้าจอ
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 ปรับ _buildTabButton ให้แสดงสถานะ active
  Widget _buildTabButton(String label, VoidCallback onTap) {
    final bool isActive = _activeTab == label;
    
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                label,
                style: fontBody.copyWith(
                  color: isActive ? Colors.green : ColorResources.colorPorpoise,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            // เส้นใต้สีเขียวเมื่อ active
            Container(
              height: 2,
              width: 40,
              color: isActive ? Colors.green : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Helper: Section Wrapper
  Widget _sectionWrapper({
    required GlobalKey key,
    String? title,
    required Widget child,
  }) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(title, style: fontBodyStrong),
            ),
            const SizedBox(height: 8),
          ],
          child,
        ],
      ),
    );
  }
}