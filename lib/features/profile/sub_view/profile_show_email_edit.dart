part of '../profile_view.dart';

class _ProfileShowEmailEdit {
  void _showValidationError(
    BuildContext context,
    String message, {
    Color backgroundColor = ColorName.redColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: message,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _showEditEmailDialog(
    BuildContext context,
    Future<bool> Function(String currentPassword, String newEmail) updateEmail,
  ) async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newEmailController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: true, // dışarı tıklayınca kapanmasın
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorName.scaffoldBackgroundColor,
        title: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: StringsEnum.editEmail.value,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputWidget(
              controller: currentPasswordController,
              obscureText: true,
              hintText: StringsEnum.currentPassword.value,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: IconConstants.iconConstants.lockIcon,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                  Validators.validatorsInstance.passwordLength,
                ),
              ],
            ),
            const SizedBox(height: 16),
            InputWidget(
              controller: newEmailController,
              obscureText: false,
              hintText: StringsEnum.newEmail.value,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: IconConstants.iconConstants.emailInsideEmpty,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  Validators.validatorsInstance.emailRegex,
                ),
              ],
            ),
          ],
        ),
        actions: [
          GlobalTextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            text: StringsEnum.cancel.value,
            textColor: ColorName.whiteColor,
          ),
          GlobalTextButton(
            text: StringsEnum.save.value,
            textColor: ColorName.whiteColor,
            onPressed: () async {
              final String currentPassword = currentPasswordController.text
                  .trim();
              final String newEmail = newEmailController.text.trim();

              final String? currentPasswordError = Validators.validatorsInstance
                  .validatePassword(currentPassword);
              if (currentPasswordError != null) {
                _showValidationError(context, currentPasswordError);
                return;
              }

              final String? newEmailError = Validators.validatorsInstance
                  .validateEmail(newEmail);
              if (newEmailError != null) {
                _showValidationError(context, newEmailError);
                return;
              }

              try {
                final bool ok = await updateEmail(currentPassword, newEmail);
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
                }
              } catch (e, stackTrace) {
                Logger().e(
                  'updateEmail dialog error',
                  error: e,
                  stackTrace: stackTrace,
                );
                _showValidationError(
                  context,
                  ErrorStringsEnum.unexpectedError.value,
                );
              }
              // Hata durumunda dialog açık kalır; global listener hata snackbar'ını gösterir
            },
          ),
        ],
      ),
    );
  }
}
