import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/settings/views/items/importcontacts/controllers/import_contact_controller.dart';
import '../../../../../../../../utils/color.dart';
import '../../../../../../../voiceassistant/sheet.dart';

class ImportContact extends StatelessWidget {
  const ImportContact({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: Stack(children: [

        Column(children: [

          Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Import Contacts' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  // Get.to(direct);
                },
                child: Container(
                  margin:  EdgeInsets.only(right: 16.w),
                  width: 30.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),

                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
              Center(

                child:  Container(
                  margin:  EdgeInsets.only(right: 16.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),

                  ),
                  child: const Center(
                    child: Icon(Icons.search ,color: Colors.white,),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
    _buildEmployeeListView()

        ],),

        bottomDetailsSheet()
      ]),
    );
  }
}

_buildEmployeeListView() {

  ImportContactController importContactController = Get.put(ImportContactController());
 
 
  return Obx(() =>  Expanded(
      child: importContactController.isLoading.value ? const CircularProgressIndicator(): ListView.builder(
        padding: EdgeInsets.all(12.sp),
        itemCount: importContactController.contactList.length,
        // itemCount: contactController.contacts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              
             },
            child: Container(
              margin: EdgeInsets.only(top : 12.sp),
              height: 90.h,
                width: 337.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4)),

                
                borderRadius: BorderRadius.circular(10.r),

              ),

              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left : 12.sp),
                    width: 50.w,
                    height: 50.w,
                    decoration:  BoxDecoration(
                      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
,
                      shape: BoxShape.circle
                    ),
                    child: GestureDetector(
                      onTap: (){
                        // Get.to(const AddContact());
                      },
                      child: Center(
                        child: Text(importContactController.contactList[index].givenName!.substring(0,1).toUpperCase() .toUpperCase(),style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'roboto_bold',
                          fontSize: 20.sp
                        ),),
                        
                        
                      ),
                    ),
                  ),

                  Container(
                    width: 150.w,
                    child: Column(
                    
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                    
                          margin: EdgeInsets.only(left : 16.sp),
                          child:Text(importContactController.contactList[index].givenName!,style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'roboto_bold',
                            fontSize: 16.sp
                          ),),
                      
                        ),Container(
                          margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                          child:Text(importContactController.contactList[index].phones![0].value!,style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: 'roboto_regular',
                              fontSize: 14.sp
                          
                          ),),
                        ),
                      ],
                    ),
                  ),

              Obx(() => 
                   Container(
                      margin: EdgeInsets.only(left : 80.sp),
                     child: GestureDetector(
                                   onTap: () {
                                    
                                     
                                   },
                                   child: Icon(
                     importContactController.isCheckboxSelected.value? Icons.check_box : Icons.check_box_outline_blank,
                                     color: Colors.grey.withOpacity(0.3) ,
                                   ),
                                 ),
                   ),
                  
)
                  
                ],
              ),
            ),
          );
        },
      )));
}