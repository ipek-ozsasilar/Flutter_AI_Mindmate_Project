part of '../history_view.dart';

class _EmptyHistoryWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
  final TextAlign textAlign = TextAlign.center;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Padding(
            padding: Paddings.paddingInstance.emptyHistoryWidgetPadding,
            child: Container(
              width: WidgetSizesEnum.historyCardContainerSizes.value,
              height: WidgetSizesEnum.historyCardContainerSizes.value,
              decoration: HistoryCardDecoration(),
              child: GlobalIcon(
                IconConstants.iconConstants.historyIcon,
                iconColor: ColorName.loginGreyTextColor,
              ),
            ),
          ),

          Padding(
            padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
            child: GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.generalSize.value,
              text: StringsEnum.noHistoryYet.value,
            ),
          ),

          Text(
            StringsEnum.startChattingToSeeHistory.value,
            style: TextStyle(
              color: ColorName.loginGreyTextColor,
              fontSize: TextSizesEnum.subtitleSize.value,
            ),
            textAlign: textAlign,
          ),
        ],
      ),
    );
  }

  BoxDecoration HistoryCardDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.limitIndicatorSize.value,
      ),
    );
  }
}
