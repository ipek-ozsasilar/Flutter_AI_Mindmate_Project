import 'package:flutter/material.dart';

@immutable
class Paddings {
  const Paddings._();
  EdgeInsets get dailyHistoryCardPadding =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
  static const paddingInstance = Paddings._();
  EdgeInsets get widgetsBetweenSpace => const EdgeInsets.only(right: 10);
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
  EdgeInsets get profileImagePickerTopAndBottomPadding => const EdgeInsets.only(top: 20,bottom: 30);
}
