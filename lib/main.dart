import 'package:flutter/material.dart';

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
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'PlayBox Social',
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}