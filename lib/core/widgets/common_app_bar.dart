import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:contact_x/core/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Widget? leadingWidget;
  final List<Widget>? actionWidgets;

  const CommonAppBar({
    super.key,
    required this.appBarTitle,
    this.leadingWidget,
    this.actionWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingWidget,
      centerTitle: true,
      title: AppTextWidget(text: appBarTitle, textStyle: AppTextStyle.boldFont),
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 70);
}
