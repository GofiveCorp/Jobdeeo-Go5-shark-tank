import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

class MainSectionHeader extends StatelessWidget {
  final String title;

  const MainSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: fontTitleStrong.copyWith(color: ColorResources.colorIron),
        // style: const TextStyle(
        //   fontSize: 16,
        //   fontWeight: FontWeight.w600,
        //   color: ColorResources.colorIron,
        // ),
      ),
    );
  }
}

class SubSectionHeader extends StatelessWidget {
  final String title;

  const SubSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: fontBody.copyWith(color: ColorResources.colorPorpoise)
        ),
      );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isOptional;
  final VoidCallback? onAddPressed;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isOptional = true,
    this.onAddPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: ColorResources.primaryColor,
          style: fontBody.copyWith(color: ColorResources.colorCharcoal),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: fontBody.copyWith(color: ColorResources.colorSilver),
            // Default border (unfocused)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: ColorResources.colorSilver,
                width: 1,
              ),
            ),
            // Focused border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: ColorResources.primaryColor,
                width: 1,
              ),
            ),
            // Error border (if needed)
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            // Focused error border (if needed)
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        if (!isOptional && onAddPressed != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onAddPressed,
                child: Text(
                    '+ เพิ่ม',
                    style: fontBodyStrong.copyWith(color: ColorResources.primaryColor)
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MultiSelectChip extends StatelessWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(String) onSelectionChanged;

  const MultiSelectChip({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);
        return GestureDetector(
          onTap: () => onSelectionChanged(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? ColorResources.ghostWhiteColor : Colors.transparent,
              border: Border.all(
                color: isSelected ? ColorResources.primaryColor : ColorResources.colorSmoke,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: ColorResources.primaryColor,
                      size: 16,
                    ),
                  ),
                Text(
                  option,
                  style: isSelected ? fontBodyStrong.copyWith(color: ColorResources.primaryColor)
                      : fontBody.copyWith(color: ColorResources.colorAnchor),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class StickyBottomButtons extends StatelessWidget {
  final String submitText;
  final String cancleText;
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;

  const StickyBottomButtons({
    super.key,
    required this.submitText,
    required this.cancleText,
    this.isLoading = false,
    this.isEnabled = true,
    this.onCancel,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: isLoading ? null : onCancel,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  side: const BorderSide(color: ColorResources.colorSmoke, width: 1),
                ),
                child: Text(
                  cancleText,
                  style: fontTitleStrong.copyWith(color: ColorResources.colorLead)
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: isEnabled && !isLoading ? onSubmit : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  backgroundColor: isEnabled  ? ColorResources.primaryColor : ColorResources.colorSoftCloud,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  submitText,
                  style: fontTitleStrong.copyWith(color:  isEnabled ?Colors.white : ColorResources.colorSilver)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}