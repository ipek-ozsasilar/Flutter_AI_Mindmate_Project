part of '../profile_view.dart';

class _ProfileShowPasswordEdit {
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
        title: GeneralTextWidget(
          color: ColorName.blackColor,
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
            ),
            const SizedBox(height: 16),
            InputWidget(
              controller: newPasswordController,
              obscureText: true,
              hintText: StringsEnum.newPassword.value,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: IconConstants.iconConstants.lockIcon,
            ),
          ],
        ),
        actions: [
          GlobalTextButton(
            onPressed: () {
              currentPasswordController.dispose();
              newPasswordController.dispose();
              Navigator.pop(context);
            },
            text: StringsEnum.cancel.value,
            textColor: ColorName.blackColor,
          ),
          GlobalTextButton(
            text: StringsEnum.save.value,
            textColor: ColorName.blackColor,
            onPressed: () async {
              final bool ok = await updatePassword(
                currentPasswordController.text.trim(),
                newPasswordController.text.trim(),
              );

              if (ok) {
                currentPasswordController.dispose();
                newPasswordController.dispose();
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
              // ❌ Hata durumunda dialog açık kalır; global listener snackbar gösterir
            },
          ),
        ],
      ),
    );
  }
}
