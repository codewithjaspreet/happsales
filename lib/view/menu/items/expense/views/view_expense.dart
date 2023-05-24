import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_view_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/expense/controllers/expense_controller.dart';

import '../../../../../utils/color.dart';
import '../../activities/views/activity_edit.dart';
import '../../contacts/widgets/SecondTypeDetailing.dart';
import '../../contacts/widgets/ThirdTypeDetailing.dart';
import '../../opportunity/views/opportunity_view.dart';
import '../widgets/subdetails_expense.dart';
import '../widgets/subdetails_expense2.dart';
import 'edit_expense.dart';

class ExpenseDetails extends StatelessWidget {
  ExpenseDetails({super.key});

  ExpenseController expenseController =Get.put( ExpenseController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
            
            Container(
                margin: EdgeInsets.only(top: 15.h, left: 14.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Travel Details',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "roboto_medium",
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
        
                      children: [
        
                        GestureDetector(
                            onTap: () {
                              Get.to(EditExpense());
                            },
                            child:Container(
                              width: 22.w,
                              height: 22.h,
                              decoration: BoxDecoration(
        
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle
                                  ),
                              margin: EdgeInsets.only(right: 20.w),
                              child: Image.asset("assets/contacts/edit.png"),
                            )),
                            
        
                        Obx(() => GestureDetector(
                            onTap: (){
        
                              expenseController.isOpen.value = !expenseController.isOpen.value;
                            },
                            child:Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Image.asset(
                                  expenseController.isOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                            )
                                
                                
                          ),
        
        
        
                          ),
        
                         
                      ],
                    )
                  ],
                ),
              ),
      
      
        Obx(() => expenseController.isOpen.value ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
          margin: EdgeInsets.only(top: 30.h, left: 14.w),
          child:Text("HAPPSALES-ATRTER-000006",style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14.sp,
          ),) ,
        ),
      
         Container(
          width: 340.w,
               padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 10.h),
               child: Expanded(
                 child: Text('Meeting with Deepak [Shuri\'s Tech company] on 08th Feb 2023 at 02:43 ',style: TextStyle(
                   color: AppColors.primaryColor,
                   fontSize: 16.sp,
                   fontWeight: FontWeight.bold
                 
                 ),),
               ),
             ),
      
             SubDetailExpense (
              title1 : 'Start Date',
              title2 : 'End Date',
              subTitle1 : '08 Feb 2023',
              subTitle2 : '08 Feb 2023',
             ),
              SubDetailExpense2(
              title1 : 'Start Location',
              subTitle1 : 'Delhi',
              ),
              SubDetailExpense2(
              title1 : 'End Location',
              subTitle1 : 'Noida',
              ),
              SubDetailExpense2(
              title1 : 'Travel Purpose',
              subTitle1 : '-',
              ),
              SubDetailExpense2(
              title1 : 'Approval Status',
              subTitle1 : '-',
              ),
               SubDetailExpense2(
              title1 : 'Remarks',
              subTitle1 : 'food',
              ),
      
      
      
      
      
          ],
        ) : SizedBox.shrink()),
      
        Hdivider(),
      
               
      
      SizedBox(height: 20.h,),
       Container(
                margin: EdgeInsets.only(top: 15.h, left: 14.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expense Entries',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "roboto_medium",
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
        
                      children: [
        
                      
                            
        
                        Obx(() => GestureDetector(
                            onTap: (){
        
                              expenseController.expenseDetails.value = !expenseController.expenseDetails.value;
                            },
                            child:Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Image.asset(
                                expenseController.expenseDetails.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                            )
                                
                                
                          ),
        
        
        
                          ),
        
                         
                      ],
                    )
                  ],
                ),
              ),
      
              Obx(() => expenseController.expenseDetails.value ? Container(
                child: Column(children: [
                  Container(
                margin: EdgeInsets.only(top: 30.h, left: 14.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Entry 1',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "roboto_medium",
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
        
                      children: [
        
                        
                            
        
                        Obx(() => GestureDetector(
                            onTap: (){
        
                              expenseController.expenseEntry.value = !expenseController.expenseEntry.value;
                            },
                            child:Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Image.asset(
                                  expenseController.expenseEntry.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                            )
                                
                                
                          ),
        
        
        
                          ),
        
                         
                      ],
                    )
                  ],
                ),
              ),
      
              Obx(() => expenseController.expenseEntry.value? Column(
                children: [
      
                  SubDetailExpense(subTitle1: '-', title1: 'Expense Type',title2: 'Mode of Travel', subTitle2: '-',),
                  SubDetailExpense(subTitle1: '0', title1: 'Distance Travelled(Kms)',title2: 'Amount', subTitle2: '0',),
                  SubDetailExpense2(title1: 'Remarks', subTitle1: '-')
                ],
              ):SizedBox.shrink())
      
                ],)
              ):SizedBox.shrink()),
      
              SizedBox(height: 10.h,),
              Hdivider(),
      
              SubDetailExpense2(title1: 'Total Expense', subTitle1: '800'),
        Hdivider(),
      
        Container(
                margin: EdgeInsets.only(top: 15.h, left: 14.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Additional Section',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: "roboto_medium",
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Row(
        
                      children: [
        
                        
        
                        Obx(() => GestureDetector(
                            onTap: (){
        
                              expenseController.additional.value = !expenseController.additional.value;
                            },
                            child:Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Image.asset(
                                  expenseController.additional.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                            )
                                
                                
                          ),
        
        
        
                          ),
        
                         
                      ],
                    )
                  ],
                ),
              ),
      
      
        Obx(() => expenseController.additional.value ? Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Documents')
        ,
                  IndividualItem(imageUrl: 'assets/activities/photo.png', title: 'Documents')
        ,
             IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Documents')
        
              
            
        
        
        
        
        
            ],
          ),
        ) : SizedBox.shrink()),
           
      Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            child: OpportunityViewRow(title: 'Is Active', subtite: 'Yes')),
      
      
      
                ThirdTypeDetailing(title1: 'Created By', subTitle1: 'asd'.toString(), title2: 'Modified By', subTitle2: 'Suvarna Traders'),
                SizedBox(height: 12.h,),
      
                ThirdTypeDetailing(title1: 'Created On', subTitle1: 'asd'.toString(), title2: 'Modified On', subTitle2: '29 Dec 2021'),
      
          ]),
        ),
      ),
    );
  }

 
}


class DetailActivityItems extends StatelessWidget {
  const DetailActivityItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/forms.png', title: 'Forms',),
              IndividualItem(imageUrl: 'assets/activities/product.png', title: 'Products',),
              IndividualItem(imageUrl: 'assets/activities/photo.png', title: 'Photo',),
            ],
          ),
             Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/teammember.png', title: 'Team Members',),
              IndividualItem(imageUrl: 'assets/activities/businessunit.png', title: 'Business Unit',),
              IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Documents',),
            ],
          ),

          IndividualItem(imageUrl: 'assets/activities/chat.png', title: 'Chats',),
         SizedBox(height: 10.h,),
          Divider(
            color: Colors.grey,
            thickness: 0.8,
          ),

         
        ],
      ),

    );

  }
}
class IndividualItem extends StatelessWidget {
  const IndividualItem({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: const Color(0xffF5F6F9),

            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imageUrl),
                Text(

                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "roboto_bold",
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),

              ],
            ),
          ),
        ),
       
      ],
    );
  }
}
