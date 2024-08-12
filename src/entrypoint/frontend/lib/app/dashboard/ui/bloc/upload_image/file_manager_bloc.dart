import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/audio_model.dart';
import '../../../data/models/file_base.dart';
import '../../../data/models/file_params.dart';
import '../../../data/models/image_model.dart';
import '../../../data/repository/file_manager_repository.dart';
import '../../widgets/select_type.dart';
import 'file_manager_state.dart';

abstract class IFileManagerBloc extends Cubit<FileManagerState> {
  IFileManagerBloc() : super(FileManagerInitial());

  Future<void> getFiles();
  Future<void> uploadFile();
  Future<void> deleteFile(FileBase file);
  Future<void> searchFiles({required String text});
  Future<void> changeMediaType(TypeFile type);
  Future<String> getVideoUrlFromBlob(int id);
}

class FileManagerBloc extends IFileManagerBloc {
  final IFileManagerRepository repository;
  final SharedPreferences sharedPreferences;
  final List<FileBase> files = [];

  FileManagerBloc({
    required this.repository,
    required this.sharedPreferences,
  });

  @override
  Future<void> getFiles() async {
    emit(FileManagerLoading());

    try {
      final token = sharedPreferences.getString('token') ?? '';

      final images = await repository.getImages(token: token);
      final audios = await repository.getAudios(token: token);

      files
        ..addAll(images)
        ..addAll(audios);

      emit(FileManagerSuccess(files: files));
    } catch (e) {
      emit(FileManagerFailure(
        message: 'Erro ao carregar arquivos',
      ));
    }
  }

  @override
  Future<void> uploadFile() async {
    emit(FileManagerLoading());
    try {
      final file = await getFile();

      if (file == null) {
        emit(FileManagerFailure(message: 'Erro ao selecionar arquivo'));
      }

      final token = sharedPreferences.getString('token') ?? '';

      final result = await repository.uploadFile(
        file: file!,
        token: token,
      );

      emit(FileManagerSuccess(result: result));
    } catch (e) {
      emit(FileManagerFailure(message: 'Erro ao fazer upload do arquivo'));
    }
  }

  Future<FileParams?> getFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null) {
        final file = FileParams.fromPicker(
          result.files.first.name,
          result.files.first.bytes!,
          result.files.first.extension!,
        );

        return file;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> searchFiles({required String text}) async {
    if (files.isEmpty) return;

    try {
      final result = files.where((element) {
        return element.name.toLowerCase().contains(text.toLowerCase());
      }).toList();

      emit(FileManagerSuccess(files: result));
    } catch (e) {
      emit(FileManagerFailure(message: 'Erro ao carregar arquivos'));
    }
  }

  @override
  Future<void> deleteFile(FileBase file) async {
    try {
      final token = sharedPreferences.getString('token') ?? '';
      final result = await repository.deleteFile(
        file: file,
        token: token,
      );

      files.remove(file);
      emit(FileManagerSuccess(result: result, files: files));
    } catch (e) {
      emit(FileManagerFailure(message: 'Erro ao deletar arquivo'));
    }
  }

  @override
  Future<void> changeMediaType(TypeFile type) async {
    try {
      final filterList = switch (type) {
        TypeFile.audios => files.whereType<AudioModel>().toList(),
        TypeFile.fotosEImagens => files.whereType<ImageModel>().toList(),
        _ => files,
      };

      emit(FileManagerSuccess(files: filterList));
    } catch (_) {
      emit(FileManagerFailure(message: 'Erro ao mudar o tipo de arquivo'));
    }
  }

  @override
  Future<String> getVideoUrlFromBlob(int id) async {
    final token = sharedPreferences.getString('token') ?? '';

    final result = await repository.getFileBytes(
      id: id.toString(),
      type: 'videos',
      token: token,
    );

    html.Blob videoBlob = html.Blob([result]);
    return html.Url.createObjectUrlFromBlob(videoBlob);
  }
}
