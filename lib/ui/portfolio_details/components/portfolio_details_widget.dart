import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/ui/home/components/featured_projects.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/heading_text_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/normal_text_widget.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';

class ProjectDetailsWidget extends StatefulWidget {
  final List<ProjectModel> projectsList;
  final GlobalKey<FormState> projectFormKey;
  const ProjectDetailsWidget({
    super.key,
    required this.projectsList,
    required this.projectFormKey,
  });

  @override
  State<ProjectDetailsWidget> createState() => _ProjectDetailsWidgetState();
}

class _ProjectDetailsWidgetState extends State<ProjectDetailsWidget> {
  final TextEditingController _projectNameController = TextEditingController();

  final TextEditingController _projectUrlController = TextEditingController();

  final TextEditingController _projectDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
        builder: (BuildContext context, DetailsState state) {
      return Form(
        key: widget.projectFormKey,
        child: Column(
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
                        hintText: Strings.enterValue(
                            Strings.projectName.toLowerCase()),
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
                        hintText: Strings.enterValue(
                            Strings.projectUrl.toLowerCase()),
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
                        inputAction: TextInputAction.newline,
                        maxLines: 5,
                        inputType: TextInputType.multiline,
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
                        child: (context
                                    .watch<DetailsBloc>()
                                    .state
                                    .projectFiles
                                    ?.isNotEmpty ??
                                false)
                            ? Wrap(
                                children: context
                                    .watch<DetailsBloc>()
                                    .state
                                    .projectFiles!
                                    .map(
                                      (element) => NormalTextWidget(
                                        "   ${element.name},   ",
                                        textColor: Colors.black,
                                      ),
                                    )
                                    .toList(),
                              )
                            : NormalTextWidget(
                                Strings.selectProjectFiles,
                                textColor: Colors.black,
                              ),
                      ).onTapWidget(
                        onTap: () {
                          context
                              .read<DetailsBloc>()
                              .add(PickProjectFilesEvent());
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
                    onTap: () {
                      if (widget.projectFormKey.currentState!.validate()) {
                        ProjectModel projectModel = ProjectModel(
                          files: context.read<DetailsBloc>().state.projectFiles,
                          description: _projectDescriptionController.text,
                          link: _projectUrlController.text,
                          name: _projectNameController.text,
                        );
                        context.read<DetailsBloc>().add(
                              UploadProjectEvent(
                                projectModel: projectModel,
                                context: context,
                              ),
                            );
                        widget.projectsList.add(projectModel);
                        setState(() {});
                        _projectDescriptionController.clear();
                        _projectNameController.clear();
                        _projectUrlController.clear();
                      }
                    },
                  ),
                  if (widget.projectsList.isNotEmpty) ...[
                    SizedBox(
                      height: 40,
                    ),
                    TextFieldTitleWidget(
                      label: Strings.existingProjects,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProjectsSection(
                      projectsList: widget.projectsList,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
