import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart' as SizesEnum;
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
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
    'October 20, 2024': [
      {
        'time': '09:30',
        'period': StringsEnum.morning.value,
        'mood': '😊',
        'userMessage': 'I had a great day today, my work went really well!',
        'aiResponse':
            'Great to hear you\'re happy! Keep up that positive energy.',
      },
      {
        'time': '14:45',
        'period': StringsEnum.afternoon.value,
        'mood': '😊',
        'userMessage': 'I had a wonderful time with my friends at lunch.',
        'aiResponse': 'Social connections are so important. Amazing!',
      },
      {
        'time': '21:00',
        'period': StringsEnum.evening.value,
        'mood': '😌',
        'userMessage': 'I\'m ending the day relaxing, I feel peaceful.',
        'aiResponse': 'Taking time for yourself is wonderful. Good night!',
      },
    ],
    'October 19, 2024': [
      {
        'time': '08:15',
        'period': StringsEnum.morning.value,
        'mood': '😰',
        'userMessage': 'I have an important meeting today, I\'m a bit nervous.',
        'aiResponse': 'Take a deep breath, you\'re prepared. Good luck!',
      },
      {
        'time': '16:30',
        'period': StringsEnum.afternoon.value,
        'mood': '😊',
        'userMessage': 'The meeting went really well, I feel relieved!',
        'aiResponse': 'Awesome! Your worries were unfounded, you\'re amazing!',
      },
    ],
    'October 18, 2024': [
      {
        'time': '10:00',
        'period': StringsEnum.morning.value,
        'mood': '😢',
        'userMessage':
            'I\'m feeling a bit sad today, things didn\'t go as planned.',
        'aiResponse':
            'Feeling sad is normal. Tomorrow is a new day, hope it\'s better.',
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
