import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/add_account.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/expense/views/view_expense.dart';

import '../../../../../utils/color.dart';
import '../../notes/views/add_notes.dart';
import '../../notes/widgets/notes_popup.dart';
import '../../opportunity/views/opportunity_view.dart';
import 'add_expense.dart';

class ExpenseListing extends StatelessWidget {
  const ExpenseListing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
      
        
           Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expense' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(const AddNotes());
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
                const NotePopup(),
              ],
            ),
          ],
        ),
          ),  
              Image.asset('assets/expenses/header.png'),
        
        
                   ExpenseRow(),
                                  ExpenseRow(),
                                   ExpenseRow(),
                                    ExpenseRow(),
        
        
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseRow extends StatelessWidget {
  const ExpenseRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: (){
              Get.to(  ExpenseDetails());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w  , vertical: 13.h),
              height: 130.h,
              width: 370.w,
              decoration: BoxDecoration(
     border: Border.all(color: Colors.grey.withOpacity(0.7)),
     borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
     children: [
       
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
         


           Container(
             padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 10.h),
             width: 336.w,
             child: Expanded(
               child: Text('Meeting with Deepak [Shuri\'s Tech company] on 08th Feb 2023 at 02:43 ',style: TextStyle(
                 color: AppColors.primaryColor,
                 fontSize: 14.sp,
                 fontWeight: FontWeight.bold
               
               ),),
             ),
           ),
          
           Container(
             padding: EdgeInsets.symmetric(horizontal: 18.w),
             child: Row(
               children: [

                
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     
                     Text(
                       'Start Date',
                       style: TextStyle(
                         fontFamily: 'roboto_regular',

          
                         fontWeight: FontWeight.normal,
                         color: AppColors.primaryColor,
          
          
                         fontSize: 13.sp,
                       ),
                     ),
                     SizedBox(
                       height: 5.h,
                     ),
                     Text(
                       '08 Feb 2023',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
      

                         color: AppColors.primaryColor,
                         fontSize: 14.sp,
                       ),
                     ),
                   ],
                 ),
                 SizedBox(width: 30.w,),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       'Total Expense',
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
                       '800',
                       style: TextStyle(
                         color: AppColors.primaryColor,
                         fontSize: 14.sp,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ],
                 ),

                 SizedBox(width:30.w,),

                  Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Text(
                       'End Date',
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
                       '08 Feb 2023',
                       style: TextStyle(
                         color: AppColors.primaryColor,
                         fontWeight: FontWeight.bold,
                         fontSize: 12.sp,
                       ),
                     ),
                   ],
                 ),
                 
          
               ],
             ),
           ),

           
          
          Container(
            padding: EdgeInsets.only(left: 90.w, top : 10.h),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
             
                 Text('Approval Status -  Not Submitted',style: TextStyle(
                   color: AppColors.themeColor,
                   fontSize: 12.sp,
                   fontWeight: FontWeight.normal
                 
                 ),)
               ],
             ),
          )
         ],
       ),
          
      
     ],
              ),
            ),
          );
  }
}