import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friflex_test_task/feature/weather_info/view/bloc/exported_bloc.dart';
import 'package:friflex_test_task/feature/weather_info/view/widgets/main_page/form_widget.dart';

import 'load_animation_widget.dart';
import 'welcome_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //получаем размер доступной области
    return BlocBuilder<RequestWeatherBloc, RequestWeatherState>(
        builder: (context, state) {
      //отслеживаем состояние компонента бизнес логики
      if (state is RequestWeatherErrorState) {
        //если состояние ошибки, то вызываем соответствующую функцию
        _showDialogueAndSnackBar(state.message);
      }
      return SingleChildScrollView(
          //прокручеваемая часть интерфейса, чтобы интерфейс не вылезал за границы при появлении ввиртуальной клавиатуры
          child: Container(
              padding: EdgeInsets.all(size.width - size.width * .85),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  const WelcomeWidget(), //Виджет с текстом добро пожаловать
                  SizedBox(height: size.height * 0.15),
                  FormWidget(
                      state: state), //виджет с текстовым полем и кнопокой
                  (state is RequestWeatherLoadingState)
                      ? LoadAnimationWidget(width: size.width * 0.7)
                      : const SizedBox()
                ],
              )));
    });
  }

  void _showDialogueAndSnackBar(String message) {
    Future<void>.delayed(Duration.zero, () {
      showDialog(
          //выводи диалоговое окно по центру
          context: context,
          builder: (context) => const AlertDialog(
                content: SizedBox(
                    height: 100,
                    width: 200,
                    child: Center(child: Text("Ошибка получения данных"))),
              ));

      ScaffoldMessenger.of(context).showSnackBar(
        //выводим SnackBar с текстом по центру
        SnackBar(content: Center(child: Text(message))),
      );
    });
    BlocProvider.of<RequestWeatherBloc>(context)
        .add(RequestWeatherClearEvent()); //передаем состояние очистки данных
  }
}
