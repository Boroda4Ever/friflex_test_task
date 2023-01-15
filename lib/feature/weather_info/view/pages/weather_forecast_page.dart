import 'package:flutter/material.dart';

import 'package:friflex_test_task/core/init/navigation/navigation_service.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/weather_forecast_page/card_widget.dart';
import 'package:friflex_test_task/service_locator.dart';

//Третий экран, выводящий информацию о трех самых холодных днях из 7 дней
class WeatherforecastPage extends StatefulWidget {
  const WeatherforecastPage({super.key});

  @override
  State<WeatherforecastPage> createState() => _WeatherforecastPageState();
}

class _WeatherforecastPageState extends State<WeatherforecastPage> {
  @override
  Widget build(BuildContext context) {
    WeatherInfoEntity data = ModalRoute.of(context)!.settings.arguments
        as WeatherInfoEntity; //достаем данные из аргумента MaterialPageRoute
    data.weatherDay.sort((a, b) =>
        a.temp.compareTo(b.temp)); //сортируем по возрастанию температуры
    return SafeArea(
      //определяем зону гарантированного отображения информации

      child: Scaffold(
        // визуальная основа для построения интерфейса
        appBar: AppBar(
          //Прозрачный AppBar
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Самые холодные дни',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              //при нажатии на эту кнопку мы переходим на предыдущий экран
              sl<NavigationService>().navigateBack();
            },
          ),
        ),
        body: ListView.separated(
          //отображаем ListView, разделенный Divider()
          itemCount: 3, //всего показываем три дня
          separatorBuilder: (context, index) =>
              const Divider(), //стандартный разделитель
          itemBuilder: (context, index) => CardWidget(data: data, index: index),
        ),
      ),
    );
  }
}
