import 'package:flutter_mindmate_project/features/history/history_view.dart';
import 'package:flutter_mindmate_project/features/message/provider/message_provider.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class HistoryViewModel extends ConsumerState<HistoryView>
    with ScaffoldMessage<HistoryView> {
  List<MessageModel> messageRead() {
    return ref.watch(messageProvider).messages;
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

  /// Tarih etiketini belirler: bugün için "today", dün için "yesterday", diğerleri için tarih
  String getDateLabel(String date, int index) {
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(
      ' ',
    )[0]; // YYYY-MM-DD formatında

    // Bugün ise
    if (date == todayDateStr) {
      return StringsEnum.today.value;
    }

    // Dün ise
    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final String yesterdayDateStr = yesterday.toString().split(' ')[0];
    if (date == yesterdayDateStr) {
      return StringsEnum.yesterday.value;
    }

    // Diğer durumlarda tarihi olduğu gibi döndür
    return date;
  }

  /// Tarihin bugün olup olmadığını kontrol eder
  bool isTodayDate(String date) {
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(
      ' ',
    )[0]; // YYYY-MM-DD formatında
    return date == todayDateStr;
  }

  List<String> getUniqueDates(List<MessageModel> messages) {
    // Unique tarihleri al (tekrar etmesin) ve sırala (yeniden eskiye)
    final List<String> uniqueDates =
        messages
            .map((message) => message.date ?? '')
            .toSet() // Set'e çevir (unique yapar)
            .toList()
          ..sort((a, b) => b.compareTo(a)); // Yeniden eskiye sırala
    return uniqueDates;
  }
}
