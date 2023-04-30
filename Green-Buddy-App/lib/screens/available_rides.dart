// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:chatapp/utils/MStyles.dart';
import 'package:flutter/material.dart';

class AvailableRides extends StatelessWidget {
  const AvailableRides({super.key});

  static const routeName = '/availableRides';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green-Bud'),
      ),
      body: Container(
        height: 400,
        child: Column(
          children: [
            CommonCard(
                'XYZ is availabe on your path for the ride. You can pick them up at location A'),
            CommonCard(
                'ABC is availabe on your path for the ride. You can pick them up at location B'),
            CommonCard(
                'PQR is availabe on your path for the ride. You can pick them up at location C'),
          ],
        ),
      ),
    );
  }
}

class CommonCard extends StatelessWidget {
  final text;
  CommonCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MStyles.pColor,
      elevation: 10,
      child: Container(
        height: 100,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(text, style: TextStyle(fontSize: 20)),
            Text(
              'You will earn 100 green coins for accepting this request',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
