import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:autonexa/app_router.dart';
import 'package:autonexa/core/constants/app_constants.dart';
import 'package:autonexa/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const AutonexaApp());
}

class AutonexaApp extends StatelessWidget {
  const AutonexaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}