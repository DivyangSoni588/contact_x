import 'package:contact_x/core/resources/app_colors.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String hintText;
  final String errorText;

  const AppDropdownField({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText,
    this.errorText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: AppTextStyle.regularBoldFont),
                );
              }).toList(),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText.isEmpty ? null : errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: AppColors.cyanAccent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: AppColors.redColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
