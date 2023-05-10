
import 'package:flutter/material.dart';

import 'AlertBox.dart';

void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MyAlertDialog();
    },
  );
}
