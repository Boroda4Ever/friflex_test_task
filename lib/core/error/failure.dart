// Классы ошибок для удобной обработки в try/catch
abstract class Failure {}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}
