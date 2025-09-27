import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

class JobBottomBar extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;
  final VoidCallback onApplyPressed;
  final bool isLoading;

  const JobBottomBar({
    super.key,
    required this.isBookmarked,
    required this.onBookmarkPressed,
    required this.onApplyPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: BookmarkButton(
                isBookmarked: isBookmarked,
                onPressed: onBookmarkPressed,
              ),
            ),
           Expanded(
             child: ApplyJobButton(
                  onPressed: onApplyPressed,
                  isLoading: isLoading,
                ),
           ),
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onPressed;

  const BookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isBookmarked ? ColorResources.primaryColor : ColorResources.colorSilver),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline_rounded,
            color: isBookmarked ? ColorResources.primaryColor : ColorResources.colorLead,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'บันทึก',
            style: fontTitleStrong.copyWith(color: isBookmarked ? ColorResources.primaryColor : ColorResources.colorLead)
          ),
        ],
      ),
    );
  }
}

class ApplyJobButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ApplyJobButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorResources.buttonColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(Icons.send, size: 20),
          Text(
            'สมัครงาน',
            style: fontTitleStrong.copyWith(color: Colors.white)
          ),
        ],
      ),
    );
  }
}