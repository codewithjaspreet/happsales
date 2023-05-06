import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/BusinessCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDownInput.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';
import 'package:happsales_crm/view/menu/views/menu.dart';

import '../../../../utils/color.dart';
class AddContact extends StatelessWidget {
  const AddContact({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "HappSales",
          style: TextStyle(
              color: Colors.black, fontSize: 16.sp, fontFamily: 'roboto_bold'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
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
              color: Colors.black,
            ),
          ),
        ],
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

        Text("Add Contact",style: TextStyle(fontFamily: "roboto_bold" , color: AppColors.primaryColor ,fontSize: 20.sp ),),
                 Row(
                   children: [
                     Container(
                       margin: EdgeInsets.only(right: 5.w,top: 8.w,),
                       child: Stack(
                         children: [
                           Positioned(

                               child: Image.asset("assets/contacts/chat.png")),
                           Positioned(
                             child: Container(
                               child: Padding(
                                 padding: EdgeInsets.only(right: 15.w),
                                 child: FittedBox(

                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Long press Ami \nto fill the details",style: TextStyle(color: Colors.black,fontSize: 8.sp),),
                                     )),
                               ),
                             ),
                           ),

                         ],
                       ),
                     ),

                     Row(
                       children: [
                         Container(
                           margin: EdgeInsets.only(right: 40.w),

                           child: Image.asset("assets/contacts/ami.png"),
                         ),
                         Container(
                           margin: EdgeInsets.only(right: 12.w),
                           decoration: const BoxDecoration(
                             color: Color(0xffB4C6D4),
                             shape: BoxShape.circle,
                           ),
                           width: 24.w,
                           height: 24.h,
                           child: const Center(
                             child:Icon(
                               Icons.cancel_outlined,
                               color: Colors.white,
                             ),
                           ),
                         ),

                       ],
                     ),
                   ],
                 )
                ],
              ),
            ),

            GestureDetector(
                onTap: () {
                  showDialogs(context);
                },
                child: const BusinessCard()),

            Hdivider(),
            const MyRow()


          ],
        ),
      )
    );
  }


}










class MyRow extends StatefulWidget {
  const MyRow({super.key});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Column(
        children:[
          Container(
            margin: EdgeInsets.only(top: 15.h  , left: 16.w , right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact Details' ,style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_medium" ,
                        fontSize: 14.sp),),


                  ],
                ),
                GestureDetector(
                    onTap: _toggleDropdown,
                    child: Image.asset(_isOpen ? "assets/contacts/back.png" : "assets/contacts/up.png")),
              ],
            ),
          ),


          if(_isOpen)
            SingleChildScrollView(
              child: Column(
                children: [
                  DropDownInput(hint : 'Title *'),
                  const Input(title: 'First Name*',),
                  const Input(title: 'Last Name',),
                  const Input(title: 'Account name',),
                  DropDownInput(hint : 'designation'),
                  DropDownInput(hint : 'Mobile Number'),
                  const Input(title: 'Mobile Number',),
                  const Input(title: 'alternate Mobile Number',),
                  const Input(title: 'Work Phone',),
                  const Input(title: 'residence phone',),
                  const Input(title: 'email address',),
                  const Input(title: 'alternate email address',),
                  const Input(title: 'Address Line',),
                  const Input(title: 'Address Line 2',),
                  const Input(title: 'Address Line 3',),
                  DropDownInput(hint: 'city',),
                  DropDownInput(hint:  'state',),
                  DropDownInput(hint: 'country',),
                  const Input(title: 'pincode',),
                  const Input(title: 'GPS Coordinate',),







                ],
              ),
            )
        ]
      ),
    );
  }

}





