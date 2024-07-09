import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mh_colors.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  cardColor: MHColors.white,
  scaffoldBackgroundColor: MHColors.white,
  buttonTheme: const ButtonThemeData(
    buttonColor: MHColors.purple,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
