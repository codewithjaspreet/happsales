import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';
import 'package:happsales_crm/view/voiceassistant/voice.dart';

import '../../../views/menu.dart';
import '../widgets/chat_model.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      "HappSales",
      style: TextStyle(
          color: Colors.white, fontSize: 16.sp, fontFamily: 'roboto_bold'),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.to(() => const Menu());
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
    ],
  ),
      backgroundColor: AppColors.primaryColor,

      body: Stack(
        children:[ 
          
          Container(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            
            children: [

            Row(
              children: [
               Container(
                width: 50.w,
                height: 50.h,
                child: Image.asset('assets/chats/chat_individual.png')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                  margin: EdgeInsets.only(bottom: 9.h,left: 10.w),
                  child: Text('Renuka',style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontFamily: 'roboto_bold'
                    ,fontWeight: FontWeight.bold
                  ),),
                ),
                 Container(
                  margin: EdgeInsets.only(bottom: 0.h,left: 10.w),
                  child: Text('Inside Sales',style: TextStyle(
                    color: Colors.white,
                  ),),
                )
                ],)
                
              ],
            ),



          ],),
        ),

        Stack(
          children:[ 
            Container(
             child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  // CHAT SECTION

                  ListView.builder(itemBuilder: (context,index){


                    return Column(
                      children: [

                        Text('assa'),
                      ],
                    );
                  }, itemCount: 10, shrinkWrap: true,),
              
                 
                 
                  
                ],
              ),
             ),
            margin: EdgeInsets.only(top: 85.h),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
            ),
              
              
                ),

       
                  Container(
                    
                    margin: EdgeInsets.only(top: 620.h,left: 20.w,right: 20.w),
                    child: Column(
                      children: [
                      Container(
              
                        width: 330.w,
                        height: 40.h,
              
              decoration: BoxDecoration(
              ),
                  child: TextFormField(
              
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.send , color: AppColors.primaryColor,),
              
                      
                      hintText:'Chat with Renuka!' ,
              
              
                      hintStyle: TextStyle(
                color: Color(0xffB4C6D4),
                fontSize: 13.sp
                
                        ),
                      border: OutlineInputBorder(
              
              
                        borderRadius: BorderRadius.circular(20.sp),
                        borderSide: const BorderSide(
              
              color: Color(0xffB4C6D4),
                        ),
              
                      ),
              
                    ),
                  ),
                ),
                  
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text('Powered By HappSales' , style: TextStyle(color: Colors.grey),))
                      ],
                    ),
                  )
          ]
        ),

        

        ]
      ),
    );
  }
}

class Conversations extends StatelessWidget {
  const Conversations({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
width: 40.w,
height: 40.h,
      color: Colors.red,
      decoration: BoxDecoration(),

    );
  }
}