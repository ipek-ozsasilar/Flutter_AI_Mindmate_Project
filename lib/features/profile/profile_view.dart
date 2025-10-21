import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_elevated_button.dart';
import 'package:flutter_mindmate_project/products/widgets/buttons/global_icon_button.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/profile_header_widget.dart';
part 'sub_view/profile_menu_item_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MessageAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
          child: Column(
            children: [
              const _ProfileHeaderWidget(),
              // Name
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.personIcon,
                text: StringsEnum.demoName.value,
                isEditable: true,
                onTap: () {},
              ),
              // Email
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.emailInsideEmpty,
                text: StringsEnum.demoEmail.value,
                isEditable: true,
                onTap: () {},
              ),
              // Password
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.lockInsideEmpty,
                text: StringsEnum.password.value,
                isEditable: true,
                onTap: () {},
              ),

              // Privacy
              _ProfileMenuItemWidget(
                icon: IconConstants.iconConstants.privacy,
                text: StringsEnum.privacy.value,
                isExpandable: true,
                onTap: () {},
              ),
              // Setting
              Padding(
                padding:Paddings.paddingInstance.emptyHistoryWidgetPadding ,
                child: _ProfileMenuItemWidget(
                  icon: IconConstants.iconConstants.settings,
                  text: StringsEnum.setting.value,
                  isExpandable: true,
                  onTap: () {},
                ),
              ),
              
              // Logout Button
              GlobalElevatedButton(
                onPressed: () {},
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
