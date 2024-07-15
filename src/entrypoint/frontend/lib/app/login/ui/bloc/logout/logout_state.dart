abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final bool status;

  LogoutSuccess({
    required this.status,
  });
}

class LogoutFailure extends LogoutState {
  final String message;

  LogoutFailure({
    required this.message,
  });
}
