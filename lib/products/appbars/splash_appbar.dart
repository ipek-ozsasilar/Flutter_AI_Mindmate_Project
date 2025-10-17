import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';

class SplashAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int _startIndex = 0;
  final int _endIndex = StringsEnum.mindmate.value.length ~/ 2;
  SplashAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppbarSizesEnum.splashToolbarHeight.value,
      leadingWidth: AppbarSizesEnum.leadingWidth.value,
      leading: Padding(
        padding: Paddings.paddingInstance.splashAppbarLeadingLeftPadding,
        child: Column(
          children: [
            //splash ekranındaki appbar leadingteki logo
            Assets.images.mindmateLogo.image(),
            //splash ekranındaki appbar leadingteki title
            RichtTextWidget(
              //Mindmate yazısı richtext olarak yazıldıgı ve yarısı farklı yarısı farklı renk oldugu ıcın stringi yarıya bölerek aldık
              isItalic: true,
              firstText: StringsEnum.mindmate.value.substring(
                _startIndex,
                _endIndex,
              ),
              secondText: StringsEnum.mindmate.value.substring(_endIndex),
              textSize: TextSizesEnum.appTitleSize.value,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(AppbarSizesEnum.splashToolbarHeight.value);
}
