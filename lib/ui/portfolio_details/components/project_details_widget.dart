import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_bloc.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_events.dart';
import 'package:umair_liaqat/bloc/details_bloc/details_state.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/ui/widgets/buttons/normal_button.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/image_with_close_icon.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/custom_text_form_field.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/heading_text_widget.dart';
import 'package:umair_liaqat/ui/widgets/text_widgets.dart/normal_text_widget.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
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
  ScrollController scrollbarController = ScrollController();
  ScrollController editDialogController = ScrollController();
  ScrollController assetImagesController = ScrollController();
  final TextEditingController _projectNameController = TextEditingController();

  final TextEditingController _projectUrlController = TextEditingController();

  final TextEditingController _projectDescriptionController =
      TextEditingController();
  List<String> images = [];
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
                      setState(() {});
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
                    ...widget.projectsList.asMap().entries.map((project) {
                      final projectJson = project.value.toMapWithoutFiles();
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    project.value.name ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppSizes.infoCardTitleFontSize(
                                                  context),
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () => onEditTap(
                                          project.value,
                                          project.key,
                                        ),
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              PortfolioAppTheme.normalTextColor,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.read<DetailsBloc>().add(
                                                DeleteProject(
                                                  id: project.value.id!,
                                                  context: context,
                                                ),
                                              );
                                          widget.projectsList
                                              .removeAt(project.key);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color:
                                              PortfolioAppTheme.normalTextColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...projectJson.entries.map(
                                (entry) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${entry.key}: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        Expanded(
                                          child: Text(
                                            entry.value?.toString() ?? "",
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              if (project.value.filesLinks != null &&
                                  project.value.filesLinks!.isNotEmpty)
                                Scrollbar(
                                  controller: scrollbarController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  // interactive: true,
                                  child: SingleChildScrollView(
                                    controller: scrollbarController,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...project.value.filesLinks!.map(
                                          (link) => Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: ImageWithCloseIcon(
                                              withCloseIcon: false,
                                              imagePath: link,
                                              height: PortfolioDetailsSizes
                                                  .imageSize(context),
                                              width: PortfolioDetailsSizes
                                                  .imageSize(context),
                                              imageType: ImageType.network,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
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
    if (project != null && isEditMode) {
      // Only clear projectFiles once when the popup is first opened.
      if (context.read<DetailsBloc>().state.projectFiles?.isEmpty ?? true) {
        context.read<DetailsBloc>().add(DeleteProjectAllFilesEvent());
      }
      _projectDescriptionController.text = project.description ?? "";
      _projectNameController.text = project.name ?? "";
      _projectUrlController.text = project.link ?? "";
      images = project.filesLinks?.toList() ?? [];
    }

    return StatefulBuilder(builder: (context, setStates) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomTextFormField(
                  width: AppSizes.textfieldWidth(context),
                  controller: _projectNameController,
                  label: Strings.projectName,
                  hintText:
                      Strings.enterValue(Strings.projectName.toLowerCase()),
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
                  hintText:
                      Strings.enterValue(Strings.projectUrl.toLowerCase()),
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
                  hintText: Strings.enterValue(
                      Strings.projectDescription.toLowerCase()),
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
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: NormalTextWidget(
                    Strings.selectProjectFiles,
                    textColor: Colors.white,
                  ),
                ).onTapWidget(
                  onTap: () {
                    context.read<DetailsBloc>().add(PickProjectFilesEvent());
                  },
                ),
              ],
            ),
            if ((context.watch<DetailsBloc>().state.projectFiles?.isNotEmpty ??
                    false) &&
                !isEditMode) ...[
              SizedBox(
                height: 20,
              ),
              Scrollbar(
                controller: assetImagesController,
                child: SingleChildScrollView(
                  controller: assetImagesController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...context
                          .watch<DetailsBloc>()
                          .state
                          .projectFiles!
                          .asMap()
                          .entries
                          .map(
                            (link) => Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: ImageWithCloseIcon(
                                withCloseIcon: true,
                                onCloseTap: () {
                                  context.read<DetailsBloc>().add(
                                        DeleteProjectFilesEvent(
                                          index: link.key,
                                        ),
                                      );
                                  setState(() {});
                                },
                                imagePath: link.value.path!,
                                height:
                                    PortfolioDetailsSizes.imageSize(context) /
                                        2,
                                width:
                                    PortfolioDetailsSizes.imageSize(context) /
                                        2,
                                imageType: ImageType.network,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
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
                    filesLinks: isEditMode ? images : null,
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
            if (isEditMode && project != null) ...[
              SizedBox(
                height: 20,
              ),
              Scrollbar(
                controller: editDialogController,
                thumbVisibility: true,
                trackVisibility: true,
                // interactive: true,
                child: SingleChildScrollView(
                  controller: editDialogController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (context
                              .watch<DetailsBloc>()
                              .state
                              .projectFiles
                              ?.isNotEmpty ??
                          false)
                        ...context
                            .watch<DetailsBloc>()
                            .state
                            .projectFiles!
                            .asMap()
                            .entries
                            .map(
                              (file) => Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: ImageWithCloseIcon(
                                  withCloseIcon: true,
                                  onCloseTap: () {
                                    context.read<DetailsBloc>().add(
                                          DeleteProjectFilesEvent(
                                            index: file.key,
                                          ),
                                        );
                                    setStates(() {});
                                  },
                                  imagePath: file.value.path!,
                                  height:
                                      PortfolioDetailsSizes.imageSize(context) /
                                          2,
                                  width:
                                      PortfolioDetailsSizes.imageSize(context) /
                                          2,
                                  imageType: ImageType.network,
                                ),
                              ),
                            ),
                      ...images.asMap().entries.map(
                            (link) => Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: ImageWithCloseIcon(
                                withCloseIcon: true,
                                onCloseTap: () {
                                  setStates(() {
                                    images.removeAt(link.key);
                                  });
                                },
                                imagePath: link.value,
                                height:
                                    PortfolioDetailsSizes.imageSize(context) /
                                        2,
                                width:
                                    PortfolioDetailsSizes.imageSize(context) /
                                        2,
                                imageType: ImageType.network,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Future<void> onEditTap(ProjectModel project, int index) async {
    context.read<DetailsBloc>().add(DeleteProjectAllFilesEvent());

    // preload values
    _projectDescriptionController.text = project.description ?? "";
    _projectNameController.text = project.name ?? "";
    _projectUrlController.text = project.link ?? "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey,
        content: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return projectComponents(
              isEditMode: true,
              project: project,
              (updatedProject) {
                context.read<DetailsBloc>().add(
                      UpdateProjectEvent(
                        projectModel: updatedProject,
                        context: context,
                      ),
                    );

                widget.projectsList[index] = updatedProject;
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
    );
  }
}
