import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:chatapp/components/notification.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final _activityStreamController = StreamController<Activity>();
  StreamSubscription<Activity>? _activityStreamSubscription;

  void _onActivityReceive(Activity activity) {
    _activityStreamController.sink.add(activity);
  }

  void _handleError(dynamic error) {
    print('Catch Error >> $error');
  }

  FlutterLocalNotificationsPlugin globalNotification =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final activityRecognition = FlutterActivityRecognition.instance;

      // Check if the user has granted permission. If not, request permission.
      PermissionRequestResult reqResult;
      reqResult = await activityRecognition.checkPermission();
      if (reqResult == PermissionRequestResult.PERMANENTLY_DENIED) {
        print('Permission is permanently denied.');
        return;
      } else if (reqResult == PermissionRequestResult.DENIED) {
        reqResult = await activityRecognition.requestPermission();
        if (reqResult != PermissionRequestResult.GRANTED) {
          print('Permission is denied.');
          return;
        }
      }

      // Subscribe to the activity stream.
      _activityStreamSubscription = activityRecognition.activityStream
          .handleError(_handleError)
          .listen(_onActivityReceive);
    });
    callNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text('Share Ride, Save World'),
              centerTitle: true),
          body: _buildContentView()),
    );
  }

  @override
  void dispose() {
    _activityStreamController.close();
    _activityStreamSubscription?.cancel();
    super.dispose();
  }

  void callNotification() async {
    await NotificationService.initialize(globalNotification, context);
    NotificationService.showNotification(
        globalNotification, 'Do want to car pool', 'Yes');
  }

  Widget _buildContentView() {
    return StreamBuilder<Activity>(
      stream: _activityStreamController.stream,
      builder: (context, snapshot) {
        String? activityName;
        if (snapshot.hasData) {
          activityName = snapshot.data!.type.toString();
          if (activityName.contains("STILL") ||
              activityName.contains("WALKING") ||
              activityName.contains("UNKNOWN")) {
            callNotification();
          }
        } else if (snapshot.hasError) {
          activityName = snapshot.error.toString();
        }

        return Center(
          child: Text(
            // activityName ?? 'Detecting activity...',
            activityName ?? 'Seems Like You Are In A Vehicle\n($activityName)',
            style: TextStyle(fontSize: 24),
          ),
        );
      },
    );
  }
}

//auto matic start timing functions // update points earned in real time

