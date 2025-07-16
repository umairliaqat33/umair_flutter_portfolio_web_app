import 'package:file_picker/file_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/ui/widgets/image_widgets/custom_image_widget.dart';
import 'package:umair_liaqat/utils/app_enum.dart';
import 'package:umair_liaqat/utils/app_sizes.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  final List<ProjectModel> projectsList;
  final Function(String)? removeImage;
  const ProjectsSection({
    super.key,
    required this.projectsList,
    this.removeImage,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppSizes.appPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              : isTablet(context)
                  ? Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: widget.projectsList
                          .asMap()
                          .entries
                          .map((entry) => SizedBox(
                                width: 340.w,
                                child: projectCardWithMouseRegion(
                                    entry.key, entry.value),
                              ))
                          .toList(),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.projectsList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var project = widget.projectsList[index];

                        return projectCardWithMouseRegion(index, project);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 200.w,
                        );
                      },
                    ),
        ],
      ),
    );
  }

  Widget projectCardWithMouseRegion(int index, ProjectModel project) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: SizedBox(
        width: double.infinity, // Ensure it has a valid width

        child: AnimatedScale(
          scale: hoveredIndex == index ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: ProjectCard(
            removeImage: (imageUrl) => widget.removeImage != null
                ? {
                    widget.projectsList[index].filesLinks
                        ?.removeWhere((element) => element == imageUrl)
                  }
                : {},
            project: project,
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final Function(String)? removeImage;

  const ProjectCard({
    super.key,
    required this.project,
    this.removeImage,
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
                          height: 180.w,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 100),
                        )
                      : Image.network(
                          imageUrl,
                          height: 180.w,
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
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: !isTablet(context) ? 48.sp : null,
                  ),
            ),
            if (isTablet(context))
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
          if (!isTablet(context))
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  PortfolioAppTheme.primary,
                ),
              ),
              child: const Text(
                "Close",
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
                SizedBox(
                  height: HomeScreenSizes.projectDialogImageHeight(context),
                  child: CarouselSlider(
                    carouselController: carouselController,
                    items: List.generate(
                      project.filesLinks!.length,
                      (index) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CustomImageWidget(
                          assetName: project.filesLinks![index],
                          imageType: ImageType.network,
                          height:
                              HomeScreenSizes.projectDialogImageHeight(context),
                          // width: double.infinity,
                          // fit: BoxFit.cover,
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
