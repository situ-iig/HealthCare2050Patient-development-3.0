import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
  }

  String mToken = "No token found";

  Future<String>getTokenz() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Center(
        child: Text("Notification Not Found!"),
      ),
    );
  }
}
