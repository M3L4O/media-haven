import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../bloc/player_audio/player_audio_state.dart';
import '../bloc/player_audio/player_bloc.dart';

Future<dynamic> audioDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      final audioPlayerBloc = sl.get<IPlayerAudioBloc>();

      return Dialog(
        child: BlocBuilder<IPlayerAudioBloc, PlayerAudioState>(
            bloc: audioPlayerBloc,
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      if (state.isPlaying) {
                        audioPlayerBloc.pause();
                      } else {
                        audioPlayerBloc.play(
                          url: 'https://www.kozco.com/tech/LRMonoPhase4.mp3',
                        );
                      }
                    },
                    icon: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (state.isPlaying) {
                        audioPlayerBloc.stop();
                      }
                      // audioPlayerBloc.seekTo(0);
                    },
                    icon: Builder(builder: (context) {
                      if (state.isPlaying) {
                        return const Icon(
                          Icons.stop,
                        );
                      }
                      return const Icon(
                        Icons.restart_alt,
                      );
                    }),
                  ),
                ],
              );
            }),
      );
    },
  );
}
