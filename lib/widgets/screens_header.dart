import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String text;
  const ScreenHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
      child:  Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
