part of '../message_view.dart';

class _ChatInputBottomSheetWidget extends StatefulWidget {
  final Function(String message, String mood) onSendMessage;

  const _ChatInputBottomSheetWidget({required this.onSendMessage});

  @override
  State<_ChatInputBottomSheetWidget> createState() => _ChatInputModalWidgetState();
}

class _ChatInputModalWidgetState extends State<_ChatInputBottomSheetWidget> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedMood = '😊';
  final List<Map<String, String>> _moods = [
    {'emoji': '😊', 'label': 'Mutlu'},
    {'emoji': '😢', 'label': 'Üzgün'},
    {'emoji': '😰', 'label': 'Endişeli'},
    {'emoji': '😡', 'label': 'Sinirli'},
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_messageController.text.trim().isEmpty) return;

    widget.onSendMessage(_messageController.text.trim(), _selectedMood);
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
      decoration: BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
            controller: _messageController,
            maxLines: 4,
            style: const TextStyle(color: ColorName.whiteColor),
            decoration: InputDecoration(
              hintText: StringsEnum.writeYourFeelingsHere.value,
              hintStyle: const TextStyle(color: ColorName.loginGreyTextColor),
              filled: true,
              fillColor: ColorName.scaffoldBackgroundColor,
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
            child: ElevatedButton.icon(
              onPressed: _handleSend,
              icon: const Icon(Icons.send),
              label: GeneralTextWidget(
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
