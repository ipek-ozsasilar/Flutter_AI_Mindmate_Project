import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool filled = true;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final OutlineInputBorder? borderNone = OutlineInputBorder(
    borderSide: BorderSide.none,
  );
  final OutlineInputBorder? borderError = OutlineInputBorder(
    borderSide: BorderSide(color: ColorName.redColor, width: 1),
  );
  InputWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.maxLength,
    this.onSuffixIconPressed,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLength: maxLength,
      style: const TextStyle(color: ColorName.whiteColor),
      cursorColor: ColorName.whiteColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorName.loginGreyTextColor),
        filled: filled,
        fillColor: ColorName.loginInputColor,
        border: borderNone,
        enabledBorder: borderNone,
        focusedBorder: borderNone,
        errorBorder: borderError,
        focusedErrorBorder: borderError,
        prefixIcon: GlobalIcon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? GlobalIconButton(
                icon: obscureText
                    ? suffixIcon!
                    : IconConstants.iconConstants.visibilityOffIcon,
                onPressed: () {
                  onSuffixIconPressed?.call();
                },
              )
            : null,
      ),
    );
  }
}
