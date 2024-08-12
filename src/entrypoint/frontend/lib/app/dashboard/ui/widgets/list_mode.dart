import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/file_base.dart';
import '../../data/models/image_model.dart';
import '../../data/models/video_model.dart';
import '../bloc/player_audio/audio_player_bloc.dart';
import '../bloc/upload_image/file_manager_bloc.dart';
import 'audio_dialog.dart';
import 'image_dialog.dart';
import 'popup_menu_options.dart';
import 'type_icon.dart';
import 'video_dialog.dart';

class ListMode extends StatefulWidget {
  final List<FileBase> files;

  const ListMode({super.key, required this.files});

  @override
  State<ListMode> createState() => _ListModeState();
}

class _ListModeState extends State<ListMode> {
  final _fileManager = sl.get<IFileManagerBloc>();
  final _audioPlayerBloc = sl.get<IAudioPlayerBloc>();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        final file = widget.files[index];

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: InkWell(
            onTap: () async {
              if (file is AudioModel) {
                _showLoadingDialog(context);
                await _audioPlayerBloc.setUrl(id: file.id);
                if (!context.mounted) return;
                Navigator.pop(context);
                audioDialog(context, file);
              } else if (file is ImageModel) {
                imageDialog(context, file);
              } else if (file is VideoModel) {
                _showLoadingDialog(context);
                final url = await _fileManager.getVideoUrlFromBlob(file.id);
                if (!context.mounted) return;
                Navigator.pop(context);
                videoDialog(context, url);
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
                  TypeIcon(file: file),
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
      itemCount: widget.files.length,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
