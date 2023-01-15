import 'package:friflex_test_task/core/init/navigation/navigation_route.dart';
import 'package:friflex_test_task/core/init/navigation/navigation_service.dart';
import 'package:friflex_test_task/core/platform/network_info.dart';
import 'package:friflex_test_task/feature/weather_info/data/repositories/weather_repository_impl.dart';
import 'package:friflex_test_task/feature/weather_info/data/source/weather_remote_data_source.dart';
import 'package:friflex_test_task/feature/weather_info/domain/repositories/weather_repository.dart';
import 'package:friflex_test_task/feature/weather_info/domain/usecases/request_weather.dart';
import 'package:friflex_test_task/feature/weather_info/view/bloc/request_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:http/http.dart' as http;

//Внедрение зависимостей
GetIt sl = GetIt.instance; //экземпляр  GetIt

Future<void> init() async {
  //регистрация классов
  // регистрируем сверху вниз по потоку вызовов

  // Navigation

  // Singleton регистрируются сразу после запуска приложения
  sl.registerSingleton<NavigationService>(NavigationService());
  sl.registerSingleton<NavigationRoute>(NavigationRoute());

  // BloC
  sl.registerFactory(() => RequestWeatherBloc(
      requestWeatherCase:
          sl())); // регистрируем как фабрики с расчетом возможности закрытия потоков BLoC

  // UseCases

  // LazySingleton регистрируются тогда, когда запрашиваются каким то классом
  sl.registerLazySingleton(() => RequestWeatherCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(
            client: sl(),
          ));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(
        sl(),
      ));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
