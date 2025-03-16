import 'package:contact_x/core/resources/app_colors.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String errorText;
  final TextInputType textInputType;

  const AppTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.errorText = '',
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        error:
            errorText.isEmpty
                ? null
                : Text(errorText, style: AppTextStyle.redFont),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.zero, // Makes edges sharp like square brackets
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ), // Adjust color and width
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.grey, width: 2),
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
    );
  }
}
