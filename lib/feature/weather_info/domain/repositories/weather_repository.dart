import 'package:dartz/dartz.dart';

import 'package:friflex_test_task/core/error/failure.dart';
import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';

//репозиторий, предоставляющий контракт, по которому можно получать данные с уровня data
abstract class WeatherRepository {
  Future<Either<Failure, WeatherInfoEntity>> getWeatherInCity(String city);
}
