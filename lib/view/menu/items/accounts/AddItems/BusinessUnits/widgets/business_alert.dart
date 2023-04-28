
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_business_alert.dart';


void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MyBusinessAlert();
    },
  );
}
