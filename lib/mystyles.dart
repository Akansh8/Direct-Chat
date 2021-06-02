import 'package:flutter/material.dart';

class myText extends StatelessWidget {
  String text;
  myText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
