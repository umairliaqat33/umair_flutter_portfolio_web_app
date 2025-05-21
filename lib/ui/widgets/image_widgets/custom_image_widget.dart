import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/assets.dart';

class CustomImageWidget extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final Alignment alignment;
  final bool matchTextDirection;
  final WidgetBuilder? placeholder;
  final Clip clipBehavior;
  final ImageType imageType;
  final bool noHeight;
  final bool noWidth;

  const CustomImageWidget({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.placeholder,
    this.clipBehavior = Clip.hardEdge,
    this.imageType = ImageType.svg,
    this.noHeight = false,
    this.noWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return imageType == ImageType.svg
        ? SvgPicture.asset(
            assetName,
            height: height,
            width: width,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(
                    color!,
                    BlendMode.srcIn,
                  ),
            fit: fit,
            alignment: alignment,
            matchTextDirection: matchTextDirection,
            placeholderBuilder: placeholder,
            clipBehavior: clipBehavior,
          )
        : imageType == ImageType.pngAndOthers
            ? Image.asset(
                assetName,
                height: noHeight ? null : height,
                width: noWidth ? null : width,
                fit: fit,
              )
            : Image.network(
                assetName,
                height: noHeight ? null : height,
                width: noWidth ? null : width,
                fit: fit,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Show the fallback image in case of an error
                  return Image.asset(
                    Assets.errorImagePlaceholder,
                    width: width,
                    height: height,
                    fit: fit,
                  );
                },
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
              );
  }
}
