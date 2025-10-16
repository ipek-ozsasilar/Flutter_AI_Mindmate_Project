import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final double buttonWidth = double.infinity;
  final FontWeight fontWeight = FontWeight.bold;
  final FontStyle fontStyle = FontStyle.italic;
  final VoidCallback onPressed;
  const ElevatedButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: buttonWidth,
        child: Center(
          child: Text(
            StringsEnum.startText.value,
            style: TextStyle(
              fontSize: TextSizesEnum.generalSize.value,
              fontWeight: fontWeight,
              color: ColorName.blackColor,
              fontStyle: fontStyle,
            ),
          ),
        ),
      ),
    );
  }
}