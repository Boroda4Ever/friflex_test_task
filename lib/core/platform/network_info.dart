import 'package:internet_connection_checker/internet_connection_checker.dart';

//интервейс для сервиса, проверяющего соединение с интернетом
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// сервис для проверки соединения с интернетом, реализующий соотвествующий интерфейс
class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImp(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
