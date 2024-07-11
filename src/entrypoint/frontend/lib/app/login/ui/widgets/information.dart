import 'package:flutter/material.dart';
import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';

class Information extends StatelessWidget {
  const Information({
    super.key,
    required this.logoUrl,
    required this.title,
    required this.description,
  });

  final String logoUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          logoUrl,
          width: 200,
        ),
        64.h,
        Text(
          title,
          style: const TextStyle(
            color: MHColors.black,
            fontSize: 24,
          ),
        ),
        32.h,
        Text(
          description,
          style: const TextStyle(
            color: MHColors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
