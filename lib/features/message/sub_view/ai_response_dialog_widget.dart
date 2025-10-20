part of '../message_view.dart';

class _AiResponseDialogWidget extends StatelessWidget {
  final String userMessage;
  final String aiResponse;
  final VoidCallback onClose;

  const _AiResponseDialogWidget({
    required this.userMessage,
    required this.aiResponse,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorName.loginInputColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: ColorName.yellowColor,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GeneralTextWidget(
                    color: ColorName.whiteColor,
                    size: TextSizesEnum.appTitleSize.value,
                    text: StringsEnum.chatCompleted.value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              StringsEnum.thankYouForSharing.value,
              style: TextStyle(
                color: ColorName.loginGreyTextColor,
                fontSize: TextSizesEnum.subtitleSize.value,
              ),
            ),
            const SizedBox(height: 16),
            // User message
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorName.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Senin mesajın:',
                    style: TextStyle(
                      color: ColorName.loginGreyTextColor,
                      fontSize: TextSizesEnum.chatTimeSize.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userMessage,
                    style: TextStyle(
                      color: ColorName.whiteColor,
                      fontSize: TextSizesEnum.subtitleSize.value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // AI response
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorName.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.psychology,
                    color: ColorName.yellowColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringsEnum.aiResponse.value,
                          style: TextStyle(
                            color: ColorName.loginGreyTextColor,
                            fontSize: TextSizesEnum.chatTimeSize.value,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          aiResponse,
                          style: TextStyle(
                            color: ColorName.whiteColor,
                            fontSize: TextSizesEnum.subtitleSize.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: WidgetSizesEnum.elevatedButtonHeight.value,
              child: ElevatedButton(
                onPressed: onClose,
                child: GeneralTextWidget(
                  color: ColorName.blackColor,
                  size: TextSizesEnum.generalSize.value,
                  text: 'Tamam',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
