import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../commons/errors/app_error.dart';
import '../../helpers/check_os/check_os_helper.dart';
import '../error_code/error_code_util.dart';

abstract class FirebaseMessagingUtil {
  factory FirebaseMessagingUtil({required OsCodes osCode}) =>
      getFirebaseMessagingUtil(osCode: osCode);

  Future<String?> getToken();

  void onMessage();

  Future<void> requestNotificationPermission();
}

FirebaseMessagingUtil initFbMessaging(OsCodes os) {
  try {
    switch (os) {
      case OsCodes.web:
        final WebFirebaseMessagingUtil webFirebaseMessagingUtil =
            WebFirebaseMessagingUtil(
          messaging: FirebaseMessaging.instance,
          localNotification: WebLocalNotificationUtil(
            flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
          ),
        );

        webFirebaseMessagingUtil.requestNotificationPermission();

        return webFirebaseMessagingUtil;
      case OsCodes.android:
        final AndroidFirebaseMessagingUtil androidFirebaseMessagingUtil =
            AndroidFirebaseMessagingUtil(
          messaging: FirebaseMessaging.instance,
          localNotification: AndroidLocalNotificationUtil(
            flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
          ),
        );

        androidFirebaseMessagingUtil.requestNotificationPermission();

        return androidFirebaseMessagingUtil;
      case OsCodes.ios:
        return IosFirebaseMessagingUtil(
          messaging: FirebaseMessaging.instance,
          localNotification: IosLocalNotificationUtil(
            flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
          ),
        );
      default:
        throw FirebaseMessagingUtilError(
          message: 'Cannot init FbMessaging ',
          code: AppErrorCodes.unknownError,
        );
    }
  } catch (e) {
    throw FirebaseMessagingUtilError(
      message: e.toString(),
      code: AppErrorCodes.unknownError,
    );
  }
}

FirebaseMessagingUtil getFirebaseMessagingUtil({required OsCodes osCode}) {
  switch (osCode) {
    case OsCodes.android:
      return AndroidFirebaseMessagingUtil(
        messaging: FirebaseMessaging.instance,
        localNotification: AndroidLocalNotificationUtil(
          flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
        ),
      );
    case OsCodes.ios:
      return IosFirebaseMessagingUtil(
        messaging: FirebaseMessaging.instance,
        localNotification: IosLocalNotificationUtil(
          flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
        ),
      );
    case OsCodes.web:
      return WebFirebaseMessagingUtil(
        messaging: FirebaseMessaging.instance,
        localNotification: WebLocalNotificationUtil(
          flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
        ),
      );
    default:
      throw FirebaseMessagingUtilError(
        message: 'Firebase messaging incompatibility with current platform',
        code: AppErrorCodes.unknownError,
      );
  }
}

class FirebaseMessagingUtilError implements AppError {
  FirebaseMessagingUtilError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in firebase messaging:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class AndroidFirebaseMessagingUtil implements FirebaseMessagingUtil {
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

class IosFirebaseMessagingUtil implements FirebaseMessagingUtil {
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

class WebFirebaseMessagingUtil implements FirebaseMessagingUtil {
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
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
        code: AppErrorCodes.unknownError,
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
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in local notification:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

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
    _init();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  // see more in https://firebase.flutter.dev/docs/messaging/notifications#notification-channels
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound('sound'),
  );

  void _init() {
    try {
      _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );
    } catch (e) {
      throw LocalNotificationUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }

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
            sound: const RawResourceAndroidNotificationSound('sound'),
            importance: Importance.max,
            priority: Priority.max,
          ),
        ),
      );
    } catch (e) {
      throw LocalNotificationUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

class IosLocalNotificationUtil implements LocalNotificationUtil {
  IosLocalNotificationUtil({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        super() {
    _init();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  void _init() {
    try {
      _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: IOSInitializationSettings(),
        ),
      );
    } catch (e) {
      throw LocalNotificationUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

class WebLocalNotificationUtil implements LocalNotificationUtil {
  WebLocalNotificationUtil({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  })  : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin,
        super() {
    _init();
  }

  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  void _init() {
    try {
      _flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(),
      );
    } catch (e) {
      throw LocalNotificationUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}
