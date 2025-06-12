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

class UserProfileDetailsWidget extends StatelessWidget {
  final Function(UserModel) updateUserData;
  final Key userDetailsFormKey;
  UserProfileDetailsWidget({
    super.key,
    required this.userDetailsFormKey,
    required this.updateUserData,
  });
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _title2Controller = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _linkedInController = TextEditingController();

  final TextEditingController _githubController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
      getUserData(context);
      return Form(
        key: userDetailsFormKey,
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
                      label: Strings.aDD,
                      width: AppSizes.textfieldWidth(context),
                      icon: Icons.add,
                      onTap: () => updateUserData(
                        UserModel(
                          description: _descriptionController.text,
                          github: _githubController.text,
                          headline1: _title2Controller.text,
                          headline2: _title2Controller.text,
                          linkedIn: _linkedInController.text,
                          name: _userNameController.text,
                          phoneNumber: _phoneController.text,
                        ),
                      ),
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

  void getUserData(BuildContext context) {
    try {
      context.read<HomeBloc>().add(GetUserData());
      UserModel? userModel = context.read<HomeBloc>().state.userModel;
      if (userModel != null) {
        _userNameController.text = userModel.name!;
        _linkedInController.text = userModel.linkedIn!;
        _githubController.text = userModel.github!;
        _descriptionController.text = userModel.description!;
        // _pictureUrl = userModel.profilePicture!;
        _phoneController.text = userModel.phoneNumber!;
        _title2Controller.text = userModel.headline2!;
        _titleController.text = userModel.headline1!;
      }
    } catch (e) {
      log("Error fetching data in portfolio screen: ${e.toString()}");
    }
  }
}
