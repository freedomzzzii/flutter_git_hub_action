import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessage() async {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late AndroidNotificationChannel _channel;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _requestNotificationPermission();

  // collect fcm token to push _notification
  // _messaging.getToken().then((value) {
  //   // print('TOKEN___: $value');
  // });

  if (!kIsWeb) {
    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final RemoteNotification? _notification = message.notification;
    final AndroidNotification? _android = message.notification?.android;

    const AndroidInitializationSettings _initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings _initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings _initializationSettings =
        InitializationSettings(
      android: _initializationSettingsAndroid,
      iOS: _initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(_initializationSettings);

    if (_notification != null && _android != null && !kIsWeb) {
      _flutterLocalNotificationsPlugin.show(
        _notification.hashCode,
        _notification.title,
        _notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  });
}

Future<void> _requestNotificationPermission() async {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationSettings _settings =
      await _messaging.getNotificationSettings();

  switch (_settings.authorizationStatus) {
    case AuthorizationStatus.authorized:
      break;
    default:
      await _messaging.requestPermission();
      break;
  }
}
