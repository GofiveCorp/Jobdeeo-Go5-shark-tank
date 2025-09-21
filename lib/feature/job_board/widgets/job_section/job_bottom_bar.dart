import 'package:flutter/material.dart';

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
    return Container(
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
      child: SafeArea(
        child: Row(
          children: [
            BookmarkButton(
              isBookmarked: isBookmarked,
              onPressed: onBookmarkPressed,
            ),
            const SizedBox(width: 12),
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
        side: BorderSide(color: isBookmarked ? Colors.teal : Colors.grey),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: isBookmarked ? Colors.teal : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'บันทึก',
            style: TextStyle(
              color: isBookmarked ? Colors.teal : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
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
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
          : const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.send, size: 20),
          SizedBox(width: 8),
          Text(
            'สมัครงาน',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}