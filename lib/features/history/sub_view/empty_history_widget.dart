part of '../history_view.dart';

class _EmptyHistoryWidget extends StatelessWidget {
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
              Icons.history,
              size: 50,
              color: ColorName.loginGreyTextColor,
            ),
          ),
          const SizedBox(height: 20),
          GeneralTextWidget(
            color: ColorName.whiteColor,
            size: TextSizesEnum.generalSize.value,
            text: StringsEnum.noHistoryYet.value,
          ),
          const SizedBox(height: 8),
          Text(
            StringsEnum.startChattingToSeeHistory.value,
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
