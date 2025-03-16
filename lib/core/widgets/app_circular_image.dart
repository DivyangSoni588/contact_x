import 'dart:io';

import 'package:flutter/material.dart';

class AppCircularImage extends StatelessWidget {
  final String? imagePath;
  final double size;

  const AppCircularImage({super.key, this.imagePath, this.size = 80.0});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300, // Placeholder background
        ),
        child:
            imagePath != null && imagePath!.isNotEmpty
                ? Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholderImage();
                  },
                )
                : _placeholderImage(),
      ),
    );
  }

  /// Placeholder widget when no image is found
  Widget _placeholderImage() {
    return Icon(
      Icons.person, // Default profile icon
      size: size * 0.6,
      color: Colors.grey.shade600,
    );
  }
}
