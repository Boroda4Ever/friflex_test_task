//абстрактный класс событий
abstract class RequestWeatherEvent {
  const RequestWeatherEvent();
}

//событие запроса данных
class RequestWeatherLoadEvent extends RequestWeatherEvent {
  final String city;

  const RequestWeatherLoadEvent(this.city);
}

//событие очистки данных
class RequestWeatherClearEvent extends RequestWeatherEvent {}
