import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/services/image_service.dart';
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_notifier/state_notifier.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(),
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
    : super(
        const ProfileState(
          imageUrl: null,
          isLoading: false,
          errorMessage: null,
        ),
      );

  final ImageService _imageService = getIt<ImageService>();

  /// Kullanıcının profil görselini yükler
  Future<bool> loadProfileImage() async {
    changeStateIsLoading(true);
    try {
      final String? url = await _imageService.getUserImageUrl();
      changeStateImageUrl(url);
      return true;
    } catch (e) {
      changeStateErrorMessage(e.toString());
      return false;
    } finally {
      changeStateIsLoading(false);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> updateEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    changeStateIsLoading(true);
    // Eski hata mesajını temizle
    changeStateErrorMessage('');
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      // Google ile giriş yapılmış mı kontrol et
      final bool isGoogleUser = user.providerData.any(
        (info) => info.providerId == 'google.com',
      );

      if (isGoogleUser) {
        changeStateErrorMessage(ErrorStringsEnum.cannotUpdateGoogleEmail.value);
        return false;
      }

      // Re-authentication
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword.trim(),
      );
      final UserCredential reauthResult = await user
          .reauthenticateWithCredential(credential);
      if (reauthResult.user == null || reauthResult.user!.uid != user.uid) {
        changeStateErrorMessage(ErrorStringsEnum.invalidCredentialError.value);
        return false;
      }

      // Email'i güncelle
      await user.updateEmail(newEmail.trim());
      // Başarılı işlemde hata mesajını temiz tut
      changeStateErrorMessage('');
      return true;
    } catch (e) {
      changeStateErrorMessage(e.toString());
      return false;
    } finally {
      changeStateIsLoading(false);
    }
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    changeStateIsLoading(true);
    // Eski hata mesajını temizle
    changeStateErrorMessage('');
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      // Google ile giriş yapılmış mı kontrol et
      final bool isGoogleUser = user.providerData.any(
        (info) => info.providerId == 'google.com',
      );

      if (isGoogleUser) {
        changeStateErrorMessage(
          ErrorStringsEnum.cannotUpdateGooglePassword.value,
        );
        return false;
      }

      //Re‑authentication: Kullanıcının “yakın zamanda” kimliğini yeniden doğrulaması.
      //Firebase, kritik işlemler (şifre/e‑posta değiştirme, hesap silme vb.) için ek güvenlik ister.
      //Re-authentication
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword.trim(),
      );
      final UserCredential reauthResult = await user
          .reauthenticateWithCredential(credential);
      if (reauthResult.user == null || reauthResult.user!.uid != user.uid) {
        changeStateErrorMessage(ErrorStringsEnum.invalidCredentialError.value);
        return false;
      }

      // Email'i güncelle
      await user.updatePassword(newPassword.trim());
      changeStateErrorMessage('');
      return true;
    } catch (e) {
      changeStateErrorMessage(e.toString());
      return false;
    } finally {
      changeStateIsLoading(false);
    }
  }

  /// Kullanıcının profil görselini yükler storage'a ve firestore'a kaydeder
  Future<bool> uploadAndSaveImage(File file) async {
    changeStateIsLoading(true);
    try {
      final String? url = await _imageService.uploadImageAndGetUrl(
        imageFile: file,
      );

      /// Firestore'a kaydet
      if (url != null) {
        final bool saved = await _imageService.saveUserImageUrl(imageUrl: url);
        if (!saved) {
          changeStateErrorMessage(ErrorStringsEnum.uploadImageFailed.value);
          return false;
        }
      }
      changeStateImageUrl(url);
      return true;
    } catch (e) {
      changeStateErrorMessage(e.toString());
      return false;
    } finally {
      changeStateIsLoading(false);
    }
  }

  void changeStateIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void changeStateErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void changeStateImageUrl(String? imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }

  /// UI açılışında eski hata mesajları kalmasın diye temizler
  void clearErrorMessage() {
    state = state.copyWith(errorMessage: '');
  }
}

class ProfileState extends Equatable {
  final String? imageUrl;
  final bool isLoading;
  final String? errorMessage;

  const ProfileState({
    required this.imageUrl,
    required this.isLoading,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [imageUrl, isLoading, errorMessage];

  ProfileState copyWith({
    String? imageUrl,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
