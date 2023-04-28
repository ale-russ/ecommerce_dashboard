import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_dashboard/features/product/player/provider/video_player_provider.dart';

class VideoPlayerWidget extends ConsumerWidget {
  final String? videoUrl;

  const VideoPlayerWidget({Key? key, this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoPlayerController = ref.watch(videoPlayerControllerProvider);

    return AspectRatio(
      aspectRatio: videoPlayerController.value!.value.aspectRatio,
      child: VideoPlayer(videoPlayerController.value!),
    );
  }
}
