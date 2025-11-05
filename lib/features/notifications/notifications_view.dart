import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/notifications/sub_view/notifications_item_widget.dart';
import 'package:flutter_mindmate_project/features/notifications/view_model/notifications_view_model.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/models/notification_model.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'sub_view/daily_notification_card_widget.dart';

// Yerel bildirimlerin UI katmanı
// - Liste, okundu işaretleme
// - Çalışma mantığı: Bildirimler cihaz tarafında planlanır ve OS tetikler; internet gerekmez
// - Android AlarmManager / iOS UNNotificationRequest üzerinden çalışır
class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends NotificationsViewModel {
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Ekran açılışında bildirimleri yükle
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    await loadNotifications();
    //Bu widget hâlâ ekranda mı, yoksa kaldırıldı mı ekrandaysa _isInitialLoading = false; yap
    if (mounted) {
      setState(() {
        _isInitialLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Başlığı büyük harfe çevir
    final String capitalizedNotifications =
        StringsEnum.notifications.value[0].toUpperCase() +
        StringsEnum.notifications.value.substring(1);

    final List<NotificationModel> notifications = notificationsRead();
    final bool isLoading = loadingWatch();
    final Map<String, List<NotificationModel>> groupedNotifications =
        groupNotificationsByDate(notifications);
    final List<String> sortedDates = groupedNotifications.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Yeniden eskiye

    //Ekran açılışında veya bildirimler yüklenirken loading göster
    if (_isInitialLoading || isLoading) {
      return Scaffold(
        backgroundColor: ColorName.scaffoldBackgroundColor,
        appBar: MessageAppbar(title: StringsEnum.notifications.value),
        body: const Center(
          child: CircularProgressIndicator(color: ColorName.yellowColor),
        ),
      );
    }
    //Bildirimler yüklendiysa, ekranı güncelle
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
              child: groupedNotifications.isEmpty
                  ? _EmptyNotifications()
                  : ListView.builder(
                      itemCount: sortedDates.length,
                      itemBuilder: (context, index) {
                        final String date = sortedDates[index];
                        final String dateLabel = getDateLabel(date);
                        final List<NotificationModel> dayNotifications =
                            groupedNotifications[date]!;
                        return _DailyNotificationCardWidget(
                          date: dateLabel,
                          notifications: dayNotifications,
                          onNotificationTap: (NotificationModel notification) {
                            if (notification.isRead == false) {
                              // Document ID'yi date ve time'dan oluştur
                              final String? userId =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (userId != null) {
                                final String safeTime =
                                    (notification.time ?? '').replaceAll(
                                      ':',
                                      '-',
                                    );
                                final String documentId =
                                    '${userId}_${notification.date ?? ''}_$safeTime';
                                markAsRead(documentId);
                              }
                            }
                          },
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

//Bildirimler yoksa, boş ekran göster
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
