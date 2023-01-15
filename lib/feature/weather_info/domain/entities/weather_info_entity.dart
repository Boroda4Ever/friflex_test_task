import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_day_entity.dart';

import 'city_entity.dart';

//сущность, хранящая информацию о погоде за несколько дней
class WeatherInfoEntity {
  final CityEntity city;
  final List<WeatherDayEntity> weatherDay;

  const WeatherInfoEntity({
    required this.city,
    required this.weatherDay,
  });
}
