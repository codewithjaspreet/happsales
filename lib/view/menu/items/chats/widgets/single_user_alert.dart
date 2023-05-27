
import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/chats/widgets/my_chat_alert.dart';

import '../views/new_single_user.dart';




void showSingleUser(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SingleUser();
    },
  );
}
