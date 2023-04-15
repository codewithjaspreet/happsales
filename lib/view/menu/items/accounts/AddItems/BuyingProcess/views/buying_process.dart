import 'package:flutter/material.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import 'add_buying.dart';
class BuyingProcess extends StatelessWidget {
  const BuyingProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: CustomAppBar(context),
      
      body : Column(
        children: [
          
          HelperRow(title: "Buying Process", direct: AddBuying()),


        ],
      )
      
      
    );
  }
}
