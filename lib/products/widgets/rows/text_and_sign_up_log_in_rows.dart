import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_text_button.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';

class TextAndSignUpLogInRowWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String space = " ";
  final WrapAlignment wrapAlignment;
  final Function()? onPressed;
  TextAndSignUpLogInRowWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    this.wrapAlignment = WrapAlignment.center,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: wrapAlignment,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GeneralTextWidget(
          color: ColorName.loginGreyTextColor,
          size: TextSizesEnum.generalSize.value,
          text: firstText + space,
        ),
        GlobalTextButton(text: secondText, textColor: ColorName.yellowColor, onPressed: onPressed),
      ],
    );
  }
}
