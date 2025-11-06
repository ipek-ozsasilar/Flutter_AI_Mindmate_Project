import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/features/forgot_password/forgot_password_view.dart';
import 'package:flutter_mindmate_project/features/login/create_account_view.dart';
import 'package:flutter_mindmate_project/features/login/view_model/login_view_model.dart';
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
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/validators/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends LoginViewModel {
  final Alignment alignment = Alignment.centerRight;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Listener'ı build içinde kur (SADECE BURADA ÇAĞRILMALI)
    setupListeners();

    return Scaffold(
      //Login appbar
      appBar: LogInAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Form(
          key: _formKey,
          child: ListView(
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
                controller: readEmailController(),
                hintText: StringsEnum.demoEmail.value,
                prefixIcon: IconConstants.iconConstants.emailIcon,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    Validators.validatorsInstance.emailRegex,
                  ),
                ],
                validator: Validators.validatorsInstance.validateEmail,
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
                controller: readPasswordController(),
                hintText: StringsEnum.password.value,
                prefixIcon: IconConstants.iconConstants.lockIcon,
                suffixIcon: IconConstants.iconConstants.visibilityIcon,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    Validators.validatorsInstance.passwordLength,
                  ), // Max 6 karakter
                ],
                validator: Validators.validatorsInstance.validatePassword,
                obscureText: watchPasswordObscure(),
                onSuffixIconPressed: togglePasswordVisibility,
              ),
              //forgot password text button
              Padding(
                padding: Paddings.paddingInstance.loginForgotPasswordTopPadding,
                child: Align(
                  alignment: alignment,
                  child: GlobalTextButton(
                    text: StringsEnum.forgotPassword.value,
                    textColor: ColorName.loginGreyTextColor,
                    onPressed: () {
                      context.navigateTo(const ForgotPasswordView());
                      //Başka bir sayfaya geçildiğinde email ve password'u temizle
                      clearEmailAndPassword();
                    },
                  ),
                ),
              ),

              Padding(
                padding: Paddings.paddingInstance.splashButtonVerticalPadding,
                child: GlobalElevatedButton(
                  onPressed: () async {
                    // Form validate et
                    if (_formKey.currentState?.validate() ?? false) {
                      // Login işlemini başlat ve başarılıysa başka bir sayfaya geç
                      await loginUser();
                    }
                  },
                  text: StringsEnum.logIn.value,
                  loading: loadingWatch(),
                ),
              ),

              OrContinueWithRow(),

              Padding(
                padding:
                    Paddings.paddingInstance.loginTextAndSignUpVerticalPadding,
                child: GlobalOutlinedIconButton(
                  onPressed: () async {
                    await googleLogin();
                  },
                ),
              ),

              TextAndSignUpLogInRowWidget(
                firstText: StringsEnum.dontHaveAnAccount.value,
                secondText: StringsEnum.signUp.value,
                onPressed: () {
                  context.navigateTo(const CreateAccountView());
                  //Başka bir sayfaya geçildiğinde email ve password'u temizle
                  clearEmailAndPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
