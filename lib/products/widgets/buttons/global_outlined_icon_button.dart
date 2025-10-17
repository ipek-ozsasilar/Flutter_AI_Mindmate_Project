import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';

class GlobalOutlinedIconButton extends StatelessWidget {
  const GlobalOutlinedIconButton({super.key});
  final double borderSideWidth = 2;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      label: GeneralTextWidget(
        color: ColorName.whiteColor,
        size: TextSizesEnum.generalSize.value,
        text: StringsEnum.google.value,
      ),
      icon: GlobalIcon(
        IconConstants.iconConstants.googleIcon,
        ColorName.whiteColor,
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorName.whiteColor,
        minimumSize: Size(
          double.infinity,
          WidgetSizesEnum.elevatedButtonHeight.value,
        ),
        side: BorderSide(color: ColorName.whiteColor, width: borderSideWidth),
        shape: RoundedRectangleBorder(),
      ),
    );
  }
}
