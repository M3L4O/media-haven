import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/injection_container.dart';
import '../../../data/repository/file_manager_repository.dart';
import '../../widgets/grid_mode.dart';
import 'audio_player_state.dart';

abstract class IAudioPlayerBloc extends Cubit<PlayerAudioState> {
  IAudioPlayerBloc() : super(PlayerAudioState());

  Future<void> setUrl({required int id});
  Future<void> togglePlayButton();

  Future<void> stop();
}

class AudioPlayerBloc extends IAudioPlayerBloc {
  final player = AudioPlayer();
  final _repository = sl.get<IFileManagerRepository>();
  StreamSubscription<Duration>? listenDuration;

  @override
  Future<void> togglePlayButton() async {
    emit(state.copyWith(isLoading: true));

    try {
      if (state.isPlaying) {
        await player.pause();
        emit(state.copyWith(isPlaying: false, isPaused: true));
        return;
      }

      if (player.duration == player.position) {
        await player.seek(Duration.zero);
        await player.stop();
      }

      emit(state.copyWith(isPlaying: true, isPaused: false));
      await player.play();
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
    return player.positionStream.listen((event) {
      emit(state.copyWith(position: event, duration: player.duration));

      if (player.duration == event) {
        emit(state.copyWith(isPlaying: false, isPaused: false));
      } else if (!state.isPlaying &&
          !state.isPaused &&
          event != Duration.zero) {
        emit(state.copyWith(isPlaying: true));
      }
    });

    // final audioDuration = await player.getDuration();
    // return player.onPositionChanged.listen((event) {
    //   print(event);
    //   print(audioDuration);
    //   emit(
    //     state.copyWith(
    //       position: event,
    //       duration: audioDuration,
    //     ),
    //   );

    //   if (audioDuration == event) {
    //     emit(state.copyWith(isPlaying: false));
    //   }
    // });
  }

  @override
  Future<void> setUrl({required int id}) async {
    listenDuration?.cancel();
    final token = sl.get<SharedPreferences>().getString('token');

    if (token == null) return emit(state.copyWith(error: 'Token not found'));

    final url = await _repository.getFileBytes(
      id: id.toString(),
      type: 'audios',
      token: token,
    );

    await player.setAudioSource(BufferAudioSource(url));
    listenDuration = await _listenDuration();
  }
}
