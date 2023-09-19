import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

ThemeData customTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.roboto().fontFamily,
  colorScheme: const ColorScheme(
    background: Color(0xFFffffff),
    brightness: Brightness.light,
    primary: Color(0xFF7D8CC4),
    onPrimary: Color(0xFFffffff),
    secondary: Color(0xFF403F4C),
    onSecondary: Color(0xFFffffff),
    error: Color(0xFFFF8484),
    onError: Color(0xFFffffff),
    onBackground: Color(0xFFffffff),
    surface: Color(0xFFffffff),
    onSurface: Color(0xFF403F4C),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.koulen(
      fontSize: 64,
      color: const Color(0xFF7D8CC4),
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.koulen(
      fontSize: 32,
      color: const Color(0xFF403F4C),
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.koulen(
      fontSize: 24,
      color: const Color(0xFF403F4C),
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: const TextStyle(
      color: Color(0xFF403F4C),
      fontSize: 20,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      color: Color(0xFF403F4C),
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customTheme,
      home: const LoginPage(),
    );
  }
}
