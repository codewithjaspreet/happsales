import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_edit_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/popups/custom_dropdown.dart';
import '../../../../../utils/popups/selection_dropdown.dart';

class ActivityEdit extends StatelessWidget {
   ActivityEdit({super.key});

  ActivityEditController controller = Get.put(ActivityEditController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(


        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Edit Activity' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
           Obx(() => GestureDetector(
            onTap: (){
                 
             controller.isOpen.value = !controller.isOpen.value;
                           
                           
                            },
             child: Row(
                 
                      children: [
                 
                       
                            
                 
                       GestureDetector(
                            onTap: (){
                 
                              controller.isOpen.value = !controller.isOpen.value;
                            },
                            child:Image.asset(

                                controller.isOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                                
                                
                          ),


                 
                 
                 
                          
                 
                         
                      ],
                    ),
           )),


        ],
      ),
    ),
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Text('Select Activity Type*' ,style: TextStyle(color: AppColors.primaryColor),)),

      DropDownHelper(

      dropDownListData:  [


        {"title": "Meeting", "value": "1"},
        {"title": "Call", "value": "2"},
        {"title": "Mail", "value": "3"},
        {"title": "Trade Show", "value": "4"},
        {"title": "Demo", "value": "5"},
        {"title": "Others", "value": "6"},
        {"title": "Service", "value": "7"},
        {"title": "Collections", "value": "8"},
        {"title": "Negotiation", "value": "9"},
        {"title": "Sample", "value": "10"},
        {"title": "Tech Support", "value": "11"},
        {"title": "Replacement", "value": "12"},
        {"title": "Show Sample", "value": "13"},









  ],
  labelText: 'Select Activity Type*',

      ),

      Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 10.h),
            child: Text('Meeting Duration' , style: TextStyle(color: Colors.grey,fontSize: 16.sp),),
          )
        ]),
        height: 300.h,
        width: 400.w,
        
        margin: EdgeInsets.symmetric(horizontal: 12.sp),
        decoration: BoxDecoration(

          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(7.sp)
        ),
        
      )



      ]),

    );
  }
}