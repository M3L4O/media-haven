import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/theme/mh_colors.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    super.key,
    required this.animationPath,
    required this.message,
    this.size = 300,
  });

  final String animationPath;
  final String message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            animationPath,
            width: size,
          ),
          24.h,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: MHColors.darkGray),
              textAlign: TextAlign.center,
            ),
          ),
          (MediaQuery.of(context).size.height * 0.18).h,
        ],
      ),
    );
  }
}
