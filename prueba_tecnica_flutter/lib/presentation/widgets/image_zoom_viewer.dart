

import 'package:flutter/material.dart';

class ImageZoomViewer extends StatelessWidget {
  final String imageUrl;

  const ImageZoomViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.black12,
              child: const Icon(Icons.broken_image, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
