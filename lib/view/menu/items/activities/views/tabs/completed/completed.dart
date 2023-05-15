import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/activities/views/tabs/completed/completed_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/add_contact.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';

import '../../../../../../../../utils/color.dart';

class ActivityCompleted extends StatelessWidget {
  const ActivityCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(children: [
       Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(
      
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Completed Activities' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
      
              
              GestureDetector(
                onTap: (){
                  Get.to(const AddContact());
                },
                child: Container(
                  margin:  EdgeInsets.only(left: 20.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),
      
                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
      
              
            ],
          ),
      
      
      
        ],
      ),
      
        ),
      
      
      buildOpportunityList(),
      
       
      
      
      
      ]),
    );
  }
}

buildOpportunityList() {
  return  Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.all(12.sp),
        itemCount:6,
        itemBuilder: (context, index) {
          return ActivityRow(status: 'Approval Status : Submitted', detail: 'Meeting[check 31 aug]On 23-Oct-2021 At 4:33 Pm', date:'24 Oct 2021');
        },
      ));
}



class ActivityRow extends StatelessWidget {

  
  ActivityRow({super.key, required this.status, required this.detail, required this.date});

  final String status;
  final String detail;
  final String date;
  CompletedController controller = Get.put(CompletedController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _toggleDropdown();
      },
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
              Obx(() => GestureDetector(
                  onTap: () {
                    controller.isOpen.value = !controller.isOpen.value;
                  },
                  child: Image.asset(controller.isOpen.value
                      ? "assets/contacts/back.png"
                      : "assets/contacts/up.png")),)
            ],
          ),
        ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(

                horizontal: 10.w,
                vertical: 10.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
            
                  Container(
                      // margin: EdgeInsets.all(30.sp),
            
            
            
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
            
                      Container(
                        child: Text(date,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "roboto_medium",
                                fontSize: 14.sp)),
                      ),

                      const VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      
            
                      Container(
            
                        width: 240.w,
                        height: 100.h,
            
                        decoration:BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.sp)
                        
                        ),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                          children: [
                          Container(
                          padding: EdgeInsets.all(8.sp),
                          child: Center(child: Text(detail ,
                          
                          style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: "roboto_medium",
                                  fontSize: 14.sp)
                          
                          ),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.sp,top: 7.h),
                          width: 190.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4.sp)
                          ),
                          child: Center(child: Text(status,style: const TextStyle(color: Colors.white), )),
                        )
                        ],)
                      )
                    ]),
                  ),

                  Hdivider()
                 
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
