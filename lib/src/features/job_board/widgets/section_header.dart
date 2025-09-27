import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: fontHeader4.copyWith(color: ColorResources.colorCharcoal)
        ),
        if (actionText != null)
          GestureDetector(
            onTap: onActionPressed,
            child: Row(
              children: [
                Text(
                  actionText!,
                  style: fontSmallStrong.copyWith(color: ColorResources.primaryColor),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: ColorResources.primaryColor,
                  size: 24,
                ),
              ],
            ),
          ),
      ],
    );
  }
}