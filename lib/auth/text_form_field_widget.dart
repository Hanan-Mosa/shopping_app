import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  String labelText;
  TextInputType type;
  Function validate;

  TextEditingController controller;

  bool hidden;

  TextFormFieldWidget(
      {super.key,
      required this.type,
      required this.labelText,
      required this.controller,
      required this.validate,
      required this.hidden});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidden,
      controller: controller,
      validator: (value) => validate(value),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 2)),
      ),
    );
  }
}
