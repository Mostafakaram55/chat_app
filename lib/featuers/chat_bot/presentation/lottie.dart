import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class CustomLoiteWidget extends StatelessWidget {
  const CustomLoiteWidget({
    super.key,
    required this.url,
    this.height = 220,
    required this.messageText,
  });
  final String url;
  final double height;
  final String messageText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(url, height: height),

      ],
    );
  }
}
