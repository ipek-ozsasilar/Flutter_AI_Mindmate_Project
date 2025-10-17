import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class GlobalElevatedButton extends StatelessWidget {
  final double buttonWidth = double.infinity; 
  final String text;
  final VoidCallback onPressed;
  const GlobalElevatedButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: buttonWidth,
        height: WidgetSizesEnum.elevatedButtonHeight.value,
        child: Center(
          child: GeneralTextWidget(
            text: text,
            color: ColorName.blackColor,
            size: TextSizesEnum.generalSize.value,
          ),
        ),
      ),
    );
  }
}
