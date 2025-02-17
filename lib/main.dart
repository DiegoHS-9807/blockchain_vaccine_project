import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinary Clinic',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        primaryColor: AppConstants.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: AppConstants.secondaryColor,
        ),
        textTheme: const TextTheme(
          headlineLarge: AppConstants.headlineLarge,
          bodyLarge: AppConstants.bodyLarge,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.inputBorderColor),
          ),
          labelStyle: TextStyle(color: AppConstants.labelColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.buttonBackgroundColor,
            foregroundColor: AppConstants.buttonForegroundColor,
            textStyle: AppConstants.buttonTextStyle,
          ),
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
