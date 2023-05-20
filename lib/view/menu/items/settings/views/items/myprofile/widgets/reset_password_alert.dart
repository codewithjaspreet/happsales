
import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/myprofile/widgets/reset_password.dart';




void showPasswordAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  MyResetPasswordAlert();
    },
  );
}
