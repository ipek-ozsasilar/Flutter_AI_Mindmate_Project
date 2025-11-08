import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class MessageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool centerTitle;
  final String title;
  const MessageAppbar({
    this.centerTitle = true,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leading: GlobalIconButton(
        icon: IconConstants.iconConstants.arrowBackIcon,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: GeneralTextWidget(
        color: ColorName.whiteColor,
        size: TextSizesEnum.appTitleSize.value,
        text: title,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
