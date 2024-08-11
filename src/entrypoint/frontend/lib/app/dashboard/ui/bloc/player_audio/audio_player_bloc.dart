import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'audio_player_state.dart';

abstract class IAudioPlayerBloc extends Cubit<PlayerAudioState> {
  IAudioPlayerBloc() : super(PlayerAudioState());

  Future<void> setUrl({required String url});
  Future<void> togglePlayButton();

  Future<void> stop();
}

class AudioPlayerBloc extends IAudioPlayerBloc {
  final player = AudioPlayer();
  StreamSubscription<Duration>? listenDuration;

  @override
  Future<void> togglePlayButton() async {
    emit(state.copyWith(isLoading: true));

    try {
      if (player.state == PlayerState.paused) {
        emit(state.copyWith(isPlaying: true, isPaused: false));
        await player.resume();
        print('resumed');
        return;
      } else if (player.state == PlayerState.playing) {
        emit(state.copyWith(isPlaying: false, isPaused: true));
        await player.pause();
        print('paused');
        return;
      }

      emit(state.copyWith(isPlaying: true, isPaused: false));

      final source = player.source;
      if (source != null) {
        player.play(source);
        print('played');
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> stop() async {
    await player.stop();
    emit(state.copyWith(isPlaying: false));
  }

  Future<StreamSubscription<Duration>> _listenDuration() async {
    final audioDuration = await player.getDuration();
    return player.onPositionChanged.listen((event) {
      print(event);
      print(audioDuration);
      emit(
        state.copyWith(
          position: event,
          duration: audioDuration,
        ),
      );

      if (audioDuration == event) {
        emit(state.copyWith(isPlaying: false));
      }
    });
  }

  @override
  Future<void> setUrl({required String url}) async {
    listenDuration?.cancel();
    await player.setSourceUrl(url);
    listenDuration = await _listenDuration();
  }
}
