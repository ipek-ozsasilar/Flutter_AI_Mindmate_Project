import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/message/provider/message_provider.dart';
import 'package:flutter_mindmate_project/features/message/sub_view/speech_to_text.dart';
import 'package:flutter_mindmate_project/features/message/view_model/message_view_model.dart';
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
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'sub_view/chat_history_widget.dart';
part 'sub_view/start_chat_button_widget.dart';
part 'sub_view/chat_input_bottom_sheet_widget.dart';


class MessageView extends ConsumerStatefulWidget {
  const MessageView({super.key});

  @override
  ConsumerState<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends MessageViewModel {
  final int _totalChats = 3;
  bool _isInitialLoading = true;

  int get _remainingChats {
    // Sadece bugünün mesajlarını say
    final DateTime today = DateTime.now();
    final String todayDateStr = today.toString().split(
      ' ',
    )[0]; // YYYY-MM-DD formatında
    final int todayMessagesCount = ref
        .watch(messageProvider)
        .messages
        .where((message) => message.date == todayDateStr)
        .length;

    return _totalChats - todayMessagesCount;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    await loadMessages();
    if (mounted) {
      setState(() {
        _isInitialLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setupListeners(); // ✅ ref.listen build içinde olmalı

    // İlk yükleme sırasında loading göster
    if (_isInitialLoading) {
      return const Scaffold(
        backgroundColor: ColorName.scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(color: ColorName.yellowColor),
        ),
      );
    }

    return Scaffold(
      appBar: MessageAppbar(title: StringsEnum.messages.value),
      body: Column(
        children: [
          _ChatHistoryWidget(
            messages: messageRead(),
            isSendingMessage: loadingWatch(),
          ),
          _StartChatButtonWidget(
            hasReachedLimit: _remainingChats <= 0,
            onSendMessage: onPressedSendButton,
            isLoading: loadingWatch(),
          ),
        ],
      ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
