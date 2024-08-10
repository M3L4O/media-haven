import '../../../data/models/file_base.dart';

abstract class FileManagerState {}

class FileManagerInitial extends FileManagerState {}

class FileManagerLoading extends FileManagerState {}

class FileManagerSuccess extends FileManagerState {
  final String? result;
  final List<FileBase>? files;

  FileManagerSuccess({
    this.result,
    this.files,
  });
}

class FileManagerFailure extends FileManagerState {
  final String message;

  FileManagerFailure({required this.message});
}

class FileManagerSearchEmpty extends FileManagerState {
  final String message;

  FileManagerSearchEmpty({required this.message});
}
