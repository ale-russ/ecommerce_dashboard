import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:riverpod/riverpod.dart';

class VideoPlayerControllerNotifier
    extends AutoDisposeAsyncNotifier<VideoPlayerController?> {
  @override
  build() {
    return initialize();
  }

  var videoUrl =
      'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
  // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  Future<VideoPlayerController> initialize() async {
    final controller = VideoPlayerController.network(videoUrl);
    log('video url is $videoUrl');
    await controller.initialize();
    controller.value.isInitialized ? controller.play() : controller.pause();
    return controller;
  }
}
