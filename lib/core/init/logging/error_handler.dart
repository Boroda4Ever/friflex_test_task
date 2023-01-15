import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'logger.dart';

// Обработчик ошибок для перехвата их в собственной зоне ошибок
class ErrorHandler {
  // объявляем функцию для инициализации перехватчика
  static void init() {
    FlutterError.onError = _recordFlutterError;
    logger.info('ErrorHandler initialized');
  }

  // объявляем функцию для перехвата ошибок
  static void recordError(Object error, StackTrace stackTrace) {
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );
  }

  static void _recordFlutterError(FlutterErrorDetails error) {
    logger.severe(error.toStringShort(), error.exception, error.stack);
  }
}
