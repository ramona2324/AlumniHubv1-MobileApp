import 'package:alumnihubv1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Tracer and Career Platform for USeP Alumni - AlumniHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: bodyTextColor),
          bodySmall: TextStyle(color: bodyTextColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(defaultPadding),
          hintStyle: TextStyle(color: bodyTextColor),
        ),
      ),
      home: FutureBuilder<bool>(
          future: AuthService().isLoggedIn(),
        builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return snapshot.data == true
                ? const HomeScreen() // Your dashboard screen
                : const OnboardingScreen();
        },
      ),
    );
  }
}
