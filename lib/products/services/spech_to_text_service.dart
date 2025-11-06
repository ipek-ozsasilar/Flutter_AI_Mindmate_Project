import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/products/enums/durations_enum.dart';

mixin SpeechToTextMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController messageController = TextEditingController();
  final String localeId = 'tr_TR';
  final bool partialResults = true;
  // Speech-to-Text
  // Konuşmayı yazıya dönüştürmek için kullanılan asıl servis nesnesi
  final SpeechToText speechToText = SpeechToText();
  // Cihazda speech-to-text özelliği başarıyla başlatıldı mı bilgisini tutar
  bool speechEnabled = false;

  // Dinleme sırasında gelen (final olmadan) anlık metni geçici olarak saklar
  String pendingSpeechText = '';

  Future<void> initSpeech() async {
    try {
      // Cihaz yeteneklerini ve izinleri kontrol ederek speech-to-text'i hazırlar
      speechEnabled = await speechToText.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      // Başlatma hatası durumunda özelliği pasifler ve kullanıcıya etki etmesin diye state günceller
      speechEnabled = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> startListening() async {
    if (!speechEnabled) {
      // Özellik başlatılamamışsa kullanıcıya bilgilendirme yapılır
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: GeneralTextWidget(
            color: ColorName.whiteColor,
            size: TextSizesEnum.generalSize.value,
            text: ErrorStringsEnum.speechToTextInitializationError.value,
          ),
        ),
      );
      return;
    }

    // Mikrofon izni kontrolü
    final status = await Permission.microphone.status;
    if (!status.isGranted) {
      await requestMicrophonePermission();
    }

    // Dinlemeye başla
    pendingSpeechText = '';
    await speechToText.listen(
      // Her yeni sonuç geldiğinde çalışacak geri çağırım; anlık ve final sonuçları işler
      onResult: onSpeechResult,
      // Türkçe tanıma için yerel kodu (Türkiye) kullan
      localeId: localeId,
      // Kısa ve net komut/sözler için uygun dinleme modu
      listenMode: ListenMode.confirmation,
      // Kısmi sonuçların da gelmesine izin ver (kullanıcı konuşurken metin akar)
      partialResults: partialResults,
      // Maksimum dinleme süresi; süre dolarsa otomatik durur
      listenFor: DurationsEnum.speechListenMax.value,
      // Belirli bir süre sessizlik olursa otomatik durdurma süresi
      pauseFor: DurationsEnum.speechPause.value, // sessizlik sonrası auto-stop
    );

    if (mounted) setState(() {});
  }

  Future<void> requestMicrophonePermission() async {
    try {
      // Kullanıcıdan mikrofon izni isteme akışı
      final status = await Permission.microphone.request();
      if (status.isGranted) {
        // İzin verildiyse dinlemeye devam edilebilir

        return;
      } else if (status.isPermanentlyDenied) {
        // Kalıcı olarak reddedildiyse ayarlara yönlendirme gerekebilir
      } else {
        // Geçici reddedildiyse tekrar sorulabilir
      }
    } catch (e) {
      // İzin isteme sırasında beklenmeyen bir hata oluştu
    }
  }

  Future<void> stopListening() async {
    try {
      // Aktif dinlemeyi güvenli bir şekilde sonlandırır
      await speechToText.stop();
      if (mounted) setState(() {});
    } catch (e) {
      // Durdurma sırasında hata olursa yoksay
    }
  }

  // 🔹 GÜNCELLENDİ: result tipi ve auto-stop kontrolü eklendi
  void onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    // Anlık (kısmi veya final) tanınan kelimeleri geçici belleğe yaz
    pendingSpeechText = result.recognizedWords;

    // Metin değişimlerini arayüze yansıtmak için çerçeve sonrasında setState çağır
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }

    // Eğer konuşma motoru sonucu final olarak işaretlediyse
    if (result.finalResult) {
      applyPendingSpeechText(); // metni input'a uygula
      stopListening(); // dinlemeyi kapat
    }
  }

  void applyPendingSpeechText() {
    // Herhangi bir metin yoksa işlem yapma
    if (pendingSpeechText.isEmpty) return;

    // Geçici metni mesaj girişine aktar ve imleci sona al
    messageController.text = pendingSpeechText.trim();
    //Bu kod, metni TextEditingControllera yazdıktan sonra imleci (caret) metnin sonuna taşır.
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: messageController.text.length),
    );

    // Kullanıcıya bilgi mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: 'Konuşma metne dönüştürüldü',
        ),
      ),
    );
  }
}
