import 'package:cubit_pro/core/error/failure.dart';
import 'package:cubit_pro/core/use_case.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/data/repo/auth_repo.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase extends UseCase<UserModel, AuthParams> {
  final AuthRepo repository;

  SignUpUsecase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(AuthParams params) async {
    return await repository.signUp(params: params);
  }
}