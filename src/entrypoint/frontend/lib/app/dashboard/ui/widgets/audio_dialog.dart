import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../bloc/player_audio/player_audio_state.dart';
import '../bloc/player_audio/player_bloc.dart';

Future<dynamic> audioDialog(BuildContext context) async {
  final audioPlayerBloc = sl.get<IPlayerAudioBloc>();
  audioPlayerBloc.setUrl(
      url:
          'https://cdn.pixabay.com/download/audio/2023/06/11/audio_1777c08c36.mp3?filename=automobile-horn-153260.mp3');

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: BlocBuilder<IPlayerAudioBloc, PlayerAudioState>(
            bloc: audioPlayerBloc,
            builder: (context, state) {
              double progress = state.position != null && state.duration != null
                  ? state.position!.inMilliseconds /
                      state.duration!.inMilliseconds
                  : 0.0;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      audioPlayerBloc.togglePlayButton();
                    },
                    icon: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value:
                          progress.isNaN || progress.isInfinite ? 0 : progress,
                    ),
                  ),
                  12.w,
                  // IconButton(
                  //   onPressed: () {
                  //     if (state.isPlaying) {
                  //       audioPlayerBloc.stop();
                  //     }
                  //     // audioPlayerBloc.seekTo(0);
                  //   },
                  //   icon: state.isPlaying ?
                  //        const Icon(
                  //         Icons.stop,
                  //       )  Icon(
                  //       Icons.restart_alt,
                  //     );

                  // ),
                ],
              );
            }),
      );
    },
  );
  audioPlayerBloc.stop();
}
