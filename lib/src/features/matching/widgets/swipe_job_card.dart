
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../../job_board/models/job_model.dart';
import '../../job_board/widgets/job_section/job_tab_content.dart';

class SwipeJobCard extends StatelessWidget {
  final JobModel job;
  final int currentTabIndex;
  final Function(int) onTabChanged;
  final VoidCallback? onTapRight;
  final VoidCallback? onTapLeft;

  const SwipeJobCard({
    super.key,
    required this.job,
    required this.currentTabIndex,
    required this.onTabChanged,
    this.onTapRight,
    this.onTapLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        Container(
          height: 520,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFF1F7F7), width: 4)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                // Header with job info
                _buildHeader(),

                // Tab indicators
                _buildTabIndicators(),

                // Content area with tap zones
                Expanded(
                  child: GestureDetector(
                    // ใช้ onTapUp แทน onTap เพื่อตรวจสอบตำแหน่ง
                    onTapUp: (details) {
                      final width = MediaQuery.of(context).size.width;
                      final tapPosition = details.globalPosition.dx;

                      // แบ่งหน้าจอเป็น 2 ส่วน
                      if (tapPosition < width * 0.4) {
                        _handleLeftTap();
                      } else if (tapPosition > width * 0.6) {
                        _handleRightTap();
                      }
                    },
                    // อนุญาตให้ scroll ทำงานได้
                    child: _buildTabContent(),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: ColorResources.linearGradient
        ),
      child: Column(
        children: [
          // Job title and company
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    job.logoURL,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business, color: ColorResources.primaryColor);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Job info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: fontTitleBold.copyWith(
                        color: ColorResources.backgroundColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      job.company.name,
                      style: fontBody.copyWith(
                        color: ColorResources.backgroundColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Text(
                job.postedAgo,
                style: fontSmall.copyWith(
                  color: Color(0xFF9CE9DD),
                ),
              ),


            ],
          ),
          SizedBox(height: 8),
          // Match percentage
          Container(
            height: 36,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                gradient: ColorResources.gd3Gradient,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 1)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.diamond,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  '${job.aiSkillMatch.score}/10',
                  style: fontHeader4.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  ' Skill Matches',
                  style: fontBody.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabIndicators() {
    const tabTitles = ['ภาพรวม', 'คุณสมบัติของผู้สมัคร', 'ไลฟ์สไตล์', 'ติดต่อ'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabTitles.length, (index) {
          final isActive = index == currentTabIndex;
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive
                    ? ColorResources.primaryColor
                    : ColorResources.colorCloud,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: _getTabContent(),
      ),
    );
  }

  Widget _getTabContent() {
    switch (currentTabIndex) {
      case 0:
        return OverviewSwipeTab(job: job);
      case 1:
        return QualificationsTab(job: job);
      case 2:
        return const LifestyleTab();
      case 3:
        return ContactTab(job: job);
      default:
        return OverviewSwipeTab(job: job);
    }
  }

  void _handleLeftTap() {
    if (currentTabIndex > 0) {
      onTabChanged(currentTabIndex - 1);
    }
    onTapLeft?.call();
  }

  void _handleRightTap() {
    if (currentTabIndex < 4) {
      onTabChanged(currentTabIndex + 1);
    }
    onTapRight?.call();
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'เพิ่งลง';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    }
  }
}

class OverviewSwipeTab extends StatelessWidget {
  final JobModel job;

  const OverviewSwipeTab({super.key, required this.job});

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
            Row(
              spacing: 4,
              children: [
                _buildSkillChip("Excel", "สูง", Color(0xFF3AA8AF)),
                _buildSkillChip("Design", "กลาง", Color(0xFF7E4FFE)),
                _buildSkillChip("Creative", "สูง", Color(0xFF4C97FF)),
              ],
            ),

            // Job Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                _buildDetailRow(Icons.work_outline, '${job.employment.seniority}, ${job.employment.type}'),
                _buildDetailRow(Icons.location_on_outlined, job.location.city),
                _buildDetailRow(Icons.attach_money, '${job.salaryRange.min} - ${job.salaryRange.max} ${job.salaryRange.currency}'),
              ],
            ),
            const Divider(color: ColorResources.colorCloud, thickness: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                TabSectionHeader(
                  icon: Icons.work,
                  title: 'ภาพรวมของตำแหน่งงาน',
                ),
                Builder(
                  builder: (_) {
                    final html = job.benefitDescription?.trim();

                    return Html(
                      data: html,
                      style: {
                        'ul': Style.fromTextStyle(fontSmall.copyWith(color: ColorResources.colorLead),
                        ).copyWith(margin: Margins.only(left: 12), padding: HtmlPaddings.zero),
                        'li': Style.fromTextStyle(fontSmall.copyWith(color: ColorResources.colorLead),
                        ).copyWith(
                          fontSize: FontSize(fontBody.fontSize ?? 14),
                          lineHeight: const LineHeight(1.4),
                          color: ColorResources.colorLead,
                        ),
                        'div': Style.fromTextStyle(fontSmall.copyWith(color: ColorResources.colorLead),
                        ).copyWith(margin: Margins.zero, padding: HtmlPaddings.zero),
                        'p': Style.fromTextStyle(fontSmall.copyWith(color: ColorResources.colorLead),
                        ).copyWith(
                          margin: Margins.only(bottom: 8),
                          fontSize: FontSize(fontBody.fontSize ?? 14),
                          color: ColorResources.colorLead,
                        ),
                      },
                    );
                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: ColorResources.colorPorpoise,
        ),
        const SizedBox(width: 8),
        Text(
            text,
            style: fontBody.copyWith(color: ColorResources.colorPorpoise)
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, String level, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              skill,
              style: fontSmallStrong.copyWith(color: color)
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
                level,
                style: fontExtraSmallStrong.copyWith(color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }
}