import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/opportunity/controller/opportunity_edit_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
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
                    'Opportunity Details',
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
                child: const Text('How does the closure property looks like ?',style: TextStyle(
                  color: AppColors.primaryColor
                ),),
               ),

               SfSliderTheme(
                data: SfSliderThemeData(
                  thumbRadius: 18.sp,
                  activeTrackHeight:  6.sp,
                  inactiveTrackHeight: 6.sp
                ),
                child: SfSlider(
                
                  inactiveColor: Colors.grey.withOpacity(0.6),
                  activeColor: Colors.grey.withOpacity(0.6),
                  thumbIcon: Container(
                    
                    width: 50.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      
                      color: AppColors.themeColor,
                    ),
                    height: 50.h,

                      child: Center(
                        child: Text('${controller.sliderValue.value.toInt()}%',style: 
                        TextStyle(color: Colors.white,fontFamily: 'roboto_bold',fontSize: 13.sp),),),
                    
                  ),
                  min: 0,
                  max: 100,
                  value: controller.sliderValue.value,
                  onChanged: (dynamic newValue){
                    controller.sliderValue.value = newValue;
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    
                    width: 340.w,
                    height: 40.h,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(

                        topLeft: Radius.circular(5.sp),
                        bottomLeft: Radius.circular(5.sp),
                      ),
                      color: Color.fromARGB(255, 31, 51, 56)
                    ),
                    child: Text('Lead'),
                  ),
                ],
              ),



              Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp,  vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Is this a reurring opportunity?' ,style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w400 ,fontSize: 14.sp
          ),),
          Switch(
            // thumb color (round icon)
            activeColor: AppColors.primaryColor,
            activeTrackColor: Colors.blue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            // boolean variable value
            value: controller.isAlreadyActive.value,

            onChanged: (value) {
              
              controller.isAlreadyActive.value = value;
            
            },
            // changes the state of the switch
          ),


        ],
      ),
    ),

    Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp,  vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           Container(
              margin: EdgeInsets.only(bottom: 10.h),
             child: Text('Opportunity Stage' ,style: TextStyle(
                color: AppColors.themeColor,fontWeight: FontWeight.bold ,fontSize: 14.sp
                     ),),
           ),

          Container(
            width: 337.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.withOpacity(0.5))
            
            ),
          )

        ],
      ),
    ),


Input(title: 'Lead Source'),


        TagInputWidget(),

      
      
Hdivider(),
SizedBox(height: 30.h,),
Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
      
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
                        margin: EdgeInsets.symmetric(horizontal: 14.w),
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
Hdivider(),

 Container(
            margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 70.h),
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
              IndividualItem(imageUrl: 'assets/contacts/activity.png', title: 'Activites',),
              IndividualItem(imageUrl: 'assets/activities/forms.png', title: 'Form',),
              IndividualItem(imageUrl: 'assets/activities/product.png', title: 'Products',),
            ],
          ),
             Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/teammember.png', title: 'Photos',),
              IndividualItem(imageUrl: 'assets/activities/businessunit.png', title: 'Competitors',),
              IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Notes',),
            ],
          ),

             Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              IndividualItem(imageUrl: 'assets/activities/teammember.png', title: 'Contact',),
              IndividualItem(imageUrl: 'assets/activities/businessunit.png', title: 'Team Members',),
              IndividualItem(imageUrl: 'assets/activities/document.png', title: 'Business Unit',),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Row(
              children: [
                SizedBox(width: 20.w,),
                IndividualItem(imageUrl: 'assets/activities/chat.png', title: 'Chats',),
            Divider(
              color: Colors.grey,
              thickness: 0.8,
            ),
            SizedBox(width: 20.w,),
             IndividualItem(imageUrl: 'assets/activities/chat.png', title: 'Chats',),
                   SizedBox(height: 10.h,),
            Divider(
              color: Colors.grey,
              thickness: 0.8,
            ),
              ],
            ),
          )

         
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
