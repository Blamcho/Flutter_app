import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login.dart';
import 'package:flutter_application_1/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1b2838), // Steam-like dark blue background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF171a21), // Darker blue for AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF66c0f4)), // Steam blue
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(const Color(0xFF66c0f4)), // Steam blue
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/Home': (context) => HomeScreen(
          username: ModalRoute.of(context)?.settings.arguments is Map<String, dynamic>
              ? (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['username'] ?? ''
              : '',
          email: ModalRoute.of(context)?.settings.arguments is Map<String, dynamic>
              ? (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['email'] ?? ''
              : '',
          password: ModalRoute.of(context)?.settings.arguments is Map<String, dynamic>
              ? (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['password'] ?? ''
              : '',
          String: '',
        ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}