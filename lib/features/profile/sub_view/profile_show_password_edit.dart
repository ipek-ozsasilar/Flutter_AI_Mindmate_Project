part of '../profile_view.dart';

class _ProfileShowPasswordEdit {
  Future<void> _showEditPasswordDialog(
    BuildContext context,
    Future<bool> Function(String currentPassword, String newPassword)
    updatePassword,
    WidgetRef ref,
  ) async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      barrierDismissible:
          true, // true: kullanıcı dışarı tıklarsa kapanır (email ile aynı)
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          String? currentPasswordError;
          String? newPasswordError;

          return AlertDialog(
            backgroundColor: ColorName.scaffoldBackgroundColor,
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            title: GeneralTextWidget(
              color: ColorName.whiteColor,
              size: TextSizesEnum.appTitleSize.value,
              text: StringsEnum.editPassword.value,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
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
                        controller: newPasswordController,
                        obscureText: true,
                        hintText: StringsEnum.newPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: IconConstants.iconConstants.lockIcon,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        validator: (value) {
                          if (newPasswordError != null) {
                            return newPasswordError;
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
                    newPasswordError = null;
                  });

                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final String currentPassword = currentPasswordController.text
                      .trim();
                  final String newPassword = newPasswordController.text.trim();

                  try {
                    final bool ok = await updatePassword(
                      currentPassword,
                      newPassword,
                    );

                    if (ok) {
                      Navigator.pop(dialogContext); // ✅ dialog kapanır
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringsEnum.passwordUpdated.value),
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
                            ErrorStringsEnum.weakPasswordError.value) {
                          setState(() {
                            newPasswordError = errorMessage;
                          });
                        } else {
                          setState(() {
                            newPasswordError = errorMessage;
                          });
                        }
                        formKey.currentState!.validate();
                      }
                    }
                  } catch (e, stackTrace) {
                    Logger().e(
                      'updatePassword dialog error',
                      error: e,
                      stackTrace: stackTrace,
                    );
                    setState(() {
                      newPasswordError = ErrorStringsEnum.unexpectedError.value;
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
