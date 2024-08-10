import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../../login/ui/widgets/custom_text_form_field.dart';
import '../../data/models/audio_model.dart';
import '../../data/models/file_base.dart';
import '../../data/models/image_model.dart';
import '../bloc/player_audio/player_bloc.dart';
import 'grid_mode.dart';
import 'list_mode.dart';

class MediaContent extends StatefulWidget {
  const MediaContent({
    super.key,
    required this.files,
    required this.isGrid,
    required this.onSearchChanged,
  });

  final List<FileBase> files;
  final bool isGrid;
  final Function(String) onSearchChanged;

  @override
  State<MediaContent> createState() => _MediaContentState();
}

class _MediaContentState extends State<MediaContent> {
  late IPlayerAudioBloc audioPlayerBloc;
  late List<FileBase> files;

  @override
  void initState() {
    audioPlayerBloc = sl.get<IPlayerAudioBloc>();
    files = widget.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Menu(
          onTypeChanged: selectTypes,
          onSearchChanged: widget.onSearchChanged,
        ),
        widget.isGrid
            ? GridMode(files: files) //
            : ListMode(files: files)
      ],
    );
  }

  selectTypes(newType) {
    switch (newType) {
      case TypeFile.fotosEImagens:
        setState(() {
          files = widget.files.whereType<ImageModel>().toList();
        });
        break;

      case TypeFile.audios:
        setState(() {
          files = widget.files.whereType<AudioModel>().toList();
        });
        break;

      case TypeFile.all:
        setState(() {
          files = widget.files;
        });
        break;

      default:
    }
  }
}

Icon getTypeIcon(dynamic type) {
  if (type is AudioModel) {
    return const Icon(
      Icons.audio_file,
      color: MHColors.lightGreen,
    );
  } else if (type is ImageModel) {
    return const Icon(
      Icons.image,
      color: MHColors.lightPurple,
    );
  }
  return const Icon(
    Icons.error,
    color: MHColors.lightGray,
  );
}

class SelectType extends StatefulWidget {
  const SelectType({
    super.key,
    required this.onTypeChanged,
  });
  final ValueChanged<TypeFile> onTypeChanged;

  @override
  State<SelectType> createState() => _SelectTypeState();
}

enum TypeFile {
  all('Todos'),
  fotosEImagens('Fotos e imagens'),
  audios('Audio'),
  videos('Vídeos');

  final String name;

  const TypeFile(this.name);
}

List<TypeFile> listType = TypeFile.values;

class _SelectTypeState extends State<SelectType> {
  TypeFile type = listType.first;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: MHColors.lightGrayVariant,
          borderRadius: BorderRadius.circular(24),
        ),
        child: DropdownButton<TypeFile>(
          value: type,
          borderRadius: BorderRadius.circular(24),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: MHColors.darkGray,
          ),
          elevation: 16,
          style: const TextStyle(
            color: MHColors.darkGray,
          ),
          underline: Container(),
          onChanged: (TypeFile? value) {
            setState(() {
              type = value!;
            });
            widget.onTypeChanged(type);
          },
          items: listType.map<DropdownMenuItem<TypeFile>>((TypeFile value) {
            return DropdownMenuItem<TypeFile>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({
    super.key,
    required this.onTypeChanged,
    required this.onSearchChanged,
  });

  final Function(TypeFile) onTypeChanged;
  final Function(String) onSearchChanged;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          16.h,
          SizedBox(
            width: 500,
            child: CustomTextFormField(
              labelText: 'Buscar no Media Heaven',
              hintText: '',
              icon: Icons.search,
              backgroundColor: MHColors.lightGrayVariant,
              onChanged: widget.onSearchChanged,
              controller: searchController,
            ),
          ),
          24.h,
          SelectType(
            onTypeChanged: widget.onTypeChanged,
          ),
          36.h,
        ],
      ),
    );
  }
}
