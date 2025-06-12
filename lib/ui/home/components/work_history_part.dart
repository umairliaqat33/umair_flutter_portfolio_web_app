import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/ui/portfolio_details/components/job_details_section.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class WorkHistoryPart extends StatelessWidget {
  final List<JobHistory> jobHistoryList;
  const WorkHistoryPart({
    super.key,
    required this.jobHistoryList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.workHistory,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: PortfolioAppTheme.nameColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          if (jobHistoryList.isNotEmpty)
            ...jobHistoryList.map(
              (job) => Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: JobDetailsSection(
                  organization: job.organization ?? "",
                  designation: job.position ?? "",
                  fromDate: job.fromDate ?? "",
                  toDate: job.toDate ?? "",
                  description: job.jobDescription ?? "",
                ),
              ),
            )
          else
            Center(
              child: Text(
                Strings.noWorkHistory,
              ),
            ),
        ],
      ),
    );
  }
}
