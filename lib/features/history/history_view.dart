import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindmate_project/features/history/view_model/history_view_model.dart';

part 'sub_view/daily_history_card_widget.dart';
part 'sub_view/history_chat_item_widget.dart';
part 'sub_view/empty_history_widget.dart';

class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends HistoryViewModel {
  @override
  void initState() {
    super.initState();
    // Build tamamlandıktan SONRA mesajları yükle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> messages = messageRead();
    final List<String> uniqueDates = getUniqueDates(messages);

    return Scaffold(
      appBar: MessageAppbar(title: StringsEnum.history.value),
      body: messages.isEmpty
          ? Center(child: _EmptyHistoryWidget())
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
                itemCount: uniqueDates.length,
                itemBuilder: (context, index) {
                  final String date = uniqueDates[index];
                  final List<MessageModel> dayChats = messages
                      .where((message) => message.date == date)
                      .toList();

                  return _DailyHistoryCardWidget(
                    date: getDateLabel(date, index),
                    isToday: isTodayDate(date),
                    dayChats: dayChats
                        .map((message) => message.toJson())
                        .toList(),
                  );
                },
              ),
            ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
