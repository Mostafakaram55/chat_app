import 'dart:convert';

import 'package:cubit_pro/featuers/chat_bot/data_sor/chat_service.dart';
import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<Message>> {
  final ChatService service;

  ChatCubit(this.service) : super([]);

  /// إرسال رسالة ترحيبية عند بداية الشات
  void sendWelcomeMessage() {
    if (state.isEmpty) {
      emit([
        Message(
          text:
              'أهلاً بك! 👋\nأنا مساعدك الذكي في منصة التسويق عبر المؤثرين.\nكيف يمكنني مساعدتك اليوم؟',
          type: MessageType.bot,
        ),
      ]);
    }
  }

  void sendMessage(String text) async {
    final currentHistory = List<Message>.from(state);

    emit([...state, Message(text: text, type: MessageType.user)]);

    final typingMessage = Message(
      text: '',
      type: MessageType.bot,
      isTyping: true,
    );
    emit([...state, typingMessage]);

    final botReply = await service.sendMessage(text, currentHistory);

    final newState = List<Message>.from(state);
    newState.removeLast();
    if (botReply.trim().startsWith('{')) {
      try {
        final decoded = jsonDecode(botReply);
        newState.add(
          Message(
            text: decoded['reply'],
            type: MessageType.bot,
            options: List<String>.from(decoded['options']),
          ),
        );
      } catch (_) {
        newState.add(Message(text: botReply, type: MessageType.bot));
      }
    } else {
      newState.add(Message(text: botReply, type: MessageType.bot));
    }

    emit(newState);
  }

  void clearChat() {
    emit([]);
    service.isFirstMessage = true;
  }

  @override
  Future<void> close() {
    service.dispose();
    return super.close();
  }
}
