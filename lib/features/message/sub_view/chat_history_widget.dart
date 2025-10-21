part of '../message_view.dart';
//kod cleanlesştirilecek
class _ChatHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> conversations;

  const _ChatHistoryWidget({required this.conversations});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: conversations.isEmpty
          ? _EmptyStateWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: Paddings.paddingInstance.generalHorizontalPadding,
                  child: GeneralTextWidget(
                    color: ColorName.whiteColor,
                    size: TextSizesEnum.appTitleSize.value,
                    text: StringsEnum.todaysConversations.value,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return _ChatCard(conversation: conversations[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final Map<String, dynamic> conversation;

  const _ChatCard({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorName.loginInputColor,
        borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    conversation['mood'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    conversation['period'],
                    style: TextStyle(
                      color: ColorName.loginGreyTextColor,
                      fontSize: TextSizesEnum.subtitleSize.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                conversation['time'],
                style: TextStyle(
                  color: ColorName.loginGreyTextColor,
                  fontSize: TextSizesEnum.chatTimeSize.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            conversation['userMessage'],
            style: TextStyle(
              color: ColorName.whiteColor,
              fontSize: TextSizesEnum.subtitleSize.value,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorName.scaffoldBackgroundColor,
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
                    conversation['aiResponse'],
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

class _EmptyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: ColorName.loginInputColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 50,
              color: ColorName.loginGreyTextColor,
            ),
          ),
          const SizedBox(height: 20),
          GeneralTextWidget(
            color: ColorName.whiteColor,
            size: TextSizesEnum.generalSize.value,
            text: StringsEnum.noChatsYet.value,
          ),
          const SizedBox(height: 8),
          Text(
            StringsEnum.startYourFirstChat.value,
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
