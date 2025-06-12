import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/common_widgets/info_card_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/heading_text_widget.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';

class QualificationDetailsWidget extends StatelessWidget {
  final List<QualificationModel> qualificationList;
  final Key qualificationFormKey;
  final Function(QualificationModel) addQualification;
  final Function editQualification;
  final Function(int, String) deleteQualification;
  QualificationDetailsWidget({
    super.key,
    required this.qualificationList,
    required this.qualificationFormKey,
    required this.addQualification,
    required this.editQualification,
    required this.deleteQualification,
  });

  final TextEditingController _instituteController = TextEditingController();

  final TextEditingController _degreeController = TextEditingController();

  final TextEditingController _completionDateController =
      TextEditingController();

  final TextEditingController _qualificationSortingIndexController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: qualificationFormKey,
      child: Column(
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
                          ValidatorUtils.customValidatorValidator(value,
                              Strings.isRequired(Strings.completionYear)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CustomTextFormField(
                      width: AppSizes.textfieldWidth(context),
                      controller: _qualificationSortingIndexController,
                      label: Strings.sortingIndex,
                      hintText: Strings.enterValue(
                          Strings.sortingIndex.toLowerCase()),
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
                  onTap: () => addQualification(
                    QualificationModel(
                      completionYear: _completionDateController.text,
                      degreeName: _degreeController.text,
                      instituteName: _instituteController.text,
                      sortingIndex: int.parse(
                        _qualificationSortingIndexController.text,
                      ),
                    ),
                  ),
                ),
                if (qualificationList.isNotEmpty) ...[
                  SizedBox(
                    height: 40,
                  ),
                  TextFieldTitleWidget(
                    label: Strings.existingQualifications,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ...qualificationList.asMap().entries.map(
                        (qualification) => InfoCard(
                          title: qualification.value.degreeName ?? "",
                          details: qualification.value.toMap(),
                          onDeleteTap: () => deleteQualification(
                            qualification.key,
                            qualification.value.id!,
                          ),
                          onEditTap: () => editQualification(
                            qualification.key,
                            qualification.value.id!,
                          ),
                        ),
                      )
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
