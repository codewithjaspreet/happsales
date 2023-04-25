import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/Addresses/address_details_page.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../../utils/color.dart';
import 'add_address.dart';

class AccountAddress extends StatelessWidget {
  const AccountAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),
      body: Column(
        children: [
          HelperRow(title: 'Account Addresses', direct: AddAddress()),
          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 35.r,
                  child: Center(
                      child:Text("a", style: TextStyle(
                          color: Colors.white , fontSize: 30.sp , fontWeight: FontWeight.w500
                      ),)
                  ),
                ),
                SizedBox(width: 10.w,),
                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("account owner to Deepak",style: TextStyle(color: AppColors.primaryColor,

                        fontSize: 20.sp , fontWeight: FontWeight.w500),),

                    SizedBox(height : 5.h),
                    Text("Aerospace".toUpperCase(),style: TextStyle(color: AppColors.primaryColor,

                        fontSize: 14.sp , fontWeight: FontWeight.w400),) ,

                    SizedBox(height: 5.h,),
                    Text("Bangalore",style: TextStyle(color: AppColors.primaryColor,

                        fontSize: 14.sp , fontWeight: FontWeight.w200),)
                  ],
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(AddressDetailsPage());
                  },
                  child: AddressDetails(

                    info1: 'account owner to Deepak',
                    info2: 'Miss Sunanda Bamnalli',
                    info3: 'Permanent Address',
                    info4: 'I don\'t know',
                    info5: 'Piccadily',
                    info6: 'London',
                    info7: 'United Kingdom',
                    info8: 'W1J',

                  ),
                )

              ],
            ),
            height: 180.h,
            width: 337.w,
            decoration: BoxDecoration(
              color: Color(0xffE5F6FF),
              borderRadius: BorderRadius.circular(10.r),

            ),
          ),
          //



        ],
      ),

    );
  }
}
class AddressDetails extends StatelessWidget {
  const AddressDetails({Key? key, required this.info1, required this.info2, required this.info3, required this.info4, required this.info5, required this.info6, required this.info7, required this.info8}) : super(key: key);

  final String info1;
  final String info2;
  final String info3;
  final String info4;
  final String info5;
  final String info6;
  final String info7;
  final String info8;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 180.h,
      width: 337.w,
      decoration: BoxDecoration(
        color: Color(0xffE5F6FF),
        borderRadius: BorderRadius.circular(10.r),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(info1,style: TextStyle(
              color: AppColors.primaryColor,

              fontSize: 14.sp , fontWeight: FontWeight.bold),
          ),
          Text(info2,style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: "roboto_medium"
          ),),
          Text(info3,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
          Text(info4,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
          Text(info5,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
          Text(info6,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
          Text(info7,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
          Text(info8,style: TextStyle(
            color: AppColors.primaryColor,
          ),),
        ],
      ),
    );
  }
}
