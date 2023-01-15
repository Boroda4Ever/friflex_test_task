import 'package:flutter/material.dart';

import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//виджет для показа любой характеристики погоды в заданном стиле
class DayWeatherDescriptionWidget extends StatelessWidget {
  final WeatherInfoEntity data;
  final int index;
  const DayWeatherDescriptionWidget(
      {super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    var size =
        MediaQuery.of(context).size; //получаем текущий размер доступной области
    return SizedBox(
      width: (size.width - 45) /
          4, //орпределяем размер области, отведенной под одну характеристику
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Image.network(
                data.weatherDay[index]
                    .getIconUrl(), //картинку получаем из интернета
                scale: 0.5,
                color: Colors.black),
          ),
          Text(
            "${data.weatherDay[index].description[0].toUpperCase()}${data.weatherDay[index].description.substring(1).toLowerCase()}", //делаем первую букву заглавной
            style: const TextStyle(color: Colors.grey, fontSize: 15),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center, //центрируем текст
          )
        ],
      ),
    );
  }
}
