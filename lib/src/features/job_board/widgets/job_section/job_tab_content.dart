import 'package:flutter/material.dart';

import '../../models/job_model.dart';
import 'job_header_widget.dart';

// Overview Tab - ย้าย job details มาที่นี่
class OverviewTab extends StatelessWidget {
  final JobModel job;

  const OverviewTab({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Details ที่ย้ายมาจาก header
          JobOverviewDetails(job: job),
          const SizedBox(height: 24),

          TabSectionHeader(
            icon: Icons.work,
            title: 'ภาพรวมของตำแหน่งงาน',
          ),
          const SizedBox(height: 12),
          Text(
            'As a Systems Analyst, you will be responsible for analyzing, designing, and implementing computer systems to meet the needs of our organization. You can work individually on a project or collaborate with a team of other systems analysts on multiple projects.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// Responsibilities Tab
class ResponsibilitiesTab extends StatelessWidget {
  const ResponsibilitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabSectionHeader(
            icon: Icons.list,
            title: 'หน้าที่และความรับผิดชอบ',
          ),
          const SizedBox(height: 16),
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
  const QualificationsTab({super.key});

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
          BulletPointList(
            points: [
              "Bachelor's degree in Business Administration, Marketing, Communications, or a related field.",
              'Excellent communication skills, both verbal and written.',
              'Strong organizational skills with the ability to manage multiple clients and tasks simultaneously.',
              'Customer-focused mindset with a passion for delivering exceptional service.',
              'Ability to quickly learn new technologies and convey complex information in a clear and understandable manner.',
              'Prior experience in customer service, account management, or onboarding is preferred but not required.',
            ],
          ),
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
        children: [
          // Row 1
          Row(
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
              const SizedBox(width: 12),
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
          const SizedBox(height: 16),
          // Row 2
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
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'At Gofive, we share a passion for driving digital transformation for businesses of all sizes. We pay attention to every detail and are committed to delivering an exceptional software experience to our users.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          TabSectionHeader(
            icon: Icons.location_city,
            title: 'การติดต่อ',
          ),
          const SizedBox(height: 12),
          const Text(
            'สาขาพระราม 2  |  สาขา FYI Center (พระรามที่ 4)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                // Background image placeholder
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.grey[100],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.video_library,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),

                // Duration badge (for video posts)
                if (isVideoPost && duration.isNotEmpty)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Interview warmup badge
                if (title.contains('AI ช่วยเตรียมตัว'))
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'interview warmup',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Card Content
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        company,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      likes,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
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
          color: Colors.teal,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
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
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 40,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              'แผนที่ตำแหน่งบริษัท',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}