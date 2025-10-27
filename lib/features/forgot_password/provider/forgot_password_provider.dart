import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_riverpod/legacy.dart';

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

  //Firebase login işlemini yapıyoruz
  Future<bool> sendPasswordResetEmail() async {
    try {
      changeStateIsLoading(true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: state.email!);
      changeStateErrorMessage(ErrorStringsEnum.passwordResetEmailSent.value);
      changeStateIsLoading(false);
      return true;
    } catch (e) {
      changeStateErrorMessage(ErrorStringsEnum.unexpectedError.value);
      changeStateIsLoading(false);
      return false;
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
