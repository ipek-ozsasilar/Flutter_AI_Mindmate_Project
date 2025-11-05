import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/models/notification_model.dart';
import 'package:logger/logger.dart';
import 'package:flutter_mindmate_project/products/enums/firestore_collection_enum.dart';

/// Firebase Firestore ile mesaj işlemlerini yöneten service
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  /// Messages koleksiyonuna erişim
  CollectionReference get _messagesCollection {
    return _firestore.collection(FirestoreCollectionsEnum.messages.value);
  }

  /// Notifications koleksiyonuna erişim
  CollectionReference get _notificationsCollection {
    return _firestore.collection(FirestoreCollectionsEnum.notifications.value);
  }

  /// Document ID oluşturur: userId_date_period_time formatında
  /// Her mesaj için unique ID oluşturur
  String _createDocumentId(
    String userId,
    String date,
    String period,
    String time,
  ) {
    // Saat formatındaki ':' karakterini '_' ile değiştir (Firestore ID için güvenli)
    final String safeTime = time.replaceAll(':', '-');
    return '${userId}_${date}_${period}_$safeTime';
  }

  /// Mesajı Firestore'a ekler
  /// Yapı: Messages/{userId_date_period_time}
  /// Her mesaj için unique document oluşturur
  Future<bool> addMessageToFirestore(MessageModel message) async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return false;
      }

      // DateTime'dan doğru formatı al
      final DateTime now = DateTime.now();
      final String fallbackTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      final String docId = _createDocumentId(
        userId,
        message.date ?? now.toString().split(' ')[0],
        message.period ?? 'unknown',
        message.time ?? fallbackTime,
      );

      await _messagesCollection.doc(docId).set(message.toJson());
      _logger.i('Mesaj başarıyla Firestore\'a eklendi: $docId');
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Kullanıcının tüm mesajlarını getirir (client-side filtering)
  /// Index gerektirmez - tüm mesajları çekip client-side filtreler
  Future<List<MessageModel>?> getMessages() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return null;
      }

      // Tüm mesajları getir
      final QuerySnapshot snapshot = await _messagesCollection.get();

      // Client-side: Sadece bu kullanıcının mesajlarını filtrele
      final List<MessageModel> userMessages = snapshot.docs
          .where((doc) => doc.id.startsWith(userId))
          .map(
            (doc) => MessageModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      // Tarihe göre sırala (yeniden eskiye)
      userMessages.sort((a, b) => (b.date ?? '').compareTo(a.date ?? ''));

      return userMessages;
    } catch (e) {
      _logger.e('Mesajlar getirilirken hata oluştu', error: e);
      return null;
    }
  }

  /// Kullanıcının tüm mesajlarını siler
  Future<bool> deleteAllMessages() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return false;
      }

      final QuerySnapshot snapshot = await _messagesCollection.get();
      final userDocs = snapshot.docs.where((doc) => doc.id.startsWith(userId));

      for (final doc in userDocs) {
        await doc.reference.delete();
      }
      _logger.i('Tüm mesajlar başarıyla silindi');
      return true;
    } catch (e) {
      _logger.e('Tüm mesajlar silinirken hata oluştu', error: e);
      return false;
    }
  }

  /// Bildirim için Document ID oluşturur: userId_date_bildirimsaati formatında
  /// Örnek: userId123_2025-11-04_19-52
  String _createNotificationDocumentId(
    String userId,
    String date,
    String time,
  ) {
    final String safeTime = time.replaceAll(':', '-');
    return '${userId}_${date}_$safeTime';
  }

  /// Bildirimi Firestore'a ekler
  /// Yapı: Notification/{userId_date_bildirimsaati}
  /// Örnek: Notification/userId123_2025-11-04_19-52
  Future<bool> addNotificationToFirestore(
    NotificationModel notification,
  ) async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return false;
      }

      final DateTime now = DateTime.now();
      final String fallbackDate = now.toString().split(' ')[0];
      final String fallbackTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

      final String docId = _createNotificationDocumentId(
        userId,
        notification.date ?? fallbackDate,
        notification.time ?? fallbackTime,
      );

      await _notificationsCollection.doc(docId).set(notification.toJson());
      _logger.i('Bildirim başarıyla Firestore\'a eklendi: $docId');
      return true;
    } catch (e) {
      _logger.e('Bildirim eklenirken hata oluştu', error: e);
      return false;
    }
  }

  /// Kullanıcının tüm bildirimlerini getirir
  /// Document ID'leri Map olarak döndürür: {documentId: NotificationModel}
  Future<Map<String, NotificationModel>?> getNotifications() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        return null;
      }

      final QuerySnapshot snapshot = await _notificationsCollection.get();

      final Map<String, NotificationModel> notificationsMap = {};

      for (final doc in snapshot.docs) {
        if (doc.id.startsWith(userId)) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          notificationsMap[doc.id] = NotificationModel.fromJson(data);
        }
      }

      // Tarih ve saate göre sıralanmış listeyi döndürmek için Map'i sıralayabiliriz
      // Ama Map zaten sırasız olduğu için, sıralama işlemini provider'da yapabiliriz
      return notificationsMap;
    } catch (e) {
      _logger.e('Bildirimler getirilirken hata oluştu', error: e);
      return null;
    }
  }

  //Bildirimi okundu olarak işaretle. Eğer bildirim dokümanında isRead alanı yoksa,
  //bu kod onu oluşturur ve true yapar.Eğer zaten varsa, değerini true olarak günceller.
  Future<bool> markNotificationAsRead(String notificationId) async {
    try {
      await _notificationsCollection.doc(notificationId).update({
        'isRead': true,
      });
      _logger.i('Bildirim okundu olarak işaretlendi: $notificationId');
      return true;
    } catch (e) {
      _logger.e('Bildirim güncellenirken hata oluştu', error: e);
      return false;
    }
  }
}
