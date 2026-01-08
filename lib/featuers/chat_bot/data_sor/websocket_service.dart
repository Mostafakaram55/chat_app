import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cubit_pro/featuers/chat_bot/data_sor/chat_constants.dart';
import 'package:cubit_pro/featuers/chat_bot/models/chat_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final _responseController =
      StreamController<Map<String, dynamic>>.broadcast();
  bool _isConnected = false;

  Stream<Map<String, dynamic>> get responseStream => _responseController.stream;

  bool get isConnected => _isConnected;

  Future<void> connect() async {
    try {
      if (_isConnected) {
        log('WebSocket already connected');
        return;
      }

      _channel = WebSocketChannel.connect(Uri.parse(ChatConstants.wsUrl));

      _isConnected = true;
      log('WebSocket connected successfully');
      _channel!.stream.listen(
        (message) {
          try {
            final decoded = jsonDecode(message);
            log('WebSocket received: $decoded');
            _responseController.add(decoded);
          } catch (e) {
            log('Error decoding WebSocket message: $e');
          }
        },
        onError: (error) {
          log('WebSocket error: $error');
          _isConnected = false;
        },
        onDone: () {
          log('WebSocket connection closed');
          _isConnected = false;
        },
      );
    } catch (e) {
      log('Error connecting to WebSocket: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendMessage(
    String message,
    List<Message> history,
  ) async {
    try {
      if (!_isConnected) {
        await connect();
      }
      final messageData = {"type": "message", "content": message};

      log('Sending WebSocket message: $messageData');

      _channel!.sink.add(jsonEncode(messageData));

      final response = await responseStream
          .firstWhere(
            (msg) => msg['type'] == 'response',
            orElse: () => throw Exception('لم يتم استلام رد من نوع response'),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('لم يتم استلام رد من الخادم');
            },
          );

      return response;
    } catch (e) {
      log('Error sending message: $e');
      rethrow;
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    log('WebSocket disconnected');
  }

  void dispose() {
    disconnect();
    _responseController.close();
  }
}
