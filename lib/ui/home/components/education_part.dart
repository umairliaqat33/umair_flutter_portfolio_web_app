import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/education_section.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
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
      padding: AppSizes.appPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${Strings.qualification}s",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: PortfolioAppTheme.nameColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          if (qualifications.isNotEmpty)
            ...qualifications.map(
              (qualification) => Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: EducationSection(
                  title: qualification.degreeName ?? "",
                  duration: qualification.completionYear ?? "",
                  institution: qualification.instituteName ?? "",
                ),
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
