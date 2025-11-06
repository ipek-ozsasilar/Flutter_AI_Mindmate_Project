// Progress ekranının ViewModel katmanı
// - Provider'daki state'i okur/günceller
// - Grafik verisini hesaplar (UI dışı mantık)
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_mindmate_project/features/progress/progress_view.dart';
import 'package:flutter_mindmate_project/features/progress/provider/progress_provider.dart';
import 'package:flutter_mindmate_project/features/message/provider/message_provider.dart';
import 'package:flutter_mindmate_project/products/enums/mood_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ProgressViewModel extends ConsumerState<ProgressView> {
  // UI'ın seçili tarih aralığını okuması için yardımcı getter
  bool isSevenDaysWatch() => ref.watch(progressProvider).isSevenDays;

  // Tarih aralığını günceller (Provider'a yazar)
  void setSevenDays(bool value) {
    ref.read(progressProvider.notifier).setSevenDays(value);
  }

  // Grafik eksen maksimumu (7 gün → 6, 30 gün → 29)
  double maxXForRange(bool isSevenDays) => isSevenDays ? 6 : 29;

  // Mesajlardan (emoji) son 7/30 güne göre FlSpot listesi üret
  List<FlSpot> chartSpotsFromMessages(bool isSevenDays) {
    final messages = ref.watch(messageProvider).messages;
    final DateTime today = DateTime.now();
    final int range = isSevenDays ? 7 : 30;

    // Gün başlangıcından itibaren karşılaştırma için YYYY-MM-DD stringi
    String toDateStr(DateTime d) => d.toString().split(' ')[0];

    // İlgili aralıktaki günlerin tarih stringleri (en eski -> en yeni)
    final List<String> dates = List.generate(range, (i) {
      final DateTime day = today.subtract(Duration(days: (range - 1 - i)));
      return toDateStr(day);
    });

    // Her gün için son mesaja göre mood değeri seç (yoksa null)
    final List<FlSpot> spots = [];
    for (int i = 0; i < dates.length; i++) {
      final String dateStr = dates[i];
      final dayMessages = messages.where((m) => m.date == dateStr).toList();
      if (dayMessages.isEmpty) {
        continue; // veri yoksa nokta koyma
      }
      final last = dayMessages.last;
      final String emoji = last.emoji ?? '';
      final mood = MoodEnum.fromEmoji(emoji);
      if (mood != null) {
        final spot = FlSpot(i.toDouble(), mood.value.toDouble());
        spots.add(spot);
      }
    }
    return spots;
  }

  // Progress ekranı açıldığında mesajlar yüklenmemişse yükle
  Future<void> ensureMessagesLoaded() async {
    final msgs = ref.read(messageProvider).messages;
    if (msgs.isEmpty) {
      await ref.read(messageProvider.notifier).loadMessages();
      if (mounted) setState(() {});
    }
  }
}
