import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friflex_test_task/core/constants/navigation_constants.dart';
import 'package:friflex_test_task/core/init/navigation/navigation_service.dart';
import 'package:friflex_test_task/feature/weather_info/view/bloc/exported_bloc.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/main_page/export_main_page_widget.dart';
import 'package:friflex_test_task/service_locator.dart';

//Первый экран с полем для ввода названия города и кнопкой "Подтвердить"
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //определяем зону гарантированного отображения информации
      child: Scaffold(
        // визуальная основа для построения интерфейса
        body: BlocListener(
          // слушаем состояния компонента бизнес логики, ожидая состояния с данными
          bloc: BlocProvider.of<RequestWeatherBloc>(context),
          listener: (context, state) {
            if (state is RequestWeatherLoadedState) {
              sl<NavigationService>().navigateToPage(
                  path: NavigationConstants.weatherInformation,
                  data: state
                      .data); //если пришло состояние с данными, мы переходим на 2 экран, прихватывая за собой эти данные
            }
          },
          child:
              const SearchWidget(), // пока не пришло состояние с данными, выводим на экран текстовое поле с кнопкой
        ),
      ),
    );
  }
}
