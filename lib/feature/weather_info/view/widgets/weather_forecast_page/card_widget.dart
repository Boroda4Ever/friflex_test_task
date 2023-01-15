import 'package:flutter/material.dart';

import 'export_weather_forecast_page_widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/general/weather_measurement_widget.dart';

//Виджет, показывающий инфу о погоде для города в выбранный день
class CardWidget extends StatelessWidget {
  //Виджет сроится с необходимыми данными
  final WeatherInfoEntity data;
  final int index;
  const CardWidget({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        //отрисовываем карточку
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              DateWidget(data: data, index: index),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  DayWeatherDescriptionWidget(
                    data: data,
                    index: index,
                  ),
                  WeatherMeasurementWidget(
                    icon: FontAwesomeIcons.temperatureHalf,
                    measurement: '°',
                    valueMeasurement: data.weatherDay[index].temp.round(),
                  ),
                  WeatherMeasurementWidget(
                    icon: FontAwesomeIcons.droplet,
                    measurement: '%',
                    valueMeasurement: data.weatherDay[index].humidity,
                  ),
                  WeatherMeasurementWidget(
                    icon: FontAwesomeIcons.wind,
                    measurement: 'м/c',
                    valueMeasurement: data.weatherDay[index].speed.round(),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
