import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/splash_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/elevated_button_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //splash appbar
      appBar: SplashAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Center(
          child: Column(
            children: [
              //splash image
              Padding(
                padding: Paddings.paddingInstance.splashImageVerticalPadding,
                child: _SplashContainerImage(),
              ),
              //splash ekranındaki title
              RichtTextWidget(
                firstText: StringsEnum.splashTitle.value,
                secondText: StringsEnum.mindmate.value,
                textSize: TextSizesEnum.splashTitleSize.value,
              ),

              //lets start button
              Expanded(
                child: Padding(
                  padding: Paddings.paddingInstance.splashButtonVerticalPadding,
                  child: ElevatedButtonWidget(onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //splash ekranındaki image başka bir sayfada kullanılmayacağı için method larak yazdık
  Stack _SplashContainerImage() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: WidgetSizesEnum.splashImageContainerHeight.value,
          color: ColorName.whiteColor,
          child: Assets.images.mindmateSplash.image(),
        ),
      ],
    );
  }
}
