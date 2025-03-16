import 'package:contact_x/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({super.key, required this.text, required this.textStyle});

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(context.appLocalizations.translate(text), style: textStyle);
  }
}
