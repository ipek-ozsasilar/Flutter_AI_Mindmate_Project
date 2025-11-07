part of '../profile_view.dart';

class _ProfileShowPasswordEdit {
  void _showValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: message,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _showEditPasswordDialog(
    BuildContext context,
    Future<bool> Function(String currentPassword, String newPassword)
    updatePassword,
  ) async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible:
          true, // true: kullanıcı dışarı tıklarsa kapanır (email ile aynı)
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorName.scaffoldBackgroundColor,
        title: GeneralTextWidget(
          color: ColorName.whiteColor,
          size: TextSizesEnum.generalSize.value,
          text: StringsEnum.editPassword.value,
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
              controller: newPasswordController,
              obscureText: true,
              hintText: StringsEnum.newPassword.value,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: IconConstants.iconConstants.lockIcon,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                  Validators.validatorsInstance.passwordLength,
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
              final String newPassword = newPasswordController.text.trim();

              final String? currentPasswordError = Validators.validatorsInstance
                  .validatePassword(currentPassword);
              if (currentPasswordError != null) {
                _showValidationError(context, currentPasswordError);
                return;
              }

              final String? newPasswordError = Validators.validatorsInstance
                  .validatePassword(newPassword);
              if (newPasswordError != null) {
                _showValidationError(context, newPasswordError);
                return;
              }

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
                }
              } catch (e, stackTrace) {
                Logger().e(
                  'updatePassword dialog error',
                  error: e,
                  stackTrace: stackTrace,
                );
                _showValidationError(
                  context,
                  ErrorStringsEnum.unexpectedError.value,
                );
              }
              // ❌ Hata durumunda dialog açık kalır; global listener snackbar gösterir
            },
          ),
        ],
      ),
    );
  }
}
