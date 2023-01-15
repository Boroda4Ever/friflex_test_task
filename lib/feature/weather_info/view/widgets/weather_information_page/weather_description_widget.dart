import 'package:flutter/material.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//Виджет, выводящий картинку и текстовое описане погоды в этот день
class WeatherDescriptionWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  const WeatherDescriptionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Image.network(data.weatherDay[0].getIconUrl(),
              scale: 0.2, color: Colors.black),
        ),
        const SizedBox(height: 10.0),
        Center(
            child: Text(
          "${data.weatherDay[0].description[0].toUpperCase()}${data.weatherDay[0].description.substring(1).toLowerCase()}",
          style: const TextStyle(color: Colors.grey, fontSize: 20),
        )),
      ],
    );
  }
}
