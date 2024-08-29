
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
    showBadge: true,
    enableVibration: true,
  );

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_notification'
  );
  DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentSound: true,
    defaultPresentBadge: true,
    
    requestSoundPermission: true,
    requestBadgePermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,

    onDidReceiveNotificationResponse: (details) {
      // var payload = jsonDecode(details.payload ?? '');
    },
    
  );
  

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);


  await Permission.notification.request();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings _ = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true,);
  
  isFlutterLocalNotificationsInitialized = true;
}


late AndroidNotificationChannel channel;


void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.max,
    icon: '@drawable/ic_notification',
  );
  
  const DarwinNotificationDetails darwinNotificationDetails =  DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails );

  
  if (notification != null) {
    if(Platform.isAndroid){
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    }
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;