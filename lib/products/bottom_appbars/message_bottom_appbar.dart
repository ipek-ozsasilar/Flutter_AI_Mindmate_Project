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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HistoryView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    opaque: true,
                  ),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProgressView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    opaque: true,
                  ),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MessageView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    opaque: true,
                  ),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfileView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    opaque: true,
                  ),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const NotificationsView(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    opaque: true,
                  ),
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
            if (text != null && text!.isNotEmpty)
              Flexible(
                child: Padding(
                  //.w (Width): Genişlik için. Widget genişliklerini ekrana göre ölçekler.
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: GeneralTextWidget(
                      text: text!,
                      //.sp (Screen Pixel): Font size için. Text boyutlarını ekrana göre ölçekler.
                      size: TextSizesEnum.messageBottomAppbarTextSize.value.sp,
                      color: ColorName.loginGreyTextColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
