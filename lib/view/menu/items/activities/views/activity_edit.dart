import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

class ActivityEdit extends StatelessWidget {
  const ActivityEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
    );
  }
}