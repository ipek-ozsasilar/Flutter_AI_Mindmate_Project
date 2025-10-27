import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/create_chat/create_chat_view.dart';
import 'package:flutter_mindmate_project/features/login/create_account_view.dart';
import 'package:flutter_mindmate_project/features/login/provider/create_account_provider.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CreateAccountViewModel extends ConsumerState<CreateAccountView>
    with
        NavigationMixin<CreateAccountView>,
        ScaffoldMessage<CreateAccountView> {
  // Build içinde çağrılır - state değişikliklerini dinler
  void setupListeners() {
    ref.listen<CreateAccountState>(createAccountProvider, (previous, next) {
      // Loading bitti, sonucu kontrol et
      if (previous != null && previous.isLoading && !next.isLoading) {
        if (next.errorMessage == ErrorStringsEnum.loginSuccess.value ||
            next.errorMessage == ErrorStringsEnum.createAccountSuccess.value) {
          // Login/Create Account başarılı, home'a git
          navigateTo(const CreateChatView());
          //email ve password'u temizle
          clearFullNameAndEmailAndPassword();
        } else if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
          // Hata mesajı göster
          showSnackBar(next.errorMessage!);
        }
      }
    });
  }

  // Button'dan çağrılır - login işlemini başlatır
  Future<bool> createAccount() async {
    // Internet bağlantısı kontrolü
    final isConnected = await ref
        .read(createAccountProvider.notifier)
        .checkInternetConnection();
    if (!isConnected) {
      showSnackBar(ErrorStringsEnum.internetConnectionError.value);
      return false;
    }

    // Full Name, Email ve password kontrolü
    final fullNameAndEmailAndPassword = await ref
        .read(createAccountProvider.notifier)
        .checkFullNameAndEmailAndPassword();
    if (!fullNameAndEmailAndPassword) {
      final errorMsg = ref.read(createAccountProvider).errorMessage;
      if (errorMsg != null && errorMsg.isNotEmpty) {
        showSnackBar(errorMsg);
      }
      return false;
    }

    // Create Account işlemini başlat (state değişir, setupListeners yakalar)
    final result = await ref
        .read(createAccountProvider.notifier)
        .emailAndPasswordCreateAccount();
    if (result) {
      navigateTo(const CreateChatView());
      clearFullNameAndEmailAndPassword();
      return true;
    } else {
      showSnackBar(ErrorStringsEnum.createAccountFailed.value);
      return false;
    }
  }

  bool loadingWatch() {
    //loading watch fonksiyonu
    return ref.watch(createAccountProvider).isLoading;
  }

  void togglePasswordVisibility() {
    ref
        .read(createAccountProvider.notifier)
        .changeStateIsPasswordObscure(
          !ref.read(createAccountProvider).isPasswordObscure,
        );
  }

  bool readPasswordObscure() {
    return ref.read(createAccountProvider).isPasswordObscure;
  }

  bool watchPasswordObscure() {
    return ref.watch(createAccountProvider).isPasswordObscure;
  }

  TextEditingController? readPasswordController() {
    return ref
        .read(createAccountProvider.notifier)
        .passwordController; //password controller'ı döndürüyoruz
  }

  Future<void> googleCreateAccount() async {
    final result = await ref
        .read(createAccountProvider.notifier)
        .GoogleCreateAccount();
    if (result) {
      navigateTo(const CreateChatView());
      clearFullNameAndEmailAndPassword();
    }
    // Hata mesajı zaten provider'da set ediliyor, setupListeners gösterecek
  }

  void clearFullNameAndEmailAndPassword() {
    ref.read(createAccountProvider.notifier).clearFullNameAndEmailAndPassword();
  }

  TextEditingController? readEmailController() {
    return ref.read(createAccountProvider.notifier).emailController;
  }

  TextEditingController? readFullNameController() {
    return ref.read(createAccountProvider.notifier).fullNameController;
  }
}
