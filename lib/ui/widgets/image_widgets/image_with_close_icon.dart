import 'dart:io';

import 'package:flutter/material.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/custom_image_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/normal_text_widget.dart';
import 'package:umair_liaqat/utils/app_enum.dart';

class ImageWithCloseIcon extends StatelessWidget {
  final String imagePath;
  final Function? onCloseTap;
  final bool withCloseIcon;
  final double? height;
  final double? width;
  final String? moreText;
  final ImageType imageType;
  const ImageWithCloseIcon({
    super.key,
    required this.imagePath,
    this.onCloseTap,
    this.withCloseIcon = true,
    this.height,
    this.width,
    this.moreText,
    this.imageType = ImageType.pngAndOthers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          moreText != null && moreText!.isNotEmpty
              ? imageType == ImageType.network
                  ? CustomImageWidget(
                      assetName: imagePath,
                      imageType: ImageType.network,
                      width: width,
                      height: height,
                    )
                  : Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.5),
                            BlendMode.darken,
                          ),
                          child: Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            width: width,
                            height: height,
                          ),
                        ),
                      ),
                    )
              : imageType == ImageType.network
                  ? CustomImageWidget(
                      assetName: imagePath,
                      imageType: ImageType.network,
                      width: width,
                      height: height,
                    )
                  : Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        child: Image.file(
                          File(imagePath),
                          fit: BoxFit.cover,
                          width: width,
                          height: height,
                        ),
                      ),
                    ),
          withCloseIcon
              ? Positioned(
                  top: 3,
                  right: 3,
                  child: GestureDetector(
                    onTap: () => onCloseTap!(),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : moreText != null && moreText!.isNotEmpty
                  ? Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: Positioned(
                        top: 20,
                        left: 4,
                        child: Center(
                          child: NormalTextWidget(
                            moreText!,
                            fontSize: 12,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
