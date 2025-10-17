import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';

class GlobalIconButton extends StatelessWidget {
  final IconData icon;
  const GlobalIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: GlobalIcon(icon, ColorName.whiteColor),
    );
  }
}
