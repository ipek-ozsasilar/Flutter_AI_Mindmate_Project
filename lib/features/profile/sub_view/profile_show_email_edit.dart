part of '../profile_view.dart';

class _ProfileShowEmailEdit {
  Future<void> _showEditEmailDialog(
    BuildContext context,
    Future<bool> Function(String currentPassword, String newEmail) updateEmail,
    WidgetRef ref,
  ) async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newEmailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      barrierDismissible: true, // dışarı tıklayınca kapanmasın
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          String? currentPasswordError;
          String? newEmailError;

          return AlertDialog(
            backgroundColor: ColorName.scaffoldBackgroundColor,
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            title: GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.appTitleSize.value,
              text: StringsEnum.editEmail.value,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 70,
                      child: InputWidget(
                        controller: currentPasswordController,
                        obscureText: true,
                        hintText: StringsEnum.currentPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: IconConstants.iconConstants.lockIcon,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        validator: (value) {
                          if (currentPasswordError != null) {
                            return currentPasswordError;
                          }
                          return Validators.validatorsInstance.validatePassword(
                            value,
                          );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            Validators.validatorsInstance.passwordLength,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 70,
                      child: InputWidget(
                        controller: newEmailController,
                        obscureText: false,
                        hintText: StringsEnum.newEmail.value,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon:
                            IconConstants.iconConstants.emailInsideEmpty,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        validator: (value) {
                          if (newEmailError != null) {
                            return newEmailError;
                          }
                          return Validators.validatorsInstance.validateEmail(
                            value,
                          );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            Validators.validatorsInstance.emailRegex,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            actions: [
              GlobalTextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                text: StringsEnum.cancel.value,
                textColor: ColorName.whiteColor,
              ),
              const SizedBox(width: 24),
              GlobalTextButton(
                text: StringsEnum.save.value,
                textColor: ColorName.whiteColor,
                onPressed: () async {
                  setState(() {
                    currentPasswordError = null;
                    newEmailError = null;
                  });

                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final String currentPassword = currentPasswordController.text
                      .trim();
                  final String newEmail = newEmailController.text.trim();

                  try {
                    final bool ok = await updateEmail(
                      currentPassword,
                      newEmail,
                    );
                    if (ok) {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringsEnum.emailUpdated.value),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      // Provider'dan gelen hataları kontrol et
                      final errorMessage = ref
                          .read(profileProvider)
                          .errorMessage;
                      if (errorMessage != null && errorMessage.isNotEmpty) {
                        if (errorMessage ==
                                ErrorStringsEnum.wrongPasswordError.value ||
                            errorMessage ==
                                ErrorStringsEnum.invalidCredentialError.value) {
                          setState(() {
                            currentPasswordError = errorMessage;
                          });
                        } else if (errorMessage ==
                                ErrorStringsEnum.emailAlreadyInUseError.value ||
                            errorMessage ==
                                ErrorStringsEnum
                                    .invalidEmailFormatError
                                    .value) {
                          setState(() {
                            newEmailError = errorMessage;
                          });
                        } else {
                          setState(() {
                            newEmailError = errorMessage;
                          });
                        }
                        formKey.currentState!.validate();
                      }
                    }
                  } catch (e, stackTrace) {
                    Logger().e(
                      'updateEmail dialog error',
                      error: e,
                      stackTrace: stackTrace,
                    );
                    setState(() {
                      newEmailError = ErrorStringsEnum.unexpectedError.value;
                    });
                    formKey.currentState!.validate();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
