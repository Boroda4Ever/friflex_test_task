import 'package:dartz/dartz.dart';

import 'package:friflex_test_task/core/error/exception.dart';
import 'package:friflex_test_task/core/error/failure.dart';
import 'package:friflex_test_task/core/init/logging/logger.dart';
import 'package:friflex_test_task/core/platform/network_info.dart';

import 'package:friflex_test_task/feature/weather_info/data/models/weather_info_model.dart';
import 'package:friflex_test_task/feature/weather_info/data/source/weather_remote_data_source.dart';

import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/domain/repositories/weather_repository.dart';

//Репозиторий для получения погоды в городе, реализующий соответствующий репозеторий с уровня domain, что позволяет отделить слой данных от остального
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource
      remoteDataSource; //источник данных, у которого мы будем запрашивать информацию
  final NetworkInfo
      networkInfo; // сервис для определения наличия соединения с интернетом

  WeatherRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, WeatherInfoEntity>> getWeatherInCity(
      String city) async {
    return await _getData(() {
      return remoteDataSource.getWeatherInCity(city);
    });
  }

  // Функция возвращает незавершенный объект, который может оказаться либо ошибкой, либо распарсенными данными
  Future<Either<Failure, WeatherInfoModel>> _getData(
      // в функцию передаем функцию по которой запрашиваем данные
      Future<WeatherInfoModel> Function() getdata) async {
    if (await networkInfo.isConnected) {
      //если есть соединение то пробуем получить данные
      try {
        final remoteData = await getdata(); //ожидаем получения данных
        return Right(remoteData); //возвращаем данные, если все ок
      } on ServerException {
        logger.info("Failed request");
        return Left(
            ServerFailure()); // возвращаем ошибку, если что то пошло не так
      }
    } else {
      logger.info("Network connection fail");
      return Left(
          NetworkFailure()); //возвращаем ошибку, если в момент запроса не было соединения
    }
  }
}
