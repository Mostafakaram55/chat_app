import 'package:cubit_pro/featuers/chat_bot/presentation/lottie.dart';
import 'package:flutter/material.dart';

class ChatEmptyStateWidget extends StatelessWidget {
  const ChatEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomLoiteWidget(
                  height: 120,
                  url: 'assets/lottie/AI bot.json',
                  messageText: '',
                ),
                const SizedBox(height: 16),
                const Text(
                  'ابدأ المحادثة مع مساعدك الذكي',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
