import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  const CustomTextField({Key? key, this.hint, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint.toString(),
        focusedBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.purple, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
          BorderSide(color: Colors.purple, width: 1),
        ),
      ),
    );
  }
}
