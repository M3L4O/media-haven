import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/file_base.dart';
import '../../data/models/image_model.dart';
import 'audio_dialog.dart';
import 'image_dialog.dart';
import 'media_content.dart';
import 'popup_menu_options.dart';

class ListMode extends StatelessWidget {
  final List<FileBase> files;

  const ListMode({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final file = files[index];

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: InkWell(
            onTap: () {
              if (file is AudioModel) {
                audioDialog(context);
              } else if (file is ImageModel) {
                imageDialog(
                  context,
                  file,
                );
              }
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Ink(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  getTypeIcon(file),
                  6.w,
                  Expanded(
                    child: Text(
                      file.name,
                      style: const TextStyle(color: MHColors.darkGray),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuOptions(file: file),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: files.length,
    );
  }
}
