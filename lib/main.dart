import 'dart:io';

import 'package:cubit_pro/config/local/cache_helper.dart';
import 'package:cubit_pro/core/user_helper/user_helper.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final userHelper = UserHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LogInView(),
    );
  }
}
