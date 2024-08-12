import 'dart:typed_data';

import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/file_base.dart';
import '../models/file_params.dart';

abstract class IFileManagerDatasource {
  Future<Response> getImages({required String token});
  Future<Response> getAudios({required String token});
  Future<Response> getVideos({required String token});
  Future<String> uploadFile({required FileParams file, required String token});
  Future<String> deleteFile({required FileBase file, required String token});
  Future<Uint8List> getFileBytes({
    required String id,
    required String type,
    required String token,
  });
}

class FileManagerDatasource implements IFileManagerDatasource {
  final IHttpClient http;

  FileManagerDatasource({required this.http});

  @override
  Future<Response> getAudios({required String token}) async {
    final response = await http.get('file/audios/', token);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Falha ao adicionar novo arquivo.');
    }
  }

  @override
  Future<Response> getImages({required String token}) async {
    final response = await http.get('file/images/', token);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Falha ao adicionar novo arquivo.');
    }
  }

  @override
  Future<String> uploadFile({
    required FileParams file,
    required String token,
  }) async {
    final response = await http.postFile(
      file,
      token,
    );

    if (response.statusCode == 201) {
      return 'Sucesso ao adicionar novo arquivo.';
    } else {
      throw Exception('Falha ao adicionar novo arquivo.');
    }
  }

  @override
  Future<String> deleteFile({
    required FileBase file,
    required String token,
  }) async {
    final type = file.type;
    if (type == null) {
      throw Exception('Invalid type');
    }

    final response = await http.delete('file/$type/${file.id}/', token);
    if (response.statusCode == 204) {
      return 'Sucesso ao excluir  arquivo.';
    } else {
      throw Exception('Falha ao excluir arquivo.');
    }
  }

  @override
  Future<Uint8List> getFileBytes({
    required String id,
    required String type,
    required String token,
  }) async {
    try {
      final response = await http.get('file/$type/$id/', token);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Falha ao buscar arquivo.');
      }
    } catch (e) {
      throw Exception('Falha ao buscar arquivo.');
    }
  }

  @override
  Future<Response> getVideos({required String token}) async {
    final response = await http.get('file/videos/', token);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Falha ao adicionar novo arquivo.');
    }
  }
}
