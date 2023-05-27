
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/chats/widgets/chat_list.dart';

import '../../notes/views/view_notes.dart';


class MyChatSearchAlert extends StatelessWidget {
  const MyChatSearchAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w , vertical: 30.h),
      title: Row(
        children: [
          Container(
           
            child: Image.asset('assets/accounts/close.png',scale: 0.7,)),
          SizedBox(width: 70.w,),
          Text("Search Chat",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),

          
        
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 339.w,
        height: 604.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

             Container(
               width: 337.w,
                height: 35.h,
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                 color: const Color(0xffF5F6F9)
               ),
               child: TextField(
                 decoration: InputDecoration(
                     suffixIcon: const Icon(Icons.search , color: Colors.grey,),
                     border: OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(8.sp),
                     ),
                     filled: true,
                     contentPadding: EdgeInsets.symmetric(
                       horizontal: 10.w
                     ),
                     hintStyle: const TextStyle(color: Color(0xff707070)),
                     hintText: "Search",

                     fillColor: const Color(0xffF5F6F9)),
               ),
             ),

              Container(
                height: 600.h,
                child: ListView.builder(
              
                      itemCount:10,
                      itemBuilder: (context, index) {
                       return const ChatItem();
                      },
                    ),
              )



            ],
          ),
        )
      ),

    );
  }
}



class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(

                 onTap: (){
              
                    },
                        
                          child: Container(
                margin: EdgeInsets.only(top : 12.sp),
                height: 90.h,
                  width: 337.w,
                decoration: BoxDecoration(
              
                  borderRadius: BorderRadius.circular(10.r),
              
                ),
              
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle
                      ),
                      child: GestureDetector(
                        onTap: (){
                          // Get.to(const AddContact());
                        },
                        child: Center(
                          child: Text('A'.toString(),style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp
                          ),),
                        ),
                      ),
                    ),
              
                    Column(
              
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
              
                          margin: EdgeInsets.only(left : 16.sp),
                          child: Text('Renuka'.toString(),style:  TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                          ),),
                        ),Container(
                          margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                          child: Text('Inside Sales'.toString(),
                              style: const TextStyle(
                                  color: AppColors.primaryColor
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                          ),
                        );
  }
}