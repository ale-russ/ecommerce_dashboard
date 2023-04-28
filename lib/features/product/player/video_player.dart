import 'dart:developer';

import 'package:ecommerce_dashboard/features/product/player/provider/video_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/custome_appbar.dart';
import 'package:video_player/video_player.dart';
import 'player_page.dart';

class VideoPlayer extends ConsumerStatefulWidget {
  const VideoPlayer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends ConsumerState<VideoPlayer> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    var videoPlayerController = ref.watch(videoPlayerControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: const CustomAppBar(
        title: 'Trailer',
        isCenterTile: true,
      ),
      body: videoPlayerController.when(
        data: (data) {
          return GestureDetector(
            onLongPressUp: () {
              data.value.volume + 0.5;
            },
            onTap: () => playPauseVideo(videoPlayerController),
            child: Stack(
              children: [
                const Center(
                  child: VideoPlayerWidget(),
                ),
                Positioned(
                  bottom: 4,
                  child: Container(
                    height: 80,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                          child: VideoProgressIndicator(
                            videoPlayerController.value!,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                                backgroundColor: Colors.white,
                                playedColor: Colors.amber,
                                bufferedColor: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          // height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ControlButtons(
                                onTap: () {},
                                icon: Icons.volume_mute_sharp,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 40),
                              Row(
                                children: [
                                  ControlButtons(
                                    onTap: () async {
                                      var newPosition =
                                          (await data!.position)!.inSeconds -
                                              10;
                                      data.seekTo(
                                          Duration(seconds: newPosition));
                                    },
                                    icon: Icons.fast_rewind_rounded,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      playPauseVideo(videoPlayerController);
                                    },
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause_circle
                                          : Icons.play_circle,
                                      color: Colors.amber,
                                      size: 35,
                                    ),
                                  ),
                                  ControlButtons(
                                      onTap: () async {
                                        var newPosition =
                                            (await data!.position)!.inSeconds +
                                                10;
                                        data.seekTo(
                                            Duration(seconds: newPosition));
                                      },
                                      icon: Icons.fast_forward_rounded),
                                ],
                              ),
                              const SizedBox(width: 50),
                              Text(
                                ' ${data!.value.duration.inMinutes} Mins ',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $error')));
          context.pop();
          return const SizedBox.shrink();
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }

  void playPauseVideo(
      AsyncValue<VideoPlayerController?> videoPlayerController) {
    if (videoPlayerController.value!.value.isPlaying) {
      videoPlayerController.value!.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      videoPlayerController.value!.play();
      setState(() {
        isPlaying = true;
      });
    }
  }
}

class ControlButtons extends ConsumerWidget {
  const ControlButtons(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.color = Colors.amber})
      : super(key: key);
  final Function onTap;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => onTap,
      icon: Icon(
        icon,
        color: color,
        size: 35,
      ),
    );
  }
}
