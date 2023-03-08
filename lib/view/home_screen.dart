import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/viewmodels/contact_view_model.dart';

import '../viewmodels/account_view_model.dart';

class HomeScreen extends StatelessWidget {

  AccountViewModel accountViewModel = Get.put(AccountViewModel());
  ContactViewModel contactViewModel = Get.put(ContactViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body:  Center(
        child: ElevatedButton(onPressed: (){

          // accountViewModel.getAccountList();
          contactViewModel.getContactList();

        }, child:
         SizedBox(
           width: 40.w,
           height: 40.h,
           child: const Text("Home Screen"),
         ),
        ),
      ),
    );
  }
}
