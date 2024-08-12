import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/mh_colors.dart';

Future<dynamic> videoDialog(
  BuildContext context,
  String url,
) async {
  final controller = VideoPlayerController.networkUrl(Uri.parse(url));

  bool hasListen = false;
  ValueNotifier<bool> isMouseOver = ValueNotifier(false);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: controller.initialize(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      return controller.value.isInitialized
                          ? MouseRegion(
                              onHover: (_) => isMouseOver.value = true,
                              onExit: (_) => isMouseOver.value = false,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  controller.value.isBuffering
                                      ? const CircularProgressIndicator()
                                      : AspectRatio(
                                          aspectRatio:
                                              controller.value.aspectRatio,
                                          child: VideoPlayer(controller),
                                        ),
                                  ValueListenableBuilder<bool>(
                                      valueListenable: isMouseOver,
                                      builder: (context, value, child) {
                                        return StatefulBuilder(
                                          builder: (context, setS) {
                                            if (!controller.value.isCompleted &&
                                                !hasListen) {
                                              hasListen = true;
                                              controller.addListener(
                                                () => _listener(
                                                  controller,
                                                  setS,
                                                ),
                                              );
                                            }

                                            return value ||
                                                    !controller.value.isPlaying
                                                ? Center(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        togglePlayPauseVideo(
                                                          controller,
                                                        );
                                                        setS(() {});
                                                      },
                                                      icon: Icon(
                                                        controller
                                                                .value.isPlaying
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        size: 50,
                                                      ),
                                                      color: MHColors.white,
                                                    ),
                                                  )
                                                : Container();
                                          },
                                        );
                                      }),
                                ],
                              ),
                            )
                          : Container();
                    }),
              ),
            ),
          ],
        ),
      );
    },
  );

  controller.dispose();
}

void _listener(VideoPlayerController controller, StateSetter setS) {
  if (controller.value.isCompleted) {
    setS(() {});
  }
}

void togglePlayPauseVideo(VideoPlayerController controller) {
  controller.value.isPlaying ? controller.pause() : controller.play();
}
