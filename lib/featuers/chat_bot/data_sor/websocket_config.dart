import 'dart:io';

/// مساعد لتحديد URL المناسب حسب البيئة
class WebSocketConfig {
  /// الحصول على URL المناسب حسب البيئة
  static String getWebSocketUrl({
    required String host,
    required int port,
    required String endpoint,
  }) {
    // للتطوير: تحديد تلقائي حسب البيئة
    String baseHost;

    if (Platform.isAndroid) {
      // Android Emulator يستخدم 10.0.2.2 للوصول إلى localhost على الكمبيوتر
      baseHost = host == 'localhost' ? '10.0.2.2' : host;
    } else if (Platform.isIOS) {
      // iOS Simulator يستخدم localhost مباشرة
      baseHost = host;
    } else {
      // أي منصة أخرى
      baseHost = host;
    }

    return 'ws://$baseHost:$port$endpoint';
  }

 

  static const String productionUrl =
      'wss://your-production-server.com/ws/chat';

  static String developmentUrl = getWebSocketUrl(
    host: 'localhost',
    port: 62754,
    endpoint: '/ws/chat/postman_socket',
  );

  static String get currentUrl {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? productionUrl : developmentUrl;
  }
}

class EnvConfig {
  /// يمكنك تعريف المتغيرات في launch.json أو عند التشغيل:
  /// flutter run --dart-define=WS_HOST=192.168.1.5
  static const String wsHost = String.fromEnvironment(
    'WS_HOST',
    defaultValue: 'localhost',
  );

  static const int wsPort = int.fromEnvironment('WS_PORT', defaultValue: 62754);

  static const String wsEndpoint = String.fromEnvironment(
    'WS_ENDPOINT',
    defaultValue: '/ws/chat/postman_socket',
  );

  static String get wsUrl => WebSocketConfig.getWebSocketUrl(
    host: wsHost,
    port: wsPort,
    endpoint: wsEndpoint,
  );
}
