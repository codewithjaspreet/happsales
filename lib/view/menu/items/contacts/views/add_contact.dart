import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/BusinessCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';
import '../../accounts/AccountDetails.dart';
import '../widgets/AddContactDetails.dart';
import '../widgets/AmiRow.dart';
import '../widgets/MoreAddDetails.dart';
import 'Details.dart';
class AddContact extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            AmiHeaderRow(title: 'Add Contact',),

            GestureDetector(
                onTap: () {
                  showDialogs(context);
                },
                child: const BusinessCard()),

            Hdivider(),
            AddContactDetails(),
            Hdivider(),

            MoreAddDetails(),
            Hdivider(),
            Container(
              padding: EdgeInsets.only(top: 12.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AccountIndividualItem(imageUrl: 'assets/accounts/more_1.png', title: 'Activity',),
                  AccountIndividualItem(imageUrl: 'assets/accounts/more_2.png', title: 'Opportunity',),
                  AccountIndividualItem(imageUrl: 'assets/accounts/more_3.png', title: 'notes',),
                ],
              ),
            ),



          ],
        ),
      )
    );
  }
}









