import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';
import 'package:umair_liaqat_portfolio/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String title;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     primaryColor,
          //     secondaryColor,
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: SizeConfig.height10(context) + 2,
        width: SizeConfig.width20(context),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: whiteColor,
              fontSize: SizeConfig.font10(context),
            ),
          ),
        ),
      ),
    );
  }
}
