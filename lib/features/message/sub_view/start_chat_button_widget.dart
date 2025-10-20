part of '../message_view.dart';

class _StartChatButtonWidget extends StatelessWidget {
  final bool hasReachedLimit;
  final VoidCallback onStartChat;

  const _StartChatButtonWidget({
    required this.hasReachedLimit,
    required this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: !hasReachedLimit
          ? SizedBox(
              width: double.infinity,
              height: WidgetSizesEnum.elevatedButtonHeight.value,
              child: ElevatedButton.icon(
                onPressed: onStartChat,
                icon: const Icon(Icons.add_circle_outline),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule,
            color: ColorName.loginGreyTextColor,
            size: 40,
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
