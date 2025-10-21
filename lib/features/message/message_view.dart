import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/chat_history_widget.dart';
part 'sub_view/start_chat_button_widget.dart';
part 'sub_view/chat_input_bottom_sheet_widget.dart.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  // Dummy data for conversations
  final List<Map<String, dynamic>> _conversations = [];
  final int _totalChats = 3;

  int get _remainingChats => _totalChats - _conversations.length;

  String _getPeriod() {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return StringsEnum.morning.value;
    } else if (hour < 18) {
      return StringsEnum.afternoon.value;
    } else {
      return StringsEnum.evening.value;
    }
  }

  void _openChatInputModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _ChatInputBottomSheetWidget(),
    );
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MessageAppbar(),
      body: Column(
        children: [
          _ChatHistoryWidget(conversations: _conversations),
          _StartChatButtonWidget(
            hasReachedLimit: _remainingChats <= 0,
            onStartChat: _openChatInputModal,
          ),
        ],
      ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
