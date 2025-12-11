import 'package:cubit_pro/core/error/failure.dart';
import 'package:cubit_pro/featuers/auth/data/data_source/local_data_source.dart';
import 'package:cubit_pro/featuers/auth/data/data_source/remote_data_source.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/data/repo/auth_repo.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImp implements AuthRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSorurce localDataSource;

  AuthRepoImp({required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, UserModel>> getCurrentUserId({
    required String userId,
  }) {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signIn({
    required AuthParams params,
  }) async {
    try {
      final user = await remoteDataSource.signIn(params: params);
      await localDataSource.setUser(value: user);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp({
    required AuthParams params,
  }) async {
    try {
      final user = await remoteDataSource.signUp(params: params);
      await localDataSource.setUser(value: user);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(e));
    }
  }
}
