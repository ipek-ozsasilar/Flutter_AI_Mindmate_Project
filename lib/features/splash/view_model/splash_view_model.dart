import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/create_chat/create_chat_view.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/features/splash/provider/splash_provider.dart';
import 'package:flutter_mindmate_project/features/splash/splash_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class SplashViewModel extends ConsumerState<SplashView> with ScaffoldMessage<SplashView> {
  // Button'dan çağrılır - sadece provider metodlarını tetikler
  Future<void> startChecks() async {
    await ref.read(splashProvider.notifier).checkInternetConnection();
    await ref.read(splashProvider.notifier).checkUserLoginStatus();
  }

  // build içinde çağrılır - listener kurar
  void setupListeners() {
    ref.listen<SplashState>(splashProvider, (previous, next) {
      // Internet yoksa uyarı
      if (previous?.isInternetConnected != next.isInternetConnected &&
          !next.isInternetConnected) {
        showSnackBar(ErrorStringsEnum.internetConnectionError.value);
      }

      // Login kontrolü bitti, yönlendir
      if (previous != null && previous.isLoading && !next.isLoading) {
        if (next.isLoggedIn) {
          context.navigateTo(const CreateChatView());
        } else {
          context.navigateTo(const LogInView());
        }
      }
    });
  }
}
