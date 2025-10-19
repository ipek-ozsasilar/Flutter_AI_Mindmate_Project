import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class MessageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  const MessageAppbar({this.centerTitle = true, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      leadingWidth: AppbarSizesEnum.messageToolbarHeight.value,
      leading: Padding(
        padding: Paddings.paddingInstance.splashAppbarLeadingLeftPadding,
        child: GlobalIconButton(
          icon: IconConstants.iconConstants.arrowBackIcon,
        ),
      ),
      title: GeneralTextWidget(
        color: ColorName.whiteColor,
        size: TextSizesEnum.appTitleSize.value,
        text: StringsEnum.messages.value,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppbarSizesEnum.messageToolbarHeight.value);
}
