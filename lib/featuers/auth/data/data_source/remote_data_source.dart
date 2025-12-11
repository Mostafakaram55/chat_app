import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_pro/featuers/auth/data/models/model.dart';
import 'package:cubit_pro/featuers/auth/presentation/params/sign_in_params.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  Future<UserModel> signIn({required AuthParams params});
  Future<UserModel> signUp({required AuthParams params});
  Future<UserModel> getCurrentUserId({required String userId});
  Future<bool> isSignedIn();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  @override
  Future<UserModel> getCurrentUserId({required String userId}) {
    throw UnimplementedError();
  }
 
  @override
  Future<bool> isSignedIn() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signIn({required AuthParams params}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
    final user = credential.user!;
    final doc = await firestore.collection("users").doc(user.uid).get();
    return UserModel.fromJson(doc.data()!);
  }
  @override
  Future<UserModel> signUp({required AuthParams params}) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
    final user = credential.user!;
    final userModel = UserModel(
      uid: user.uid,
      name: params.name ?? "",
      email: user.email!,
      phone: params.phone,
    );
    await firestore.collection("users").doc(user.uid).set(userModel.toJson());
    return userModel;
  }
}
