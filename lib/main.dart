import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalNotifications();
  runApp(MyApp());
}

Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
  await initializeLocalNotifications();
  await showNotification(message);
}

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

bool initializedLocalNotifications = false;

initializeLocalNotifications() async {
  if (initializedLocalNotifications) return;
  initializedLocalNotifications = true;

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        print('onDidReceiveLocalNotification $id $title $payload');
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

showNotification(message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      color: Colors.blue.shade800,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics,
  );
  flutterLocalNotificationsPlugin.show(1, "notification title",
      message['data']['message'], platformChannelSpecifics);

  await flutterLocalNotificationsPlugin.showDailyAtTime(
      hashValues(message['data']['hour'], message['data']['mins']),
      "title",
      "${message['data']['hour']} - ${message['data']['mins']}",
      Time(int.parse(message['data']['hour']),
          int.parse(message['data']['mins']), 0),
      platformChannelSpecifics);

  final pending =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  for (var n in pending) {
    print('PENDING --> ${n.body} || ${n.id}');
  }
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        await showNotification(message);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onBackgroundMessage: onBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      print("Token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Messaging",
      home: Scaffold(
        appBar: AppBar(title: Text("Messaging")),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text("Olá Mundo!"),
          ),
        ),
      ),
    );
  }
}
