import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';

class OrContinueWithRow extends StatelessWidget {
  const OrContinueWithRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: DividerMethod()),
        Padding(
          padding: Paddings.paddingInstance.orContinueWithHorizontalPadding,
          child: GeneralTextWidget(
            color: ColorName.loginGreyTextColor,
            size: TextSizesEnum.generalSize.value,
            text: StringsEnum.orContinueWith.value,
          ),
        ),
        Expanded(child: DividerMethod()),
      ],
    );
  }

  Divider DividerMethod() => Divider(color: ColorName.loginGreyTextColor);
}
