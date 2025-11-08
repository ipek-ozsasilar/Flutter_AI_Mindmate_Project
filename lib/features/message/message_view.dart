import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/features/message/view_model/message_view_model.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/models/message_model.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/services/spech_to_text_service.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final List<MessageModel> messages = messageRead();
    final bool isEmpty = messages.isEmpty;

    return Scaffold(
      appBar: MessageAppbar(title: StringsEnum.messages.value),
      body: isEmpty
          ? Column(
              children: [
                const Spacer(),
                _EmptyStateWidget(),
                const SizedBox(height: 40),
                _StartChatButtonWidget(
                  hasReachedLimit: remainingChats(totalChats: _totalChats) <= 0,
                  // onSendMessage → MessageViewModel.onPressedSendButton'u çağırır.
                  // Bu metot mesajı gönderdikten sonra NotificationsViewModel üzerinden
                  // yerel bildirimi planlar (delay ile). Navigasyon için global navigatorKey kullanılır.
                  //butona bastıktan ve verıtabanına verıler kaydedıldıkten sonra bildirim planlanır.
                  //TAM BURADA BİLDİRİM PLANLANIYOR.
                  onSendMessage: onPressedSendButton,
                  isLoading: loadingWatch(),
                ),
                const Spacer(),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _ChatHistoryWidget(
                    messages: messages,
                    isSendingMessage: loadingWatch(),
                  ),
                  _StartChatButtonWidget(
                    hasReachedLimit:
                        remainingChats(totalChats: _totalChats) <= 0,
                    // onSendMessage → MessageViewModel.onPressedSendButton'u çağırır.
                    // Bu metot mesajı gönderdikten sonra NotificationsViewModel üzerinden
                    // yerel bildirimi planlar (delay ile). Navigasyon için global navigatorKey kullanılır.
                    //butona bastıktan ve verıtabanına verıler kaydedıldıkten sonra bildirim planlanır.
                    //TAM BURADA BİLDİRİM PLANLANIYOR.
                    onSendMessage: onPressedSendButton,
                    isLoading: loadingWatch(),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
