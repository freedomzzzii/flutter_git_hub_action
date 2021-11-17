import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../commons/errors/app_error.dart';
import '../error_code/error_code_util.dart';

abstract class FirebaseMessagingUtil {
  Future<String?> getToken();

  void onMessage();

  Future<void> requestNotificationPermission();
}

class FirebaseMessagingUtilError implements AppError {
  FirebaseMessagingUtilError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in firebase messaging:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class AndroidFirebaseMessagingUtil extends FirebaseMessagingUtil {
  AndroidFirebaseMessagingUtil({
    required FirebaseMessaging messaging,
    required AndroidLocalNotificationUtil localNotification,
  })  : _messaging = messaging,
        _localNotification = localNotification,
        super();

  final FirebaseMessaging _messaging;
  final AndroidLocalNotificationUtil _localNotification;

  FirebaseMessaging get messaging => _messaging;

  AndroidLocalNotificationUtil get localNotification => _localNotification;

  @override
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  void onMessage() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          _localNotification.show(message: message);
        }
      });
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> requestNotificationPermission() async {
    try {
      final NotificationSettings _settings =
          await _messaging.getNotificationSettings();

      switch (_settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          getToken();
          onMessage();
          break;
        default:
          final NotificationSettings _newSetting =
              await _messaging.requestPermission();
          if (_newSetting.authorizationStatus ==
              AuthorizationStatus.authorized) {
            getToken();
            onMessage();
          }
          break;
      }
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

class IosFirebaseMessagingUtil extends FirebaseMessagingUtil {
  IosFirebaseMessagingUtil({
    required FirebaseMessaging messaging,
    required IosLocalNotificationUtil localNotification,
  })  : _messaging = messaging,
        _localNotification = localNotification,
        super();

  final FirebaseMessaging _messaging;
  final IosLocalNotificationUtil _localNotification;

  FirebaseMessaging get messaging => _messaging;

  IosLocalNotificationUtil get localNotification => _localNotification;

  @override
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> onMessage() async {
    try {
      // see more in https://firebase.flutter.dev/docs/messaging/notifications#ios-configuration
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // do something e.g. call api
      });
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> requestNotificationPermission() async {
    try {
      final NotificationSettings _settings =
          await _messaging.getNotificationSettings();

      switch (_settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          getToken();
          onMessage();
          break;
        default:
          final NotificationSettings _newSetting =
              await _messaging.requestPermission();
          if (_newSetting.authorizationStatus ==
              AuthorizationStatus.authorized) {
            getToken();
            onMessage();
          }
          break;
      }
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

class WebFirebaseMessagingUtil extends FirebaseMessagingUtil {
  WebFirebaseMessagingUtil({
    required FirebaseMessaging messaging,
    required WebLocalNotificationUtil localNotification,
  })  : _messaging = messaging,
        _localNotification = localNotification,
        super();

  final FirebaseMessaging _messaging;
  final WebLocalNotificationUtil _localNotification;

  FirebaseMessaging get messaging => _messaging;

  WebLocalNotificationUtil get localNotification => _localNotification;

  @override
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> onMessage() async {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // do something e.g. call api
      });
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> requestNotificationPermission() async {
    try {
      final NotificationSettings _settings =
          await _messaging.getNotificationSettings();

      switch (_settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          getToken();
          onMessage();
          break;
        default:
          final NotificationSettings _newSetting =
              await _messaging.requestPermission();
          if (_newSetting.authorizationStatus ==
              AuthorizationStatus.authorized) {
            getToken();
            onMessage();
          }
          break;
      }
    } catch (e) {
      throw FirebaseMessagingUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

abstract class LocalNotificationUtil {
  // e.g. onSelectNotification - select notification
}

class LocalNotificationUtilError implements AppError {
  LocalNotificationUtilError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in local notification:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class AndroidLocalNotificationUtil implements LocalNotificationUtil {
  AndroidLocalNotificationUtil({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        super() {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
      ),
    );
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  // see more in https://firebase.flutter.dev/docs/messaging/notifications#notification-channels
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  Future<void> show({
    required RemoteMessage message,
  }) async {
    try {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      _flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    } catch (e) {
      throw LocalNotificationUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

class IosLocalNotificationUtil implements LocalNotificationUtil {
  IosLocalNotificationUtil({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        super() {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(),
      ),
    );
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;
}

class WebLocalNotificationUtil implements LocalNotificationUtil {
  WebLocalNotificationUtil({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        super() {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(),
    );
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;
}
