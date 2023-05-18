
import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/resources/widgets/myresource_alert.dart';




void showResourceSearchAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MyResourceSearchAlert();
    },
  );
}
