import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/dashboard/ui/dashboard_page.dart';
import 'app/login/ui/login_page.dart';
import 'core/injection_container.dart';
import 'core/theme/theme.dart';

void main() {
  initGlobalContainer();
  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Haven',
      theme: theme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(),
      },
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
