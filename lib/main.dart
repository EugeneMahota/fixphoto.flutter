import 'package:flutter/material.dart';
import 'login-module/splash-screen/splash_screen.dart';
import 'package:tirmobile/login-module/login_screen.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'assets/styles/theme.dart';

void main() async {
  await DotEnv.load();

  setupServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo',
      theme: AppTheme().defaultTheme,
      initialRoute: '/splash-screen',
      routes: {
        '/splash-screen': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
