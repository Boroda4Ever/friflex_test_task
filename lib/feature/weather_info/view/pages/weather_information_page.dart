import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friflex_test_task/core/constants/navigation_constants.dart';
import 'package:friflex_test_task/core/init/navigation/navigation_service.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/view/bloc/exported_bloc.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/weather_information_page/export_weather_information_page_widgets.dart';
import 'package:friflex_test_task/service_locator.dart';

//Второй Экран, выводящий детальную информацию о погоде в выбранном городе
class WeatherInformationPage extends StatelessWidget {
  const WeatherInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherInfoEntity data = ModalRoute.of(context)!.settings.arguments
        as WeatherInfoEntity; //данные получаем из аргумента MaterialPageRoute

    return WillPopScope(
      //если нажали на андроид устройстве кнопку назад, мы должны излучить состояние с очисткой данных
      onWillPop: () async {
        BlocProvider.of<RequestWeatherBloc>(context)
            .add(RequestWeatherClearEvent());
        return true;
      },
      child: SafeArea(
        //определяем зону гарантированного отображения информации
        child: Scaffold(
            // визуальная основа для построения интерфейса
            appBar: AppBar(
              // AppBar прозрачного цвета и без тени
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ), // Кнопка назад
                onPressed: () {
                  //При нажатии на кнопку мы излучаем состояние с очисткой данных и совершаем чистый переход на первый экран с очисткой истории маршрутов
                  BlocProvider.of<RequestWeatherBloc>(context)
                      .add(RequestWeatherClearEvent());
                  sl<NavigationService>()
                      .navigateToPageClear(path: NavigationConstants.main);
                },
              ),
              actions: [
                IconButton(
                  // кнопка для перехода на экран с информацией о погоде за несколько дней
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    //при нажатии мы перехдим на 3 экран, притягивая за собой данные
                    sl<NavigationService>().navigateToPage(
                        path: NavigationConstants.weatherForecast, data: data);
                  },
                )
              ],
            ),
            body: ListView(
              //Отображение визуальных элементов
              children: [
                const SizedBox(height: 20.0),
                CityWidget(data: data), //Виджет с названием города и временем
                const SizedBox(height: 50.0),
                WeatherDescriptionWidget(
                    data: data), //виджет с иконкой погоды и словесным описанием
                const SizedBox(height: 10.0),
                TemperatureWidget(
                    data: data), //виджет, показывающий температуру
                const SizedBox(height: 50.0),
                AdditionalWeatherParamsWidget(
                    data:
                        data), //виджет, показывающий информвцию о влажности и скорости ветра в этом городе
                const SizedBox(height: 50.0),
              ],
            )),
      ),
    );
  }
}
