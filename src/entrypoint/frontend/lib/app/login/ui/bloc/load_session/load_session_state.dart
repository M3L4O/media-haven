import '../../../data/models/token_model.dart';

abstract class LoadSessionState {}

class LoadSessionInitial extends LoadSessionState {}

class LoadSessionLoading extends LoadSessionState {}

class LoadSessionSuccess extends LoadSessionState {
  final TokenModel user;

  LoadSessionSuccess({
    required this.user,
  });
}

class LoadSessionFailure extends LoadSessionState {
  final String message;

  LoadSessionFailure({
    required this.message,
  });
}
