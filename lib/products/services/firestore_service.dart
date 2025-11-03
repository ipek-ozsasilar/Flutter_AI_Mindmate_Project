import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
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
      final String fallbackTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      
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
}
