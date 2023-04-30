import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './askDestination.dart';

class NotificationService {
  static Future initialize(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    BuildContext context,
  ) async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
    );
    const initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      // print("details: ${details.toString()}"),
      Navigator.of(context).pushNamed(AskDestination.routeName);
    });
    if (Platform.isAndroid) {
      print("requesting permission");
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    }
  }

  static Future showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String title,
      String body) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
        'default channel', 'Game Notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        actions: [
          AndroidNotificationAction(
            'action one',
            'Ok',
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            'action two',
            'Cancel',
            cancelNotification: true,
          ),
        ]);
    const DarwinNotificationDetails ios = DarwinNotificationDetails();
    const NotificationDetails platform =
        NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform);
  }
}
