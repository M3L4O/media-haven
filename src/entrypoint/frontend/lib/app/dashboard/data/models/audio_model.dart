import 'file_base.dart';

class AudioModel extends FileBase {
  double? fileSize;
  String? uploadDate;
  String? mIMEType;
  String? description;
  double? duration;
  int? bitrate;
  double? samplingRate;
  bool? stereo;
  int? account;

  AudioModel({
    this.fileSize,
    this.uploadDate,
    this.mIMEType,
    this.description,
    this.duration,
    this.bitrate,
    this.samplingRate,
    this.stereo,
    this.account,
    required super.file,
    required super.id,
    required super.initialUrl,
  });

  AudioModel.fromJson(super.json)
      : fileSize = json['file_size'],
        uploadDate = json['upload_date'],
        mIMEType = json['MIME_type'],
        description = json['description'],
        duration = json['duration'],
        bitrate = json['bitrate'],
        samplingRate = json['sampling_rate'],
        stereo = json['stereo'],
        account = json['account'],
        super.fromJson();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['file_size'] = fileSize;
    data['upload_date'] = uploadDate;
    data['MIME_type'] = mIMEType;
    data['description'] = description;
    data['duration'] = duration;
    data['bitrate'] = bitrate;
    data['sampling_rate'] = samplingRate;
    data['stereo'] = stereo;
    data['account'] = account;

    return data;
  }
}
