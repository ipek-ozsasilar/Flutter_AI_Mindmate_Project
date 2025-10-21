part of '../progress_view.dart';

class _MoodLegendWidget extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  const _MoodLegendWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _ProgressMoodContainerDecoration(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Padding(
            padding: Paddings.paddingInstance.emptyHistoryWidgetPadding,
            child: GeneralTextWidget(
              text: StringsEnum.moodExplanation.value,
              color: ColorName.whiteColor,
              size: TextSizesEnum.generalSize.value,
            ),
          ),

          _EmojiItem(
            emoji: Assets.icons.verySadEmoji.image(),
            label: StringsEnum.verySadLabel.value,
            color: ColorName.moodVerySadColor,
          ),

          Padding(
            padding: Paddings
                .paddingInstance
                .progressViewMoodLegendItemVerticalPadding,
            child: _EmojiItem(
              emoji: Assets.icons.sadEmoji.image(),
              label: StringsEnum.sadLabel.value,
              color: ColorName.moodSadColor,
            ),
          ),

          _EmojiItem(
            emoji: Assets.icons.neutralEmoji.image(),
            label: StringsEnum.neutralLabel.value,
            color: ColorName.moodNeutralColor,
          ),

          Padding(
            padding: Paddings
                .paddingInstance
                .progressViewMoodLegendItemVerticalPadding,
            child: _EmojiItem(
              emoji: Assets.icons.happyEmoji.image(),
              label: StringsEnum.happyLabel.value,
              color: ColorName.moodHappyColor,
            ),
          ),

          _EmojiItem(
            emoji: Assets.icons.veryHappyEmoji.image(),
            label: StringsEnum.veryHappyLabel.value,
            color: ColorName.moodVeryHappyColor,
          ),
        ],
      ),
    );
  }

  BoxDecoration _ProgressMoodContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
    );
  }
}

class _EmojiItem extends StatelessWidget {
  final Widget emoji;
  final String label;
  final Color color;

  const _EmojiItem({
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: Paddings.paddingInstance.widgetsBetweenSpace,
          child: Container(
            width: WidgetSizesEnum.progressEmojiItemContainerSize.value,
            height: WidgetSizesEnum.progressEmojiItemContainerSize.value,
            decoration: _ProgressEmojiContainerDecoration(),
            child: Center(child: emoji),
          ),
        ),

        Expanded(
          child: GeneralTextWidget(
            text: label,
            color: ColorName.loginGreyTextColor,
            size: TextSizesEnum.generalSize.value,
          ),
        ),
        Container(
          width: WidgetSizesEnum.progressEmojiStatusCircleSize.value,
          height: WidgetSizesEnum.progressEmojiStatusCircleSize.value,
          decoration: _MoodStatusCircleDecoration(),
        ),
      ],
    );
  }

  BoxDecoration _MoodStatusCircleDecoration() =>
      BoxDecoration(color: color, shape: BoxShape.circle);

  BoxDecoration _ProgressEmojiContainerDecoration() {
    final Color? progressEmojiContainerColor = color.withOpacity(0.2);
    return BoxDecoration(
      color: progressEmojiContainerColor,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.smallBorderRadius.value,
      ),
    );
  }
}
