import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() => runApp(MyApp());

Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
  final res = await http.get("https://www.reddit.com/r/aww.json");
  print("Response: ${res.body}");
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
