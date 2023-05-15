
import 'package:flutter/material.dart';

import 'expandable_feild.dart';



void showExpandAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  const MyExpandAlert();
    },
  );
}
