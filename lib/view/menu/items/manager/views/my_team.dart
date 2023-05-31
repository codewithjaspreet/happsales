import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';
import 'dart:math' as math;
import '../../../../../utils/color.dart';

class MyTeam extends StatelessWidget {
  const MyTeam({super.key});

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
    teamList()

        ],),

        bottomDetailsSheet()
      ]),
    );
  }
}

teamList() {

 
 
  return Expanded(
      child:  ListView.builder(
        padding: EdgeInsets.all(12.sp),
        itemCount: 10,
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
                        child: Text('Deepak'.substring(0,1).toUpperCase() .toUpperCase(),style: TextStyle(
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
                          child:Text('Deepak',style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'roboto_medium',
                            fontSize: 16.sp
                          ),),
                      
                        ),Container(
                          margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                          child:Text('Tester',style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: 'roboto_regular',
                              fontSize: 14.sp
                          
                          ),),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ));
}