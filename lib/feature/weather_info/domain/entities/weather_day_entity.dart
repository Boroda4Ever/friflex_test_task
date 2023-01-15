import 'package:friflex_test_task/core/constants/api_constants.dart';

//сущность, хранящая информацию о погоде в данный день
class WeatherDayEntity {
  final int dt;
  final double temp;
  final int humidity;
  final double speed;
  final String description;
  final String icon;

  const WeatherDayEntity({
    required this.dt,
    required this.temp,
    required this.humidity,
    required this.speed,
    required this.description,
    required this.icon,
  });

  String getIconUrl() {
    return '${APIConstants.imagesUrl}$icon.png';
  }
}
