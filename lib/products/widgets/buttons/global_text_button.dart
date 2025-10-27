import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class GlobalTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function()? onPressed;
  final EdgeInsets padding = EdgeInsets.zero;
  GlobalTextButton({super.key, required this.text, required this.textColor,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: GeneralTextWidget(
        color: textColor,
        size: TextSizesEnum.generalSize.value,
        text: text,
      ),
    );
  }
}
