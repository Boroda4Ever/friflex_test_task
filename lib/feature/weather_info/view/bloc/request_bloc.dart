import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:friflex_test_task/core/error/failure.dart';
import 'package:friflex_test_task/feature/weather_info/domain/usecases/request_weather.dart';
import 'package:friflex_test_task/feature/weather_info/view/bloc/request_state.dart';

import 'request_event.dart';

// Компонент бизнес логики для хранения состояния приложения и обработки событий запроса/очистки данных
class RequestWeatherBloc
    extends Bloc<RequestWeatherEvent, RequestWeatherState> {
  final RequestWeatherCase
      requestWeatherCase; //указываем сценарий, по которому будут выполняться запросы

  // При запуске конструктора передаем изначально пустое состояние и указываем, как будут обрабатываться события
  RequestWeatherBloc({required this.requestWeatherCase})
      : super(RequestWeatherEmptyState()) {
    on<RequestWeatherLoadEvent>(_onEventLoad);
    on<RequestWeatherClearEvent>(_onEventClear);
  }

  // Функция для обработки события загрузки данных
  FutureOr<void> _onEventLoad(
      RequestWeatherLoadEvent event, Emitter<RequestWeatherState> emit) async {
    emit(
        RequestWeatherLoadingState()); //испускаем состояние загрузки на время ожидания ответа от сервера
    final failureOrData = await requestWeatherCase(
        RequestWeatherByCity(city: event.city)); //ждем ответ от сервера
    emit(failureOrData.fold(
        (failure) => //если пришла ошибка, испускаем состояние с ошибкой, которую предварительно преобразуем в строку соотвествующей функцией
            RequestWeatherErrorState(message: _mapFailureToMessage(failure)),
        (data) => RequestWeatherLoadedState(
            data: data))); //если пришли данные, испускаем состояние с данными
  }

  // Функция для обработки собятия очистки данных
  FutureOr<void> _onEventClear(
      RequestWeatherClearEvent event, Emitter<RequestWeatherState> emit) async {
    emit(RequestWeatherEmptyState()); //просто испускаем пустое состояние
  }

  //возвращаем строку в соответствии с ошибкой, вернувшейся со слоя data
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Ошибка сервера";
      case NetworkFailure:
        return "Ошибка сетевого соединения";
      default:
        return 'Unexpected Error';
    }
  }
}
