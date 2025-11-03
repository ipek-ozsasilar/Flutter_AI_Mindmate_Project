part of '../profile_view.dart';

class _ProfileShowEmailEdit {
  final Logger _logger = Logger();

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
        title: GeneralTextWidget(
          color: ColorName.blackColor,
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
            ),
            const SizedBox(height: 16),
            InputWidget(
              controller: newEmailController,
              obscureText: false,
              hintText: StringsEnum.newEmail.value,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: IconConstants.iconConstants.emailInsideEmpty,
            ),
          ],
        ),
        actions: [
          GlobalTextButton(
            onPressed: () {
              currentPasswordController.dispose();
              newEmailController.dispose();
              Navigator.pop(context);
            },
            text: StringsEnum.cancel.value,
            textColor: ColorName.blackColor,
          ),
          GlobalTextButton(
            text: StringsEnum.save.value,
            textColor: ColorName.blackColor,
            onPressed: () async {
              final bool ok = await updateEmail(
                currentPasswordController.text.trim(),
                newEmailController.text.trim(),
              );
              if (ok) {
                currentPasswordController.dispose();
                newEmailController.dispose();
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
              // Hata durumunda dialog açık kalır; global listener hata snackbar'ını gösterir
            },
          ),
        ],
      ),
    );
  }
}
