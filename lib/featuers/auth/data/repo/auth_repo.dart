import 'package:cubit_pro/core/error/failure.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> signIn({required AuthParams params});
  Future<Either<Failure, UserModel>> signUp({required AuthParams params});
  Future<bool> isSignedIn();
  Future<Either<Failure, UserModel>> getCurrentUserId({required String userId});
}

