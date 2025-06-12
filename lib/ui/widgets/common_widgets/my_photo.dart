import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/assets.dart';

import 'custom_outline.dart';

class MyPhoto extends StatefulWidget {
  final String? picture;
  const MyPhoto({super.key, this.picture});

  @override
  State<MyPhoto> createState() => _MyPhotoState();
}

class _MyPhotoState extends State<MyPhoto> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    sizeAnimation = Tween(begin: 0.0, end: 0.2).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.75, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    //
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;
      final theme = Theme.of(context);
      return SizedBox(
        width: context.width / (isMobile ? 2 : 4),
        height: context.width / (isMobile ? 2 : 4),
        child: AlignTransition(
          alignment: _alignAnimation,
          child: CustomOutline(
            strokeWidth: 5,
            radius: context.width * 0.2 * (isMobile ? 2.4 : 1),
            padding: const EdgeInsets.all(5),
            width: context.width * sizeAnimation.value * (isMobile ? 3 : 1),
            height: context.width * sizeAnimation.value * (isMobile ? 3 : 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.secondaryColor,
                  theme.secondaryColor.withValues(alpha: 0),
                  PortfolioAppTheme.blue,
                  theme.primaryColor
                ],
                stops: const [
                  0.2,
                  0.4,
                  0.6,
                  1
                ]),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomLeft,
                  image: widget.picture == null
                      ? AssetImage(Assets.errorImagePlaceholder)
                      : NetworkImage(widget.picture!),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // String? getDirectGoogleDriveImageUrl(String? url) {
  //   if (url == null) return null;

  //   final regex =
  //       RegExp(r'https:\/\/drive\.google\.com\/file\/d\/([a-zA-Z0-9_-]+)');
  //   final match = regex.firstMatch(url);

  //   if (match != null && match.groupCount >= 1) {
  //     final fileId = match.group(1);
  //     final newUrl = 'https://drive.google.com/uc?export=download&id=$fileId';
  //     return newUrl;
  //   }

  //   // If input url is already direct or not a drive url, return it as is
  //   return url;
  // }
}
