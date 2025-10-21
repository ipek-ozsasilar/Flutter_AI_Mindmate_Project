import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/history/history_view.dart';
import 'package:flutter_mindmate_project/features/message/message_view.dart';
import 'package:flutter_mindmate_project/features/notifications/notifications_view.dart';
import 'package:flutter_mindmate_project/features/profile/profile_view.dart';
import 'package:flutter_mindmate_project/features/progress/progress_view.dart';
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryView()),
                );
              },
            ),
          ),
          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.progressIcon,
              text: StringsEnum.progress.value,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressView()),
                );
              },
            ),
          ),

          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.addIcon,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessageView()),
                );
              },
            ),
          ),

          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.personIcon,
              text: StringsEnum.profile.value,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                );
              },
            ),
          ),
          Expanded(
            child: _MessageBottomAppbarTextAndIcon(
              icon: IconConstants.iconConstants.notificationsIcon,
              text: StringsEnum.notifications.value,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsView()),
                );
              },
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
