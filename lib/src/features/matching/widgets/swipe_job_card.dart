import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
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
          margin: const EdgeInsets.all(16),
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
                  child: Stack(
                    children: [
                      // Main content
                      _buildTabContent(),

                      // Invisible tap zones
                      Row(
                        children: [
                          // Left tap zone
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: _handleLeftTap,
                              child: Container(
                                color: Colors.transparent,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          // Right tap zone
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: _handleRightTap,
                              child: Container(
                                color: Colors.transparent,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    job.companyLogo,
                    fit: BoxFit.cover,
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
                      job.companyName,
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
                _getTimeAgo(job.postedAt),
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
                  '${job.matchPercentage}%',
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
    return SingleChildScrollView( // เพิ่ม scroll ให้ content
      child: Container(
        padding: const EdgeInsets.all(16),
        child: _getTabContent(),
      ),
    );
  }

  Widget _getTabContent() {
    switch (currentTabIndex) {
      case 0:
        return OverviewTab(job: job);
      case 1:
        return const QualificationsTab();
      case 2:
        return const LifestyleTab();
      case 3:
        return const ContactTab();
      default:
        return OverviewTab(job: job);
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