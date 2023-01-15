import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_day_entity.dart';

// Модель для хранения информации о погоде для одного дня, наследующая соответствующую сущность и имеющая фабричный конструктор из json
class WeatherDayModel extends WeatherDayEntity {
  WeatherDayModel({
    required dt,
    required temp,
    required humidity,
    required speed,
    required description,
    required icon,
  }) : super(
            dt: dt,
            temp: temp,
            humidity: humidity,
            speed: speed,
            description: description,
            icon: icon);

  factory WeatherDayModel.fromJson(Map<String, dynamic> json) {
    return WeatherDayModel(
        dt: json['dt'],
        temp: json['temp']['day'],
        humidity: json['humidity'],
        speed: json['speed'],
        description: json["weather"][0]['description'],
        icon: json["weather"][0]['icon']);
  }
}
