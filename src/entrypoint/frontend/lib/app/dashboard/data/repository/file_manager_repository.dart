import 'dart:convert';

import '../datasource/file_manager_datasource.dart';
import '../models/audio_model.dart';
import '../models/file_base.dart';
import '../models/file_params.dart';
import '../models/image_model.dart';

abstract class IFileManagerRepository {
  Future<List<ImageModel>> getImages({required String token});
  Future<List<AudioModel>> getAudios({required String token});
  Future<String> uploadFile({required FileParams file, required String token});
  Future<String> deleteFile({required FileBase file, required String token});
}

class FileManagerRepository implements IFileManagerRepository {
  final IFileManagerDatasource datasource;

  FileManagerRepository({required this.datasource});

  @override
  Future<List<ImageModel>> getImages({required String token}) async {
    try {
      final result = await datasource.getImages(token: token);
      final data = jsonDecode(result.body);

      return (data as List)
          .map(
            (item) => ImageModel.fromJson(item),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AudioModel>> getAudios({required String token}) async {
    try {
      final result = await datasource.getAudios(token: token);
      final data = jsonDecode(result.body);

      return (data as List)
          .map(
            (item) => AudioModel.fromJson(item),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadFile({
    required FileParams file,
    required String token,
  }) async {
    try {
      final uploadResponse = await datasource.uploadFile(
        file: file,
        token: token,
      );

      return uploadResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteFile({
    required FileBase file,
    required String token,
  }) async {
    try {
      final deleteResponse = await datasource.deleteFile(
        file: file,
        token: token,
      );

      return deleteResponse;
    } catch (e) {
      rethrow;
    }
  }
}
