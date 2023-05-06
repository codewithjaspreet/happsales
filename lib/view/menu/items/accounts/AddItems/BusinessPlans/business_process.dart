import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../../../utils/color.dart';
import '../BuyingProcess/widgets/buy_row.dart';
import 'add_business_plan.dart';
import 'business_plan_details.dart';
class BusinessProcess extends StatelessWidget {
  const BusinessProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        appBar: CustomAppBar(context),

        body : Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

          Container(
          padding: EdgeInsets.all(12.sp),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Business Plans' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(const AddBusiness());
                    },
                    child: Container(
                      margin:  EdgeInsets.only(right: 12.w),
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

                ],
              ),
            ],
          ),
        ),

              Container(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 35.r,
                      child: Center(
                          child:Text("a".toUpperCase(), style: TextStyle(
                              color: Colors.white , fontSize: 30.sp , fontWeight: FontWeight.w500
                          ),)
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text("ABC Logistics",style: TextStyle(color: AppColors.primaryColor,

                            fontSize: 20.sp , fontWeight: FontWeight.w500),),

                        SizedBox(height: 5.h,),
                        Text("Karnatka",style: TextStyle(color: AppColors.primaryColor,

                            fontSize: 14.sp , fontWeight: FontWeight.w200),)
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(

                      padding :  EdgeInsets.all(10.sp),

                      child: const BuyRow(title: 'HAPPSALES-SCBPL-00000000034' , date: "21 Sep 2022", content : "kishore", route: BusinessPlanDetails(),)),

                ],
              )

            ],
          ),
        )


    );
  }
}

