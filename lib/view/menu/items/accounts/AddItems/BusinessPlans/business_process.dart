import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BuyingProcess/views/buy_detail.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

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

              HelperRow(title: "Business Plans", direct: AddBusiness()),

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

                      child: BuyRow(title: 'HAPPSALES-SCBPL-00000000034' , date: "21 Sep 2022", content : "kishore", route: BusinessPlanDetails(),)),

                ],
              )

            ],
          ),
        )


    );
  }
}

