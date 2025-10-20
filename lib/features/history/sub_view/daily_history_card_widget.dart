part of '../history_view.dart';

class _DailyHistoryCardWidget extends StatelessWidget {
  final String date;
  final bool isToday;
  final List<Map<String, dynamic>> dayChats;

  const _DailyHistoryCardWidget({
    required this.date,
    required this.isToday,
    required this.dayChats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralTextWidget(
                color: ColorName.whiteColor,
                size: TextSizesEnum.appTitleSize.value,
                text: date,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isToday
                      ? ColorName.yellowColor.withOpacity(0.2)
                      : ColorName.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: isToday
                      ? Border.all(color: ColorName.yellowColor, width: 1)
                      : null,
                ),
                child: Text(
                  isToday
                      ? StringsEnum.today.value
                      : '${dayChats.length} ${StringsEnum.chats.value}',
                  style: TextStyle(
                    color: isToday
                        ? ColorName.yellowColor
                        : ColorName.loginGreyTextColor,
                    fontSize: TextSizesEnum.chatTimeSize.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
}
