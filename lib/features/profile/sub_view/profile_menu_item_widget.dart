part of '../profile_view.dart';

class _ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isEditable;
  final bool isExpandable;
  final VoidCallback? onTap;

  const _ProfileMenuItemWidget({
    required this.icon,
    required this.text,
    this.isEditable = false,
    this.isExpandable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Paddings.paddingInstance.chatHistoryWidgetMargin ,
      padding: Paddings.paddingInstance.profileMenuItemPadding,
      decoration: _ContainerDecoration(),
      child: Row(
          children: [
            Padding(
              padding: Paddings.paddingInstance.widgetsBetweenSpace  ,
              child: GlobalIcon(icon, iconColor: ColorName.loginGreyTextColor),
            ),
            
            Expanded(
              child: GeneralTextWidget(
                text: text,
                color: ColorName.loginGreyTextColor,
                size: TextSizesEnum.generalSize.value,
              ),
            ),

            if (isEditable)
              GlobalIconButton(icon: IconConstants.iconConstants.editIcon, onPressed: () {}),
            if (isExpandable)
              GlobalIconButton(icon: IconConstants.iconConstants.arrowDownIcon, onPressed: () {}),
        ],
      ),
    );
  }

  BoxDecoration _ContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.smallBorderRadius.value),
    );
  }
}
