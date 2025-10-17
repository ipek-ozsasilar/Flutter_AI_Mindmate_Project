import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/log_in_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_outlined_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/inputs/input_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/rows/or_continue_with_rows.dart';
import 'package:flutter_mindmate_project/products/widgets/rows/text_and_sign_up_log_in_rows.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/validators/validators.dart';

class CreateAccountView extends StatefulWidget {
  CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {

  final Alignment alignment = Alignment.centerRight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Login appbar
      appBar: LogInAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: ListView(
          children: [
            GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.googleSize.value,
              text: StringsEnum.createYourAccount.value,
            ),
            //email address text
            Padding(
              padding: Paddings.paddingInstance.loginVerticalPadding,
              child: GeneralTextWidget(
                color: ColorName.loginGreyTextColor,
                size: TextSizesEnum.generalSize.value,
                text: StringsEnum.fullName.value,
              ),
            ),
            //full name input
            InputWidget(
              hintText: StringsEnum.fullName.value,
              prefixIcon: IconConstants.iconConstants.personIcon,
              keyboardType: TextInputType.name,
            ),

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
            ),
            //forgot password text button
            Padding(
              padding: Paddings.paddingInstance.loginForgotPasswordTopPadding,
              child: TextAndSignUpLogInRowWidget(
                firstText: StringsEnum.privacyPolicyFirstPart.value,
                secondText: StringsEnum.privacyPolicySecondPart.value,
                wrapAlignment: WrapAlignment.start,
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
              firstText: StringsEnum.alreadyHaveAnAccount.value,
              secondText: StringsEnum.logIn.value,
            ),
          ],
        ),
      ),
    );
  }
}
