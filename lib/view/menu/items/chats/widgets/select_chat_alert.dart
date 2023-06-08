
import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/chats/widgets/my_chat_alert.dart';
import 'package:happsales_crm/view/menu/items/chats/widgets/my_select_chat_alert.dart';




void showSelectChatAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MySelectChatAlert();
    },
  );
}
