import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  final String time;
  final String title;
  final String message;
  final bool isRead;
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  const NotificationItemWidget({
    required this.time,
    required this.title,
    required this.message,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _CalenderContainerDecoration(),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          // Saat ve okundu işareti
          Padding(
            padding: Paddings.paddingInstance.widgetsBetweenSpace,
            child: Column(
              children: [
                Padding(
                  padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
                  child: Container(
                    padding:
                        Paddings.paddingInstance.notificationsItemTimePadding,
                    decoration: _NotificationItemTimeDecoration(),
                    child: GeneralTextWidget(
                      text: time,
                      color: ColorName.yellowColor,
                      size: TextSizesEnum.chatTimeSize.value,
                    ),
                  ),
                ),

                if (!isRead)
                  Container(
                    width: WidgetSizesEnum.notificationReadDotSize.value,
                    height: WidgetSizesEnum.notificationReadDotSize.value,
                    decoration: _NotificationReadDotDecoration(),
                  ),
              ],
            ),
          ),

          // İçerik
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Padding(
                  padding: Paddings.paddingInstance.chatHistoryWidgetMargin,
                  child: GeneralTextWidget(
                    text: title,
                    color: isRead
                        ? ColorName.loginGreyTextColor
                        : ColorName.whiteColor,
                    size: TextSizesEnum.generalSize.value,
                  ),
                ),

                GeneralTextWidget(
                  text: message,
                  color: ColorName.loginGreyTextColor,
                  size: TextSizesEnum.subtitleSize.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _NotificationReadDotDecoration() {
    return const BoxDecoration(
      color: ColorName.yellowColor,
      shape: BoxShape.circle,
    );
  }

  BoxDecoration _CalenderContainerDecoration() {
    double borderWidth = 1;
    Color borderColor = ColorName.loginGreyTextColor.withOpacity(0.1);

    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: borderColor, width: borderWidth),
      ),
    );
  }

  BoxDecoration _NotificationItemTimeDecoration() {
    Color color = ColorName.yellowColor.withOpacity(0.2);
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(
        WidgetSizesEnum.notificationReadDotSize.value,
      ),
    );
  }
}
