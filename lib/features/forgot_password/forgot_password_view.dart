import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/log_in_appbar.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/mixins/scaffold_message.dart';
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

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView>
    with ScaffoldMessage {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogInAppbar(),
      body: Padding(
        padding: Paddings.paddingInstance.generalHorizontalPadding,
        child: Form(
          key: _formKey,
          child: ListView(
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
                  text:
                      'Enter your email address, we will send you a password reset link',
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
                controller: _emailController,
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
                      showSnackBar(
                        ErrorStringsEnum.passwordResetEmailSent.value,
                      );
                    }
                  },
                  text: StringsEnum.send.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
