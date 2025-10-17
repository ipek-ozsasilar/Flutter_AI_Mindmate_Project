import 'package:flutter/material.dart';

class GeneralTextWidget extends StatelessWidget {
  GeneralTextWidget({
    super.key,
    required this.color,
    required this.size,
    required this.text,
  });

  final FontWeight fontWeight = FontWeight.bold;
  final Color color;
  final double size;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
