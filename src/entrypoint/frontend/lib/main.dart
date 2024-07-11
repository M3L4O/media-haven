import 'package:flutter/material.dart';
import 'package:frontend/core/theme/theme.dart';
import 'app/login/ui/login_page.dart';

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
