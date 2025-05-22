import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/education_section.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class EducationPart extends StatelessWidget {
  final List<QualificationModel> qualifications;
  const EducationPart({
    super.key,
    required this.qualifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.qualifications,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: PortfolioAppTheme.nameColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          if (qualifications.isNotEmpty)
            ...qualifications.map(
              (qualification) => EducationSection(
                title: qualification.degreeName ?? "",
                duration: qualification.completionYear ?? "",
                institution: qualification.instituteName ?? "",
              ),
            )
          else
            Center(
              child: Text(
                Strings.noQualifications,
              ),
            ),
        ],
      ),
    );
  }
}
