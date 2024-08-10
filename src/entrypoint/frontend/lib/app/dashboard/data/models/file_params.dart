import 'dart:typed_data';

import 'package:mime/mime.dart';

class FileParams {
  String? name;
  Uint8List? bytes;
  String? fileExtension;
  String? type;

  FileParams(
    this.name,
    this.bytes,
    this.fileExtension,
    this.type,
  );

  FileParams.fromPicker(
    final String filename,
    final Uint8List fileBytes,
    final String fileExtensionP,
  ) {
    name = filename;
    bytes = fileBytes;
    fileExtension = lookupMimeType(filename)?.split('/')[1];
    type = lookupMimeType(filename)?.split('/')[0];
  }

  @override
  String toString() {
    return 'FileModel{name: $name, type: $type, fileExtension: $fileExtension}';
  }
}
