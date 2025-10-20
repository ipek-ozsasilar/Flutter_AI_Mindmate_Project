part of '../history_view.dart';

class _HistoryChatItemWidget extends StatelessWidget {
  final Map<String, dynamic> chat;

  const _HistoryChatItemWidget({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorName.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time and mood
          Row(
            children: [
              Text(chat['mood'], style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                chat['period'],
                style: TextStyle(
                  color: ColorName.loginGreyTextColor,
                  fontSize: TextSizesEnum.subtitleSize.value,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                chat['time'],
                style: TextStyle(
                  color: ColorName.loginGreyTextColor,
                  fontSize: TextSizesEnum.chatTimeSize.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // User message
          Text(
            chat['userMessage'],
            style: TextStyle(
              color: ColorName.whiteColor,
              fontSize: TextSizesEnum.subtitleSize.value,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
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
                const Icon(
                  Icons.psychology,
                  color: ColorName.yellowColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    chat['aiResponse'],
                    style: TextStyle(
                      color: ColorName.loginGreyTextColor,
                      fontSize: TextSizesEnum.chatTimeSize.value,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
