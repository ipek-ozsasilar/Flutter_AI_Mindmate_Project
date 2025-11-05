import 'package:flutter_mindmate_project/features/message/message_view.dart';
import 'package:flutter_mindmate_project/features/message/provider/message_provider.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
// notificationsProvider.notifier kullanıldığı için provider import edilir
import 'package:flutter_mindmate_project/features/notifications/provider/notifications_provider.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

abstract class MessageViewModel extends ConsumerState<MessageView>
    with ScaffoldMessage<MessageView> {
  final Logger _logger = Logger();
  void setupListeners() {
    ref.listen(messageProvider, (previous, next) {
      // Error mesajı değiştiğinde ve boş değilse snackbar göster
      if (next.errorMessage.isNotEmpty &&
          next.errorMessage != previous?.errorMessage) {
        _logger.e(next.errorMessage);
      }

      // İnternet bağlantı durumu değiştiğinde bildirim göster
      if (previous != null && previous.isConnected != next.isConnected) {
        if (next.isConnected) {
          _logger.i(ErrorStringsEnum.internetConnectionSuccess.value);
        } else {
          _logger.e(ErrorStringsEnum.internetConnectionError.value);
        }
      }

      // Mesajlar yüklendiğinde (ilk yüklemede veya refresh'te)
      if (previous != null &&
          previous.messages.length != next.messages.length &&
          next.messages.isNotEmpty) {
        _logger.i(ErrorStringsEnum.messageGetSuccess.value);
      }

      // AI yanıtı geldiğinde
      if (next.aiResponse.isNotEmpty &&
          next.aiResponse != previous?.aiResponse) {
        _logger.i(ErrorStringsEnum.aiResponseSuccess.value);
      }
    });
  }

  Future<bool> checkInternetConnection() async {
    final isConnected = await ref
        .read(messageProvider.notifier)
        .checkInternetConnection();
    if (!isConnected) {
      showSnackBar(ErrorStringsEnum.internetConnectionError.value);
      return false;
    } else {
      return true;
    }
  }

  bool loadingWatch() {
    return ref.watch(messageProvider).isLoading;
  }

  /// Sadece bugünün mesajlarını döndürür
  List<MessageModel> messageRead() {
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(
      ' ',
    )[0]; // YYYY-MM-DD formatında

    // Sadece bugünün mesajlarını filtrele
    return ref
        .watch(messageProvider)
        .messages
        .where((message) => message.date == todayDateStr)
        .toList();
  }

  /// Günlük kalan sohbet hakkını döndürür
  int remainingChats({required int totalChats}) {
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(' ')[0];

    final int todayMessagesCount = ref
        .watch(messageProvider)
        .messages
        .where((MessageModel message) => message.date == todayDateStr)
        .length;

    return totalChats - todayMessagesCount;
  }

  /// Butona basınca çağrılacak callback fonksiyonu
  /// Bottom sheet'ten gelen mesajı işler ve API'ye gönderir
  Future<void> onPressedSendButton(String userMessage, String mood) async {
    /// 1. İnternet bağlantısını kontrol et
    final bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      showSnackBar(ErrorStringsEnum.internetConnectionError.value);
      return;
    }
    ;

    /// 2. Provider'daki sendMessage metodunu çağır
    final bool ok = await ref
        .read(messageProvider.notifier)
        .sendMessage(userMessage, mood);

    /// 3. Başarılıysa Notification ViewModel üzerinden planla
    if (ok) {
      await ref
          .read(notificationsProvider.notifier)
          .scheduleMotivationAfterMessage(
            userMessage: userMessage,
            //1 dakika sonra bildirim göster
            delay: const Duration(minutes: 1),
          );
    }
  }

  Future<List<MessageModel>?> loadMessages() async {
    final List<MessageModel>? messages = await ref
        .read(messageProvider.notifier)
        .loadMessages();
    if (messages == null) {
      showSnackBar(ErrorStringsEnum.messageGetError.value);
      return null;
    }
    return messages;
  }
}
