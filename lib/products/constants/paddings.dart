import 'package:flutter/material.dart';

@immutable
class Paddings {
  const Paddings._();
  static const paddingInstance = Paddings._();
  EdgeInsets get generalHorizontalPadding => const EdgeInsets.symmetric(horizontal: 25);
  EdgeInsets get splashImageVerticalPadding => const EdgeInsets.symmetric(vertical: 30);
  EdgeInsets get splashButtonVerticalPadding => const EdgeInsets.symmetric(vertical: 40);
  EdgeInsets get splashAppbarLeadingLeftPadding => const EdgeInsets.only(left: 25);
}
