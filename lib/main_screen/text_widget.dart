import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String text;

  TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
