import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/view/menu/items/activities/views/activity_edit_controller.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/add_tag.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/popups/custom_dropdown.dart';
import '../../../../../utils/popups/selection_dropdown.dart';
import '../../contacts/widgets/MoreDetail.dart';
import '../../contacts/widgets/ThirdTypeDetailing.dart';
import '../../opportunity/views/opportunity_view.dart';
import 'activity_view.dart';

class ActivityEdit extends StatelessWidget {
   ActivityEdit({super.key});

  ActivityEditController controller = Get.put(ActivityEditController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
          Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
      
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit Activity' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
             
            
      
      
          ],
        ),
          ),
           Container(
        padding: EdgeInsets.all(12.sp),
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                            Text('Activity Details' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
           
                  Obx(() => GestureDetector(
                onTap: (){
                     
                 controller.isOpen.value = !controller.isOpen.value;
                               
                               
                                },
                 child: Row(
                     
                          children: [
                     
                           
                                
                     
                           GestureDetector(
                                onTap: (){
                     
                                  controller.isOpen.value = !controller.isOpen.value;
                                },
                                child:Image.asset(
           
                                    controller.isOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                                    
                                    
                              ),
           
           
                     
                     
                     
                              
                     
                             
                          ],
                        ),
               )),
                ],
               ),
           ),
      
          Container(
        margin: EdgeInsets.symmetric(horizontal: 12.sp),
        child: Text('Select Activity Type*' ,style: TextStyle(color: AppColors.primaryColor),)),
      
        DropDownHelper(),
      
        Container(
      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 10.h),
              child: Text('Meeting Duration' , style: TextStyle(color: Colors.grey,fontSize: 16.sp),),
            )
          ]),
          height: 300.h,
          width: 400.w,
          
          margin: EdgeInsets.only(left: 12.sp,right: 12.sp,bottom: 30.h),
          decoration: BoxDecoration(
      
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(7.sp)
          ),
          
        ),
      
        Row(
          children: [
            Container(
              width:150.w,
      
            padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 2.h),
            child: TextFormField(
      
      
              decoration: InputDecoration(
      
            labelText: 'Activity Date*',
            floatingLabelStyle: const TextStyle(
              color : Color(0xff00A6D6),
            ),
            labelStyle: const TextStyle(
              color: Color(0xff8F9BB3),
            ),
            hintText: 'Activity Date*',
      
      
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
          width:150.w,
      
        padding: EdgeInsets.only( right: 16.w, top: 2.h),
        child: TextFormField(
      
      
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
      
      
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: const BorderSide(
      
            color: Color(0xffB4C6D4),
          ),
      
        ),
      
          ),
        ),
          ),
      
          Icon(Icons.punch_clock_rounded , color: Colors.grey,size: 40,)
      
          
          ],
        ),
        SizedBox(height: 10.h,),
      
        Input(title: 'Account Name*' ,),
        SizedBox(height: 10.h,),
        Input(title: 'Contact Name'),
        SizedBox(height: 10.h,),
        Input(title: 'Opportunity Name'),
        SizedBox(height: 10.h,),
        Input(title: 'Activity Title*'),

        SizedBox(height: 10.h,),
        Input(title: 'Activity Assignment Details'),
        SizedBox(height: 10.h,),
        Input(title: 'Activity Details'),
        SizedBox(height: 10.h,),
        Input(title: 'Activity Status*'),
      
        TagInputWidget(),

      Container(
        height: 237.h,
        width: 370.w,
      margin: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xffB4C6D4)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.sp , vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       Row(

            children:  [
                  Container(
                    child: Text('Travel Details',style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_bold",fontSize: 14.sp),)),

                    

            ],

          ) ,
          SizedBox(height: 10.h,),
         
ActivityInput(title: 'Activity Planned',isSuffixIcon: false,),
SizedBox(height: 10.h,),
ActivityInput(title: 'Planned for Date',isSuffixIcon: false,),
SizedBox(height: 10.h,),
ActivityInput(title: 'Activity Title',isSuffixIcon: false,),


          





        ],
      ),
    ),
        ToggleButtonRow(title: 'Create a follow-up activity', isAlreadyActive: true)
      
       , 
       
       
      Container(
        height: 547.h,
        width: 370.w,
      margin: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xffB4C6D4)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.sp , vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

       Row(

            children:  [
                  Container(
                    child: Text('Travel Details',style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_bold",fontSize: 14.sp),)),

                    

            ],

          ) ,
          SizedBox(height: 10.h,),
         
ActivityInput(title: 'Travel Purpose',isSuffixIcon: false,),
SizedBox(height: 10.h,),
ActivityInput(title: 'Start Location',isSuffixIcon: true,),
SizedBox(height: 10.h,),
ActivityInput(title: 'End Location',isSuffixIcon: true,),
SizedBox(height: 10.h,),

ActivityInput(title: 'Distance Travel',isSuffixIcon: false,),
SizedBox(height: 10.h,),

ActivityInput(title: 'Mode Of Travel',isSuffixIcon: false,),
SizedBox(height: 10.h,),

ActivityInput(title: 'Travel Expense',isSuffixIcon: false,),
SizedBox(height: 10.h,),

ActivityInput(title: 'Other Expense',isSuffixIcon: false,),
SizedBox(height: 10.h,),

ActivityInput(title: 'Remarks',isSuffixIcon: false,),


          



        ],
      ),
    ),
Hdivider(),
SizedBox(height: 30.h,),
Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
      
                        child: Text(
                          'Additional Details',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"
                          ),
                        ),
                      ),
      
             
      
                      Obx(() => Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                            onTap: (){
                            
                              controller.isAdditionalInfoOpen.value = !controller.isAdditionalInfoOpen.value;
                            },
                            child:Image.asset(
                                controller.isAdditionalInfoOpen.value ? "assets/contacts/up.png" : "assets/contacts/back.png")
                                
                                
                          ),
                      ),


                      


      
      
      
                        ),


      
                       
                    ],
                  ),

      Obx(() =>  
                      controller.isAdditionalInfoOpen.value?
                      
                        DetailActivityItems() : SizedBox.shrink(),
)
,

 Container(
            margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 16.h),
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


        ]),
      ),

    );
  }
}

class ActivityInput extends StatelessWidget {
  // const ActivityInput({super.key});

  const ActivityInput({required this.title,required this.isSuffixIcon});


  final String title;
  final bool isSuffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
          width:350.w,
      
        padding: EdgeInsets.only(  top: 2.h),
        child: TextFormField(
      
      
          decoration: InputDecoration(
            
            suffixIcon: isSuffixIcon ? Icon(Icons.local_activity,color: Colors.blue,) : SizedBox.shrink(),      
        labelText: title,
        floatingLabelStyle: const TextStyle(
          color : Color(0xff00A6D6),
        ),
        labelStyle: const TextStyle(
          color: Color(0xff8F9BB3),
        ),
        hintText: title,
      
      
        hintStyle: TextStyle(color: const Color(0xff8F9BB3),fontSize: 14.sp,fontWeight: FontWeight.w400,fontFamily: "roboto_regular"),
        border: OutlineInputBorder(
      
      
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: const BorderSide(
      
            color: Color(0xffB4C6D4),
          ),
      
        ),
      
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
