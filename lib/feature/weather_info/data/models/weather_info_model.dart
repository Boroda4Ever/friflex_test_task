import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

import 'city_model.dart';
import 'weather_day_model.dart';

// Модель для хранения информации о погоде за несколько дней, наследующая соответствующую сущность и имеющая фабричный конструктор из json
class WeatherInfoModel extends WeatherInfoEntity {
  WeatherInfoModel({
    required city,
    required weatherDay,
  }) : super(city: city, weatherDay: weatherDay);

  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    var list = [];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(WeatherDayModel.fromJson(v));
      });
    }
    return WeatherInfoModel(
        city: (json['city'] != null ? CityModel.fromJson(json['city']) : null)
            as CityModel,
        weatherDay: list.map((e) => e as WeatherDayModel).toList());
  }
}
