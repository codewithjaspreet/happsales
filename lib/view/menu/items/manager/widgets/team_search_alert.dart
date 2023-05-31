
import 'package:flutter/material.dart';

import 'my_team_alert.dart';




void showTeamAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const MyTeamSearch();
    },
  );
}
