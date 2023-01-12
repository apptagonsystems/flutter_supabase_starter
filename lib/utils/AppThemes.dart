import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const int _blackPrimaryValue = 0xFF000000;

class AppThemes {
  AppBarTheme get appTheme => AppBarTheme(
        color: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        toolbarTextStyle: const TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 18),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 18),
        ).headline6,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      );

  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(letterSpacing: 1),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent[400]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      );

  ColorScheme get colorScheme => ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
        _blackPrimaryValue,
        <int, Color>{
          50: Color(0xFF000000),
          100: Color(0xFF000000),
          200: Color(0xFF000000),
          300: Color(0xFF000000),
          400: Color(0xFF000000),
          500: Color(_blackPrimaryValue),
          600: Color(0xFF000000),
          700: Color(0xFF000000),
          800: Color(0xFF000000),
          900: Color(0xFF000000),
        },
      )).copyWith(secondary: Colors.black);
}
