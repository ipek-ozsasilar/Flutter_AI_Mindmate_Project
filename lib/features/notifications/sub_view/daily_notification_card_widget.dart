part of '../notifications_view.dart';

class _DailyNotificationCardWidget extends StatefulWidget {
  final String date;
  final List<NotificationModel> notifications;
  final Function(NotificationModel)? onNotificationTap;

  const _DailyNotificationCardWidget({
    required this.date,
    required this.notifications,
    this.onNotificationTap,
  });

  @override
  State<_DailyNotificationCardWidget> createState() =>
      _DailyNotificationCardWidgetState();
}

class _DailyNotificationCardWidgetState
    extends State<_DailyNotificationCardWidget> {
  bool isExpanded = false;
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

  //okunmamıs bıldırım var mı?
  bool get hasUnreadNotifications {
    return widget.notifications.any((notif) => notif.isRead == false);
  }

  //okunmamıs bıldırım sayısı
  int get unreadCount {
    return widget.notifications.where((notif) => notif.isRead == false).length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Paddings.paddingInstance.chatHistoryWidgetMargin,
      decoration: _NotificationsCardDecoration(),
      child: Column(
        children: [
          // Ana Başlık - Tıklanabilir
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
              child: Row(
                children: [
                  // İkon
                  Padding(
                    padding: Paddings.paddingInstance.widgetsBetweenSpace,
                    child: Container(
                      width:
                          WidgetSizesEnum.notificationTimeContainerSize.value,
                      height:
                          WidgetSizesEnum.notificationTimeContainerSize.value,
                      decoration: _NotificationsInsideCardDecoration(),
                      child: GlobalIcon(
                        IconConstants.iconConstants.calendarIcon,
                        iconColor: hasUnreadNotifications
                            ? ColorName.whiteColor
                            : ColorName.loginGreyTextColor,
                        iconSize: IconSizesEnum.iconSize.value,
                      ),
                    ),
                  ),

                  // Tarih ve Bilgi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: crossAxisAlignment,
                      children: [
                        Padding(
                          padding: Paddings
                              .paddingInstance
                              .notificationsItemBottomPadding,
                          child: Row(
                            children: [
                              Padding(
                                padding: Paddings
                                    .paddingInstance
                                    .widgetsBetweenSpace,
                                child: GeneralTextWidget(
                                  text: widget.date,
                                  color: hasUnreadNotifications
                                      ? ColorName.whiteColor
                                      : ColorName.loginGreyTextColor,
                                  size: TextSizesEnum.generalSize.value,
                                ),
                              ),

                              if (hasUnreadNotifications)
                                Container(
                                  padding: Paddings
                                      .paddingInstance
                                      .notificationsItemTimePadding,
                                  decoration: BoxDecoration(
                                    color: ColorName.yellowColor,
                                    borderRadius: BorderRadius.circular(
                                      WidgetSizesEnum.smallBorderRadius.value,
                                    ),
                                  ),
                                  child: GeneralTextWidget(
                                    text:
                                        '$unreadCount ${StringsEnum.newNotifications.value}',
                                    color: ColorName.blackColor,
                                    size: TextSizesEnum.chatTimeSize.value,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        GeneralTextWidget(
                          text:
                              '${widget.notifications.length} ${StringsEnum.notifications.value}',
                          color: ColorName.loginGreyTextColor,
                          size: TextSizesEnum.chatTimeSize.value,
                        ),
                      ],
                    ),
                  ),

                  // Açılır ok
                  GlobalIcon(
                    isExpanded
                        ? IconConstants.iconConstants.arrowUpIcon
                        : IconConstants.iconConstants.arrowDownIcon,
                    iconColor: ColorName.loginGreyTextColor,
                    iconSize: IconSizesEnum.iconSize.value,
                  ),
                ],
              ),
            ),
          ),

          // Genişletilmiş İçerik
          if (isExpanded)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ColorName.loginGreyTextColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: widget.notifications.map((notification) {
                  return GestureDetector(
                    onTap: () {
                      widget.onNotificationTap?.call(notification);
                    },
                    child: NotificationItemWidget(
                      time: notification.time ?? '',
                      title: notification.title ?? '',
                      message: notification.body ?? '',
                      isRead: notification.isRead ?? false,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  BoxDecoration _NotificationsInsideCardDecoration() {
    Color colorGrey = ColorName.loginGreyTextColor.withOpacity(0.2);
    Color colorYellow = ColorName.yellowColor.withOpacity(0.2);
    return BoxDecoration(
      color: hasUnreadNotifications ? colorYellow : colorGrey,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.smallBorderRadius.value,
      ),
    );
  }

  BoxDecoration _NotificationsCardDecoration() {
    Color color = ColorName.loginInputColor.withOpacity(0.6);
    Color colorYellow = ColorName.yellowColor.withOpacity(0.3);
    double borderWidth = 2;
    return BoxDecoration(
      color: hasUnreadNotifications ? ColorName.loginInputColor : color,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      border: Border.all(
        color: hasUnreadNotifications ? colorYellow : Colors.transparent,
        width: borderWidth,
      ),
    );
  }
}
