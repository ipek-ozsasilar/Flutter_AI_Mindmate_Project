import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/legacy.dart';

var splashProvider = StateNotifierProvider<SplashProvider, SplashState>(
  (ref) => SplashProvider(),
);

class SplashState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isInternetConnected;
  final String errorMessage;

  const SplashState({
    required this.isLoading,
    required this.isLoggedIn,
    required this.isInternetConnected,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isLoggedIn,
    isInternetConnected,
    errorMessage,
  ];

  SplashState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isInternetConnected,
    String? errorMessage,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isInternetConnected: isInternetConnected ?? this.isInternetConnected,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider()
    : super(
        const SplashState(
          isLoading: true,
          isLoggedIn: false,
          isInternetConnected: false,
          errorMessage: '',
        ),
      );

  void changeStateInternetConnected(bool isInternetConnected) {
    state = state.copyWith(isInternetConnected: isInternetConnected);
  }

  void changeStateErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void changeStateLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void changeStateIsLoggedIn(bool isLoggedIn) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }

  Future<void> checkInternetConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        changeStateInternetConnected(false);
      } else {
        changeStateInternetConnected(true);
      }
    } catch (e) {
      changeStateErrorMessage(e.toString());
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> checkUserLoginStatus() async {
    try {
      //loading durumunu true yapıyoruz
      changeStateLoading(true);
      //kullanıcının giriş yapıp yapmadığını kontrol ediyoruz
      final user = _auth.currentUser;
      if (user != null) {
        changeStateIsLoggedIn(true);
      } else {
        changeStateIsLoggedIn(false);
      }
    } catch (e) {
      //hata durumunu false yapıyoruz
      changeStateErrorMessage(e.toString());
    } finally {
      changeStateLoading(false);
    }
  }
}
