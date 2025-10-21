import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/notifications/sub_view/notifications_item_widget.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/daily_notification_card_widget.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  // Günlere göre gruplandırılmış motivasyon mesajları
  //dummy data
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  final Map<String, List<Map<String, dynamic>>> groupedMotivations = {
    'Bugün': [
      {
        'time': '09:00',
        'title': 'Günaydın! ☀️',
        'message':
            'Yeni bir gün, yeni bir başlangıç! Bugün kendine iyi davran.',
        'isRead': false,
      },
      {
        'time': '12:00',
        'title': 'Öğle Hatırlatması 🌟',
        'message':
            'Hissettiklerini paylaşmak seni daha güçlü yapar. Benimle konuşmak ister misin?',
        'isRead': false,
      },
      {
        'time': '18:00',
        'title': 'Akşam Motivasyonu 🌙',
        'message':
            'Bugün neler hissettin? Duygularını paylaşmak için buradayım.',
        'isRead': true,
      },
    ],
    'Dün': [
      {
        'time': '09:00',
        'title': 'Günaydın! ☀️',
        'message':
            'Her yeni gün bir umut, her sabah yeni bir fırsat. Haydi başlayalım!',
        'isRead': true,
      },
      {
        'time': '12:00',
        'title': 'Günün Ortası 💪',
        'message': 'Sen harikasın! Unutma, sen çok değerlisin.',
        'isRead': true,
      },
      {
        'time': '18:00',
        'title': 'Günün Sonu 🌆',
        'message': 'Bugün nasıl geçti? Benimle paylaşmak ister misin?',
        'isRead': true,
      },
    ],
    '19 Ekim 2025': [
      {
        'time': '09:00',
        'title': 'Sabah Enerjisi ⚡',
        'message': 'Bugün kendine zaman ayır. Sen buna değersin!',
        'isRead': true,
      },
      {
        'time': '12:00',
        'title': 'Öğle Molası ☕',
        'message': 'Derin bir nefes al. Her şey yoluna girecek.',
        'isRead': true,
      },
    ],
    '18 Ekim 2025': [
      {
        'time': '09:00',
        'title': 'Yeni Bir Gün 🌈',
        'message': 'Hatırla: Zorluklarla baş edebilecek güce sahipsin.',
        'isRead': true,
      },
      {
        'time': '18:00',
        'title': 'Akşam Sakinliği 🕊️',
        'message': 'Bugün ne kadar ilerlediğini fark et. Gurur duy!',
        'isRead': true,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final String capitalizedNotifications =
        StringsEnum.notifications.value[0].toUpperCase() +
        StringsEnum.notifications.value.substring(1);
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackgroundColor,
      appBar: MessageAppbar(title: StringsEnum.notifications.value),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Padding(
              padding: Paddings.paddingInstance.notificationsViewTitlePadding,
              child: GeneralTextWidget(
                text: capitalizedNotifications,
                color: ColorName.whiteColor,
                size: TextSizesEnum.todayCardTitleSize.value,
              ),
            ),

            Padding(
              padding: Paddings.paddingInstance.emptyHistoryWidgetPadding,
              child: GeneralTextWidget(
                text: StringsEnum.dailyMotivationMessages.value,
                color: ColorName.loginGreyTextColor,
                size: TextSizesEnum.subtitleSize.value,
              ),
            ),

            Expanded(
              child: groupedMotivations.isEmpty
                  ? _EmptyNotifications()
                  : ListView.builder(
                      itemCount: groupedMotivations.length,
                      itemBuilder: (context, index) {
                        final date = groupedMotivations.keys.elementAt(index);
                        final notifications = groupedMotivations[date]!;
                        return _DailyNotificationCardWidget(
                          date: date,
                          notifications: notifications,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          GlobalIcon(
            IconConstants.iconConstants.notificationsIcon,
            iconColor: ColorName.loginGreyTextColor,
            iconSize: IconSizesEnum.moodIconSize.value * 1.5,
          ),

          Padding(
            padding: Paddings.paddingInstance.notificationsViewTitlePadding,
            child: GeneralTextWidget(
              text: StringsEnum.noNotificationsYet.value,
              color: ColorName.whiteColor,
              size: TextSizesEnum.appTitleSize.value,
            ),
          ),

          Padding(
            padding:
                Paddings.paddingInstance.notificationsViewDescriptionPadding,
            child: GeneralTextWidget(
              text: StringsEnum.noNotificationsYetDescription.value,
              color: ColorName.loginGreyTextColor,
              size: TextSizesEnum.subtitleSize.value,
            ),
          ),
        ],
      ),
    );
  }
}
