import 'package:flutter_mindmate_project/features/notifications/notifications_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindmate_project/features/notifications/provider/notifications_provider.dart';
import 'package:flutter_mindmate_project/models/notification_model.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';

/// Notifications feature için ViewModel
/// - Provider'ı kullanır, UI'a basit API sağlar
abstract class NotificationsViewModel extends ConsumerState<NotificationsView> {
  NotificationsViewModel();

  /// Mesaj sonrası bildirim planlama (UI tarafından çağrılır)
  Future<void> scheduleAfterMessage({
    required String userMessage,
    Duration delay = const Duration(hours: 2),
  }) async {
    try {
      await ref
          .read(notificationsProvider.notifier)
          .scheduleMotivationAfterMessage(
            userMessage: userMessage,
            delay: delay,
          );
    } catch (e) {
      // no-op
    }
  }

  /// UI'ın listeyi okuması için basit getter
  List<NotificationModel> notificationsRead() {
    return ref.watch(notificationsProvider).notifications;
  }

  /// UI için loading durumu
  bool loadingWatch() {
    return ref.watch(notificationsProvider).isLoading;
  }

  /// Ekran açılışında bildirimleri yükler
  Future<void> loadNotifications() async {
    await ref.read(notificationsProvider.notifier).loadNotifications();
  }

  Future<void> markAsRead(String notificationId) async {
    await ref.read(notificationsProvider.notifier).markAsRead(notificationId);
  }

  /// Tarih etiketini belirler: bugün için "Today", dün için "Yesterday", diğerleri için tarih
  String getDateLabel(String date) {
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(' ')[0]; // YYYY-MM-DD

    if (date == todayDateStr) {
      return StringsEnum.today.value;
    }

    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final String yesterdayDateStr = yesterday.toString().split(' ')[0];
    if (date == yesterdayDateStr) {
      return StringsEnum.yesterday.value;
    }

    return date;
  }

  /// Tarihe göre bildirimleri grupla
  //Tüm bildirimleri tarih (date) alanına göre gruplayarak bir map (sözlük) haline getirmek.
  Map<String, List<NotificationModel>> groupNotificationsByDate(
    List<NotificationModel> notifications,
  ) {
    final Map<String, List<NotificationModel>> grouped = {};
    for (final NotificationModel notification in notifications) {
      final String date = notification.date ?? '';
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(notification);
    }
    return grouped;
  }
}
