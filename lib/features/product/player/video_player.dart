import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/custome_appbar.dart';
import 'controller.dart';

class videoplayer extends ConsumerWidget {
  const videoplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'trailer',
        isCenterTile: true,
      ),
      body: Center(
        child: VideoPlayerWidget(
            videoUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
      ),
    );
  }
}
