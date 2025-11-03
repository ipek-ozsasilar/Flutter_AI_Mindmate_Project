import 'dart:io';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';

import 'package:flutter_mindmate_project/features/profile/profile_view.dart';
import 'package:flutter_mindmate_project/features/profile/provider/profile_provider.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileViewModel extends ConsumerState<ProfileView>
    with ScaffoldMessage<ProfileView> {
  ProfileViewModel();

  File? selectedImage;

  void setupListeners() {
    ref.listen(profileProvider, (previous, next) {
      if (previous?.isLoading == true && next.isLoading == false) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      // Hataları global olarak göster (önceki davranış)
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        showSnackBar(next.errorMessage!);
      }
    });
  }

  bool loadingWatch() {
    return ref.watch(profileProvider).isLoading;
  }


  void clearErrorMessage() {
    ref.read(profileProvider.notifier).clearErrorMessage();

  }

  Future<bool> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final bool updated = await ref
        .read(profileProvider.notifier)
        .updatePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
    if (!updated) {
      showSnackBar(ErrorStringsEnum.updatePasswordFailed.value);
    }
    return updated;
  }

  Future<bool> updateEmail(String currentPassword, String newEmail) async {
    final bool updated = await ref
        .read(profileProvider.notifier)
        .updateEmail(currentPassword: currentPassword, newEmail: newEmail);
    if (!updated) {
      showSnackBar(ErrorStringsEnum.updateEmailFailed.value);
    }
    return updated;
  }

  Future<void> signOut() async {
    await ref.read(profileProvider.notifier).signOut();
    context.navigateTo(const LogInView());
  }

  /// Kullanıcının profil görselini yükler
  Future<void> loadProfileImage() async {
    await ref.read(profileProvider.notifier).loadProfileImage();
  }

  String? imageUrlWatch() {
    return ref.watch(profileProvider).imageUrl;
  }

  /// Kullanıcının profil görselini yükler storage'a ve firestore'a kaydeder
  Future<void> uploadAndSaveImage(File file) async {
    final bool uploaded = await ref
        .read(profileProvider.notifier)
        .uploadAndSaveImage(file);
    if (!uploaded) {
      showSnackBar(ErrorStringsEnum.uploadImageFailed.value);
      return;
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    final File file = File(image.path);
    setState(() => selectedImage = file);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(StringsEnum.uploadingImage.value)));
    }

    final success = await ref
        .read(profileProvider.notifier)
        .uploadAndSaveImage(file);

    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? StringsEnum.imageUploadSuccess.value
            : StringsEnum.imageUploadError.value),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}
