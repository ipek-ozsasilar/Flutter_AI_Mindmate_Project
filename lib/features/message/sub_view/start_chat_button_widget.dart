part of '../message_view.dart';

class _StartChatButtonWidget extends StatelessWidget {
  final bool hasReachedLimit;
  final bool isLoading;
  final Function(String userMessage, String mood) onSendMessage;

  const _StartChatButtonWidget({
    required this.hasReachedLimit,
    required this.isLoading,
    required this.onSendMessage,
  });

  void _openChatInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ChatInputBottomSheetWidget(
        isLoading: isLoading,
        onSendMessage:
            onSendMessage, // Parent'tan gelen callback'i ileterek gönder
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      child: !hasReachedLimit
          ? SizedBox(
              width: double.infinity,
              height: WidgetSizesEnum.elevatedButtonHeight.value,
              child: ElevatedButton.icon(
                onPressed: () => _openChatInputModal(context),
                icon: GlobalIcon(IconConstants.iconConstants.addIcon),
                label: GeneralTextWidget(
                  color: ColorName.blackColor,
                  size: TextSizesEnum.generalSize.value,
                  text: StringsEnum.shareYourFeelings.value,
                ),
              ),
            )
          : _LimitReachedWidget(),
    );
  }
}

class _LimitReachedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlobalIcon(
            IconConstants.iconConstants.scheduleIcon,
            iconColor: ColorName.loginGreyTextColor,
            iconSize: IconSizesEnum.limitReachedIconSize.value,
          ),
          const SizedBox(height: 8),
          GeneralTextWidget(
            color: ColorName.whiteColor,
            size: TextSizesEnum.generalSize.value,
            text: StringsEnum.dailyLimitReached.value,
          ),
          const SizedBox(height: 4),
          Text(
            StringsEnum.comeBackTomorrow.value,
            style: TextStyle(
              color: ColorName.loginGreyTextColor,
              fontSize: TextSizesEnum.subtitleSize.value,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
