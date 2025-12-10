import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';

abstract class RemoteDataSource {
  Future<UserModel> signIn({required AuthParams params});
  Future<UserModel> signUp({required AuthParams params});
  Future<UserModel> getCurrentUserId({required String userId});
  Future<bool> isSignedIn();
}
class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<UserModel> getCurrentUserId({required String userId}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signIn({required AuthParams params}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({required AuthParams params}) {
    throw UnimplementedError();
  }

}