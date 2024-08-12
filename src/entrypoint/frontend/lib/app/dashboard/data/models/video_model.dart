import 'file_base.dart';

class VideoModel extends FileBase {
  VideoModel({
    required super.file,
    required super.id,
    required super.initialUrl,
  });

  VideoModel.fromJson(super.json) : super.fromJson();
}
