import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ScaffoldMessage<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: message,
        ),
      ),
    );
  }
}
