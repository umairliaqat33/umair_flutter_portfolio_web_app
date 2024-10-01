import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late FlickManager flickManager;
  @override
  void initState() {
    _initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(flickManager: flickManager),
    );
  }

  Future<void> _initializePlayer() async {
    try {
      flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.asset('assets/images/freelancers.mp4'),
      );
      //       networkUrl(
      //     Uri.parse(
      //         'https://mazwai.com/videvo_files/video/free/2015-11/small_watermarked/9th-may_preview.webm'),
      //   ),
      // );
    } catch (e) {
      log(e.toString());
    }
  }
}
