import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../notifier/video_controller.notifier.dart';

final videoPlayerControllerProvider = AsyncNotifierProvider.autoDispose<
    VideoPlayerControllerNotifier,
    VideoPlayerController?>(VideoPlayerControllerNotifier.new);
