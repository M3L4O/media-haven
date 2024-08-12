class PlayerAudioState {
  final Duration? position;
  final Duration? duration;
  final bool isPaused;
  final bool isStopped;
  final bool isPlaying;
  final bool isLoading;
  final String? error;

  PlayerAudioState({
    this.position,
    this.duration,
    this.isPaused = false,
    this.isStopped = false,
    this.isPlaying = false,
    this.isLoading = false,
    this.error,
  });

  PlayerAudioState copyWith({
    Duration? position,
    Duration? duration,
    bool? isPaused,
    bool? isStopped,
    bool? isPlaying,
    bool isLoading = false,
    String? error,
  }) {
    return PlayerAudioState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPaused: isPaused ?? this.isPaused,
      isStopped: isStopped ?? this.isStopped,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading,
      error: error,
    );
  }
}
