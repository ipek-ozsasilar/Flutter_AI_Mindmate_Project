import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/daily_history_card_widget.dart';
part 'sub_view/history_chat_item_widget.dart';
part 'sub_view/empty_history_widget.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  // Dummy history data - grouped by date
  final Map<String, List<Map<String, dynamic>>> _historyData = {
    '20 Ekim 2024': [
      {
        'time': '09:30',
        'period': StringsEnum.morning.value,
        'mood': '😊',
        'userMessage': 'Bugün harika bir gün geçirdim, işlerim çok iyi gitti!',
        'aiResponse':
            'Mutlu olduğunu duymak harika! Bu olumlu enerjiyi devam ettir.',
      },
      {
        'time': '14:45',
        'period': StringsEnum.afternoon.value,
        'mood': '😊',
        'userMessage': 'Öğle yemeğinde arkadaşlarımla güzel vakit geçirdim.',
        'aiResponse': 'Sosyal bağlantılar çok önemli. Harika!',
      },
      {
        'time': '21:00',
        'period': StringsEnum.evening.value,
        'mood': '😌',
        'userMessage': 'Günü dinlenerek bitiriyorum, huzurluyum.',
        'aiResponse': 'Kendinize zaman ayırmanız muhteşem. İyi geceler!',
      },
    ],
    '19 Ekim 2024': [
      {
        'time': '08:15',
        'period': StringsEnum.morning.value,
        'mood': '😰',
        'userMessage': 'Bugün önemli bir toplantım var, biraz gerginim.',
        'aiResponse': 'Derin nefes al, hazırlıklısın. Başarılar dilerim!',
      },
      {
        'time': '16:30',
        'period': StringsEnum.afternoon.value,
        'mood': '😊',
        'userMessage': 'Toplantı çok iyi geçti, rahatladım!',
        'aiResponse': 'Harika! Endişelerin boşaymış, süpersin!',
      },
    ],
    '18 Ekim 2024': [
      {
        'time': '10:00',
        'period': StringsEnum.morning.value,
        'mood': '😢',
        'userMessage': 'Bugün biraz üzgünüm, işler planladığım gibi gitmedi.',
        'aiResponse':
            'Üzgün hissetmek normal. Yarın yeni bir gün, umarım daha iyi olur.',
      },
    ],
  };

  String _getDateLabel(String date, int index) {
    if (index == 0) {
      return StringsEnum.today.value;
    } else if (index == 1) {
      return StringsEnum.yesterday.value;
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dates = _historyData.keys.toList();

    return Scaffold(
      appBar: const MessageAppbar(),
      body: _historyData.isEmpty
          ? _EmptyHistoryWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final String date = dates[index];
                final List<Map<String, dynamic>> dayChats = _historyData[date]!;
                return _DailyHistoryCardWidget(
                  date: _getDateLabel(date, index),
                  isToday: index == 0,
                  dayChats: dayChats,
                );
              },
            ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
