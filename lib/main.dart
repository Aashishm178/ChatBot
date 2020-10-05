import 'package:chatbot/Screens/SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) {
      print(message.toString());
    },
    onBackgroundMessage: (Map<String, dynamic> message) {
      print(message.toString());
    },
    onLaunch: (Map<String, dynamic> message) {
      print(message.toString());
    },
    onResume: (Map<String, dynamic> message) {
      print(message.toString());
    },
  );
}

FirebaseMessaging firebaseMessaging = FirebaseMessaging();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
