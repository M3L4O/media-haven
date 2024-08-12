import 'package:flutter/material.dart';

import '../../data/models/file_base.dart';
import 'grid_mode.dart';
import 'list_mode.dart';

class MediaContent extends StatefulWidget {
  const MediaContent({
    super.key,
    required this.files,
    required this.isGrid,
  });

  final List<FileBase> files;
  final bool isGrid;

  @override
  State<MediaContent> createState() => _MediaContentState();
}

class _MediaContentState extends State<MediaContent> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        widget.isGrid
            ? GridMode(files: widget.files) //
            : ListMode(files: widget.files)
      ],
    );
  }
}

