import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/profile/view_model/profile_view_model.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_text_button.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/inputs/input_widget.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:flutter_mindmate_project/features/profile/provider/profile_provider.dart';

part 'sub_view/profile_header_widget.dart';
part 'sub_view/profile_menu_item_widget.dart';
part 'sub_view/profile_show_email_edit.dart';
part 'sub_view/profile_show_password_edit.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ProfileViewModel {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadProfileImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    setupListeners();
    return Scaffold(
      appBar: MessageAppbar(title: StringsEnum.profile.value),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
          child: Column(
            children: [
              _ProfileHeaderWidget(
                selectedImage: selectedImage,
                imageUrl: imageUrlWatch(),
                onImagePicked: () => pickImage(context),
              ),
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.emailInsideEmpty,
                text:
                    FirebaseAuth.instance.currentUser?.email ??
                    StringsEnum.demoEmail.value,
                isEditable: true,
                onTap: () {
                  clearErrorMessage();
                  _ProfileShowEmailEdit()._showEditEmailDialog(
                    context,
                    updateEmail
                    
                  );
                },
              ),
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.lockInsideEmpty,
                text: StringsEnum.password.value,
                isEditable: true,
                onTap: () {
                  clearErrorMessage();
                  _ProfileShowPasswordEdit()._showEditPasswordDialog(
                    context,
                    updatePassword,
                  );
                },
              ),
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.privacy,
                text: StringsEnum.privacy.value,
                isExpandable: true,
              ),
              GlobalElevatedButton(
                onPressed: () async {
                  await signOut();
                },
                text: StringsEnum.logout.value,
                icon: IconConstants.iconConstants.logout,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
