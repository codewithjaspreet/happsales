import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../../utils/color.dart';
import 'edit_address.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'HAPPSALES-ACADR-0000000072',
                    style: TextStyle(
                        fontFamily: 'roboto_medium',
                        fontSize: 14.sp,
                        color: AppColors.primaryColor),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const EditAddress());
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 30.w,
                        height: 30.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff171A63),
                        ),
                        child: Center(
                          child: Image.asset('assets/contacts/edit.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.sp),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 35.r,
                  child: Center(
                      child: Text(
                    "a",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "account owner to Deepak",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Aerospace".toUpperCase(),
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Bangalore",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w200),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Permanent Address',
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text('I don\'t know '),
                const Text('Hugh'),
                SizedBox(
                  height: 10.h,
                ),
                const Text('Piccadilly'),
                const Text('London '),
                const Text('United Kingdom'),
                const Text('W1J'),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Text(
                  'GPS Coordinates',
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text('51.50998, -0.1337'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
