import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/BusinessCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/DropDownInput.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';
import 'package:happsales_crm/view/menu/views/menu.dart';

import '../../../../utils/color.dart';
class AddAccount extends StatelessWidget {


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
                Get.to(() => Menu());
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

                    Text("Add Accounts",style: TextStyle(fontFamily: "roboto_bold" , color: AppColors.primaryColor ,fontSize: 20.sp ),),
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
                              decoration: BoxDecoration(
                                color: Color(0xffB4C6D4),
                                shape: BoxShape.circle,
                              ),
                              width: 24.w,
                              height: 24.h,
                              child: Center(
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
                  child: BusinessCard()),

              Hdivider(),
              MyRow()


            ],
          ),
        )
    );
  }


}


class MyRow extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  bool _isOpen = true;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Container(
            margin: EdgeInsets.only(top: 15.h  , left: 16.w , right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account Details' ,style: TextStyle(color: AppColors.primaryColor,fontFamily: "roboto_medium" ,
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
              child: GestureDetector(
                onTap: (){
                  _toggleDropdown();
                },
                child: Column(
                  children: [
                    CustomDropDown(items: [

                      DropdownMenuItem(child:

                          Text("Account 1"),
                          value: "account 1",

                      ),


                    ],
                      labelText: "AccountName *",


                    ),
                    Input(title: 'Location *',),
                    Input(title: 'Segment',),
                    Input(title: 'Status',),
                    CustomDropDown(items: [], labelText: "Type"),
                    CustomDropDown(items: [], labelText: "Industry"),
                    // DropDownInput(hint : 'Type'),
                    // DropDownInput(hint : 'Industry'),
                    Input(title: 'Work phone',),
                    Input(title: 'Website',),
                    Input(title: 'Turnover (Cr)',),
                    Input(title: 'No. Of Employees',),
                    Input(title: 'Credit Rating',),
                    Input(title: 'Currency',),
                    Input(title: 'Tags',),
                    Input(title: 'Add Category',),

                  ],
                ),
              ),
            ),
          Container(
            margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white,fontSize: 18.sp),)),
                  width: 125.w,
                  height:48.h,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(26.sp),
                    color: Color(0xff8199AC),
                  ),
                ),
                Container(
                  child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 18.sp),)),
                  width: 125.w,
                  height:48.h,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(26.sp),

                    shape: BoxShape.rectangle,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          )

        ]
    );
  }

}





