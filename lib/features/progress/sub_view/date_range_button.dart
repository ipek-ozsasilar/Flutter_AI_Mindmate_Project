part of '../progress_view.dart';

class _DateRangeButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateRangeButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Paddings
            .paddingInstance
            .progressViewDateRangeButtonContainerPadding,
        decoration: _DateRangeButtonContainerDecoration(),
        child: GeneralTextWidget(
          text: text,
          color: isSelected
              ? ColorName.blackColor
              : ColorName.loginGreyTextColor,
          size: TextSizesEnum.generalSize.value,
        ),
      ),
    );
  }

  BoxDecoration _DateRangeButtonContainerDecoration() {
    return BoxDecoration(
      color: isSelected ? ColorName.yellowColor : ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.smallBorderRadius.value,
      ),
    );
  }
}
