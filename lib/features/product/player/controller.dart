import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier.dart';

class VideoPlayerWidget extends ConsumerWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoPlayerController = ref.watch(videoPlayerControllerProvider);

    if (videoPlayerController == null) {
      print('loading page $videoPlayerController');
      return const CircularProgressIndicator();
    }

    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: VideoPlayer(videoPlayerController),
    );
  }
}
