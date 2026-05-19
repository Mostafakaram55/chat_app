import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/chat_bubble_widget.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/widgets/typing_indicator_widget.dart';
import 'package:flutter/material.dart';

class ChatMessagesListWidget extends StatelessWidget {
  final List<Message> messages;
  final ScrollController scrollController;
  final Function(String) onOptionSelected;

  const ChatMessagesListWidget({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        // Show typing indicator for typing messages
        if (message.isTyping) {
          return const TypingIndicatorWidget();
        }

        final isUser = message.type == MessageType.user;
        return ChatBubbleWidget(
          message: message,
          isUser: isUser,
          onOptionSelected: onOptionSelected,
        );
      },
    );
  }
}
