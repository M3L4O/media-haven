import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../data/models/file_base.dart';
import '../bloc/player_audio/audio_player_bloc.dart';
import '../bloc/player_audio/audio_player_state.dart';

Future<dynamic> audioDialog(
  BuildContext context,
  FileBase file,
) async {
  final audioPlayerBloc = sl.get<IAudioPlayerBloc>();

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: BlocBuilder<IAudioPlayerBloc, PlayerAudioState>(
            bloc: audioPlayerBloc,
            builder: (context, state) {
              double progress = state.position != null && state.duration != null
                  ? state.position!.inMilliseconds /
                      state.duration!.inMilliseconds
                  : 0.0;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  6.h,
                  Text(
                    file.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MHColors.darkGray,
                    ),
                  ),
                  Row(
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
                          value: progress.isNaN || progress.isInfinite
                              ? 0
                              : progress,
                        ),
                      ),
                      12.w,
                    ],
                  ),
                  6.h,
                ],
              );
            }),
      );
    },
  );
  audioPlayerBloc.stop();
}
