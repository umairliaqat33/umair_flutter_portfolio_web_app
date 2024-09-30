import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/config/size_config.dart';

class ProjectContainerWidget extends StatelessWidget {
  const ProjectContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height50(context),
      width: SizeConfig.width30(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            SizeConfig.height1(context),
          ),
        ),
      ),
    );
  }
}
