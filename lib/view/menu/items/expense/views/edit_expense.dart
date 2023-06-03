import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/widgets/new_process_add_feild.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';
import 'package:happsales_crm/view/menu/items/expense/controllers/expense_controller.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/popups/selection_dropdown.dart';
import '../../activities/views/activity_edit.dart';
import '../../contacts/widgets/HDivider.dart';
import '../../contacts/widgets/InputOne.dart';
import '../widgets/date_picker.dart';
import '../widgets/subdetails_expense.dart';
import '../widgets/subdetails_expense2.dart';

class EditExpense extends StatelessWidget {
   EditExpense({super.key});

  ExpenseController controller = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Stack(
        children:[ SafeArea(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
              padding: EdgeInsets.all(12.sp),
              child: Row(
            
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Expense' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
                  
                ],
              ),
                ),
            
                 Container(
                padding: EdgeInsets.all(12.sp),
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                                    Text('Travel Details' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 16.sp,color: AppColors.primaryColor),),
                   
                          Obx(() => GestureDetector(
                        onTap: (){
                             
                         controller.isEditDetailOpen.value = !controller.isEditDetailOpen.value;
                                       
                                       
                                        },
                         child: Row(
                             
                                  children: [
                             
                                   
                                        
                             
                                   GestureDetector(
                                        onTap: (){
                             
                                          controller.isEditDetailOpen.value = !controller.isEditDetailOpen.value;
                                        },
                                        child:Image.asset(
                   
                                            controller.isEditDetailOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                                            
                                            
                                      ),
                   
                   
                             
                             
                             
                                      
                             
                                     
                                  ],
                                ),
                       )),
                        ],
                       ),
                   ),
            
                   Obx(() => controller.isEditDetailOpen.value ? Column(
                    children: [
                    Input(title: 'Expense Details*' ,),
            
            SizedBox(height: 15.h,),
                Row(
                  children: [
                    ExpenseDatePicker(labelText: 'Start Date*' ,),
                 
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width:180.w,
              
                child: GestureDetector(
                  onTap: () {
                    controller.pickTime(context);
                  },
                  child: TextFormField(
                    
                    controller: controller.timeController,
                              
                    decoration: InputDecoration(
                              
                  labelText: 'Activity Time*',
                  floatingLabelStyle: const TextStyle(
                    color : Color(0xff00A6D6),
                  ),
                  labelStyle: const TextStyle(
                    color: Color(0xff8F9BB3),
                  ),
                  hintText: 'Activity Time*',
                              
                              
                  hintStyle: TextStyle(color: const Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
                  border: OutlineInputBorder(
                              
                              
                    borderRadius: BorderRadius.circular(2.sp),
                    borderSide: const BorderSide(
                              
                      color: Color(0xffB4C6D4),
                    ),
                              
                  ),
                              
                    ),
                  ),
                ),
                  ),
              
              
                  
                  ],
                ),
                SizedBox(height: 10.h,),
              
                SizedBox(height: 10.h,),
                Container(
            
              padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 10.h),
              child: TextFormField(
            
            
                decoration: InputDecoration(
                  suffixIcon: Container(
                    child: Image.asset('assets/expenses/location.png')),
            
                  labelText: 'Start Location',
                  floatingLabelStyle: const TextStyle(
                    color : Color(0xff00A6D6),
                  ),
                  labelStyle: const TextStyle(
                    color: Color(0xff8F9BB3),
                  ),
                  hintText: 'Start Location',
            
            
                  hintStyle: TextStyle(color: const Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
                  border: OutlineInputBorder(
            
            
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: const BorderSide(
            
                      color: Color(0xffB4C6D4),
                    ),
            
                  ),
            
                ),
              ),
                ),
          
                Container(
            
              padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 10.h),
              child: TextFormField(
            
            
                decoration: InputDecoration(
                  suffixIcon: Container(
                    child: Image.asset('assets/expenses/location.png')),
            
                  labelText: 'End Location',
                  floatingLabelStyle: const TextStyle(
                    color : Color(0xff00A6D6),
                  ),
                  labelStyle: const TextStyle(
                    color: Color(0xff8F9BB3),
                  ),
                  hintText: 'End Location',
            
            
                  hintStyle: TextStyle(color: const Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
                  border: OutlineInputBorder(
            
            
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: const BorderSide(
            
                      color: Color(0xffB4C6D4),
                    ),
            
                  ),
            
                ),
              ),
                ),
                SizedBox(height: 10.h,),
                Input(title: 'Travel Purpose*'),
                ToggleButtonRow(title: 'Submit for Approval', isAlreadyActive: false),
                NewProcessAddFeild(title: 'Remarks')
                    ],
                   ):SizedBox.shrink()),
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
              
                                    controller.expenseDetails.value = !controller.expenseDetails.value;
                                  },
                                  child:Container(
                                    margin: EdgeInsets.only(right: 3.w),
                                    child: Image.asset(
                                        controller.expenseDetails.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                                  )
                                      
                                      
                                ),
              
              
              
                                ),
              
                               
                            ],
                          )
                        ],
                      ),
                    ),
            
                    Obx(() => controller.expenseDetails.value ? Container(
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
              
                                    controller.expenseEntry.value = !controller.expenseEntry.value;
                                  },
                                  child:Row(
                                    children: [
          
                              Container(
                                margin: EdgeInsets.only(left: 10.w),
                                child: Image.asset('assets/notes/delete.png')),
          
                                SizedBox(width: 20.w,),
                                      Container(
                                        margin: EdgeInsets.only(right: 3.w),
                                        child: Image.asset(
                                            controller.expenseEntry.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                                      ),
          
                                      
                                    ],
                                  )
                                      
                                      
                                ),
              
              
              
                                ),
              
                               
                            ],
                          )
                        ],
                      ),
                    ),
            
                    Obx(() => controller.expenseEntry.value? Column(
                      children: [
             DropDownHelper(),
              DropDownHelper(),
              Input(title: 'Distance Travelled'),
              Input(title: 'Remarks'),
                        
                      ],
                    ):SizedBox.shrink()
                    
            )
            
                      ],)
                    ):SizedBox.shrink()),
            
        Hdivider(),
        
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           GestureDetector(
                      onTap: (){
                        // Get.to(direct);
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
            ],
          ),
        ),
        
        Input(title: 'Total Expense'),
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
              
                                    controller.additional.value = !controller.additional.value;
                                  },
                                  child:Container(
                                    margin: EdgeInsets.only(right: 3.w),
                                    child: Image.asset(
                                        controller.additional.value ? "assets/contacts/up.png" : "assets/contacts/back.png"),
                                  )
                                      
                                      
                                ),
              
              
              
                                ),
              
                               
                            ],
                          ),
                          
                        ],
                      ),
                    ),
            Obx(() => controller.additional.value ? Container(
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
                margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 125.w,
                      height:48.h,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(26.sp),
                        color: const Color(0xff8199AC),
                      ),
                      child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                    ),
                    Container(
                      width: 125.w,
                      height:48.h,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(26.sp),
        
                        shape: BoxShape.rectangle,
                        color: AppColors.primaryColor,
                      ),
                      child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 18.sp),)),
                    )
                  ],
                ),
              )
        
            
                ],
              ),
            ),
          ),
        ),

        bottomDetailsSheet()
        ]
      ),
    );
  }
}