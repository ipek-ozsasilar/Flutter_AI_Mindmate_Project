part of '../history_view.dart';

class _DailyHistoryCardWidget extends StatelessWidget {
  final String date;
  final bool isToday;
  final List<Map<String, dynamic>> dayChats;
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;
  final Color? color = ColorName.yellowColor.withOpacity(0.2);
  final double width = 1;

  _DailyHistoryCardWidget({
    required this.date,
    required this.isToday,
    required this.dayChats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Paddings.paddingInstance.chatHistoryWidgetMargin,
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _ContainerDecoration(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          // Date header
          Padding(
            padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                GeneralTextWidget(
                  color: ColorName.whiteColor,
                  size: TextSizesEnum.appTitleSize.value,
                  text: date,
                ),
                Container(
                  padding: Paddings.paddingInstance.dailyHistoryCardPadding,
                  decoration: BoxDecoration(
                    color: isToday ? color : ColorName.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(
                      WidgetSizesEnum.smallBorderRadius.value,
                    ),
                    border: isToday
                        ? Border.all(color: ColorName.yellowColor, width: width)
                        : null,
                  ),
                  child: GeneralTextWidget(
                    text: isToday
                        ? StringsEnum.today.value
                        : '${dayChats.length} ${StringsEnum.chats.value}',
                    color: isToday
                        ? ColorName.yellowColor
                        : ColorName.loginGreyTextColor,
                    size: TextSizesEnum.subtitleSize.value,
                  ),
                ),
              ],
            ),
          ),

          // Chats list
          ...dayChats.asMap().entries.map((entry) {
            final int index = entry.key;
            final Map<String, dynamic> chat = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < dayChats.length - 1 ? 12 : 0,
              ),
              child: _HistoryChatItemWidget(chat: chat),
            );
          }),
        ],
      ),
    );
  }

  BoxDecoration _ContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
    );
  }
}
