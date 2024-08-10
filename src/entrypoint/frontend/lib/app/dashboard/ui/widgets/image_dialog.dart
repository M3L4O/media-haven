import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
              child: IconButton(
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
            ),
            SizedBox(
              height: 400,
              child: Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: file.file,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error,
                      color: MHColors.lightGray,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
