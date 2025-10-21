import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class GlobalElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const GlobalElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: WidgetSizesEnum.elevatedButtonHeight.value,
      child: ElevatedButton(
        onPressed: onPressed,
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: Paddings.paddingInstance.widgetsBetweenSpace,
                    child: Icon(icon, color: ColorName.blackColor),
                  ),
                  GeneralTextWidget(
                    text: text,
                    color: ColorName.blackColor,
                    size: TextSizesEnum.generalSize.value,
                  ),
                ],
              )
            : GeneralTextWidget(
                text: text,
                color: ColorName.blackColor,
                size: TextSizesEnum.generalSize.value,
              ),
      ),
    );
  }
}
