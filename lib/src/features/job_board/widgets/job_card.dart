import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final bool showMatchScore;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
    this.showMatchScore = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 253,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorResources.colorCloud, width: 1),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 4),
                Text(
                  job.title,
                  style: fontTitleStrong.copyWith(color: ColorResources.colorCharcoal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  job.company.name,
                  style: fontBody.copyWith(color: ColorResources.colorPorpoise),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                // Match Percentage
                if (showMatchScore)
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: ColorResources.gd3Gradient.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
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
                          '${(job.aiSkillMatch.score * 10).round()}% Skill Matches',
                          style: fontSmallStrong.copyWith(color : Color(0xFF596DF8)),
                        )
                      ],
                    ),
                  ),

                Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 18,
                      color: ColorResources.colorPorpoise,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${job.employment.seniority}, ${job.employment.type}',
                      style: fontSmall.copyWith(color: ColorResources.colorPorpoise)
                      ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: ColorResources.colorPorpoise,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      job.location.city,
                      style: fontSmall.copyWith(color: ColorResources.colorPorpoise)
                    ),
                  ],
                ),

                if (job.salaryRange.isHidden)
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 18,
                        color: ColorResources.colorPorpoise,
                      ),
                      const SizedBox(width: 8),
                      Text(
                          '${job.salaryRange.min} - ${job.salaryRange.max} ${job
                              .salaryRange.currency}',
                          style: fontSmall.copyWith(
                              color: ColorResources.colorPorpoise)
                      ),
                    ],
                  ),

              ],
            ),

            Text(
              job.postedAgo,
              style: fontSmall.copyWith(color: ColorResources.colorFlint)
            ),
          ],
        ),
      ),
    );
  }
}