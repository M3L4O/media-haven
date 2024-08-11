import 'file_base.dart';

class ImageModel extends FileBase {
  double? fileSize;
  String? uploadDate;
  String? mIMEType;
  String? description;
  int? width;
  int? height;
  int? colorDepth;
  int? account;

  ImageModel({
    this.fileSize,
    this.uploadDate,
    this.mIMEType,
    this.description,
    this.width,
    this.height,
    this.colorDepth,
    this.account,
    required super.file,
    required super.id,
  });

  ImageModel.fromJson(super.json)
      : fileSize = json['file_size'],
        uploadDate = json['upload_date'],
        mIMEType = json['MIME_type'],
        description = json['description'],
        width = json['width'],
        height = json['height'],
        colorDepth = json['color_depth'],
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
    data['width'] = width;
    data['height'] = height;
    data['color_depth'] = colorDepth;
    data['account'] = account;

    return data;
  }
}
