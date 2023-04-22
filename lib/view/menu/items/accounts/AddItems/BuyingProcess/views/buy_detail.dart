import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/CompetitionActivities/widgets/competition_row.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';

import '../widgets/buy_sec_row.dart';
class BuyDetails extends StatelessWidget {
  const BuyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Process Code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'HAPPSALES-ACCMP-00000000074',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: 25.w,
                  height: 25.h,
                  child: Image.asset('assets/contacts/edit.png'),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          ),
          BuySecondRow(
            compTitle: "Account Name",
            compSubTitle: "account owner to Deepak",
          ),

          BuySecondRow(
            compTitle: "Buying Process",
            compSubTitle: "Navigation",
          ),


          Hdivider(),

          BuySecondRow(compTitle: 'Is Active', compSubTitle: 'Yes'),
          Hdivider(),

          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'deepak',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified By',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '25 Mar 2023',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modified On',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,


                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),





    );
  }
}
