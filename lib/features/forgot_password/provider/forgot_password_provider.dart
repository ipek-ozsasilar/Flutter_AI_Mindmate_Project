import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';

var forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordProvider, ForgotPasswordState>(
      (ref) => ForgotPasswordProvider(),
    );

class ForgotPasswordProvider extends StateNotifier<ForgotPasswordState> {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordProvider()
    : super(
        const ForgotPasswordState(
          isLoading: false,
          email: '',
          isConnected: false,
          errorMessage: '',
        ),
      );

  Future<bool> checkInternetConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        changeStateIsConnected(false);
        changeStateErrorMessage(ErrorStringsEnum.internetConnectionError.value);
        return false;
      } else {
        changeStateIsConnected(true);
        return true;
      }
    } catch (e) {
      changeStateErrorMessage(e.toString());
      return false;
    }
  }

  Future<bool> checkEmail() async {
    final email = emailController.text.trim();

    // Email boş mu kontrol et
    if (email.isEmpty) {
      changeStateErrorMessage(ErrorStringsEnum.emailEmptyError.value);
      return false;
    }

    // Email geçerliyse state'e kaydet
    changeStateEmail(email);
    return true;
  }

  //Firebase password reset email gönderme işlemi
  //Güvenlik: user-not-found hatası gösterilmez (email enumeration saldırısını önlemek için)
  //Email kayıtlı olsun ya da olmasın, her durumda başarılı mesaj gösterilir
  Future<bool> sendPasswordResetEmail() async {
    final String? email = state.email;
    if (email == null || email.isEmpty) {
      changeStateErrorMessage(ErrorStringsEnum.emailEmptyError.value);
      return false;
    }

    changeStateIsLoading(true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Güvenlik: Email kayıtlı olsun ya da olmasın, her durumda başarılı mesaj göster
      changeStateErrorMessage(ErrorStringsEnum.passwordResetEmailSent.value);
      changeStateIsLoading(false);
      return true;
    } on FirebaseAuthException catch (error, stackTrace) {
      // Güvenlik açığı: user-not-found hatası gösterilmez
      // Email enumeration saldırısını önlemek için her durumda başarılı mesaj gösterilir
      if (error.code == 'user-not-found') {
        Logger().w(
          'Password reset requested for non-existent email (security: not shown to user)',
          error: error,
          stackTrace: stackTrace,
        );
        // Güvenlik: Kullanıcıya hata gösterme, başarılı mesaj göster
        changeStateErrorMessage(ErrorStringsEnum.passwordResetEmailSent.value);
        changeStateIsLoading(false);
        return true;
      }

      // Network hatası gibi kritik hatalar gösterilir
      if (error.code == 'network-request-failed') {
        Logger().e(
          'Network error while sending password reset email',
          error: error,
          stackTrace: stackTrace,
        );
        changeStateErrorMessage(ErrorStringsEnum.internetConnectionError.value);
        changeStateIsLoading(false);
        return false;
      }

      // Diğer hatalar loglanır ama kullanıcıya gösterilmez (güvenlik)
      Logger().e(
        'FirebaseAuthException while sending password reset email',
        error: error,
        stackTrace: stackTrace,
      );
      // Güvenlik: Hata gösterilmez, başarılı mesaj gösterilir
      changeStateErrorMessage(ErrorStringsEnum.passwordResetEmailSent.value);
      changeStateIsLoading(false);
      return true;
    } catch (error, stackTrace) {
      // Beklenmeyen hatalar loglanır
      Logger().e(
        'Unexpected error while sending password reset email',
        error: error,
        stackTrace: stackTrace,
      );
      // Güvenlik: Hata gösterilmez, başarılı mesaj gösterilir
      changeStateErrorMessage(ErrorStringsEnum.passwordResetEmailSent.value);
      changeStateIsLoading(false);
      return true;
    }
  }

  void changeStateIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void changeStateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void changeStateIsConnected(bool isConnected) {
    state = state.copyWith(isConnected: isConnected);
  }

  void changeStateErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void clearEmail() {
    emailController.clear();
  }
}

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final String? email;
  final bool isConnected;
  final String? errorMessage;
  const ForgotPasswordState({
    required this.isLoading,
    required this.email,
    required this.isConnected,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, email, isConnected, errorMessage];

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? email,
    bool? isConnected,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
