import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';

class ProjectDetailsWidget extends StatefulWidget {
  final List<ProjectModel> projectsList;
  final GlobalKey<FormState> projectFormKey;
  final bool isEditMode;
  const ProjectDetailsWidget({
    super.key,
    required this.projectsList,
    required this.projectFormKey,
    this.isEditMode = false,
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
                  projectComponents(
                    (project) {
                      if (context
                              .read<DetailsBloc>()
                              .state
                              .projectFiles
                              ?.isEmpty ??
                          true) {
                        Fluttertoast.showToast(
                          msg: Strings.pleaseAddPicture,
                        );
                        return;
                      }
                      context.read<DetailsBloc>().add(
                            UploadProjectEvent(
                              projectModel: project,
                              context: context,
                            ),
                          );
                      widget.projectsList.add(project);
                    },
                  ),
                  if (widget.projectsList.isNotEmpty && !widget.isEditMode) ...[
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
                      isEditMode: true,
                      projectsList: widget.projectsList,
                      showHeading: false,
                      deleteProject: (id, index) {
                        context.read<DetailsBloc>().add(
                              DeleteProject(
                                id: id,
                                context: context,
                              ),
                            );
                        widget.projectsList.removeAt(index);
                        setState(() {});
                      },
                      editProject: (id, index) async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  PortfolioAppTheme.greyButtonColor,
                              content: projectComponents(
                                  project: widget.projectsList[index],
                                  isEditMode: true, (project) {
                                context.read<DetailsBloc>().add(
                                      UpdateProjectEvent(
                                        projectModel: project,
                                        context: context,
                                      ),
                                    );
                                int index = widget.projectsList.indexWhere(
                                    (element) => element.id == project.id);
                                widget.projectsList[index] = project;
                                Navigator.pop(context);
                              }),
                            );
                          },
                        );
                      },
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

  Widget projectComponents(
    Function(ProjectModel) onTap, {
    bool isEditMode = false,
    ProjectModel? project,
  }) {
    List<String> images = [];
    if (project != null) {
      _projectDescriptionController.text = project.description ?? "";
      _projectNameController.text = project.name ?? "";
      _projectUrlController.text = project.link ?? "";
      images = project.filesLinks ?? [];
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _projectNameController,
              label: Strings.projectName,
              hintText: Strings.enterValue(Strings.projectName.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, Strings.isRequired(Strings.projectName)),
            ),
            SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              width: AppSizes.textfieldWidth(context),
              controller: _projectUrlController,
              label: Strings.projectUrl,
              hintText: Strings.enterValue(Strings.projectUrl.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
                  value, Strings.isRequired(Strings.projectUrl)),
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
              controller: _projectDescriptionController,
              inputAction: TextInputAction.newline,
              maxLines: 5,
              inputType: TextInputType.multiline,
              label: Strings.projectDescription,
              hintText:
                  Strings.enterValue(Strings.projectDescription.toLowerCase()),
              validator: (value) => ValidatorUtils.customValidatorValidator(
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
                  : images.isNotEmpty
                      ? Wrap(
                          children: images
                              .map(
                                (element) => NormalTextWidget(
                                  "   $element,   ",
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
                context.read<DetailsBloc>().add(PickProjectFilesEvent());
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        NormalButton(
          label: isEditMode ? Strings.update : Strings.add,
          width: AppSizes.textfieldWidth(context),
          icon: isEditMode ? null : Icons.add,
          onTap: () {
            if (widget.projectFormKey.currentState!.validate()) {
              ProjectModel projectModel = ProjectModel(
                id: project?.id,
                files: context.read<DetailsBloc>().state.projectFiles,
                description: _projectDescriptionController.text,
                link: _projectUrlController.text,
                name: _projectNameController.text,
              );
              onTap(projectModel);
              setState(() {});
              _projectDescriptionController.clear();
              _projectNameController.clear();
              _projectUrlController.clear();
            }
          },
        ),
      ],
    );
  }
}
