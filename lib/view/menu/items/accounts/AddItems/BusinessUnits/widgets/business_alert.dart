
import 'package:flutter/material.dart';

import 'my_business_alert.dart';


void showBusinessDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MyBusinessAlert();
    },
  );
}
