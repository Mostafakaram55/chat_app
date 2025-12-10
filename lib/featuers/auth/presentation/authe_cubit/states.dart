import 'package:cubit_pro/featuers/auth/data/models/model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
//============ sign in States========
class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {
  final UserModel user;
  LoginSuccessState({required this.user});
}
class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState({required this.error});
}
//============ sign up States========
class SignUpLoadingState extends AuthStates {}
class SignUpSuccessState extends AuthStates {
  final UserModel user;
  SignUpSuccessState({required this.user});
}
class SignUpErrorState extends AuthStates {
  final String error;
  SignUpErrorState({required this.error});
}