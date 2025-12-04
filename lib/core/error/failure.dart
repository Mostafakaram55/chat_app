

import 'package:cubit_pro/core/utiles/app_string.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class Failure {
  final String error;

  const Failure(this.error);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.error);

  factory FirebaseFailure.fromFirebaseException(FirebaseException exception) {
    switch (exception.code) {
      case 'network-request-failed':
        return FirebaseFailure(AppStrings.connectionErrorMessage);
      case 'invalid-argument':
        return FirebaseFailure(AppStrings.invalidArgumentErrorMessage);
      case 'email-already-in-use':
        return FirebaseFailure(AppStrings.emailAlreadyInUseErrorMessage);
      case 'user-not-found':
        return FirebaseFailure(AppStrings.userNotFoundErrorMessage);
      case 'wrong-password':
        return FirebaseFailure(AppStrings.wrongPasswordErrorMessage);
      case 'requires-recent-login':
        return FirebaseFailure(AppStrings.requiresRecentLoginErrorMessage);
      case 'permission-denied':
        return FirebaseFailure(AppStrings.permissionDeniedErrorMessage);
      case 'unknown':
        return FirebaseFailure(AppStrings.unknownErrorMessage);
      default:
        return FirebaseFailure(AppStrings.defaultErrorMessage);
    }
  }
}
