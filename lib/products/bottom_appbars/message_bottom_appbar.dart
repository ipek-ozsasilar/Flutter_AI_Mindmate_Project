import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class MessageBottomAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  MessageBottomAppbar({super.key});
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceAround;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorName.bottomAppBarColor,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.historyIcon,
              text: StringsEnum.history.value,
              onPressed: () {},
            ),
          ),
          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.progressIcon,
              text: StringsEnum.progress.value,
              onPressed: () {},
            ),
          ),

          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.addIcon,
              onPressed: () {},
            ),
          ),

          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.personIcon,
              text: StringsEnum.profile.value,
              onPressed: () {},
            ),
          ),
          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.notificationsIcon,
              text: StringsEnum.notifications.value,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MessageBottomAppbarTextAndIcon extends StatelessWidget {
  final IconData icon;
  final String? text;
  final onPressed;
  final MainAxisSize mainAxisSize = MainAxisSize.min;
  const _MessageBottomAppbarTextAndIcon({
    required this.icon,
    this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Column(
          mainAxisSize: mainAxisSize,
          children: [
            GlobalIcon(icon, iconColor: ColorName.loginGreyTextColor),
            GeneralTextWidget(
              text: text ?? '',
              size: TextSizesEnum.messageBottomAppbarTextSize.value,
              color: ColorName.loginGreyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
