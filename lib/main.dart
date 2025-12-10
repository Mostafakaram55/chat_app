import 'package:cubit_pro/config/local/cache_helper.dart';
import 'package:cubit_pro/core/user_helper/user_helper.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/login_view.dart';
import 'package:flutter/material.dart';
final userHelper = UserHelper();
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await CacheHelper.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit Pro',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: LogInView(),
    );
  }
}
