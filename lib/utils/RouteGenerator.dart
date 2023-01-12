import 'package:all_in_one/models/UserModel.dart';
import 'package:all_in_one/screens/MainScreen.dart';
import 'package:all_in_one/screens/OnboardingScreen.dart';
import 'package:all_in_one/screens/RequestPermissionScreen.dart';
import 'package:all_in_one/screens/SplashScreen.dart';
import 'package:all_in_one/screens/WelcomeScreen.dart';
import 'package:all_in_one/screens/account/AccountScreen.dart';
import 'package:all_in_one/screens/auth/LoginScreen.dart';
import 'package:all_in_one/screens/auth/RegisterScreen.dart';
import 'package:all_in_one/utils/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateMaterialRoutes(RouteSettings settings) {
    final UserModel? _user = settings.arguments as UserModel?;

    switch (settings.name) {
      case AppRoutes.splashPageRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case AppRoutes.welcomePageRoute:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());

      case AppRoutes.onBoardingPageRoute:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      case AppRoutes.registerPageRoute:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case AppRoutes.loginPageRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.enablePermissionPageRoute:
        return MaterialPageRoute(
            builder: (context) => const RequestPermissionScreen());

      case AppRoutes.mainPageRoute:
        return MaterialPageRoute(
            builder: (context) => MainScreen(userModel: _user!));

      case AppRoutes.accountPageRoute:
        return MaterialPageRoute(
            builder: (context) => AccountScreen(userModel: _user!));
    }
    return MaterialPageRoute(builder: (context) => const RegisterScreen());
  }

  static Route<dynamic> generateCupertinoRoutes(RouteSettings settings) {
    final UserModel? _user = settings.arguments as UserModel?;
    switch (settings.name) {
      case AppRoutes.splashPageRoute:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case AppRoutes.welcomePageRoute:
        return CupertinoPageRoute(builder: (context) => const WelcomeScreen());

      case AppRoutes.onBoardingPageRoute:
        return CupertinoPageRoute(
            builder: (context) => const OnboardingScreen());

      case AppRoutes.registerPageRoute:
        return CupertinoPageRoute(builder: (context) => const RegisterScreen());

      case AppRoutes.loginPageRoute:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.enablePermissionPageRoute:
        return CupertinoPageRoute(
            builder: (context) => const RequestPermissionScreen());

      case AppRoutes.mainPageRoute:
        return CupertinoPageRoute(
            builder: (context) => MainScreen(userModel: _user!));

      case AppRoutes.accountPageRoute:
        return CupertinoPageRoute(
            builder: (context) => AccountScreen(userModel: _user!));
    }
    return CupertinoPageRoute(builder: (context) => const RegisterScreen());
  }
}
