import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/log_in_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_outlined_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_text_button.dart';
import 'package:flutter_mindmate_project/products/widgets/inputs/input_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/rows/or_continue_with_rows.dart';
import 'package:flutter_mindmate_project/products/widgets/rows/text_and_sign_up_log_in_rows.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/richt_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/validators/validators.dart';

class LogInView extends StatefulWidget {
  LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final Alignment alignment = Alignment.centerRight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Login appbar
      appBar: LogInAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //welcome back title
            GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.googleSize.value,
              text: StringsEnum.welcomeBack.value,
            ),
            //email address text
            Padding(
              padding: Paddings.paddingInstance.loginVerticalPadding,
              child: GeneralTextWidget(
                color: ColorName.loginGreyTextColor,
                size: TextSizesEnum.generalSize.value,
                text: StringsEnum.emailAddress.value,
              ),
            ),
            //email address input
            InputWidget(
              hintText: StringsEnum.demoEmail.value,
              prefixIcon: IconConstants.iconConstants.emailIcon,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  Validators.validatorsInstance.emailRegex,
                ),
              ],
            ),
            //password text
            Padding(
              padding: Paddings.paddingInstance.loginPasswordVerticalPadding,
              child: GeneralTextWidget(
                color: ColorName.loginGreyTextColor,
                size: TextSizesEnum.generalSize.value,
                text: StringsEnum.password.value,
              ),
            ),

            //password input
            InputWidget(
              hintText: StringsEnum.password.value,
              prefixIcon: IconConstants.iconConstants.lockIcon,
              suffixIcon: IconConstants.iconConstants.visibilityIcon,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            //forgot password text button
            Padding(
              padding:
                  Paddings.paddingInstance.loginForgotPasswordVerticalPadding,
              child: Align(
                alignment: alignment,
                child: GlobalTextButton(
                  text: StringsEnum.forgotPassword.value,
                  textColor: ColorName.loginGreyTextColor,
                ),
              ),
            ),

            Padding(
              padding: Paddings.paddingInstance.splashButtonVerticalPadding,
              child: GlobalElevatedButton(
                onPressed: () {},
                text: StringsEnum.logIn.value,
              ),
            ),

            OrContinueWithRow(),

            Padding(
              padding:
                  Paddings.paddingInstance.loginTextAndSignUpVerticalPadding,
              child: GlobalOutlinedIconButton(),
            ),

            TextAndSignUpLogInRowWidget(
              firstText: StringsEnum.dontHaveAnAccount.value,
              secondText: StringsEnum.signUp.value,
            ),
          ],
        ),
      ),
    );
  }
}
