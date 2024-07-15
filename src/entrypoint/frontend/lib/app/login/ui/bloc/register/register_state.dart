import '../../../data/models/token_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final TokenModel user;

  RegisterSuccess({required this.user});
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message});
}
