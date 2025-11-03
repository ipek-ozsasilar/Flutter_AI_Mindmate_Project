part of '../history_view.dart';

class _HistoryChatItemWidget extends StatelessWidget {
  final Map<String, dynamic> chat;
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

  const _HistoryChatItemWidget({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _ContainerDecoration(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          // Time and mood
          Padding(
            padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
            child: Row(
              children: [
                GeneralTextWidget(
                  color: ColorName.whiteColor,
                  size: TextSizesEnum.subtitleSize.value,
                  text: chat['emoji'] ?? '😊',
                ),
                const SizedBox(width: 8),
                GeneralTextWidget(
                  color: ColorName.loginGreyTextColor,
                  size: TextSizesEnum.subtitleSize.value,
                  text: chat['period'] ?? '',
                ),
                const Spacer(),
                GeneralTextWidget(
                  color: ColorName.loginGreyTextColor,
                  size: TextSizesEnum.chatTimeSize.value,
                  text: chat['time'] ?? '',
                ),
              ],
            ),
          ),

          // User message
          Padding(
            padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
            child: GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.subtitleSize.value,
              text: chat['userMessage'] ?? '',
            ),
          ),

          // AI response
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorName.loginInputColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 GlobalIcon(
                  IconConstants.iconConstants.psychologyIcon,
                  iconColor: ColorName.yellowColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GeneralTextWidget(
                    color: ColorName.loginGreyTextColor,
                    size: TextSizesEnum.chatTimeSize.value,
                    text: chat['aiResponse'] ?? '',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _ContainerDecoration() {
    return BoxDecoration(
      color: ColorName.scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.smallBorderRadius.value,
      ),
    );
  }
}
