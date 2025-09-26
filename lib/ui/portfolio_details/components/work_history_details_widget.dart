import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/info_card_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/heading_text_widget.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';

class WorkHistoryDetailsWidget extends StatefulWidget {
  final List<JobHistory> workHistoryList;
  final Key workHistoryFormKey;
  final Function(JobHistory) addWorkHistory;
  final Function editWorkHistory;
  final Function(int, String) deleteWorkHistory;
  const WorkHistoryDetailsWidget({
    super.key,
    required this.workHistoryList,
    required this.workHistoryFormKey,
    required this.addWorkHistory,
    required this.editWorkHistory,
    required this.deleteWorkHistory,
  });

  @override
  State<WorkHistoryDetailsWidget> createState() =>
      _WorkHistoryDetailsWidgetState();
}

class _WorkHistoryDetailsWidgetState extends State<WorkHistoryDetailsWidget> {
  final TextEditingController _positionController = TextEditingController();

  final TextEditingController _organizationController = TextEditingController();

  final TextEditingController _fromDateController = TextEditingController();

  final TextEditingController _toDateController = TextEditingController();

  final TextEditingController _jobDescriptionController =
      TextEditingController();

  final TextEditingController _jobSortingIndexController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.workHistoryFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingTextWidget(
            AppStrings.addWorkHistory,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: PortfolioDetailsSizes.imageSectionPadding(context),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _fieldsSection(),
                if (widget.workHistoryList.isNotEmpty) ...[
                  SizedBox(
                    height: 40,
                  ),
                  TextFieldTitleWidget(
                    label: AppStrings.existingWorkHistory,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ...widget.workHistoryList.asMap().entries.map(
                        (workHistory) => InfoCard(
                          title: workHistory.value.position ?? "",
                          details: workHistory.value.toMap(),
                          onDeleteTap: () => widget.deleteWorkHistory(
                              workHistory.key, workHistory.value.id!),
                          onEditTap: () => showEditDialog(
                            workHistory.value,
                            workHistory.key,
                          ),
                        ),
                      ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showEditDialog(
    JobHistory qualification,
    int index,
  ) async {
    _positionController.text = qualification.position ?? "";

    _organizationController.text = qualification.organization ?? "";

    _fromDateController.text = qualification.fromDate ?? "";

    _toDateController.text = qualification.toDate ?? "";

    _jobDescriptionController.text = qualification.jobDescription ?? "";

    _jobSortingIndexController.text = qualification.sortIndex?.toString() ?? "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          content: SingleChildScrollView(
            child: _fieldsSection(
              isEditMode: true,
              index: index,
            ),
          ),
        );
      },
    );
  }

  Widget _fieldsSection({
    bool isEditMode = false,
    int? index,
  }) {
    return Column(
      children: [
        Row(
          children: [
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _positionController,
              label: AppStrings.jobPosition,
              hintText:
                  AppStrings.enterValue(AppStrings.jobPosition.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.jobPosition)),
            ),
            SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _organizationController,
              label: AppStrings.organization,
              hintText:
                  AppStrings.enterValue(AppStrings.organization.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.organization)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _fromDateController,
              label: AppStrings.fromDate,
              hintText:
                  AppStrings.enterValue(AppStrings.fromDate.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.fromDate)),
            ),
            SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _toDateController,
              label: AppStrings.toDate,
              hintText: AppStrings.enterValue(AppStrings.toDate.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.toDate)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              inputAction: TextInputAction.newline,
              maxLines: 5,
              inputType: TextInputType.multiline,
              controller: _jobDescriptionController,
              label: AppStrings.jobDescription,
              hintText: AppStrings.enterValue(
                  AppStrings.jobDescription.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.jobDescription)),
            ),
            SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _jobSortingIndexController,
              label: AppStrings.sortingIndex,
              hintText:
                  AppStrings.enterValue(AppStrings.sortingIndex.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, AppStrings.isRequired(AppStrings.sortingIndex)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: NormalButton(
            label: isEditMode ? AppStrings.update : AppStrings.add,
            width: AppSizes.textfieldWidth(context),
            icon: isEditMode ? null : Icons.add,
            onTap: () {
              if (isEditMode) {
                JobHistory job = JobHistory(
                  fromDate: _fromDateController.text,
                  id: widget.workHistoryList[index!].id,
                  userId: widget.workHistoryList[index].userId,
                  jobDescription: _jobDescriptionController.text,
                  organization: _organizationController.text,
                  position: _positionController.text,
                  toDate: _toDateController.text,
                  sortIndex: int.parse(_jobSortingIndexController.text),
                );
                context.read<DetailsBloc>().add(
                      UpdateWorkHistory(
                        context: context,
                        jobHistory: job,
                      ),
                    );
                widget.workHistoryList[index] = job;
                setState(() {});
              } else {
                widget.addWorkHistory(
                  JobHistory(
                    fromDate: _fromDateController.text,
                    jobDescription: _jobDescriptionController.text,
                    organization: _organizationController.text,
                    position: _positionController.text,
                    sortIndex: int.parse(_jobSortingIndexController.text),
                    toDate: _toDateController.text,
                  ),
                );
              }
              _fromDateController.clear();
              _jobDescriptionController.clear();
              _organizationController.clear();
              _positionController.clear();
              _jobSortingIndexController.clear();
              _toDateController.clear();
            },
          ),
        ),
      ],
    );
  }
}
