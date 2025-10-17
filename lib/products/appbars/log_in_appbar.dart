import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';

class LogInAppbar extends StatelessWidget implements PreferredSizeWidget {
  LogInAppbar({super.key});
  final int _startIndex = 0;
  final bool centerTitle = true;
  final int _endIndex = StringsEnum.mindmate.value.length ~/ 2;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppbarSizesEnum.logInToolbarHeight.value,
      centerTitle: centerTitle,
      title: Column(
        children: [
          //login ekranındaki appbar leadingteki logo
          Assets.images.mindmateLogo.image(),
          //login ekranındaki appbar leadingteki title
          RichtTextWidget(
            isItalic: true,
            firstText: StringsEnum.mindmate.value.substring(
              _startIndex,
              _endIndex,
            ),
            secondText: StringsEnum.mindmate.value.substring(_endIndex),
            textSize: TextSizesEnum.googleSize.value,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppbarSizesEnum.logInToolbarHeight.value);
}
