import 'package:contact_x/src/category/presentation/views/home_screen.dart';
import 'package:contact_x/src/contacts/presentation/views/add_contacts_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args = settings.arguments;

  switch (settings.name) {
    case HomeScreen.routeName:
      return _pageBuilder((_) => const HomeScreen(), settings: settings);
    case AddContactsScreen.routeName:
      return _pageBuilder((_) => const AddContactsScreen(), settings: settings);
    default:
      return _pageBuilder((_) => const Placeholder(), settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    settings: settings,
    transitionsBuilder: (_, animation, __, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
