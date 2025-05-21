import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/image_picker_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/heading_text_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/normal_text_widget.dart';

class PortfolioDetailsScreen extends StatelessWidget {
  PortfolioDetailsScreen({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _title2Controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();
  final TextEditingController _qualificationSortingIndexController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _jobSortingIndexController =
      TextEditingController();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectUrlController = TextEditingController();
  final TextEditingController _projectDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
          return SingleChildScrollView(
            child: Padding(
              padding: AppSizes.appPadding(context).copyWith(
                bottom: 30,
              ),
              child: Column(
                children: [
                  _buildPictureAndDescription(context),
                  SizedBox(
                    height: 40,
                  ),
                  _buildQualificationPart(context),
                  SizedBox(
                    height: 40,
                  ),
                  _buildWorkHistoryPart(context),
                  SizedBox(
                    height: 40,
                  ),
                  _buildProjectPart(
                      context: context,
                      projectFiles:
                          context.watch<DetailsBloc>().state.projectFiles),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPictureAndDescription(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            children: [
              ImagePickerWidget(
                height: PortfolioDetailsSizes.imageSize(context),
                width: PortfolioDetailsSizes.imageSize(context),
                onPressed: () {
                  context.read<DetailsBloc>().add(ImagePickEvent());
                },
                platformFile:
                    context.watch<DetailsBloc>().state.profilePicturePlatform,
                imgUrl: null,
              ),
              NormalTextWidget(
                Strings.profilePictureSize,
              ),
            ],
          ),
        ),
        SizedBox(
          width: AppSizes.textfieldWidth(context) * 1.016,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _titleController,
                label: Strings.headline1,
                hintText: Strings.enterValue(Strings.headline1.toLowerCase()),
                validator: (value) => ValidatorUtils.customValidatorValidator(
                  value,
                  Strings.isRequired(Strings.headline1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: _title2Controller,
                label: Strings.headline2,
                hintText: Strings.enterValue(Strings.headline2.toLowerCase()),
                validator: (value) => ValidatorUtils.customValidatorValidator(
                    value, Strings.isRequired(Strings.headline2)),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                maxLines: 5,
                controller: _descriptionController,
                label: Strings.description,
                hintText: Strings.enterValue(Strings.description.toLowerCase()),
                validator: (value) => ValidatorUtils.customValidatorValidator(
                  value,
                  Strings.isRequired(Strings.description),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                maxLines: 5,
                controller: _phoneController,
                label: Strings.phoneNumber,
                hintText: Strings.enterValue(Strings.phoneNumber.toLowerCase()),
                validator: (value) => ValidatorUtils.customValidatorValidator(
                  value,
                  Strings.isRequired(Strings.phoneNumber),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context) / 2,
                    maxLines: 5,
                    controller: _githubController,
                    label: Strings.gitHub,
                    hintText: Strings.enterValue(Strings.gitHub.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.gitHub),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context) / 2,
                    maxLines: 5,
                    controller: _linkedInController,
                    label: Strings.linkedIn,
                    hintText:
                        Strings.enterValue(Strings.linkedIn.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.linkedIn),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: NormalButton(
                  label: Strings.aDD,
                  width: AppSizes.textfieldWidth(context),
                  icon: Icons.add,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQualificationPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(
          Strings.addADegree,
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
              Row(
                children: [
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _degreeController,
                    label: Strings.degreeName,
                    hintText:
                        Strings.enterValue(Strings.degreeName.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.degreeName),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _instituteController,
                    label: Strings.institute,
                    hintText:
                        Strings.enterValue(Strings.institute.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.institute),
                    ),
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
                    controller: _completionDateController,
                    label: Strings.completionYear,
                    hintText: Strings.enterValue(
                        Strings.completionYear.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.completionYear)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _qualificationSortingIndexController,
                    label: Strings.sortingIndex,
                    hintText:
                        Strings.enterValue(Strings.sortingIndex.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.sortingIndex)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              NormalButton(
                label: Strings.aDD,
                width: AppSizes.textfieldWidth(context),
                icon: Icons.add,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkHistoryPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(
          Strings.addWorkHistory,
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
              Row(
                children: [
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _positionController,
                    label: Strings.jobPosition,
                    hintText:
                        Strings.enterValue(Strings.jobPosition.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.jobPosition)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _organizationController,
                    label: Strings.organization,
                    hintText:
                        Strings.enterValue(Strings.organization.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.organization)),
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
                    label: Strings.fromDate,
                    hintText:
                        Strings.enterValue(Strings.fromDate.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.fromDate)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _toDateController,
                    label: Strings.toDate,
                    hintText: Strings.enterValue(Strings.toDate.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.toDate)),
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
                    maxLines: 5,
                    controller: _jobDescriptionController,
                    label: Strings.jobDescription,
                    hintText: Strings.enterValue(
                        Strings.jobDescription.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.jobDescription)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _jobSortingIndexController,
                    label: Strings.sortingIndex,
                    hintText:
                        Strings.enterValue(Strings.sortingIndex.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.sortingIndex)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: NormalButton(
                  label: Strings.aDD,
                  width: AppSizes.textfieldWidth(context),
                  icon: Icons.add,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectPart({
    required BuildContext context,
    List<PlatformFile>? projectFiles,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(
          Strings.addAProject,
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
              Row(
                children: [
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _projectNameController,
                    label: Strings.projectName,
                    hintText:
                        Strings.enterValue(Strings.projectName.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.projectName)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextFormField(
                    width: AppSizes.textfieldWidth(context),
                    controller: _projectUrlController,
                    label: Strings.projectUrl,
                    hintText:
                        Strings.enterValue(Strings.projectUrl.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.projectUrl)),
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
                    controller: _projectDescriptionController,
                    label: Strings.projectDescription,
                    hintText: Strings.enterValue(
                        Strings.projectDescription.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.projectDescription),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: AppSizes.textfieldWidth(context),
                    margin: EdgeInsets.only(top: 22),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: (projectFiles?.isNotEmpty ?? false)
                        ? SingleChildScrollView(
                            child: Row(
                              children: projectFiles!
                                  .map(
                                    (element) => NormalTextWidget(
                                      "${element.name},",
                                      textColor: Colors.black,
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        : NormalTextWidget(
                            Strings.selectProjectFiles,
                            textColor: Colors.black,
                          ),
                  ).onTapWidget(
                    onTap: () {
                      context.read<DetailsBloc>().add(PickProjectFilesEvent());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              NormalButton(
                label: Strings.aDD,
                width: AppSizes.textfieldWidth(context),
                icon: Icons.add,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
