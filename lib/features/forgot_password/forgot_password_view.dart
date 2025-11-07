import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/features/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/log_in_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/inputs/input_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/validators/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ForgotPasswordViewModel {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setupListeners();
    return Scaffold(
      appBar: LogInAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.paddingInstance.generalHorizontalPadding,
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Forgot Password title
                GeneralTextWidget(
                  color: ColorName.whiteColor,
                  size: TextSizesEnum.googleSize.value,
                  text: StringsEnum.forgotPassword.value,
                ),

                // Description text
                Padding(
                  padding: Paddings.paddingInstance.loginVerticalPadding,
                  child: GeneralTextWidget(
                    color: ColorName.loginGreyTextColor,
                    size: TextSizesEnum.generalSize.value,
                    text: StringsEnum.forgotPasswordDescription.value,
                  ),
                ),

                // Email address text
                Padding(
                  padding: Paddings.paddingInstance.loginVerticalPadding,
                  child: GeneralTextWidget(
                    color: ColorName.loginGreyTextColor,
                    size: TextSizesEnum.generalSize.value,
                    text: StringsEnum.emailAddress.value,
                  ),
                ),

                // Email address input
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

                // Send button
                Padding(
                  padding: Paddings.paddingInstance.splashButtonVerticalPadding,
                  child: GlobalElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // TODO: Send password reset email
                        sendPasswordResetEmail();
                      }
                    },
                    text: StringsEnum.send.value,
                    loading: loadingWatch(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
