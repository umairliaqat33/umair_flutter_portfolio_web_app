import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/bloc/home_bloc/home_bloc.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/image_picker_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/normal_text_widget.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';

class UserProfileDetailsWidget extends StatefulWidget {
  final Function(UserModel) updateUserData;
  final UserModel? userModel;
  final Key userDetailsFormKey;
  const UserProfileDetailsWidget({
    super.key,
    required this.userDetailsFormKey,
    required this.updateUserData,
    this.userModel,
  });

  @override
  State<UserProfileDetailsWidget> createState() =>
      _UserProfileDetailsWidgetState();
}

class _UserProfileDetailsWidgetState extends State<UserProfileDetailsWidget> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _title2Controller = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _skillsController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _linkedInController = TextEditingController();

  final TextEditingController _githubController = TextEditingController();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserProfileDetailsWidget oldWidget) {
    getUserData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
      return Form(
        key: widget.userDetailsFormKey,
        child: Row(
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
                    platformFile: null,
                    imgUrl:
                        context.watch<DetailsBloc>().state.profilePictureLink ??
                            context
                                .watch<HomeBloc>()
                                .state
                                .userModel
                                ?.profilePicture,
                  ),
                  NormalTextWidget(
                    AppStrings.profilePictureSize,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSizes.textfieldWidth(context) * 1.016,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _userNameController,
                    label: AppStrings.userName,
                    hintText: AppStrings.enterValue(
                        AppStrings.userName.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      AppStrings.isRequired(AppStrings.userName),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _titleController,
                    label: AppStrings.headline1,
                    hintText: AppStrings.enterValue(
                        AppStrings.headline1.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      AppStrings.isRequired(AppStrings.headline1),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _title2Controller,
                    label: AppStrings.headline2,
                    hintText: AppStrings.enterValue(
                        AppStrings.headline2.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, AppStrings.isRequired(AppStrings.headline2)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    inputAction: TextInputAction.newline,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                    controller: _descriptionController,
                    label: AppStrings.description,
                    hintText: AppStrings.enterValue(
                        AppStrings.description.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      AppStrings.isRequired(AppStrings.description),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    inputAction: TextInputAction.next,
                    maxLines: 5,
                    // inputType: TextInputType.de,
                    controller: _skillsController,
                    label: AppStrings.skills,
                    hintText:
                        "${AppStrings.enterValue(AppStrings.skills.toLowerCase())} ${AppStrings.separatedByComma}",
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      AppStrings.isRequired(AppStrings.skills),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    inputAction: TextInputAction.newline,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                    controller: _phoneController,
                    label: AppStrings.phoneNumber,
                    hintText: AppStrings.enterValue(
                        AppStrings.phoneNumber.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      AppStrings.isRequired(AppStrings.phoneNumber),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomTextFormField(
                        width: AppSizes.textfieldWidth(context) / 2,
                        inputAction: TextInputAction.newline,
                        maxLines: 5,
                        inputType: TextInputType.multiline,
                        controller: _githubController,
                        label: AppStrings.gitHub,
                        hintText: AppStrings.enterValue(
                            AppStrings.gitHub.toLowerCase()),
                        validator: (value) =>
                            ValidatorUtils.customValidatorValidator(
                          value,
                          AppStrings.isRequired(AppStrings.gitHub),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomTextFormField(
                        width: AppSizes.textfieldWidth(context) / 2,
                        inputAction: TextInputAction.newline,
                        maxLines: 5,
                        inputType: TextInputType.multiline,
                        controller: _linkedInController,
                        label: AppStrings.linkedIn,
                        hintText: AppStrings.enterValue(
                            AppStrings.linkedIn.toLowerCase()),
                        validator: (value) =>
                            ValidatorUtils.customValidatorValidator(
                          value,
                          AppStrings.isRequired(AppStrings.linkedIn),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: NormalButton(
                      label: AppStrings.add,
                      width: AppSizes.textfieldWidth(context),
                      icon: Icons.add,
                      onTap: () {
                        widget.updateUserData(
                          UserModel(
                            description: _descriptionController.text,
                            github: _githubController.text,
                            headline1: _titleController.text,
                            headline2: _title2Controller.text,
                            linkedIn: _linkedInController.text,
                            name: _userNameController.text,
                            phoneNumber: _phoneController.text,
                            skills: _skillsController.text,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void getUserData() {
    try {
      if (widget.userModel != null) {
        _userNameController.text = widget.userModel?.name ?? "";
        _linkedInController.text = widget.userModel?.linkedIn ?? "";
        _githubController.text = widget.userModel?.github ?? "";
        _descriptionController.text = widget.userModel?.description ?? "";
        _skillsController.text = widget.userModel?.skills ?? "";
        // _pictureUrl = userModel?.profilePicture!;
        _phoneController.text = widget.userModel?.phoneNumber ?? "";
        _title2Controller.text = widget.userModel?.headline2 ?? "";
        _titleController.text = widget.userModel?.headline1 ?? "";
      }
    } catch (e) {
      log("Error fetching data in portfolio screen: ${e.toString()}");
    }
  }
}
