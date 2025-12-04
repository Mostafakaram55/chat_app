import 'dart:convert';

import 'package:cubit_pro/config/local/cach_helper_keys.dart';
import 'package:cubit_pro/config/local/cache_helper.dart';
import 'package:cubit_pro/core/utiles/app_constants.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';

class UserHelper {
  bool isLoggin() {
    return CacheHelper.getData(key: CacheHelperKeys.accessToken) != null;
  }

  //! save user  and get user  and update user
  Future<void> saveToPrefs({required UserModel useModel}) async {
    final jsonString = jsonEncode(useModel.toJson());
    await CacheHelper.setData(
      key: AppConstants.userModelShared,
      value: jsonString,
    );
  }

  //! Load user from SharedPreferences
  static UserModel? getUserModelFormSharedPref() {
    final jsonString = CacheHelper.getData(key: AppConstants.userModelShared);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }
}
