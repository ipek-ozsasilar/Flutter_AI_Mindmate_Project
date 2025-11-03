part of '../create_chat_view.dart';

class _StartChatWidget extends StatelessWidget {
  const _StartChatWidget();
  final double borderSideWidth = 2;
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizesEnum.startChatContainerHeight.value,
      width: WidgetSizesEnum.startChatContainerWidth.value,
      decoration: StartChatContainerDecoration(),
      child: InkWell(
        onTap: () {
          context.navigateTo(const MessageView());
        },
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            GlobalIcon(
              IconConstants.iconConstants.addIcon,
              iconColor: ColorName.whiteColor,
            ),
            GeneralTextWidget(
              text: StringsEnum.startChat.value,
              size: TextSizesEnum.generalSize.value,
              color: ColorName.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration StartChatContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginGreyTextColor,
      shape: BoxShape.rectangle,
      border: Border.all(color: ColorName.whiteColor, width: borderSideWidth),
    );
  }
}
