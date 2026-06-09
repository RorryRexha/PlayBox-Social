import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo principal
            Image.asset(
              'assets/logos/playbox_logo.png', // coloca aquí tu logo en PNG
              width: 150,
            ),

            const SizedBox(height: 30),

            // Nombre de la app
            const Text(
              "PLAY BOX SOCIAL",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            // Eslogan principal
            const Text(
              "Conecta. Comparte. Juega.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Tus mejores momentos en un solo lugar.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(
              color: Colors.cyanAccent,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
