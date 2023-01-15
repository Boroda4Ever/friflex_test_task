import 'package:flutter/material.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//Виджет, показывающий температуру
class TemperatureWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  const TemperatureWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${data.weatherDay[0].temp.round()}°",
        style: const TextStyle(fontSize: 100),
      ),
    );
  }
}
