
import 'package:flutter/material.dart';

import 'my_search.dart';



void showSearchAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MySearchAlert();
    },
  );
}
