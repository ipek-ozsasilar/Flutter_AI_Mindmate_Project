import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/create_chat/create_chat_view.dart';
import 'package:flutter_mindmate_project/features/forgot_password/forgot_password_view.dart';
import 'package:flutter_mindmate_project/features/forgot_password/provider/forgot_password_provider.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ForgotPasswordViewModel extends ConsumerState<ForgotPasswordView>
    with
        NavigationMixin<ForgotPasswordView>,
        ScaffoldMessage<ForgotPasswordView> {
  // Build içinde çağrılır - state değişikliklerini dinler
  void setupListeners() {
    ref.listen<ForgotPasswordState>(forgotPasswordProvider, (previous, next) {
      // Loading bitti, sonucu kontrol et
      if (previous != null && previous.isLoading && !next.isLoading) {
        if (next.errorMessage == ErrorStringsEnum.loginSuccess.value ||
            next.errorMessage == ErrorStringsEnum.createAccountSuccess.value) {
          // Login/Create Account başarılı, home'a git
          navigateTo(const LogInView());
          //email ve password'u temizle
          clearEmail();
        } else if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
          // Hata mesajı göster
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
      navigateTo(const LogInView());
      clearEmail();
      return true;
    } else {
      showSnackBar(ErrorStringsEnum.unexpectedError.value);
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
