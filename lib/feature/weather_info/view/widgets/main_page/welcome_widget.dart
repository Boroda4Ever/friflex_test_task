import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Добро пожаловать",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 32),
    );
  }
}
