import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:flutter_mindmate_project/products/enums/firestore_collection_enum.dart';

/// Kullanıcı profil görseli yükleme ve okuma servisleri
class ImageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  CollectionReference<Map<String, dynamic>> get _imagesCollection =>
      _firestore.collection(FirestoreCollectionsEnum.images.value);

  /// Görseli Firebase Storage'a yükler ve indirilebilir URL'i döner
  Future<String?> uploadImageAndGetUrl({required File imageFile}) async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return null;

      final String fileName =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference ref = _storage.ref().child(fileName);
      await ref.putFile(imageFile);
      final String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      _logger.e('Görsel yüklenirken hata oluştu', error: e);
      return null;
    }
  }

  /// Firestore `Image/{userId}` dokümanına yalnızca imageUrl alanını yazar
  Future<bool> saveUserImageUrl({required String imageUrl}) async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return false;

      await _imagesCollection.doc(userId).set({
        'imageUrl': imageUrl,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      _logger.e('Görsel URL kaydedilirken hata oluştu', error: e);
      return false;
    }
  }

  /// Firestore'dan kullanıcının güncel görsel URL'ini getirir
  Future<String?> getUserImageUrl() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return null;

      final DocumentSnapshot<Map<String, dynamic>> doc = await _imagesCollection
          .doc(userId)
          .get();
      if (!doc.exists) return null;
      return doc.data()?['imageUrl'] as String?;
    } catch (e) {
      _logger.e('Görsel URL getirilirken hata oluştu', error: e);
      return null;
    }
  }
}
