import 'package:flutter/material.dart';
import 'package:frontend/core/theme/mh_colors.dart';

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
