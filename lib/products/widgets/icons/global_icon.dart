import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';

Icon GlobalIcon(
  IconData icon,
  {
  Color? iconColor = ColorName.whiteColor,
  double? iconSize = 25,
}) {
  return Icon(icon, color: iconColor, size: iconSize);
}
