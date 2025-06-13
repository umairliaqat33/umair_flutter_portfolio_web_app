import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  final List<ProjectModel> projectsList;
  final bool showHeading;
  final Function(String, int)? editProject;
  final Function(String, int)? deleteProject;
  final bool isEditMode;
  const ProjectsSection({
    super.key,
    required this.projectsList,
    this.showHeading = true,
    this.editProject,
    this.deleteProject,
    this.isEditMode = false,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isMobile = context.width < 600;
    return Padding(
      padding: widget.showHeading
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showHeading)
            Text(
              Strings.featuredProjects,
              style: textTheme.displaySmall!.copyWith(
                color: PortfolioAppTheme.nameColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 20),
          widget.projectsList.isEmpty
              ? Center(
                  child: Text(
                    Strings.noProjects,
                  ),
                )
              : GridView.builder(
                  itemCount: widget.projectsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isMobile ? 1.2 : 1.0,
                  ),
                  itemBuilder: (context, index) {
                    var project = widget.projectsList[index];

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoveredIndex = index),
                      onExit: (_) => setState(() => hoveredIndex = -1),
                      child: SizedBox(
                        width: double.infinity, // Ensure it has a valid width

                        child: AnimatedScale(
                          scale: hoveredIndex == index ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: ProjectCard(
                            isEditMode: widget.isEditMode,
                            project: project,
                            editProject: () => widget.editProject != null
                                ? widget.editProject!(project.id!, index)
                                : null,
                            deleteProject: () => widget.editProject != null
                                ? widget.editProject!(project.id!, index)
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final Function()? editProject;
  final Function()? deleteProject;
  final bool isEditMode;

  const ProjectCard({
    super.key,
    required this.project,
    this.editProject,
    this.deleteProject,
    this.isEditMode = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  CarouselSliderController? carouselController;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.project.filesLinks?.isNotEmpty == true
        ? widget.project.filesLinks!.first
        : 'https://via.placeholder.com/150'; // fallback image
    PlatformFile? imagePath; // fallback image
    if ((widget.project.filesLinks?.isEmpty ?? true) &&
        widget.project.files != null &&
        (widget.project.files?.isNotEmpty ?? false)) {
      imagePath = widget.project.files!.first;
    }

    return GestureDetector(
      onTap: () => _showProjectDialog(context, widget.project),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: widget.project.filesLinks?.isNotEmpty == true &&
                          imagePath != null
                      ? Image.asset(
                          imagePath.path!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 100),
                        )
                      : Image.network(
                          imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 100),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.name ?? 'No Title',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.project.description ??
                            'No description available',
                        maxLines: widget.isEditMode ? 5 : 10,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.isEditMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () =>
                        widget.editProject != null ? widget.editProject!() : {},
                    icon: Icon(
                      Icons.edit,
                      color: PortfolioAppTheme.normalTextColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => widget.deleteProject != null
                        ? widget.deleteProject!()
                        : {},
                    icon: Icon(
                      Icons.delete,
                      color: PortfolioAppTheme.normalTextColor,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void _showProjectDialog(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: PortfolioAppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              project.name ?? 'Project',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: PortfolioAppTheme.primary,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          if (project.link != null && project.link!.isNotEmpty)
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  PortfolioAppTheme.primary,
                ),
              ),
              onPressed: () => _launchUrl(project.link!),
              icon: const Icon(
                Icons.link,
                color: Colors.white,
              ),
              label: const Text(
                "View Project",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
        content: SingleChildScrollView(
          child: Container(
            width: HomeScreenSizes.projectDialogWidth(context),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                CarouselSlider(
                  carouselController: carouselController,
                  items: List.generate(
                    project.filesLinks!.length,
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        project.filesLinks![index],
                        height:
                            HomeScreenSizes.projectDialogImageHeight(context),
                        // width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: PortfolioAppTheme.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: isLandScape(context) ? 0.6 : 0.8,
                    // onPageChanged: (page, reason) {
                    //   controller.selectedPage.value = page;
                    // },
                  ),
                ),
                Container(
                    width: double.infinity, height: 2, color: Colors.grey[400]),
                const SizedBox(height: 20),
                Text(
                  project.description ?? 'No description provided',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
