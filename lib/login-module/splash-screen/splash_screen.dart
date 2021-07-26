import 'package:flutter/material.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/login-module/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 2000,
      text: 'FIXPhoto',
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: AppColors().pink,
      ),
      backgroundColor: Colors.white,
    );
  }
}
