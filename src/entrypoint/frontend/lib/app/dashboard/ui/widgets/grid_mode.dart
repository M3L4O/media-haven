import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

class GridMode extends StatefulWidget {
  final List<FileBase> files;

  const GridMode({super.key, required this.files});

  @override
  State<GridMode> createState() => _GridModeState();
}

class _GridModeState extends State<GridMode> {
  final _fileManager = sl.get<IFileManagerBloc>();
  final _audioPlayerBloc = sl.get<IAudioPlayerBloc>();

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
                  TypeIcon(file: file),
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
                  child: SizedBox(
                    height: 180,
                    child: Builder(
                      builder: (context) {
                        if (file is ImageModel) {
                          return CustomImageNetwork(
                            url: file.file,
                            fit: BoxFit.cover,
                          );
                        } else if (file is AudioModel) {
                          return Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.audiotrack,
                              color: MHColors.lightGreen.withOpacity(0.3),
                            ),
                          );
                        } else if (file is VideoModel) {
                          return Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.ondemand_video_sharp,
                              color: MHColors.mediumPurple.withOpacity(0.3),
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

class BufferAudioSource extends StreamAudioSource {
  final Uint8List _buffer;

  BufferAudioSource(this._buffer) : super(tag: "Bla");

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) {
    start = start ?? 0;
    end = end ?? _buffer.length;

    return Future.value(
      StreamAudioResponse(
        sourceLength: _buffer.length,
        contentLength: end - start,
        offset: start,
        contentType: 'audio/mp3',
        stream: Stream.value(
          List<int>.from(_buffer.skip(start).take(end - start)),
        ),
      ),
    );
  }
}
