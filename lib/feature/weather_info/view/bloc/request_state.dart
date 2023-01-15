import '../../domain/entities/weather_info_entity.dart';

//абстрактный класс состояний
abstract class RequestWeatherState {
  const RequestWeatherState();
}

// Пустое состояние
class RequestWeatherEmptyState extends RequestWeatherState {}

// Состояние загрузки
class RequestWeatherLoadingState extends RequestWeatherState {}

// Состояние с загруженными данными
class RequestWeatherLoadedState extends RequestWeatherState {
  final WeatherInfoEntity data;
  const RequestWeatherLoadedState({required this.data});
}

// Состояние с ошибкой
class RequestWeatherErrorState extends RequestWeatherState {
  final String message;
  const RequestWeatherErrorState({required this.message});
}
