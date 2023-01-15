import 'package:flutter/material.dart';

import 'package:friflex_test_task/common/architecture_widgets/not_found_navigation_widget.dart';
import 'package:friflex_test_task/core/constants/navigation_constants.dart';
import 'package:friflex_test_task/feature/weather_info/view/pages/exported_pages.dart';

//класс, хранящий функцию route generator callback
class NavigationRoute {
  NavigationRoute();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.defaultRoute:
        return _normalNavigate(const MainPage(),
            NavigationConstants.defaultRoute, settings.arguments);
      case NavigationConstants.main:
        return _normalNavigate(
            const MainPage(), NavigationConstants.main, settings.arguments);
      case NavigationConstants.weatherInformation:
        return _normalNavigate(const WeatherInformationPage(),
            NavigationConstants.weatherInformation, settings.arguments);
      case NavigationConstants.weatherForecast:
        return _normalNavigate(const WeatherforecastPage(),
            NavigationConstants.weatherForecast, settings.arguments);
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute _normalNavigate(
      // фунуция для навигации
      Widget widget,
      String pageName,
      Object? args) {
    return MaterialPageRoute(
        // возвращаем модальный маршрут, который заменяет экран адаптивным переходом
        builder: (context) => widget,
        settings: RouteSettings(name: pageName, arguments: args));
  }
}
