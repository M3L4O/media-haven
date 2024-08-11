import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'player_audio_state.dart';

abstract class IPlayerAudioBloc extends Cubit<PlayerAudioState> {
  IPlayerAudioBloc() : super(PlayerAudioState());

  Future<void> play({required String url});
  Future<void> pause();
  Future<void> stop();
  void listenDuration();
}

class PlayerAudioBloc extends IPlayerAudioBloc {
  final player = AudioPlayer(); // Create a player

  @override
  Future<void> play({required String url}) async {
    emit(state.copyWith(isLoading: true));
    try {
      await player.setUrl(url);

      if (player.playing) {
        pause();
        return;
      }

      player.play();
      emit(state.copyWith(isPlaying: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> pause() async {
    if (player.playing) {
      await player.pause();
      emit(state.copyWith(isPaused: true));
    }
    // TODO: implement play when is paused
    // emit(state.copyWith(isPaused: false));
  }

  @override
  Future<void> stop() async {
    await player.stop();
    emit(state.copyWith(isStopped: true));
  }

  @override
  void listenDuration() {
    player.durationStream.listen((event) {
      if (event == null) {
        return;
      }
      emit(
        state.copyWith(
          position: player.position,
          duration: event,
        ),
      );
    });
  }
}
