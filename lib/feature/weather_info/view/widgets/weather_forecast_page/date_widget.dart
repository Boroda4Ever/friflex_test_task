import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//Виджет для показа даты
class DateWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  final int index;
  const DateWidget({super.key, required this.data, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('d/M/y').format(DateTime.fromMillisecondsSinceEpoch(
          data.weatherDay[index].dt *
              1000)), //форматируем дату по шаблону из DateTime
      style: const TextStyle(fontSize: 15),
    );
  }
}
