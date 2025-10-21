import 'package:flutter/material.dart';

@immutable
class Paddings {
  const Paddings._();
  EdgeInsets get dailyHistoryCardPadding =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
  static const paddingInstance = Paddings._();
  EdgeInsets get widgetsBetweenSpace => const EdgeInsets.only(right: 10);
  EdgeInsets get progressViewDateRangeButtonPadding =>
      EdgeInsets.only(right: 16);
  EdgeInsets get generalHorizontalPadding =>
      const EdgeInsets.symmetric(horizontal: 25);
  EdgeInsets get splashImageVerticalPadding =>
      const EdgeInsets.symmetric(vertical: 30);
  EdgeInsets get splashButtonVerticalPadding =>
      const EdgeInsets.symmetric(vertical: 40);
  EdgeInsets get splashAppbarLeadingLeftPadding =>
      const EdgeInsets.only(left: 25);
  EdgeInsets get loginVerticalPadding =>
      const EdgeInsets.symmetric(vertical: 20);
  EdgeInsets get loginPasswordVerticalPadding =>
      const EdgeInsets.only(top: 25, bottom: 20);
  EdgeInsets get loginForgotPasswordTopPadding =>
      const EdgeInsets.only(top: 10);
  EdgeInsets get loginTextAndSignUpVerticalPadding =>
      const EdgeInsets.symmetric(vertical: 20);
  EdgeInsets get orContinueWithHorizontalPadding =>
      const EdgeInsets.symmetric(horizontal: 8);
  EdgeInsets get chatHistoryWidgetAllPadding => const EdgeInsets.all(16);
  EdgeInsets get chatHistoryWidgetMargin => const EdgeInsets.only(bottom: 12);
  EdgeInsets get emptyHistoryWidgetPadding => const EdgeInsets.only(bottom: 20);
  EdgeInsets get profileMenuItemPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  EdgeInsets get profileImagePickerTopAndBottomPadding =>
      const EdgeInsets.only(top: 20, bottom: 30);
  EdgeInsets get progressViewTitleTopPadding => const EdgeInsets.only(top: 20);
  EdgeInsets get progressViewDateRangeButtonContainerPadding =>
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      EdgeInsets get progressViewMoodLegendItemVerticalPadding => const EdgeInsets.symmetric(vertical: 10);  
      EdgeInsets get notificationsViewTitlePadding => const EdgeInsets.only(top: 20,bottom: 10);
      EdgeInsets get notificationsViewDescriptionPadding => const EdgeInsets.symmetric(horizontal: 50);
       EdgeInsets get notificationsItemTimePadding => const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
       EdgeInsets get notificationsItemBottomPadding => const EdgeInsets.only(bottom: 5);
}
