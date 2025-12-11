import 'package:cubit_pro/featuers/auth/data/data_source/local_data_source.dart';
import 'package:cubit_pro/featuers/auth/data/data_source/remote_data_source.dart';
import 'package:cubit_pro/featuers/auth/data/repo/auth_repo.dart';
import 'package:cubit_pro/featuers/auth/domain/repo_imp/auth_repo_imp.dart';
import 'package:cubit_pro/featuers/auth/domain/use_case/sign_in_use_case.dart';
import 'package:cubit_pro/featuers/auth/domain/use_case/sign_up_use-case.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
void setup() {
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      remoteDataSource: RemoteDataSourceImpl(),
      localDataSource: LocalDataSourceImpl(),
    ),
  );
  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(authRepo: getIt.get<AuthRepo>()),
  );
  getIt.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(repository: getIt.get<AuthRepo>()),
  );
  getIt.registerFactory(
    () => AuthCubit(
      signInUseCases: getIt.get<SignInUseCase>(),
      signUpUsecase: getIt.get<SignUpUsecase>(),
    ),
  );
}
