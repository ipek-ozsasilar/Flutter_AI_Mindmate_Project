import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:flutter_mindmate_project/models/notification_model.dart';
import 'package:flutter_mindmate_project/products/services/chat_service.dart';
import 'package:flutter_mindmate_project/products/services/firestore_service.dart';
import 'package:flutter_mindmate_project/products/services/notification_service.dart';
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';

/// Notifications feature için Riverpod StateNotifierProvider
/// - Bildirim planlama, listeleme ve okundu işaretleme akışını kontrol eder
final notificationsProvider =
    StateNotifierProvider<NotificationsProvider, NotificationsState>(
      (ref) => NotificationsProvider(),
    );

/// Bildirim ekranı UI durum modeli
class NotificationsState extends Equatable {
  final bool isLoading;
  final List<NotificationModel> notifications;
  final String errorMessage;

  const NotificationsState({
    required this.isLoading,
    required this.notifications,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, notifications, errorMessage];

  NotificationsState copyWith({
    bool? isLoading,
    List<NotificationModel>? notifications,
    String? errorMessage,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Bildirimlerle ilgili iş mantığını içerir
/// - NotificationService ile yerel bildirim planlar
/// - FirestoreService ile bildirim kayıtlarını yönetir
class NotificationsProvider extends StateNotifier<NotificationsState> {
  NotificationsProvider()
    : super(
        const NotificationsState(
          isLoading: false,
          notifications: [],
          errorMessage: '',
        ),
      );

  final Logger _logger = Logger();

  /// Yerel bildirim planlama/izin/kanal işlemleri
  final NotificationService _notificationService = getIt<NotificationService>();
  final FirestoreService _firestoreService = getIt<FirestoreService>();

  /// Mesaj gönderdikten sonra motivasyon bildirimi planlar
  /// - Chat içeriğine göre metin üretir ve belirli bir gecikmeyle zamanlar
  Future<void> scheduleMotivationAfterMessage({
    required String userMessage,
    Duration delay = const Duration(hours: 2),
  }) async {
    try {
      changeIsLoading(true);
      final String motivation = await generateMotivation(userMessage);
      await _notificationService.scheduleMotivation(
        delay: delay,
        body: motivation,
        alsoShowNow: false,
      );
      // Bildirim planlandıktan sonra listeyi yenile
      //Yeni bir bildirim Firestore’a eklendi, o zaman ekranı güncelle ki kullanıcı hemen görebilsin
      await loadNotifications();
    } catch (e) {
      _logger.w('scheduleMotivationAfterMessage failed: $e');
      changeErrorMessage('Bildirim planlanamadı: ${e.toString()}');
    } finally {
      changeIsLoading(false);
    }
  }

  void changeIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void changeErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void changeNotifications(List<NotificationModel> notifications) {
    state = state.copyWith(notifications: notifications.toList());
  }

  /// Firestore'dan tüm bildirimleri çeker ve tarihe göre sıralar
  Future<void> loadNotifications() async {
    try {
      changeIsLoading(true);
      final Map<String, NotificationModel>? notificationsMap =
          await _firestoreService.getNotifications();
      if (notificationsMap != null) {
        // Map'ten List'e çevir ve sırala (yeniden eskiye)
        final List<NotificationModel> notifications =
            notificationsMap.values.toList()..sort((a, b) {
              final int dateCompare = (b.date ?? '').compareTo(a.date ?? '');
              if (dateCompare != 0) return dateCompare;
              return (b.time ?? '').compareTo(a.time ?? '');
            });
        changeNotifications(notifications);
      } else {
        changeErrorMessage('Bildirimler yüklenemedi');
      }
    } catch (e) {
      _logger.e('loadNotifications failed: $e');
      changeErrorMessage('Bildirimler yüklenirken hata oluştu: ${e.toString()}');
    } finally {
      changeIsLoading(false);
    }
  }
   
  //Kullanıcı bildirime baktıysa, Firestore’da ve ekrandaki state’de artık bu bildirimi okundu olarak göster.
  Future<void> markAsRead(String documentId) async {
    try {
      await _firestoreService.markNotificationAsRead(documentId);
      // Listeyi güncelle
      final List<NotificationModel> updatedNotifications = state.notifications
          .map((notification) {
            // Document ID'yi date ve time'dan yeniden oluştur
            final String? userId = FirebaseAuth.instance.currentUser?.uid;
            if (userId != null) {
              final String safeTime = (notification.time ?? '').replaceAll(
                ':',
                '-',
              );
              final String notificationDocId =
                  '${userId}_${notification.date ?? ''}_$safeTime';
              if (notificationDocId == documentId) {
                return notification.copyWith(isRead: true);
              }
            }
            return notification;
          })
          .toList();
      changeNotifications(updatedNotifications);
    } catch (e) {
      _logger.e('markAsRead failed: $e');
      changeErrorMessage('Bildirim okundu olarak işaretlenirken hata oluştu: ${e.toString()}');
    }
  }
}
