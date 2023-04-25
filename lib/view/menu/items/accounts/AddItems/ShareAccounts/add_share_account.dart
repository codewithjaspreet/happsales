import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../contacts/widgets/CustomAppBar.dart';

class AddShareAccount extends StatelessWidget {
  const AddShareAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
    );
  }
}
