class FileBase {
  final String file;
  final int id;

  FileBase({
    required this.file,
    required this.id,
  });

  FileBase.fromJson(Map<String, dynamic> json)
      : file = json['file'],
        id = json['id'];

  String get name {
    var uri = Uri.parse(file);
    var pathSegments = uri.pathSegments;
    return pathSegments.last;
  }
}
