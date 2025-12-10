import 'package:cubit_pro/featuers/auth/domain/use_case/sign_in_use_case.dart';
import 'package:cubit_pro/featuers/auth/domain/use_case/sign_up_use-case.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/states.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final SignInUseCase authUseCases;
  final SignUpUsecase signUpUsecase;

  AuthCubit({required this.authUseCases, required this.signUpUsecase})
    : super(AuthInitialState());

  Future<void> signIn({required AuthParams params}) async {
    emit(LoginLoadingState());
    final result = await authUseCases.call(params);
    result.fold(
      (failure) {
        emit(LoginErrorState(error: failure.error));
      },
      (user) {
        emit(LoginSuccessState(user: user));
      },
    );
  }
  Future<void> signUp({required AuthParams params}) async {
    emit(SignUpLoadingState());
    final result = await signUpUsecase.call(params);
    result.fold(
      (failure) {
        emit(SignUpErrorState(error: failure.error));
      },
      (user) {
        emit(SignUpSuccessState(user: user));
      },
    );
  }
}
