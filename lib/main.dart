import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/init/logging/error_handler.dart';
import 'core/init/logging/logger.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'feature/weather_info/view/bloc/request_bloc.dart';
import 'package:friflex_test_task/service_locator.dart' as di;
import 'service_locator.dart';

void main() async {
  // точка входа в приложение
  WidgetsFlutterBinding
      .ensureInitialized(); // WidgetFlutterBinding используется для взаимодействия с движком Flutter, вызываем эту функцию, чтобы убедиться в наличии WidgetsBinding(экземпляр при необходимости создается и инициализируется)
  await di.init(); //ожидаем инициализации service locator
  runZonedGuarded(() {
    // запускаем код в собственной зоне ошибок
    initLogger(); //инициализируем логгер
    logger.info('Start main');

    ErrorHandler.init(); //инициализируем перехватчик ошибок
    runApp(
      const App(),
    );
  }, ErrorHandler.recordError); //передаем функцию для перехвата ошибок
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestWeatherBloc>(
      //подключаем BLoC
      create: (context) => sl<
          RequestWeatherBloc>(), // получаем ранее инициализированный экземпляр RequestWeatherBloc из service locator
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        debugShowCheckedModeBanner: false, // отключаем дебажную метку
        title: 'Friflex test task',
        onGenerateRoute: sl<NavigationRoute>()
            .generateRoute, // передаем route generator callback
        navigatorKey: sl<NavigationService>()
            .navigatorKey, // передаем глобальный ключ для навигатора
      ),
    );
  }
}
