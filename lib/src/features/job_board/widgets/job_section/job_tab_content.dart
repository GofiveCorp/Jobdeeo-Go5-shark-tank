import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../../models/job_model.dart';
import 'job_header_widget.dart';

class OverviewTab extends StatelessWidget {
  final job;

  const OverviewTab({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobOverviewDetails(job: job),
            const Divider(color: ColorResources.colorCloud, thickness: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                TabSectionHeader(
                  icon: Icons.work,
                  title: 'ภาพรวมของตำแหน่งงาน',
                ),
                Text(
                    job.benefitDescription,
                    style: fontBody.copyWith(color: ColorResources.colorLead)
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

// Responsibilities Tab
class ResponsibilitiesTab extends StatelessWidget {
  final JobModel job;
  const ResponsibilitiesTab({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabSectionHeader(
            icon: Icons.list,
            title: 'หน้าที่และความรับผิดชอบ',
          ),
          BulletPointList(
            points: [
              'Serve as the primary point of contact for new clients, guiding them through the onboarding process and ensuring a seamless transition onto our platform.',
              'Provide personalized training sessions to educate clients on how to effectively use our products and services to achieve their objectives.',
              'Proactively identify opportunities to enhance the onboarding experience and streamline processes.',
              'Act as a trusted advisor to clients, offering best practices, tips, and recommendations for optimizing their use of our platform.',
              'Monitor client progress during the onboarding phase, addressing any issues or concerns promptly and effectively.',
              'Collect feedback from clients to identify areas for improvement and inform product development initiatives.',
            ],
          ),
        ],
      ),
    );
  }
}

// Qualifications Tab
class QualificationsTab extends StatelessWidget {
  final JobModel job;
  const QualificationsTab({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabSectionHeader(
            icon: Icons.school,
            title: 'คุณสมบัติของผู้สมัคร',
          ),
          const SizedBox(height: 16),
          // BulletPointList(
          //   points: job.responsibility
          // ),
        ],
      ),
    );
  }
}

// Lifestyle Tab - ใหม่สำหรับแสดงคลิป
class LifestyleTab extends StatelessWidget {
  const LifestyleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          // Row 1
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: VideoCard(
                  title: 'วิธีเดินทางมาที่งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '01:59',
                  isVideoPost: true,
                ),
              ),
              Expanded(
                child: VideoCard(
                  title: 'แจกการ์ด! สัมภาษณ์งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '',
                  isVideoPost: false,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: VideoCard(
                  title: 'AI ช่วยเตรียมตัวสัมภาษณ์งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '',
                  isVideoPost: false,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

// Contact Tab
class ContactTab extends StatelessWidget {
  final JobModel job;
  const ContactTab({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ""
            // job.aboutCompany, style: fontBody.copyWith(color: ColorResources.colorLead)
          ),
          Column(
            spacing: 4,
            children: [
              TabSectionHeader(
                icon: Icons.location_city,
                title: 'การติดต่อ',
              ),
              Text(
              //     job.branches[1].name != null || job.branches[0].name != null
              //         ?'${job.branches[0].name}  |  ${job.branches[1].name}'
                  '',
                style: fontBodyStrong.copyWith(color: ColorResources.primaryColor)
                ),
            ],
          ),
          CompanyLocationMap(),
        ],
      ),
    );
  }
}

// Video Card Widget สำหรับแท็บไลฟ์สไตล์
class VideoCard extends StatelessWidget {
  final String title;
  final String company;
  final String likes;
  final String duration;
  final bool isVideoPost;

  const VideoCard({
    super.key,
    required this.title,
    required this.company,
    required this.likes,
    required this.duration,
    required this.isVideoPost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168, // Adjusted to match your design specification
      height: 240, // Fixed height as requested
      margin: const EdgeInsets.only(right: 8), // Spacing between cards
      padding: const EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Stack(
                  children: [
                    // Background image
                    Image.asset(
                      'assets/mock/video_image_mock.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    // Duration badge (for video posts)
                    if (isVideoPost && duration.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                duration,
                                style: fontExtraTinyStrong.copyWith(color: Colors.white),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: fontSmallStrong.copyWith(color: ColorResources.textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/mock/company_logo_mock.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        company,
                        style: fontExtraTiny.copyWith(color: ColorResources.text2Color),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4), // Spacing before like section
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 12,
                      color: ColorResources.text2Color,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      likes,
                      style: fontExtraTiny.copyWith(color: ColorResources.text2Color),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Widgets
class TabSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const TabSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorResources.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: fontTitleStrong.copyWith(color: ColorResources.colorCharcoal)
        ),
      ],
    );
  }
}

class BulletPointList extends StatelessWidget {
  final List<String> points;

  const BulletPointList({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: points.map((point) => BulletPoint(text: point)).toList(),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: const BoxDecoration(
              color: ColorResources.colorLead,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: fontBody.copyWith(color: ColorResources.colorLead)
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyLocationMap extends StatelessWidget {
  const CompanyLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 173,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Image.asset('assets/mock/map_mock.png', fit: BoxFit.cover)
    );
  }
}