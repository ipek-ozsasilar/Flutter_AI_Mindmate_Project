import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/splash_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with NavigationMixin {
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
                isItalic: true,
              ),

              //lets start button
              Expanded(
                child: Padding(
                  padding: Paddings.paddingInstance.splashButtonVerticalPadding,
                  child: GlobalElevatedButton(
                    onPressed: () {
                      navigateTo(LogInView());
                    },
                    text: StringsEnum.startText.value,
                  ),
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
