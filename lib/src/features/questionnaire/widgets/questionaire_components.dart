import 'package:flutter/material.dart';
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
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorResources.colorIron,
        ),
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
        style: TextStyle(
          fontSize: 14,
          color: ColorResources.colorPorpoise,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final Function(String) onChanged;
  final bool isOptional;
  final VoidCallback? onAddPressed;

  const CustomTextField({
    super.key,
    this.hintText,
    this.initialValue,
    required this.onChanged,
    this.isOptional = false,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorResources.colorSilver),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 14,
              color: ColorResources.colorSilver,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: ColorResources.colorCharcoal,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.primaryColor),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        if (isOptional && onAddPressed != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onAddPressed,
                child: const Text(
                  '+ เพิ่ม',
                  style: TextStyle(
                    color: Color(0xFF24CAB1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
                  style: TextStyle(
                    color: isSelected ? ColorResources.primaryColor : ColorResources.colorAnchor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
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
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  final String submitText;
  final bool isLoading;

  const StickyBottomButtons({
    super.key,
    this.onCancel,
    this.onSubmit,
    required this.submitText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  'ย้อนกลับ',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF24CAB1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}