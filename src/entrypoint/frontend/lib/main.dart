import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/dashboard/ui/dashboard_page.dart';
import 'app/login/ui/login_page.dart';
import 'core/injection_container.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGlobalContainer();
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
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final token = sl.get<SharedPreferences>().getString('token');
          if (token != null) {
            return const Dashboard();
          }

          return const LoginPage();
        },
      ),
    );
  }
}
