import '../../../../core/service/http_client.dart';
import 'audio_model.dart';
import 'image_model.dart';
import 'video_model.dart';

class FileBase {
  String file;
  final String initialUrl;
  final int id;

  FileBase({
    required this.initialUrl,
    required this.file,
    required this.id,
  });

  FileBase.fromJson(Map<String, dynamic> json)
      : file = json['file'],
        initialUrl = json['file'],
        id = json['id'] {
    file = type != null ? '${baseUrl}file/$type/${json['id']}/' : json['file'];
  }

  String get name {
    var uri = Uri.parse(initialUrl);
    var pathSegments = uri.pathSegments;
    return pathSegments.last;
  }

  String? get type {
    return switch (this) {
      AudioModel() => 'audios',
      ImageModel() => 'images',
      VideoModel() => 'videos',
      _ => null,
    };
  }
}
