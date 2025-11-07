import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/forgot_password/forgot_password_view.dart';
import 'package:flutter_mindmate_project/features/forgot_password/provider/forgot_password_provider.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ForgotPasswordViewModel extends ConsumerState<ForgotPasswordView>
    with ScaffoldMessage<ForgotPasswordView> {
  // Build içinde çağrılır - state değişikliklerini dinler
  void setupListeners() {
    ref.listen<ForgotPasswordState>(forgotPasswordProvider, (previous, next) {
      // Loading bitti, sonucu kontrol et
      if (previous != null && previous.isLoading && !next.isLoading) {
        if (next.errorMessage == ErrorStringsEnum.loginSuccess.value ||
            next.errorMessage == ErrorStringsEnum.createAccountSuccess.value ||
            next.errorMessage ==
                ErrorStringsEnum.passwordResetEmailSent.value) {
          // Login/Create Account/Password Reset başarılı, login ekranına git
          context.navigateTo(const LogInView());
          // Email'i temizle
          clearEmail();
        } else if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
          // Hata mesajı göster (sadece network hatası gibi kritik hatalar)
          showSnackBar(next.errorMessage!);
        }
      }
    });
  }

  // Button'dan çağrılır - login işlemini başlatır
  Future<bool> sendPasswordResetEmail() async {
    // Internet bağlantısı kontrolü
    final isConnected = await ref
        .read(forgotPasswordProvider.notifier)
        .checkInternetConnection();
    if (!isConnected) {
      showSnackBar(ErrorStringsEnum.internetConnectionError.value);
      return false;
    }

    // Full Name, Email ve password kontrolü
    final email = await ref.read(forgotPasswordProvider.notifier).checkEmail();
    if (!email) {
      final errorMsg = ref.read(forgotPasswordProvider).errorMessage;
      if (errorMsg != null && errorMsg.isNotEmpty) {
        showSnackBar(errorMsg);
      }
      return false;
    }

    // Password reset email gönder (state değişir, setupListeners yakalar)
    final result = await ref
        .read(forgotPasswordProvider.notifier)
        .sendPasswordResetEmail();
    if (result) {
      // Başarılı mesajı göster ve login ekranına yönlendir
      final String? successMessage = ref
          .read(forgotPasswordProvider)
          .errorMessage;
      if (successMessage != null && successMessage.isNotEmpty) {
        showSnackBar(successMessage);
      }
      context.navigateTo(const LogInView());
      clearEmail();
      return true;
    } else {
      // Sadece network hatası gibi kritik hatalar gösterilir
      final String? errorMessage = ref
          .read(forgotPasswordProvider)
          .errorMessage;
      if (errorMessage != null && errorMessage.isNotEmpty) {
        showSnackBar(errorMessage);
      }
      return false;
    }
  }

  bool loadingWatch() {
    //loading watch fonksiyonu
    return ref.watch(forgotPasswordProvider).isLoading;
  }

  TextEditingController? readEmailController() {
    return ref.read(forgotPasswordProvider.notifier).emailController;
  }

  void clearEmail() {
    ref.read(forgotPasswordProvider.notifier).clearEmail();
  }
}
