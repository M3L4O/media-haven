import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helpers/custom_size.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/theme/mh_colors.dart';
import '../../data/models/image_model.dart';

Future<dynamic> imageDialog(BuildContext context, ImageModel file) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.h,
            Text(
              file.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MHColors.white,
              ),
            ),
            20.h,
            Stack(
              children: [
                CustomImageNetwork(
                  url: file.file,
                  fit: BoxFit.contain,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Column(
                    children: [
                      Icon(
                        Icons.close,
                        color: MHColors.gray,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    super.key,
    required this.url,
    this.fit,
  });

  final String url;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final token = sl.get<SharedPreferences>().getString('token');

        return Image.network(
          url,
          headers: {"Authorization": "JWT $token"},
          fit: fit ?? BoxFit.contain,
        );
      },
    );
  }
}
