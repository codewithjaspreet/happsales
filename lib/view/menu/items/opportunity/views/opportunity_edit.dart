import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/opportunity/controller/opportunity_edit_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../utils/color.dart';
import '../../activities/views/activity_edit.dart';
import '../../activities/views/activity_view.dart';
import '../../contacts/widgets/HDivider.dart';
import '../../contacts/widgets/InputOne.dart';
import '../../contacts/widgets/ToggleButtonRow.dart';
import '../../contacts/widgets/add_tag.dart';

class OpportunityEdit extends StatelessWidget {
   const OpportunityEdit({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
           Container(
        padding: EdgeInsets.all(6.sp),
        child: Row(
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8.w),
              child: Text('Edit Opportunity' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
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
      
           OpportunityEditDetails(),
      
      
        ]),
      ),
    );
  }
}

class OpportunityEditDetails extends StatelessWidget {
   OpportunityEditDetails({super.key});
  OpportunityEditController controller = Get.put(OpportunityEditController()); 


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       controller.toggleOpen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Details',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
              Obx(() => GestureDetector(
                  onTap: controller.toggleOpen,
                  child: Image.asset(controller.isOpen.value
                      ? "assets/contacts/back.png"
                      : "assets/contacts/up.png")),)
            ],
          ),
        ),
        Obx(() => controller.isOpen.value ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // DropDownInput(hint : 'Title *'),
                const Input(
                  title: 'Account Name*',
                ),
                const Input(
                  title: 'Opportunity Name',
                ),
                const Input(
                  title: 'Opportunity Detail',
                ),
              

                // DropDownInput(hint : 'Mobile Number'),
                const Input(
                  title: 'Contact Name',
                ),
                const Input(
                  title: 'Opportunity Value',
                ),
                const Input(
                  title: 'Currency',
                ),
                const Input(
                  title: 'Closure Date',
                ),
               
               Container(
                  margin: EdgeInsets.only(left: 18.w , top: 16.h),
                child: const Text('How does the closure property looks like ?'),
               ),
               SfSlider(
                inactiveColor: Colors.grey,
                activeColor: Colors.grey,
                thumbIcon: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle
                    ,color: Colors.blue
                  ),
                ),
                min: 0.0,
                max: 100.0,
                value: controller.sliderValue.value,
                interval: 20,
                minorTicksPerInterval: 1,
                onChanged: (value) {
                  controller.sliderValue.value = value;
                
                },

                
     ),

             ToggleButtonRow(title: 'Is This a reoccuring opportunity', isAlreadyActive: false)
,
Input(title: 'Lead Source'),


        TagInputWidget(),

      
      
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
                      
                        DetailOpportunityItems() : SizedBox.shrink(),
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





     
              ],
            ),
          ):Container())
          
      ]),
    );
  }
}
class DetailOpportunityItems extends StatelessWidget {
  const DetailOpportunityItems({Key? key}) : super(key: key);

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
              IndividualItem(imageUrl: 'assets/activities/activity.png', title: 'Forms',),
              IndividualItem(imageUrl: 'assets/activities/form.png', title: 'Products',),
              IndividualItem(imageUrl: 'assets/activities/product.png', title: 'Photo',),
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
