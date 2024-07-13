import 'package:flutter/material.dart';

import 'app/login/ui/login_page.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Haven',
      theme: theme,
      home: const LoginPage(),
    );
  }
}
