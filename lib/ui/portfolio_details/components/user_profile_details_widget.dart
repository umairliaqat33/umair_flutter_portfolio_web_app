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
                    controller: _userNameController,
                    label: Strings.userName,
                    hintText:
                        Strings.enterValue(Strings.userName.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.userName),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _titleController,
                    label: Strings.headline1,
                    hintText:
                        Strings.enterValue(Strings.headline1.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
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
                    hintText:
                        Strings.enterValue(Strings.headline2.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                            value, Strings.isRequired(Strings.headline2)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    inputAction: TextInputAction.newline,
                    maxLines: 5,
                    inputType: TextInputType.multiline,
                    controller: _descriptionController,
                    label: Strings.description,
                    hintText:
                        Strings.enterValue(Strings.description.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.description),
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
                    label: Strings.skills,
                    hintText:
                        "${Strings.enterValue(Strings.skills.toLowerCase())} ${Strings.separatedByComma}",
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
                      value,
                      Strings.isRequired(Strings.skills),
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
                    label: Strings.phoneNumber,
                    hintText:
                        Strings.enterValue(Strings.phoneNumber.toLowerCase()),
                    validator: (value) =>
                        ValidatorUtils.customValidatorValidator(
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
                        inputAction: TextInputAction.newline,
                        maxLines: 5,
                        inputType: TextInputType.multiline,
                        controller: _githubController,
                        label: Strings.gitHub,
                        hintText:
                            Strings.enterValue(Strings.gitHub.toLowerCase()),
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
                        inputAction: TextInputAction.newline,
                        maxLines: 5,
                        inputType: TextInputType.multiline,
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
                      label: Strings.add,
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
