
import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/opportunity/widgets/my_workflow.dart';

import '../../notes/widgets/my_search.dart';




void WorkFlowAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const WorkFlowStatus();
    },
  );
}
