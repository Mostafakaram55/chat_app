import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login View'),
      ),
      body: Center(
        child: Text('This is the login view'),
      ),
    );
  }
}