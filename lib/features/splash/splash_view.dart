import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/splash/view_model/splash_view_model.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/splash_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewModel {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Listener'ı build içinde kur (DOĞRU YER)
    setupListeners();

    return Scaffold(
      //splash appbar
      appBar: SplashAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1), // üst boşluk
            Expanded(
              flex: 5, // resim alanı
              child: _SplashContainerImage(),
            ),
            const Spacer(flex: 1), // küçük boşluk
            RichtTextWidget(
              firstText: StringsEnum.splashTitle.value,
              secondText: StringsEnum.mindmate.value,
              textSize: TextSizesEnum.splashTitleSize.value,
              isItalic: true,
            ),
            const Spacer(flex: 1),
            GlobalElevatedButton(
              onPressed: () async {
                await startChecks();
              },
              text: StringsEnum.startText.value,
            ),
            const Spacer(flex: 1), // altta biraz daha boşluk
          ],
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
          height: MediaQuery.of(context).size.height * 0.3,
          color: ColorName.whiteColor,
          child: Assets.images.mindmateSplash.image(),
        ),
      ],
    );
  }
}
