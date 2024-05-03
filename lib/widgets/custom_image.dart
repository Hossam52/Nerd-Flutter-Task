import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nerd_hossam_task/widgets/default_loader.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  const CustomImage(
      {super.key, required this.imagePath, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: BoxFit.cover,
      width: width,
      height: height,
      placeholderFadeInDuration: const Duration(milliseconds: 500),
      placeholder: (context, url) {
        return const DefaultLoader();
      },
    );
  }
}
