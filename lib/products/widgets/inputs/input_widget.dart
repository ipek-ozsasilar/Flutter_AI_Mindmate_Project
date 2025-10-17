import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool filled = true;
  InputWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.inputFormatters,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (value) =>
          value!.isEmpty ? StringsEnum.emailAddress.value : null,
      decoration: InputDecoration(
        hintText: StringsEnum.emailAddress.value,
        hintStyle: TextStyle(color: ColorName.loginGreyTextColor),
        filled: filled,
        fillColor: ColorName.loginInputColor,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: GlobalIconButton(icon: prefixIcon),
        suffixIcon: suffixIcon != null
            ? GlobalIconButton(icon: suffixIcon!)
            : null,
      ),
    );
  }
}
