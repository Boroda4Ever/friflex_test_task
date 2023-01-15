import 'package:dartz/dartz.dart';

import 'package:friflex_test_task/core/error/failure.dart';
import 'package:friflex_test_task/core/usecases/usecases.dart';

import 'package:friflex_test_task/feature/weather_info/domain/entities/weather_info_entity.dart';
import 'package:friflex_test_task/feature/weather_info/domain/repositories/weather_repository.dart';

// Сценарий запроса погоды для города по его имени
class RequestWeatherCase
    extends UseCase<WeatherInfoEntity, RequestWeatherByCity> {
  final WeatherRepository weatherRepository;

  RequestWeatherCase(this.weatherRepository);

  // В случае вызова обращаемся к репозиторию, который реализует контракт с секущего уровня domain на уровне data
  @override
  Future<Either<Failure, WeatherInfoEntity>> call(
      RequestWeatherByCity params) async {
    return await weatherRepository.getWeatherInCity(params.city);
  }
}

class RequestWeatherByCity {
  final String city;

  const RequestWeatherByCity({required this.city});
}
