import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/message/message_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/icons.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/mixins/navigation_mixin.dart';
import 'package:flutter_mindmate_project/products/widgets/icons/global_icon.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/start_chat_widget.dart';

class CreateChatView extends StatefulWidget {
  const CreateChatView({super.key});

  @override
  State<CreateChatView> createState() => _CreateChatViewState();
}

class _CreateChatViewState extends State<CreateChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppbar(title: StringsEnum.startChat.value),
      body: SingleChildScrollView(child: Center(child: _StartChatWidget())),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
