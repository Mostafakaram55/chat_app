import 'package:cubit_pro/core/error/failure.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/data/repo/auth_repo.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImp implements AuthRepo {
  @override
  Future<Either<Failure, UserModel>> getCurrentUserId({required String userId}) {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signIn({required AuthParams params}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUp({required AuthParams params}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}
