import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:riverpod/riverpod.dart';

final videoPlayerControllerProvider = StateNotifierProvider<
    VideoPlayerControllerNotifier,
    VideoPlayerController?>((ref) => VideoPlayerControllerNotifier());

class VideoPlayerControllerNotifier
    extends StateNotifier<VideoPlayerController?> {
  VideoPlayerControllerNotifier() : super(null);

  Future<void> initialize(String videoUrl) async {
    final controller = VideoPlayerController.network(videoUrl);
    print('video url is $videoUrl');
    await controller.initialize();
    state = controller;
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}
