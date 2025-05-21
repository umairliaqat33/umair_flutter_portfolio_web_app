import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/assets.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit fit;
  const NetworkImageWidget({
    super.key,
    required this.imagePath,
    this.imageWidth,
    this.imageHeight,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      width: imageWidth,
      height: imageHeight,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: PortfolioAppTheme.primary,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // Show the fallback image in case of an error
        return Image.asset(
          Assets.errorImagePlaceholder,
          width: imageWidth,
          height: imageHeight,
        );
      },
    );
  }
}
