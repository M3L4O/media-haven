import 'package:flutter/material.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../../login/ui/widgets/custom_text_form_field.dart';
import 'media_content.dart';

class DashboardHeader extends StatefulWidget {
  final Function(TypeFile) onTypeChanged;
  final Function(String) onSearchChanged;

  const DashboardHeader({
    super.key,
    required this.onTypeChanged,
    required this.onSearchChanged,
  });

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  late final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
