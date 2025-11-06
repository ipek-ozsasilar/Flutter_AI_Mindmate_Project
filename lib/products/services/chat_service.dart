import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> chatService(String prompt) async {
  try {
    //dotenv.env['OPENAI_API_KEY'] ile .env dosyasındaki OPENAI_API_KEY değerini alır
    //Açıkça yazılmaz environment variable olarak yüklenir.
    //Environment variable (ortam değişkeni): Uygulamanın çalışırken dışarıdan okuduğu ayar/değerleri içerir.
    final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    final String emptyResponse = 'API cevabı boş döndü';
    final String model = 'gpt-3.5-turbo';
    final int successStatusCode = 200;
    final String systemPrompt =
        'Sen bir ruh sağlığı asistanısın. Kullanıcılara empatik ve destekleyici yanıtlar ver. Kullanıcının mesajını hangi dilde yazdıysa, sen de aynı dilde yanıt ver. Kullanıcı Türkçe yazdıysa Türkçe, İngilizce yazdıysa İngilizce, diğer dillerde yazdıysa o dilde yanıt ver.';
    // Doğru OpenAI endpoint'i
    final Uri url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': prompt},
        ],
        //0.7 değeri, daha fazla rastgelelik ve değişkenlik sağlar.
        //Temperature, modelin yanıtlarındaki yaratıcılığı/rastgeleliği ayarlar.
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == successStatusCode) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final String text =
          data['choices'][0]['message']['content'] as String? ?? '';
      return text.isNotEmpty ? text : emptyResponse;
    } else {
      throw Exception('API isteği başarısız: ${response.statusCode}');
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> generateMotivation(String userMessage) async {
  try {
    final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    final String model = 'gpt-3.5-turbo';
    final Uri url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final String systemPrompt =
        'Kısa, nazik, güven verici, tetikleyici olmayan, 20-30 kelimelik bir motivasyon cümlesi üret. Emoji kullanma. Kullanıcının mesajını hangi dilde yazdıysa, sen de aynı dilde motivasyon mesajı ver. Kullanıcı Türkçe yazdıysa Türkçe, İngilizce yazdıysa İngilizce, diğer dillerde yazdıysa o dilde yanıt ver.';
    final String userPrompt =
        'Kullanıcının mesajı: "$userMessage". Bu duygu durumuna uygun tek cümlelik motivasyon yaz.';

    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final String text =
          data['choices'][0]['message']['content'] as String? ?? '';
      return text.trim();
    } else {
      return 'Kendine nazik ol, bu duygular geçecek. Yanındayım.';
    }
  } catch (e) {
    return 'Kendine nazik ol, bu duygular geçecek. Yanındayım.';
  }
}
