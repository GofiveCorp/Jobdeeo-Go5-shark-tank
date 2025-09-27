import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';
import '../../../../../utils/time_utils.dart';
import '../../models/job_model.dart';

class JobAppBarInfo extends StatelessWidget {
  final JobModel job;

  const JobAppBarInfo({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            job.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            job.companyName,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Widget สำหรับแสดงรายละเอียดงานในแท็บภาพรวม
class JobOverviewDetails extends StatelessWidget {
  final JobModel job;

  const JobOverviewDetails({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 16,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                job.companyLogo,
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: fontHeader4.copyWith(color: ColorResources.colorIron)
                  ),
                  Text(
                    job.companyName,
                    style: fontTitleStrong.copyWith(color: ColorResources.colorPorpoise)
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    TimeUtils.getTimeAgo(job.postedAt),
                    style: fontSmall.copyWith(color: ColorResources.colorFlint)
                ),
              ],
            )
          ],
        ),
        Container(
          height: 36,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: ColorResources.gd3Gradient.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100),
            border: GradientBoxBorder(
              gradient: ColorResources.gd3Gradient,
              width: 1,
            ),
          ),
          child: Row(
            spacing: 2,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.diamond,
                size: 12,
                color: Color(0xFF596DF8),
              ),
              Text(
                '${job.matchPercentage}% Skill Matches',
                style: fontSmallStrong.copyWith(color : Color(0xFF596DF8)),
              )
            ],
          ),
        ),
        // Skills Section
        Row(
          children: [
            _buildSkillChip('Swift', 'สูง', Color(0xFF3AA8AF)),
            const SizedBox(width: 8),
            _buildSkillChip('Kotlin', 'กลาง', Color(0xFF7E4FFE)),
            const SizedBox(width: 8),
            _buildSkillChip('Firebase', 'เบื้องต้น', Color(0xFF4C97FF)),
          ],
        ),

        // Job Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            _buildDetailRow(Icons.work_outline, '${job.level}, ${job.workType}'),
            _buildDetailRow(Icons.location_on_outlined, job.location),
            _buildDetailRow(Icons.attach_money, job.salaryRange),
            Row(
              children: [
                Image.asset('assets/common/img_bts.png'
                  , width: 16, height: 16),
                const SizedBox(width: 8),
                Text(
                  'อโศก',
                  style: fontBody.copyWith(color: ColorResources.colorPorpoise)
                ),
                const SizedBox(width: 16),
    Image.asset('assets/common/img_mrt.png'
    , width: 16, height: 16),
    const SizedBox(width: 8),
    Text(
    'สุขุมวิท',
    style: fontBody.copyWith(color: ColorResources.colorPorpoise)
    ),
              ],
            ),
          ],
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
}