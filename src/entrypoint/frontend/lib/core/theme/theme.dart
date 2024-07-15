import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mh_colors.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  cardColor: MHColors.white,
  primaryColor: MHColors.blue,
  scaffoldBackgroundColor: MHColors.white,
  buttonTheme: const ButtonThemeData(
    buttonColor: MHColors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: GoogleFonts.sourceSans3TextTheme(),
  drawerTheme: const DrawerThemeData(
    backgroundColor: MHColors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: MHColors.white,
    iconTheme: IconThemeData(
      color: MHColors.blue,
    ),
    titleTextStyle: TextStyle(
      color: MHColors.blue,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: MHColors.blue,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: MHColors.blue,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: MHColors.blue,
    contentTextStyle: TextStyle(
      color: MHColors.white,
    ),
  ),
);
