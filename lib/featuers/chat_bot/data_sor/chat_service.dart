import 'dart:developer';
import 'package:cubit_pro/featuers/chat_bot/data_sor/websocket_service.dart';
import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';

/// خدمة الشات الموحدة التي تستخدم WebSocket API
class ChatService {
  final WebSocketService _wsService = WebSocketService();

  bool isFirstMessage = true;

  /// إرسال رسالة والحصول على الرد
  Future<String> sendMessage(String message, List<Message> history) async {
    try {
      // إرسال الرسالة عبر WebSocket
      final response = await _wsService.sendMessage(message, history);

      // معالجة الرد
      if (response['success'] == true && response['type'] == 'response') {
        isFirstMessage = false;

        // استخراج المحتوى من الرد
        final content = response['content'] ?? 'لا يوجد رد.';

        // يمكنك أيضاً استخدام المصادر إذا كنت تريد عرضها
        final sources = response['sources'] as List<dynamic>?;
        if (sources != null && sources.isNotEmpty) {
          log('Response sources: $sources');
        }

        return content;
      } else {
        return response['content'] ?? 'عذراً، حدث خطأ في الاتصال.';
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  /// معالجة الأخطاء
  String _handleError(dynamic e) {
    log('Chat Service Error: $e');

    if (e.toString().contains('TimeoutException')) {
      return 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';
    }

    if (e.toString().contains('WebSocket')) {
      return 'فشل الاتصال بالخادم. تأكد من تشغيل الخادم على ws://localhost:62754';
    }

    return 'حدث خطأ غير متوقع. يرجى المحاولة لاحقاً.';
  }

  /// إعادة الاتصال
  Future<void> reconnect() async {
    try {
      _wsService.disconnect();
      await _wsService.connect();
    } catch (e) {
      log('Reconnection failed: $e');
    }
  }

  /// التحقق من حالة الاتصال
  bool get isConnected => _wsService.isConnected;

  /// تنظيف الموارد
  void dispose() {
    _wsService.dispose();
  }
}
