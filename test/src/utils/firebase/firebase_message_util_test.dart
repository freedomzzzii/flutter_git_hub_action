import 'package:firebase_core/firebase_core.dart';
// Note. ignore this because mock firebase init need class MethodChannelFirebase
// ignore: depend_on_referenced_packages
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_starter_kit/src/utils/firebase/firebase_message_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_message_util_test.mocks.dart';

// create Callback for mock initial firebase
typedef Callback = void Function(MethodCall call);
// create setupFirebaseAuthMocks function for mock initial firebase
void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel
      .setMockMethodCallHandler((MethodCall call) async {
    if (call.method == 'Firebase#initializeCore') {
      return <Object>[
        <String, dynamic>{
          'name': defaultFirebaseAppName,
          'options': <String, String>{
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': <String, dynamic>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return <String, dynamic>{
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': <String, dynamic>{},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

@GenerateMocks(<Type>[
  FirebaseMessaging,
  FlutterLocalNotificationsPlugin,
  AndroidLocalNotificationUtil,
  IosLocalNotificationUtil,
  WebLocalNotificationUtil,
])
void main() {
  final MockFirebaseMessaging mockFirebaseMessaging = MockFirebaseMessaging();
  final MockFlutterLocalNotificationsPlugin
      mockFlutterLocalNotificationsPlugin =
      MockFlutterLocalNotificationsPlugin();
  const NotificationSettings expectNotificationSettings = NotificationSettings(
    showPreviews: AppleShowPreviewSetting.always,
    carPlay: AppleNotificationSetting.disabled,
    lockScreen: AppleNotificationSetting.enabled,
    notificationCenter: AppleNotificationSetting.enabled,
    badge: AppleNotificationSetting.enabled,
    sound: AppleNotificationSetting.enabled,
    authorizationStatus: AuthorizationStatus.authorized,
    announcement: AppleNotificationSetting.enabled,
    alert: AppleNotificationSetting.enabled,
    timeSensitive: AppleNotificationSetting.enabled,
  );

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  });

  group('initFbMessaging Function', () {
    test('Should have initFbMessaging Function', () {
      expect(initFbMessaging, initFbMessaging);
    });
  });

  group('FirebaseMessagingUtilError Class', () {
    test('Should have FirebaseMessagingUtilError Class', () {
      expect(FirebaseMessagingUtilError, FirebaseMessagingUtilError);
    });

    test('Should have mandatory properties', () {
      expect(expectFirebaseMessagingUtilError.code, expectDataSourceError.code);
      expect(
        expectFirebaseMessagingUtilError.message,
        expectDataSourceError.message,
      );
    });
  });

  group('LocalNotificationUtilError Class', () {
    test('Should have LocalNotificationUtilError Class', () {
      expect(LocalNotificationUtilError, LocalNotificationUtilError);
    });

    test('Should have mandatory properties', () {
      expect(expectLocalNotificationUtilError.code, expectDataSourceError.code);
      expect(
        expectLocalNotificationUtilError.message,
        expectDataSourceError.message,
      );
    });
  });

  group('AndroidFirebaseMessagingUtil Class', () {
    final MockAndroidLocalNotificationUtil mockAndroidLocalNotificationUtil =
        MockAndroidLocalNotificationUtil();
    final AndroidFirebaseMessagingUtil expectAndroidFirebaseMessagingUtil =
        AndroidFirebaseMessagingUtil(
      messaging: mockFirebaseMessaging,
      localNotification: mockAndroidLocalNotificationUtil,
    );

    test('Should have AndroidFirebaseMessagingUtil Class', () {
      expect(AndroidFirebaseMessagingUtil, AndroidFirebaseMessagingUtil);
    });

    test('Should have mandatory properties', () {
      expect(
        expectAndroidFirebaseMessagingUtil.messaging,
        mockFirebaseMessaging,
      );
      expect(
        expectAndroidFirebaseMessagingUtil.localNotification,
        mockAndroidLocalNotificationUtil,
      );
    });

    test('Should have getToken method - Success case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenAnswer(
        (_) => Future<String>.value(
          expectTaskCreateResponseEntity.title,
        ),
      );

      final String? expectToken =
          await expectAndroidFirebaseMessagingUtil.getToken();

      expect(expectToken, expectTaskCreateResponseEntity.title);
    });

    test('Should have getToken method - Failure case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async => expectAndroidFirebaseMessagingUtil.getToken(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async => expectAndroidFirebaseMessagingUtil.getToken(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have requestNotificationPermission method - Success case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenAnswer(
        (_) => Future<NotificationSettings>.value(expectNotificationSettings),
      );
      when(
        mockFirebaseMessaging.requestPermission(),
      ).thenAnswer(
        (_) => Future<NotificationSettings>.value(expectNotificationSettings),
      );

      expect(
        () async =>
            expectAndroidFirebaseMessagingUtil.requestNotificationPermission(),
        isA<void>(),
      );
    });

    test('Should have requestNotificationPermission method - Failure case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async =>
            expectAndroidFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async =>
            expectAndroidFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have onMessage method - Success case', () async {
      expect(
        () async => expectAndroidFirebaseMessagingUtil.onMessage(),
        isA<void>(),
      );
    });
  });

  group('IosFirebaseMessagingUtil Class', () {
    final MockIosLocalNotificationUtil mockIosLocalNotificationUtil =
        MockIosLocalNotificationUtil();
    final IosFirebaseMessagingUtil expectIosFirebaseMessagingUtil =
        IosFirebaseMessagingUtil(
      messaging: mockFirebaseMessaging,
      localNotification: mockIosLocalNotificationUtil,
    );

    test('Should have IosFirebaseMessagingUtil Class', () {
      expect(IosFirebaseMessagingUtil, IosFirebaseMessagingUtil);
    });

    test('Should have mandatory properties', () {
      expect(expectIosFirebaseMessagingUtil.messaging, mockFirebaseMessaging);
      expect(
        expectIosFirebaseMessagingUtil.localNotification,
        mockIosLocalNotificationUtil,
      );
    });

    test('Should have getToken method - Success case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenAnswer(
        (_) => Future<String>.value(
          expectTaskCreateResponseEntity.title,
        ),
      );

      final String? expectToken =
          await expectIosFirebaseMessagingUtil.getToken();

      expect(expectToken, expectTaskCreateResponseEntity.title);
    });

    test('Should have getToken method - Failure case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async => expectIosFirebaseMessagingUtil.getToken(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async => expectIosFirebaseMessagingUtil.getToken(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have requestNotificationPermission method - Success case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenAnswer(
        (_) => Future<NotificationSettings>.value(
          expectNotificationSettings,
        ),
      );

      expect(
        () async =>
            expectIosFirebaseMessagingUtil.requestNotificationPermission(),
        isA<void>(),
      );
    });

    test('Should have requestNotificationPermission method - Failure case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async =>
            expectIosFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async =>
            expectIosFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have onMessage method - Success case', () async {
      when(
        mockFirebaseMessaging.setForegroundNotificationPresentationOptions(),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      expect(
        () async => expectIosFirebaseMessagingUtil.onMessage(),
        isA<void>(),
      );
    });
  });

  group('WebFirebaseMessagingUtil Class', () {
    final MockWebLocalNotificationUtil mockWebLocalNotificationUtil =
        MockWebLocalNotificationUtil();
    final WebFirebaseMessagingUtil expectWebFirebaseMessagingUtil =
        WebFirebaseMessagingUtil(
      messaging: mockFirebaseMessaging,
      localNotification: mockWebLocalNotificationUtil,
    );

    test('Should have WebFirebaseMessagingUtil Class', () {
      expect(WebFirebaseMessagingUtil, WebFirebaseMessagingUtil);
    });

    test('Should have mandatory properties', () {
      expect(expectWebFirebaseMessagingUtil.messaging, mockFirebaseMessaging);
      expect(
        expectWebFirebaseMessagingUtil.localNotification,
        mockWebLocalNotificationUtil,
      );
    });

    test('Should have getToken method - Success case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenAnswer(
        (_) => Future<String>.value(
          expectTaskCreateResponseEntity.title,
        ),
      );

      final String? expectToken =
          await expectWebFirebaseMessagingUtil.getToken();

      expect(expectToken, expectTaskCreateResponseEntity.title);
    });

    test('Should have getToken method - Failure case', () async {
      when(
        mockFirebaseMessaging.getToken(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async => expectWebFirebaseMessagingUtil.getToken(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async => expectWebFirebaseMessagingUtil.getToken(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have requestNotificationPermission method - Success case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenAnswer(
        (_) => Future<NotificationSettings>.value(expectNotificationSettings),
      );

      expect(
        () async =>
            expectWebFirebaseMessagingUtil.requestNotificationPermission(),
        isA<void>(),
      );
    });

    test('Should have requestNotificationPermission method - Failure case', () {
      when(
        mockFirebaseMessaging.getNotificationSettings(),
      ).thenThrow(expectFirebaseMessagingUtilError);

      expect(
        () async =>
            expectWebFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(isA<FirebaseMessagingUtilError>()),
      );

      expect(
        () async =>
            expectWebFirebaseMessagingUtil.requestNotificationPermission(),
        throwsA(
          predicate(
            (Error e) =>
                e is FirebaseMessagingUtilError &&
                e
                    .toString()
                    .contains(expectFirebaseMessagingUtilError.toString()),
          ),
        ),
      );
    });

    test('Should have onMessage method - Success case', () async {
      when(
        mockFirebaseMessaging.setForegroundNotificationPresentationOptions(),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      expect(
        () async => expectWebFirebaseMessagingUtil.onMessage(),
        isA<void>(),
      );
    });
  });

  group('AndroidLocalNotificationUtil Class', () {
    when(
      mockFlutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      ),
    ).thenAnswer(
      (_) => Future<bool?>.value(),
    );

    final AndroidLocalNotificationUtil expectAndroidLocalNotificationUtil =
        AndroidLocalNotificationUtil(
      flutterLocalNotificationsPlugin: mockFlutterLocalNotificationsPlugin,
    );
    const AndroidNotificationChannel expectChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );
    const RemoteMessage expectMessage = RemoteMessage(
      notification: RemoteNotification(),
    );

    test('Should have AndroidLocalNotificationUtil Class', () {
      expect(AndroidLocalNotificationUtil, AndroidLocalNotificationUtil);
    });

    test('Should have mandatory properties', () {
      expect(
        expectAndroidLocalNotificationUtil.flutterLocalNotificationsPlugin,
        mockFlutterLocalNotificationsPlugin,
      );
    });

    test('Should have show method - Success case', () {
      when(
        mockFlutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(expectChannel),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );
      when(
        mockFlutterLocalNotificationsPlugin.show(
          expectMessage.notification?.hashCode,
          expectMessage.notification?.title,
          expectMessage.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              expectChannel.id,
              expectChannel.name,
              channelDescription: expectChannel.description,
              icon: 'launch_background',
            ),
          ),
        ),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      expect(
        () async =>
            expectAndroidLocalNotificationUtil.show(message: expectMessage),
        isA<void>(),
      );
    });

    test('Should have show method - Failure case', () {
      when(
        mockFlutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(expectChannel),
      ).thenThrow(expectLocalNotificationUtilError);

      expect(
        () async =>
            expectAndroidLocalNotificationUtil.show(message: expectMessage),
        isA<void>(),
      );
    });
  });

  group('IosLocalNotificationUtil Class', () {
    when(
      mockFlutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: IOSInitializationSettings(),
        ),
      ),
    ).thenAnswer(
      (_) => Future<bool?>.value(),
    );

    final IosLocalNotificationUtil expectIosLocalNotificationUtil =
        IosLocalNotificationUtil(
      flutterLocalNotificationsPlugin: mockFlutterLocalNotificationsPlugin,
    );

    test('Should have IosLocalNotificationUtil Class', () {
      expect(IosLocalNotificationUtil, IosLocalNotificationUtil);
    });

    test('Should have mandatory properties', () {
      expect(
        expectIosLocalNotificationUtil.flutterLocalNotificationsPlugin,
        mockFlutterLocalNotificationsPlugin,
      );
    });
  });

  group('WebLocalNotificationUtil Class', () {
    when(
      mockFlutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(),
      ),
    ).thenAnswer(
      (_) => Future<bool?>.value(),
    );

    final WebLocalNotificationUtil expectWebLocalNotificationUtil =
        WebLocalNotificationUtil(
      flutterLocalNotificationsPlugin: mockFlutterLocalNotificationsPlugin,
    );
    test('Should have WebLocalNotificationUtil Class', () {
      expect(WebLocalNotificationUtil, WebLocalNotificationUtil);
    });

    test('Should have mandatory properties', () {
      expect(
        expectWebLocalNotificationUtil.flutterLocalNotificationsPlugin,
        mockFlutterLocalNotificationsPlugin,
      );
    });
  });
}
