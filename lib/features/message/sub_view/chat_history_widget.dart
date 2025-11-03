part of '../message_view.dart';

class _ChatHistoryWidget extends StatelessWidget {
  final List<MessageModel> messages;
  final bool isSendingMessage;

  const _ChatHistoryWidget({
    required this.messages,
    required this.isSendingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: messages.isEmpty
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      // Sadece en son eklenen mesaj (son index) için loading göster
                      // VE o mesajın AI response'u henüz yoksa
                      final bool isLastMessage = index == messages.length - 1;
                      final bool shouldShowLoading =
                          isLastMessage &&
                          isSendingMessage &&
                          (messages[index].aiResponse == null ||
                              messages[index].aiResponse!.isEmpty);

                      return _ChatCard(
                        message: messages[index],
                        isLoading: shouldShowLoading,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _ChatCard extends StatelessWidget {
  final MessageModel message;
  final bool isLoading;

  const _ChatCard({required this.message, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final bool hasAiResponse =
        message.aiResponse != null && message.aiResponse!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
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
                    message.emoji ?? '',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    message.period ?? '',
                    style: TextStyle(
                      color: ColorName.loginGreyTextColor,
                      fontSize: TextSizesEnum.subtitleSize.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                message.time ?? '',
                style: TextStyle(
                  color: ColorName.loginGreyTextColor,
                  fontSize: TextSizesEnum.chatTimeSize.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            message.userMessage ?? '',
            style: TextStyle(
              color: ColorName.whiteColor,
              fontSize: TextSizesEnum.subtitleSize.value,
            ),
          ),
          const SizedBox(height: 8),
          // AI Response veya Loading
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorName.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: hasAiResponse
                ? Row(
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
                          message.aiResponse ?? '',
                          style: TextStyle(
                            color: ColorName.loginGreyTextColor,
                            fontSize: TextSizesEnum.chatTimeSize.value,
                          ),
                        ),
                      ),
                    ],
                  )
                : isLoading
                ? Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorName.yellowColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        StringsEnum.aiIsThinking.value,
                        style: TextStyle(
                          color: ColorName.loginGreyTextColor,
                          fontSize: TextSizesEnum.chatTimeSize.value,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(), // AI response yoksa ve loading değilse boş göster
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
