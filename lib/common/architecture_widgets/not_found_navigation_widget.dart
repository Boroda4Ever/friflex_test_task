import 'package:flutter/material.dart';

// Архитектурный виджет, на который может переходить навигатор при некорректном маршруте
class NotFoundNavigationWidget extends StatelessWidget {
  const NotFoundNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(child: Text('Not Found')),
      ),
    );
  }
}
