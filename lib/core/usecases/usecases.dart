import 'package:dartz/dartz.dart';

import 'package:friflex_test_task/core/error/failure.dart';

// абстрактный класс, описывающий сценарий взаимодействия
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
