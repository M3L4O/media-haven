import 'package:http/http.dart';

import '../../../../core/service/http_client.dart';
import '../models/audio_model.dart';
import '../models/file_base.dart';
import '../models/file_params.dart';
import '../models/image_model.dart';

abstract class IFileManagerDatasource {
  Future<Response> getImages({required String token});
  Future<Response> getAudios({required String token});
  Future<String> uploadFile({required FileParams file, required String token});
  Future<String> deleteFile({required FileBase file, required String token});
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
    String? type = verifyType(file);

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

  String? verifyType(FileBase file) {
    String? type;
    if (file is AudioModel) {
      type = 'audios';
    } else if (file is ImageModel) {
      type = 'images';
    }
    return type;
  }
}
