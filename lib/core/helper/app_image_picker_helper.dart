import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AppImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the camera and saves it to the app's directory
  Future<String?> pickImageFromCamera() async {
    return _pickAndSaveImage(source: ImageSource.camera);
  }

  /// Picks an image from the gallery and saves it to the app's directory
  Future<String?> pickImageFromGallery() async {
    return _pickAndSaveImage(source: ImageSource.gallery);
  }

  /// Internal helper method to pick and save an image
  Future<String?> _pickAndSaveImage({required ImageSource source}) async {
    try {
      XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85, // Optional: Compress image
      );

      if (pickedFile == null) return null; // User canceled selection

      // Get the app's directory to store images
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File savedImage = File('${appDir.path}/$fileName');

      // Save image to app directory
      await File(pickedFile.path).copy(savedImage.path);

      return savedImage.path; // Return the saved image path
    } catch (e) {
      return null;
    }
  }
}
