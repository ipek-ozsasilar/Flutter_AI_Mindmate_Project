part of '../message_view.dart';

class _ChatInputBottomSheetWidget extends StatefulWidget {
  final Function(String userMessage, String mood) onSendMessage;
  final bool isLoading;
  const _ChatInputBottomSheetWidget({
    required this.onSendMessage,
    required this.isLoading,
  });

  @override
  State<_ChatInputBottomSheetWidget> createState() =>
      _ChatInputModalWidgetState();
}

class _ChatInputModalWidgetState extends State<_ChatInputBottomSheetWidget>
    with SpeechToTextMixin {
  String _selectedMood = '😊';
  // 5 seviyeyi MoodEnum ile hizala
  final List<Map<String, String>> _moods = [
    {'emoji': '😢', 'label': 'Very Sad'},
    {'emoji': '☹️', 'label': 'Sad'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😄', 'label': 'Very Happy'},
  ];

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  @override
  void dispose() {
    // Dinleme açık kalmasın diye widget kapanırken güvenli şekilde durdurulur
    speechToText.stop();
    messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (messageController.text.trim().isEmpty) return;
    widget.onSendMessage(messageController.text.trim(), _selectedMood);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      decoration: const BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralTextWidget(
            color: ColorName.whiteColor,
            size: TextSizesEnum.appTitleSize.value,
            text: StringsEnum.howAreYouFeelingToday.value,
          ),
          const SizedBox(height: 16),
          // Mood selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _moods.map((mood) {
              final bool isSelected = _selectedMood == mood['emoji'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = mood['emoji']!;
                  });
                },
                child: Container(
                  width: WidgetSizesEnum.moodIconContainerSize.value,
                  height: WidgetSizesEnum.moodIconContainerSize.value,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorName.yellowColor.withOpacity(0.3)
                        : ColorName.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: ColorName.yellowColor, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      mood['emoji']!,
                      style: TextStyle(
                        fontSize: IconSizesEnum.moodIconSize.value,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Message input
          TextField(
            controller: messageController,
            maxLines: 4,
            style: const TextStyle(color: ColorName.whiteColor),
            decoration: InputDecoration(
              hintText: StringsEnum.writeYourFeelingsHere.value,
              hintStyle: const TextStyle(color: ColorName.loginGreyTextColor),
              filled: true,
              fillColor: ColorName.scaffoldBackgroundColor,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Onay (OK) butonu: sadece dinlerken görünür
                  if (speechToText.isListening)
                    IconButton(
                      tooltip: 'Onayla',
                      onPressed: () async {
                        applyPendingSpeechText();
                        await stopListening();
                      },
                      icon: const Icon(
                        Icons.check,
                        color: ColorName.yellowColor,
                      ),
                    ),
                  // Mikrofon toggle
                  IconButton(
                    onPressed: speechEnabled
                        ? () {
                            if (speechToText.isListening) {
                              stopListening();
                            } else {
                              startListening();
                            }
                          }
                        : null,
                    icon: GlobalIcon(
                      speechToText.isListening
                          ? IconConstants.iconConstants.micIcon
                          : IconConstants.iconConstants.micOffIcon,
                      iconColor: ColorName.yellowColor,
                    ),
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Send button
          SizedBox(
            width: double.infinity,
            height: WidgetSizesEnum.elevatedButtonHeight.value,
            child: ElevatedButton(
              onPressed: _handleSend,
              child: widget.isLoading
                  ? const CircularProgressIndicator()
                  : GeneralTextWidget(
                      color: ColorName.blackColor,
                      size: TextSizesEnum.generalSize.value,
                      text: StringsEnum.send.value,
                    ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
