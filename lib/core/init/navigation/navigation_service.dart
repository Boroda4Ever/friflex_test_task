import 'package:flutter/material.dart';
import 'package:friflex_test_task/core/init/logging/logger.dart';

import 'i_navigation_service.dart';

// Сервис для навигации, реализующий соответствующий интерфейс
class NavigationService implements INavigationService {
  NavigationService();

  GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(); //глобальный ключ навигации
  bool removeAllOldRoutes(Route<dynamic> route) =>
      false; //функция для очистки истории переходов и последующего чистого перехода на экран

  // переход на экран по маршруту с возможными аргументами
  @override
  Future<void> navigateToPage({required String path, Object? data}) async {
    logger.info("Navigate to page $path");
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  // возврат на предыдущий экран
  @override
  void navigateBack() {
    logger.info("Navigation pop");
    navigatorKey.currentState!.pop();
  }

  //чистый переход на экран по маршруту с возможными аргументами и очисткой истории переходов
  @override
  Future<void> navigateToPageClear({required String path, Object? data}) async {
    logger.info("Clear navigate to page $path");
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }
}
