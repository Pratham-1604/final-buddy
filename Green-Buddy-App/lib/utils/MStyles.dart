import 'package:flutter/material.dart';

class MStyles {
  static final pColor = Color(0xFF038373);
  static final sColor = Color(0xFF00CC8E);
  static final bgColor = Color(0xFFE1C6A8);
}

class MPrimaryButton extends StatelessWidget {
  final onPressed;

  final child;

  const MPrimaryButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class MPrimaryText extends StatelessWidget {
  final String text;

  const MPrimaryText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

// Leave design aside for now, just focus on the functionality