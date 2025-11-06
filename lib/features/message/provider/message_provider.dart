import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/services/chat_service.dart';
import 'package:flutter_mindmate_project/products/services/firestore_service.dart';
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';
import 'package:flutter_riverpod/legacy.dart';

var messageProvider = StateNotifierProvider<MessageProvider, MessageState>(
  (ref) => MessageProvider(),
);

class MessageProvider extends StateNotifier<MessageState> {
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  MessageProvider()
    : super(
        const MessageState(
          isLoading: false,
          isConnected: false,
          errorMessage: '',
          aiResponse: '',
          messages: [],
        ),
      );

  /// Mesajı AI'ye gönderir ve veritabanına kaydeder
  Future<bool> sendMessage(String userMessage, String mood) async {
    try {
      // 1. Önce mesajı AI response olmadan ekle (UI'da loading gösterilsin)
      final DateTime now = DateTime.now();
      final String formattedTime = _getCurrentTimeFromDateTime(now);

      final MessageModel messageWithoutResponse = MessageModel(
        date: now.toString().split(' ')[0],
        period: _getPeriodFromDateTime(now),
        time: formattedTime,
        userMessage: userMessage,
        aiResponse: '', // Henüz AI response yok
        emoji: mood,
      );

      // 2. Mesajı hemen ekle (UI güncellensin)
      addMessage(messageWithoutResponse);

      // 3. Loading başlat
      changeStateIsLoading(true);

      // 4. AI'den cevap al (ChatService kullanarak)
      final String aiResponse = await chatService(userMessage);
      changeStateAiResponse(aiResponse);

      // 5. En son eklenen mesajı güncelle (AI response ile)
      updateLastMessageWithAiResponse(aiResponse);

      // 6. Güncellenmiş mesajı Firestore'a kaydet
      final MessageModel messageWithResponse = MessageModel(
        date: messageWithoutResponse.date,
        period: messageWithoutResponse.period,
        time: messageWithoutResponse.time,
        userMessage: userMessage,
        aiResponse: aiResponse,
        emoji: mood,
      );

      final bool isAdded = await _firestoreService.addMessageToFirestore(
        messageWithResponse,
      );
      if (!isAdded) {
        changeStateErrorMessage(ErrorStringsEnum.messageAddError.value);
        return false;
      }

      // Bildirim planlama işi NotificationsProvider'a taşındı

      // Loading bitir
      changeStateIsLoading(false);
      return true;
    } catch (e) {
      changeStateIsLoading(false);
      changeStateErrorMessage('Mesaj gönderilemedi: ${e.toString()}');
      return false;
    }
  }

  /// Kullanıcının tüm mesajlarını Firestore'dan yükler
  Future<List<MessageModel>?> loadMessages() async {
    try {
      changeStateIsLoading(true);
      final List<MessageModel>? messages = await _firestoreService
          .getMessages();
      if (messages == null) {
        changeStateErrorMessage(ErrorStringsEnum.messageGetError.value);
        return null;
      }
      changeStateMessages(messages);
      changeStateIsLoading(false);
      return messages;
    } catch (e) {
      changeStateIsLoading(false);
      changeStateErrorMessage(
        'Mesajlar yüklenirken hata oluştu: ${e.toString()}',
      );
      return null;
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      changeStateIsLoading(true);
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
      changeStateIsLoading(false);
      return false;
    } finally {
      changeStateIsLoading(false);
    }
  }

  void addMessage(MessageModel message) {
    // Yeni bir boş liste oluştur
    //Riverpod sadece referans değişikliklerini algılar o yüzden yeni bir liste oluşturuyoruz.
    final List<MessageModel> updatedMessages = <MessageModel>[];
    // Eski mesajları yeni listeye ekle
    updatedMessages.addAll(state.messages);
    // Yeni mesajı listeye ekle
    updatedMessages.add(message);
    // State'i güncelle
    state = state.copyWith(messages: updatedMessages);
  }

  /// En son eklenen mesajı AI response ile günceller
  void updateLastMessageWithAiResponse(String aiResponse) {
    if (state.messages.isEmpty) return;

    // Yeni bir boş liste oluştur
    final List<MessageModel> updatedMessages = <MessageModel>[];
    // Tüm mesajları kopyala
    updatedMessages.addAll(state.messages);

    // En son mesajı (son index) güncelle
    final int lastIndex = updatedMessages.length - 1;
    final MessageModel lastMessage = updatedMessages[lastIndex];
    updatedMessages[lastIndex] = lastMessage.copyWith(aiResponse: aiResponse);

    // State'i güncelle
    state = state.copyWith(messages: updatedMessages);
  }

  void changeStateAiResponse(String aiResponse) {
    state = state.copyWith(aiResponse: aiResponse);
  }

  void changeStateMessages(List<MessageModel> messages) {
    state = state.copyWith(messages: messages);
  }

  void changeStateErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }

  void changeStateIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void changeStateIsConnected(bool isConnected) {
    state = state.copyWith(isConnected: isConnected);
  }

  String _getPeriodFromDateTime(DateTime dateTime) {
    final int hour = dateTime.hour;
    if (hour < 12) {
      return StringsEnum.morning.value;
    } else if (hour < 18) {
      return StringsEnum.afternoon.value;
    } else {
      return StringsEnum.evening.value;
    }
  }

  String _getCurrentTimeFromDateTime(DateTime dateTime) {
    // 24 saatlik format (HH:mm) - örnek: 21:00, 20:45, 17:17
    // Türkiye saat dilimi için 3 saat ekle (UTC+3)
    final DateTime localDateTime = dateTime.toLocal();
    final DateTime turkishTime = localDateTime.add(const Duration(hours: 3));
    // 24 saatlik format için: saat 24'ü geçerse 0'a döner (DateTime otomatik günleri günceller ama biz sadece saat ve dakikayı alıyoruz)
    final int hour = turkishTime.hour % 24;
    final int minute = turkishTime.minute;
    // 24 saatlik format: 00:00 - 23:59
    final String hourString = hour.toString().padLeft(2, '0');
    final String minuteString = minute.toString().padLeft(2, '0');
    final String timeString = '$hourString:$minuteString';
    return timeString;
  }
}

class MessageState extends Equatable {
  final bool isLoading;
  final List<MessageModel> messages;
  final bool isConnected;
  final String errorMessage;
  final String aiResponse;

  const MessageState({
    required this.isLoading,
    required this.messages,
    required this.isConnected,
    required this.errorMessage,
    required this.aiResponse,
  });

  @override
  List<Object?> get props => [
    isLoading,
    messages,
    isConnected,
    errorMessage,
    aiResponse,
  ];

  MessageState copyWith({
    bool? isLoading,
    List<MessageModel>? messages,
    bool? isConnected,
    String? errorMessage,
    String? aiResponse,
  }) {
    return MessageState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: errorMessage ?? this.errorMessage,
      aiResponse: aiResponse ?? this.aiResponse,
    );
  }
}
