import 'dart:io';
import 'package:cubit_pro/config/local/cache_helper.dart';
import 'package:cubit_pro/config/routes/app_routes.dart';
import 'package:cubit_pro/core/di/di.dart';
import 'package:cubit_pro/core/user_helper/user_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final userHelper = UserHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   setup();
  await CacheHelper.init();
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
