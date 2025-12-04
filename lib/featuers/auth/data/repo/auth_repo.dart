import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';

abstract class AuthRepo {
  Future<void> signIn({required AuthParams params});
  Future<void> signUp({required AuthParams params});
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String?> getCurrentUserId();
}