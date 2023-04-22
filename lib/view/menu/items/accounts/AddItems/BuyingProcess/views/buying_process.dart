import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BuyingProcess/views/add_buying.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BuyingProcess/views/buy_detail.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import '../../../../../../../utils/color.dart';
import '../../CompetitionActivities/competition_details.dart';
import '../widgets/buy_row.dart';
class BuyingProcess extends StatelessWidget {
  const BuyingProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(context),
        body : Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              HelperRow(title: "Buying Process", direct: AddBuying()),

              Container(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 35.r,
                      child: Center(
                          child:Text("a", style: TextStyle(
                              color: Colors.white , fontSize: 30.sp , fontWeight: FontWeight.w500
                          ),)
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("account owner to Deepak",style: TextStyle(color: AppColors.primaryColor,

                            fontSize: 20.sp , fontWeight: FontWeight.w500),),

                        SizedBox(height : 5.h),
                        Text("Aerospace".toUpperCase(),style: TextStyle(color: AppColors.primaryColor,

                            fontSize: 14.sp , fontWeight: FontWeight.w400),) ,

                        SizedBox(height: 5.h,),
                        Text("Bangalore",style: TextStyle(color: AppColors.primaryColor,

                            fontSize: 14.sp , fontWeight: FontWeight.w200),)
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(

                      padding :  EdgeInsets.all(20.sp),

                      child: BuyRow(title: "HAPPSALES-ACBUY-00000000074" , date: "25 Mar 2023", content : "T", route: BuyDetails(),)),

                ],
              )

            ],
          ),
        )


    );
  }
}

