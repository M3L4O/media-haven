

abstract class FileManagerState {}

class FileManagerInitial extends FileManagerState {}

class FileManagerLoading extends FileManagerState {}

class FileManagerSuccess extends FileManagerState {
  final String? result;

  FileManagerSuccess({this.result});
}

class FileManagerFailure extends FileManagerState {
  final String message;

  FileManagerFailure({required this.message});
}

class FileManagerSearchEmpty extends FileManagerState {
  final String message;

  FileManagerSearchEmpty({required this.message});
}
