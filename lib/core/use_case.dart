import 'package:cubit_pro/core/error/failure.dart';
import 'package:dartz/dartz.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params search);
}

class NoParams {}