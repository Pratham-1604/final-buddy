import 'package:chatapp/pages/RewardsScreen.dart';
import 'package:chatapp/screens/activity.dart';
import 'package:chatapp/screens/askDestination.dart';
import 'package:chatapp/screens/available_rides.dart';
import 'package:chatapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './screens/chat_screen.dart';
import './screens/error.dart';
import './screens/loading_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  // return ScreenUtilInit(
  //     designSize: const Size(360, 690),
  //     minTextAdapt: true,
  //     splitScreenMode: true,
  //     builder: (context, child) {
  //       return GetMaterialApp(
  //         title: 'Flutter Demo',
  //         theme: ThemeData(
  //           primarySwatch: Colors.blue,
  //         ),
  //         home: ExampleApp(),
  //           routes: {
  //             AskDestination.routeName: (context) => AskDestination(),
  //             MapScreen.routeName: (context) => MapScreen(),
  //           }
  //       );
  //     });

  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const ErrorScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                  title: 'Green-Buddy',
                  theme: ThemeData(
                    primarySwatch: Colors.teal,
                    backgroundColor: Colors.purple[800],
                    accentColor: Colors.deepPurple,
                    accentColorBrightness: Brightness.dark,
                    buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.teal,
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.hasData) {
                        // return AskDestination();
                        return HomePage();
                      }
                      return AuthScreen();
                    },
                  ),
                  routes: {
                    AskDestination.routeName: (context) => AskDestination(),
                    ChatScreen.routeName: (context) => ChatScreen(),
                    ExampleApp.routeName: (context) => ExampleApp(),
                    RewardsScreen.routeName: (context) => RewardsScreen(),
                    AvailableRides.routeName: (context) => AvailableRides(),
                  },
                );
              });
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const LoadingScreen();
      },
    );
  }
}
