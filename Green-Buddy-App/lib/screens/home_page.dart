// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:chatapp/pages/RewardsScreen.dart';
import 'package:chatapp/screens/activity.dart';
import 'package:chatapp/screens/askDestination.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green-Buddy'),
        centerTitle: true,
      ),
      body: Container(
        height: 700,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 10,
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Your current activity'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ExampleApp.routeName);
                    },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Available for car pool'),
                    onPressed: () {
                      // add person in database for looking for a ride or looking for people from rides
                      Navigator.of(context).pushNamed(AskDestination.routeName);
                    },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Go to community'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Green Coins and Rewards'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RewardsScreen.routeName);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
