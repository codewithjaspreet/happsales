
import 'package:flutter/material.dart';

import 'my_share_account_alert.dart';


void showShareDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MyShareAccountAlert();
    },
  );
}
