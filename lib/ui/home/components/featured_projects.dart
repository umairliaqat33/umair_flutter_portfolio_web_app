import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:umair_liaqat/utils/app_extensions.dart';
import 'package:umair_liaqat/utils/app_theme.dart';

class FeatureProjects extends StatefulWidget {
  const FeatureProjects({super.key});

  @override
  State<FeatureProjects> createState() => _FeatureProjectsState();
}

class _FeatureProjectsState extends State<FeatureProjects> {
  int hoveredIndex = -1;
  List<Map<String, dynamic>> projects = [];

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  void fetchProjects() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.fetchAndActivate();
      String jsonString = remoteConfig.getString('projects');

      if (jsonString.isEmpty) {
        jsonString = '''
      {
        "projects": [
          {
            "image": "assets/imgs/default.png",
            "title": "Default Project",
            "description": "This is a default project description.",
            "github": "https://github.com/default",
            "videoUrl": "https://www.youtube.com/watch?v=default"
          }
        ]
      }
      ''';
      }

      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      if (jsonData.containsKey('projects') && jsonData['projects'] is List) {
        setState(() {
          projects = List<Map<String, dynamic>>.from(jsonData['projects']);
        });
      } else {
        projects = [];
      }

      log("✅ Projects Loaded Successfully");
    } catch (e) {
      log("❌ Error Fetching Projects: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isMobile = context.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Projects',
            style: textTheme.displaySmall!.copyWith(
              color: PortfolioAppTheme.nameColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          projects.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: projects.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isMobile ? 1.2 : 1.0,
                  ),
                  itemBuilder: (context, index) {
                    var project = projects[index];

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoveredIndex = index),
                      onExit: (_) => setState(() => hoveredIndex = -1),
                      child: SizedBox(
                        width: double.infinity, // Ensure it has a valid width

                        child: AnimatedScale(
                          scale: hoveredIndex == index ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: _buildProjectCard(
                            project["image"],
                            project["title"],
                            project["description"],
                            project["github"],
                            project["videoUrl"],
                            textTheme,
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

  Widget _buildProjectCard(String image, String title, String description,
      String github, String videoUrl, TextTheme textTheme) {
    return GestureDetector(
      onTap: () => _showProjectPopup(context, title, description, videoUrl),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.flutter_dash,
                          size: 50, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.code, size: 18),
                      label: const Text("View on GitHub"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: PortfolioAppTheme.nameColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProjectPopup(
      BuildContext context, String title, String description, String videoUrl) {
    final isMobile = context.width < 600;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? context.width * 0.95 : 800,
              maxHeight: context.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with close button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PortfolioAppTheme.nameColor.withValues(alpha: 0.1),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: PortfolioAppTheme.nameColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        color: PortfolioAppTheme.nameColor,
                      ),
                    ],
                  ),
                ),

                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (videoUrl.isNotEmpty) ...[
                          // Video Player
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: BuildVideoPlayer(videoUrl: videoUrl),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Description
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project Description',
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: PortfolioAppTheme.nameColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const BuildVideoPlayer({super.key, required this.videoUrl});

  @override
  State<BuildVideoPlayer> createState() => _BuildVideoPlayerState();
}

class _BuildVideoPlayerState extends State<BuildVideoPlayer> {
  YoutubePlayerController? _controller;

  bool _isLoading = true;

  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      log('Attempting to load video URL: ${widget.videoUrl}');
      final videoId = _extractVideoId(widget.videoUrl);
      log('Extracted video ID: $videoId');

      if (videoId == null) {
        setState(() {
          _error = "Invalid YouTube URL";
          _isLoading = false;
        });
        return;
      }

      // Create controller with more specific parameters
      // _controller = YoutubePlayerController(
      //   params: const YoutubePlayerParams(
      //     showControls: true,
      //     showFullscreenButton: true,
      //     enableCaption: true,
      //     mute: false,
      //     strictRelatedVideos: true,
      //     playsInline: true,
      //   ),
      // );

      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      );
      log('Loading video with ID: $videoId');

      // Always construct a proper watch URL
      final watchUrl = 'https://www.youtube.com/watch?v=$videoId';
      log('Using watch URL: $watchUrl');

      // try {
      //   // Load the video using the constructed watch URL
      //   await _controller!.loadVideo(watchUrl);
      //   log('Video loaded successfully');
      // } catch (loadError) {
      //   log('Error loading video: $loadError');
      //   setState(() {
      //     _error = "Failed to load video. Please try again.";
      //     _isLoading = false;
      //   });
      //   return;
      // }

      // Wait a bit for the player to initialize
      await Future.delayed(const Duration(milliseconds: 500));
      log('Player initialization complete');

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      log('Error initializing video: $e');
      setState(() {
        _error = "Failed to load video: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _initializeVideo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_controller == null) {
      return const Center(child: Text("Invalid YouTube URL"));
    }

    return YoutubePlayerScaffold(
      controller: _controller!,
      builder: (context, player) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              player,
              // Add a loading overlay
              if (_isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  /// Extracts the YouTube video ID from a given URL, including Shorts.
  String? _extractVideoId(String url) {
    log('Extracting video ID from URL: $url');
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      log('Failed to parse URL');
      return null;
    }

    log('Parsed URI: $uri');
    log('Path segments: ${uri.pathSegments}');

    // Check for 'v' parameter in YouTube URLs (standard YouTube link)
    if (uri.queryParameters.containsKey('v')) {
      log('Found video ID in query parameters: ${uri.queryParameters['v']}');
      return uri.queryParameters['v'];
    }

    // Handle shortened URLs (youtube/VIDEO_ID)
    if (uri.host.contains('youtube')) {
      log('Found youtube URL');
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    // Handle embedded URLs (youtube.com/embed/VIDEO_ID)
    if (uri.pathSegments.contains('embed')) {
      log('Found embed URL');
      int embedIndex = uri.pathSegments.indexOf('embed');
      if (embedIndex != -1 && embedIndex + 1 < uri.pathSegments.length) {
        return uri.pathSegments[embedIndex + 1];
      }
    }

    // Handle Shorts URLs (youtube.com/shorts/VIDEO_ID)
    if (uri.pathSegments.contains('shorts')) {
      log('Found Shorts URL');
      int shortsIndex = uri.pathSegments.indexOf('shorts');
      if (shortsIndex != -1 && shortsIndex + 1 < uri.pathSegments.length) {
        String videoId = uri.pathSegments[shortsIndex + 1];
        // Remove any query parameters from the video ID
        videoId = videoId.split('?')[0];
        log('Extracted Shorts video ID: $videoId');
        return videoId;
      }
    }

    log('No valid video ID found in URL');
    return null;
  }
}
