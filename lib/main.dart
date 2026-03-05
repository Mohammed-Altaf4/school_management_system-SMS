import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "School Management System",
      theme: ThemeData(
        primaryColor: const Color(0xFF1F3C88),
        scaffoldBackgroundColor: const Color(0xFFEAF2FF),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        // You can add named routes for dashboards if needed
        // '/admin': (context) => const AdminDashboard(),
        // '/teacher': (context) => const TeacherDashboard(),
      },
    );
  }
}
