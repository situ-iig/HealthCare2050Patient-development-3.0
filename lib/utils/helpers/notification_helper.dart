import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';

import '../../firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel(
        notificationId, // id
        notificationName, // title
        description: notificationDescription, // description
        importance: Importance.high,
        enableVibration: true,
        playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> handleFirebaseBackGroundNotification(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   // showFirebaseNotification(message);
    print('A bg message just showed up :  ${message.messageId}');
}

createNotificationChannel()async{
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
}

Future<void> handleForegroundNotification()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
    );
}

onMessageNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showFirebaseNotification(message);
    });
}

showFirebaseNotification(RemoteMessage message){
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannel.id,
              notificationChannel.name,
              channelDescription: notificationChannel.description,
              color: iconColor,
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: DarwinNotificationDetails(presentAlert: true,presentSound: true,)
        ));
  }
}

onOpenAppNotification(BuildContext context){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null) {
          Fluttertoast.showToast(msg: "${message.notification?.body}");
            showDialog(
                context: context,
                builder: (_) {
                    return AlertDialog(
                        title: Text(notification.title!),
                        content: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(notification.body!)],
                            ),
                        ),
                    );
                });
        }
    });
}
