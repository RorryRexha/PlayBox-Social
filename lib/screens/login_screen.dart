import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: const Center(
        child: Text(
          "LOGIN",
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}