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
      return Dialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  4.w,
                  Text(
                    file.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MHColors.darkGray,
                    ),
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
            ),
            SizedBox(
              height: 400,
              child: Align(
                alignment: Alignment.center,
                child: CustomImageNetwork(
                  url: file.file,
                ),
                // Image.memory(),
              ),
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
