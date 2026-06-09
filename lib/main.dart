import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PlayBoxSocial());
}

class PlayBoxSocial extends StatelessWidget {
  const PlayBoxSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PlayBox Social',

      home: const SplashScreen(),
    );
  }
}