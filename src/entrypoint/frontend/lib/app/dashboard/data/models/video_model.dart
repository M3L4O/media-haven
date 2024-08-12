import 'file_base.dart';

class VideoModel extends FileBase {
  int? fileSize;
  String? uploadDate;
  String? mimeType;
  String? description;
  double? duration;
  int? width;
  int? height;
  String? videoCodec;
  int? frameRate;
  int? bitrate;
  String? thumbnail;
  int? account;

  VideoModel({
    required this.fileSize,
    required this.uploadDate,
    required this.mimeType,
    required this.description,
    required this.duration,
    required this.width,
    required this.height,
    required this.videoCodec,
    required this.frameRate,
    required this.bitrate,
    required this.thumbnail,
    required this.account,
    required super.file,
    required super.id,
    required super.initialUrl,
  });

  VideoModel.fromJson(super.json)
      : fileSize = json["file_size"],
        uploadDate = json["upload_date"],
        mimeType = json["MIME_type"],
        description = json["description"],
        duration = json["duration"],
        width = json["width"],
        height = json["height"],
        videoCodec = json["video_codec"],
        frameRate = json["frame_rate"],
        bitrate = json["bitrate"],
        thumbnail = json["thumbnail"],
        account = json["account"],
       
        super.fromJson();
}
