import 'package:contact_x/core/resources/app_string_keys.dart';
import 'package:contact_x/core/resources/app_text_style.dart';
import 'package:contact_x/core/widgets/app_text_widget.dart';
import 'package:contact_x/src/add_contacts/presentation/views/add_contacts_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Black background
        child: Column(
          children: [
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.white),
              title: AppTextWidget(
                text: AppStringKeys.addContacts,
                textStyle: AppTextStyle.boldFont,
              ),
              onTap: () {
                Navigator.pushNamed(context, AddContactsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category, color: Colors.white),
              title: AppTextWidget(
                text: AppStringKeys.addCategory,
                textStyle: AppTextStyle.boldFont,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.list, color: Colors.white),
              title: AppTextWidget(
                text: AppStringKeys.contactList,
                textStyle: AppTextStyle.boldFont,
              ),
              onTap: () {
                // Handle navigation
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
