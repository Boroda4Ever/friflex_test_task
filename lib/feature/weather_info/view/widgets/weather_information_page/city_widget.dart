import 'package:flutter/material.dart';

import 'package:friflex_test_task/feature/weather_info/view/widgets/weather_forecast_page/date_widget.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//Виджет, показывающий название города и дату
class CityWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  const CityWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            data.city.name,
            style: const TextStyle(fontSize: 40),
          ),
        ),
        Center(
          child: DateWidget(data: data),
        ),
      ],
    );
  }
}
