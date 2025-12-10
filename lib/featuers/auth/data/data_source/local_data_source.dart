
import 'package:cubit_pro/core/user_helper/user_helper.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/main.dart';

abstract class LocalDataSorurce {
  Future<void> setUser({ required UserModel value});
  Future<UserModel?> getUser({required String key});
}

class LocalDataSourceImpl implements LocalDataSorurce {
  @override
  Future<UserModel?> getUser({required String key}) async{
    return UserHelper.getUserModelFormSharedPref();
  }

  @override
  Future<void> setUser({required UserModel value}) {
    return userHelper.saveToPrefs(useModel: value);
  }
}
