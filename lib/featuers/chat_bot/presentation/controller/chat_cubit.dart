import 'package:cubit_pro/featuers/chat_bot/data_sor/gemini_service.dart';
import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<Message>> {
  final GeminiService service;

  ChatCubit(this.service) : super([]);

  void sendMessage(String text) async {
    // 1. إضافة رسالة المستخدم
    emit([...state, Message(text: text, type: MessageType.user)]);

    // 2. إضافة رسالة مؤقتة "جاري التفكير..."
    final typingMessage = Message(text: '...', type: MessageType.bot);
    emit([...state, typingMessage]);

    // 3. استدعاء الخدمة
    final botReply = await service.sendMessage(text);

    // 4. استبدال الرسالة المؤقتة بالرد الفعلي
    final newState = List<Message>.from(state);
    if (newState.isNotEmpty && newState.last.text == '...') {
      newState.removeLast();
    }
    newState.add(Message(text: botReply, type: MessageType.bot));
    emit(newState);
  }
}
