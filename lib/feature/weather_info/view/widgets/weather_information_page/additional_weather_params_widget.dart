import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/general/weather_measurement_widget.dart';

class AdditionalWeatherParamsWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  const AdditionalWeatherParamsWidget({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = data.weatherDay;
    var humidity = forecastList[0].humidity;
    var wind = forecastList[0].speed;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        WeatherMeasurementWidget(
            isShouldBeBig: true,
            icon: FontAwesomeIcons.droplet,
            valueMeasurement: humidity,
            measurement: '%'),
        WeatherMeasurementWidget(
            isShouldBeBig: true,
            icon: FontAwesomeIcons.wind,
            valueMeasurement: wind.round(),
            measurement: 'м/c'),
      ],
    );
  }
}
