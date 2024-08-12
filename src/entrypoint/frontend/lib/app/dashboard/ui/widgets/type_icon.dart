import 'package:flutter/material.dart';

import '../../../../core/theme/mh_colors.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/file_base.dart';
import '../../data/models/image_model.dart';
import '../../data/models/video_model.dart';

class TypeIcon extends StatelessWidget {
  final FileBase file;

  const TypeIcon({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return switch (file) {
      AudioModel() => const Icon(
          Icons.audio_file,
          color: MHColors.lightGreen,
        ),
      ImageModel() => const Icon(
          Icons.image,
          color: MHColors.lightPurple,
        ),
      VideoModel() => const Icon(
          Icons.ondemand_video_sharp,
          color: MHColors.mediumPurple,
        ),
      _ => const Icon(
          Icons.error,
          color: MHColors.lightGray,
        ),
    };
  }
}
