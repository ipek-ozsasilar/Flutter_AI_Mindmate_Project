import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';

class RichtTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final double textSize;
  final bool isItalic;
  final FontWeight fontWeight = FontWeight.w500;
  final FontStyle fontStyle = FontStyle.italic;
  RichtTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.textSize,
    this.isItalic = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: fontWeight,
              color: ColorName.whiteColor,
              fontStyle: isItalic ? fontStyle : null,
            ),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: fontWeight,
              color: ColorName.yellowColor,
              fontStyle: isItalic ? fontStyle : null,
            ),
          ),
        ],
      ),
    );
  }
}
