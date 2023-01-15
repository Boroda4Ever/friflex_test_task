import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:friflex_test_task/core/constants/api_constants.dart';
import 'package:friflex_test_task/core/error/exception.dart';
import 'package:friflex_test_task/core/init/logging/logger.dart';

import 'package:friflex_test_task/feature/weather_info/data/models/weather_info_model.dart';

// Интерфейс, описывающий удаленный источник данных
abstract class WeatherRemoteDataSource {
  Future<WeatherInfoModel> getWeatherInCity(String city);
}

// Удаленный источник данных, реализующий соответстувющий интерфейс
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client; // нам требуется http.Client для запросов на сервер

  WeatherRemoteDataSourceImpl({required this.client});

  //функция, отправляющая запрос на сервер в необходимом виде и возвращающая Future
  @override
  Future<WeatherInfoModel> getWeatherInCity(String city) async {
    logger.info("Request weather for city: $city");

    final parameters = {
      // необходимые параметры, из который в последствии собирается Uri
      'appid': APIConstants.appId,
      'units': 'metric',
      'q': city,
      'lang': 'ru'
    };
    // Получаем ответ от сервара на наш запрос
    final response = await client.get(Uri.https(
        APIConstants.baseUrlDomain, APIConstants.forecastPath, parameters));
    // смотрим на код нашего ответа и в зависимости от этого либо парсим данные и возвращаем их, либо бросаем исключение
    if (response.statusCode == 200) {
      logger.info("Successfull request");

      return WeatherInfoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
