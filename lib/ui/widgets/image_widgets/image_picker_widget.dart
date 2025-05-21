import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/assets.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/custom_image_widget.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function onPressed;
  final PlatformFile? platformFile;
  final String? imgUrl;
  final double? height;
  final double? width;

  const ImagePickerWidget({
    super.key,
    required this.onPressed,
    required this.platformFile,
    required this.imgUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return (imgUrl != null && imgUrl!.isNotEmpty) && platformFile == null
        ? GestureDetector(
            onTap: () => onPressed(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: PortfolioAppTheme.primary,
                      width: 1,
                    ),
                  ),
                  width: width ?? 100,
                  height: height ?? 100,
                  padding: const EdgeInsets.all(2),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      child: Image.network(
                        width: double.infinity,
                        imgUrl!,
                        fit: BoxFit.cover,
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
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Show the fallback image in case of an error
                          return Image.asset(
                            Assets.errorImagePlaceholder,
                            width: 80,
                            height: 80,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // SmallHeadingTextWidget(
                //   headingText ?? AppStrings.uploadImage,
                //   textColor: PortfolioAppTheme.primary,
                // ),
                // SmallHeadingTextWidget(
                //   subtitleText ?? AppStrings.clickToUploadImage,
                //   fontSize: SizeConfig.font12(),
                //   textColor: subtitleTextColor,
                // )
              ],
            ),
          )
        : platformFile != null
            ? GestureDetector(
                onTap: () => onPressed(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PortfolioAppTheme.primary,
                          width: 1,
                        ),
                      ),
                      width: width ?? 100,
                      height: height ?? 100,
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          child: Image.network(
                            platformFile!.path!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // SmallHeadingTextWidget(
                    //   AppStrings.uploadImage,
                    //   textColor: PortfolioAppTheme.primary,
                    // ),
                    // SmallHeadingTextWidget(
                    //   AppStrings.clickToUploadImage,
                    //   fontSize: SizeConfig.font12(),
                    //   textColor: subtitleTextColor,
                    // )
                  ],
                ),
              )
            : GestureDetector(
                onTap: () async => onPressed(),
                child: Column(
                  children: [
                    Container(
                      height: height ?? 100,
                      width: width ?? 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: CustomImageWidget(
                        assetName: Assets.imagePickerIcon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    // SmallHeadingTextWidget(
                    //   AppStrings.uploadImage,
                    //   textColor: PortfolioAppTheme.primary,
                    // ),
                    // SmallHeadingTextWidget(
                    //   AppStrings.clickToUploadImage,
                    //   fontSize: SizeConfig.font12(),
                    //   textColor: subtitleTextColor,
                    // )
                  ],
                ),
              );
  }
}
