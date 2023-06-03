import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ToggleButtonRow.dart';

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
        children:[ Container(
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

        Container(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                
                children: [
                      

            ConversationList(),
           SendingTile()

              ]
              
              ),
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

        ]
      ),
    );
  }
}

class ConversationList extends StatelessWidget {
   ConversationList({super.key});
   
List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
      ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),

    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "receiver"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),

    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "receiver"),

  
  ];
 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
  itemCount: 5,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 10.sp,bottom: 10.sp),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index){
    return Container(
      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
      child: Align(
        alignment: (messages[index].messageType == "receiver"?Alignment.topRight:Alignment.topLeft),
        child: Container(
          
          height: 100.h,
          width: double.infinity,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(messages[index].messageType == 'receiver' ? "You" : 'Renuka', style: TextStyle(fontSize: 15.sp),),
              SizedBox(height: 6.sp,),

              Text(messages[index].messageContent, style: TextStyle(fontSize: 15.sp),),
                           SizedBox(height:10.sp,),

              Container(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('23-Dec-2021 11:01',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp
                    ),),
                    SizedBox(width: 10.w,),
                    Icon(Icons.done_all,size: 15.sp,color: Colors.grey,)
                  ],
                ),
              )
            ],
          )),
        ),
      
    );
  },
);
  }
}


class SendingTile extends StatelessWidget {
  const SendingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
              margin: EdgeInsets.only(top: 200.h,left: 10.w,right: 10.w),
              child: Stack(
                    children: <Widget>[
                      Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.sp),
                  border: Border.all(color: Colors.black.withOpacity(0.5))
                ),
                height: 40.h,
                
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                            
                          Expanded(
                            child: TextField(
                              
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.send,color: AppColors.primaryColor,),
                                hintText: "Chat with Renuka...",
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          
                        ],
                        
                      ),
                     
                    ],
                  ),
                ),
              ),
                      ),
                    ],
                  ),
            );
  }
}

