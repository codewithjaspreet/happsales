import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/add_account.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../utils/color.dart';
import '../../opportunity/views/opportunity_view.dart';
import 'add_expense.dart';

class ExpenseListing extends StatelessWidget {
  const ExpenseListing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [

          HelperRow(title: 'Expense', direct: AddExpense(),),
          Image.asset('assets/expenses/header.png'),


               GestureDetector(
            onTap: (){
              Get.to( const OpportunitiesDetails());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 6.h),
              height: 120.h,
              width: 336.w,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.123),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h,),
                    


                      
          
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Value',
                                  style: TextStyle(
                                    fontFamily: 'roboto_regular',

          
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.primaryColor,
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  '75000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
      

                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 40.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Currency',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'roboto_regular',
                                    color: AppColors.primaryColor,
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(
                                  height: 5.h,
                                ),

                                Text(
                                  'Indian Rupee',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 20.w,),

                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Closure Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'roboto_regular',
                                    color: AppColors.primaryColor,
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(
                                  height: 5.h,
                                ),

                                Text(
                                  '25 Aug 2021',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
          
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      
                            Text('Approval Status -  Not Submitted',style: TextStyle(
                              color: AppColors.themeColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold
                            
                            ),)
                          ],
                        ),
                      )
          
          
                    ],
                  ),
          
                 
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}