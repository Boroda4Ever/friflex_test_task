import 'package:flutter/material.dart';

//Зацикленная анимация загрузки
class LoadAnimationWidget extends StatefulWidget {
  const LoadAnimationWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<LoadAnimationWidget> createState() => _LoadAnimationWidgetState();
}

class _LoadAnimationWidgetState extends State<LoadAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> animationTranslate;
  late Animation<Offset> animationResize;

  late Offset containerSizeBegin;
  late Offset containerSizeEnd;

  late Offset containerPositionBegin;
  late Offset containerPositionEnd;

  @override
  void initState() {
    super.initState();

    containerSizeBegin = const Offset(5, 5); //Начальный размер
    containerSizeEnd = const Offset(100, 5); //конечный размер

    containerPositionBegin =
        Offset(-(widget.width) / 2, 0); //Начальное смещение
    containerPositionEnd =
        Offset((widget.width) / 2 - 50, 0); //Конечное смещение

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward(); //сразу запускаем анимацию

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController
            .repeat(); //как только анимация закончилась, повторно запускаем
      }
    });

    animationTranslate = Tween<Offset>(
      //Анимация движения между начальным и конечным положением
      begin: containerPositionBegin,
      end: containerPositionEnd,
    ).animate(animationController);

    animationResize = Tween<Offset>(
      //Анимация изменения размера между начальным и конечным размером
      begin: containerSizeBegin,
      end: containerSizeEnd,
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        var animatedChild = _createLine(
          //создаем линию по параметрам
          width: animationResize.value.dx,
          height: animationResize.value.dy,
        );
        animatedChild = Transform.translate(
          //изменяем линию
          offset: animationTranslate.value,
          child: animatedChild,
        );
        return animatedChild;
      },
    );
  }

  //функция создания линии
  Widget _createLine({required double width, required double height}) {
    return Center(
      child: Container(
        color: Colors.black,
        width: width,
        height: height,
      ),
    );
  }
}
