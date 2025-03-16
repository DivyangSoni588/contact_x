import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class AppContactHelper {
  /// Save contact with name, phone number, and optional profile image path
  static Future<void> saveContact({
    required String name,
    required String phoneNumber,
    String? imagePath,
  }) async {
    // Request permission
    if (await Permission.contacts.request().isGranted) {
      Contact newContact =
          Contact()
            ..name.first = name
            ..phones = [Phone(phoneNumber)];

      // Set profile image if available
      if (imagePath != null) {
        newContact.photo = await _getImageBytes(imagePath);
      }

      // Insert the contact into the phone's contact list
      await FlutterContacts.insertContact(newContact);
    } else {
      debugPrint("🚫 Permission denied: Cannot save contact.");
    }
  }

  /// Convert image file to byte array for storing in contacts
  static Future<Uint8List?> _getImageBytes(String imagePath) async {
    try {
      File imageFile = File(imagePath);
      return await imageFile.readAsBytes();
    } catch (e) {
      debugPrint("❌ Error loading image: $e");
      return null;
    }
  }
}
