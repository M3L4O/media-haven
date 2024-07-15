import 'package:flutter/material.dart';

extension CustomSizeExtension on int {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());

  SizedBox get wh => SizedBox(width: toDouble(), height: toDouble());
}

extension CustomSizeExt on double {
  SizedBox get h => SizedBox(height: this);

  SizedBox get w => SizedBox(width: this);

  SizedBox get wh => SizedBox(width: this, height: this);
}
