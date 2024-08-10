import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/file_base.dart';
import '../../data/models/image_model.dart';
import '../../data/models/option.dart';
import '../bloc/upload_image/file_manager_bloc.dart';

class PopupMenuOptions extends StatelessWidget {
  final FileBase file;
  late final _fileManagerBloc = sl.get<IFileManagerBloc>();

  PopupMenuOptions({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Option>(
      icon: const Icon(
        Icons.more_vert,
        color: MHColors.darkGray,
        size: 18,
      ),
      onSelected: (Option op) {
        if (op == Option.delete) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    8.w,
                    const Text(
                      'Deseja excluir este arquivo?',
                      style: TextStyle(
                        color: MHColors.darkGray,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: MHColors.darkGray,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fileManagerBloc.deleteFile(file);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                        color: MHColors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (op == Option.details) {
          detailsDialog(context, file);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
        const PopupMenuItem<Option>(
          value: Option.details,
          child: Text('Detalhes'),
        ),
        const PopupMenuItem<Option>(
          value: Option.delete,
          child: Text('Excluir'),
        ),
      ],
    );
  }

  Future<dynamic> detailsDialog(BuildContext context, file) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Detalhes do arquivo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MHColors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: MHColors.darkGray,
                      size: 18,
                    ),
                  ),
                ],
              ),
              if (file is AudioModel) ...[
                Text('Arquivo: ${file.file}'),
                Text('Duração: ${file.duration ?? ''}'),
                Text('Tamanho: ${file.fileSize ?? ''}'),
                Text('Data de Upload: ${file.uploadDate ?? ''}'),
                Text('Tipo: ${file.mIMEType}'),
                Text('Descriçāo: ${file.description ?? ''}'),
                Text('Sampling rate: ${file.samplingRate ?? ''}'),
                Text('Bitrate: ${file.bitrate ?? ''}'),
                if (file.stereo != null && file.stereo!) const Text('Stereo'),
              ],
              if (file is ImageModel) ...[
                Text('Arquivo: ${file.file}'), // File
                Text('Tamanho do Arquivo: ${file.fileSize ?? ''}'), // File Size
                Text('Data de Upload: ${file.uploadDate ?? ''}'), // Upload Date
                Text('Tipo MIME: ${file.mIMEType ?? ''}'), // MIME Type
                Text('Descrição: ${file.description ?? ''}'), // Description
                Text('Largura: ${file.width ?? ''}'), // Width
                Text('Altura: ${file.height ?? ''}'), // Height
                Text(
                    'Profundidade de Cor: ${file.colorDepth ?? ''}'), // Color Depth
                Text('Conta: ${file.account ?? ''}'), // Account
                Text('Nome: ${file.name}'), // Name
              ]
            ],
          ),
        );
      },
    );
  }
}
