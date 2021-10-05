import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Telephony telephony = Telephony.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    checkNotifications();
  }

  checkNotifications() async {
    // var token = await messaging.getToken(
    //   vapidKey: "BGpdLRs......",
    // );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("send sms"),
          onPressed: () {},
        ),
      ),
    );
  }

  _sendSMS() async {
    try {
      var permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
      print("permissionsGranted :$permissionsGranted");
      telephony.sendSms(
          to: "+201028734848", message: "May the force be with you!");
    } catch (e) {
      print("error :$e");
    }
  }
}
