import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';
import 'package:happsales_crm/viewmodels/contact_view_model.dart';
import '../../../views/menu.dart';
import 'Details.dart';
import 'add_contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var isLoading = false;

  ContactViewModel contactController = Get.put(ContactViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    
      body: isLoading
          ? Stack(
            clipBehavior: Clip.none,
            children: [
              const CircularProgressIndicator(),
              bottomDetailsSheet()
            ],
          )
          : Stack(
            children: [
              Column(
            children: [
              CustomAppBar(context),
               const HelperRow(
                direct: AddContact(),
                title: "My Contacts",
              ),
              Image.asset("assets/contacts/contact_banner.png"),
    
              _buildEmployeeListView()
    
            ],
          ),
          bottomDetailsSheet()
            ],
          )
    );
  }
}
_buildEmployeeListView() {

  int generateRandomColorInt() {
    Random random =  Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    int color = (r << 16) + (g << 8) + b;
    return color;
  }

  ContactViewModel contactController = Get.put(ContactViewModel());
  return  Expanded(
      child: Obx(() => ListView.builder(
        padding: EdgeInsets.all(12.sp),

        itemCount: contactController.contacts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              print("THE ID IS${contactController.contacts[index].contactID}");
              Get.to(() => ContactDetails(Id : contactController.contacts[index].contactID,));
            },
            child: Container(
              margin: EdgeInsets.only(top : 12.sp),
              height: 90.h,
                width: 337.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),

                color: Colors.white ,
                borderRadius: BorderRadius.circular(10.r),

              ),

              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left : 12.sp),
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.to(const AddContact());
                      },
                      child: Center(
                        child: Text(contactController.contacts[index].contactName[index].toUpperCase(),style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp
                        ),),
                      ),
                    ),
                  ),

                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        margin: EdgeInsets.only(left : 16.sp),
                        child: Text(contactController.contacts[index].contactName,style: const TextStyle(
                          color: AppColors.primaryColor
                        ),),
                      ),Container(
                        margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                        child: Text(contactController.contacts[index].designation,
                            style: const TextStyle(
                                color: AppColors.primaryColor
                            )),
                      ),Container(
                        margin: EdgeInsets.only(left : 16.sp,top: 4.sp),
                        child: Text(contactController.contacts[index].contactCode.toString(),
                            style: const TextStyle(
                                color: AppColors.primaryColor
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      )));
}