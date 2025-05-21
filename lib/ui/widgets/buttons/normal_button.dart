import 'package:flutter/material.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';

class NormalButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final Widget? widget;
  final IconData? icon;
  final bool atRight;
  final double? width;
  const NormalButton({
    super.key,
    required this.label,
    required this.onTap,
    this.atRight = false,
    this.widget,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: widget ??
          Container(
            width: width ?? double.infinity,
            height: context.width * 0.03,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null && !atRight)
                    Icon(
                      icon,
                      size: context.width * 0.01,
                      color: Colors.white,
                    ),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if (icon != null && atRight)
                    Icon(
                      size: context.width * 0.01,
                      icon,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
    );
  }
}
