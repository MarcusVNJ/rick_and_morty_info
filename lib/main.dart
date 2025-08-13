import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/application/view/router/router.dart';
import 'package:rick_and_morty_info/application/view/theme/rick_theme.dart';
import 'package:rick_and_morty_info/core/config/configs.dart';
import 'package:rick_and_morty_info/core/config/setup_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Configs.load();
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty Info',
      theme: RickTheme.getTheme(),
      routerConfig: routers,
      debugShowCheckedModeBanner: false,
    );
  }
}
