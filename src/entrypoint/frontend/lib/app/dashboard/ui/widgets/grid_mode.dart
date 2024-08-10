import 'package:cached_network_image/cached_network_image.dart';
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

class GridMode extends StatefulWidget {
  final List<FileBase> files;

  const GridMode({super.key, required this.files});

  @override
  State<GridMode> createState() => _GridModeState();
}

class _GridModeState extends State<GridMode> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemBuilder: (BuildContext context, int index) {
        final file = widget.files[index];

        return SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  getTypeIcon(file),
                  4.w,
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
              InkWell(
                onTap: () {
                  if (file is AudioModel) {
                    audioDialog(context);
                  } else if (file is ImageModel) {
                    imageDialog(context, file);
                  }
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Ink(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    height: 180,
                    child: Builder(
                      builder: (context) {
                        if (file is ImageModel) {
                          return CachedNetworkImage(
                            imageUrl: file.file,
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Icon(
                                  Icons.error,
                                  color: MHColors.lightGray,
                                ),
                              );
                            },
                          );
                        } else if (file is AudioModel) {
                          return Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.audiotrack,
                              color: MHColors.lightGreen.withOpacity(0.3),
                            ),
                          );
                        }
                        return const Center(
                          child: Text(
                            'Arquivo não suportado',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: widget.files.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisExtent: 250,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
    );
  }
}
