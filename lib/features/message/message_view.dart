import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/chat_history_widget.dart';
part 'sub_view/start_chat_button_widget.dart';
part 'sub_view/chat_input_modal_widget.dart';
part 'sub_view/ai_response_dialog_widget.dart';

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
          _ChatInputBottomSheetWidget(onSendMessage: _handleSendMessage),
    );
  }

  Future<void> _handleSendMessage(String message, String mood) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ColorName.loginInputColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: ColorName.yellowColor),
              const SizedBox(height: 16),
              Text(
                StringsEnum.aiIsThinking.value,
                style: const TextStyle(
                  color: ColorName.whiteColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulate AI response (2 seconds delay)
    await Future.delayed(const Duration(seconds: 2));

    // Generate dummy AI response
    final String aiResponse = _generateDummyAiResponse(mood);

    // Add to conversations list
    setState(() {
      _conversations.add({
        'time':
            '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        'period': _getPeriod(),
        'mood': mood,
        'userMessage': message,
        'aiResponse': aiResponse,
      });
    });

    // Close loading dialog
    Navigator.pop(context);

    // Show AI response dialog
    showDialog(
      context: context,
      builder: (context) => _AiResponseDialogWidget(
        userMessage: message,
        aiResponse: aiResponse,
        onClose: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  String _generateDummyAiResponse(String mood) {
    // Dummy AI responses based on mood
    switch (mood) {
      case '😊':
        return 'Mutlu olduğunu duymak harika! Bu olumlu enerjiyi devam ettir ve başarılarını kutla.';
      case '😢':
        return 'Üzgün hissetmek normal. Kendine zaman tanı ve sevdiklerinle konuşmayı dene.';
      case '😰':
        return 'Endişeli hissediyorsun. Derin nefes almayı dene ve bir şeyleri kontrol edebileceğini unutma.';
      case '😡':
        return 'Sinirlenmek doğal bir duygu. Kısa bir yürüyüş veya egzersiz sana iyi gelebilir.';
      default:
        return 'Duygularını paylaştığın için teşekkürler. Senin için buradayım.';
    }
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
