import 'package:flutter/material.dart';

class MediaContentGrid extends StatelessWidget {
  const MediaContentGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                //TODO: Implementar ação de clique
              },
              child: Ink(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text('Media $index'),
                ),
              ),
            );
          },
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            mainAxisExtent: 150,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
        ),
      ],
    );
  }
}