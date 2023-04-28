import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/alert.dart';

import '../../../../../../utils/color.dart';
import '../../../contacts/widgets/CustomAppBar.dart';
import 'add_business_units.dart';

class BusinessUnit extends StatelessWidget {
  const BusinessUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body:Column(
        children: [

          Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Business Units' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
              Container(
                margin:  EdgeInsets.only(right: 16.w),
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff171A63),

                ),
                child:  GestureDetector(
                  onTap: (){
                    showDialogs(context);
                  },
                  child: Center(
                    child: Icon(Icons.add ,color: Colors.white,),
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
                      child:Text("c".toUpperCase(), style: TextStyle(
                          color: Colors.white , fontSize: 30.sp , fontWeight: FontWeight.w500
                      ),)
                  ),
                ),
                SizedBox(width: 20.w,),
                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text("Cruzer Blade pvt ltd",style: TextStyle(color: AppColors.primaryColor,

                        fontSize: 20.sp , fontWeight: FontWeight.w500),),

                    SizedBox(height: 5.h,),
                    Text("Malaysia",style: TextStyle(color: AppColors.primaryColor,

                        fontSize: 14.sp , fontWeight: FontWeight.w200),)
                  ],
                )
              ],
            ),
          ),
          BusinessUnitRow(title: 'Cloud'),
          BusinessUnitRow(title: 'IDC Infra'),

          Expanded(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Center(child: Text("Cancel" , style:   TextStyle(color: Colors.white),)),
                          width: 125.w,
                          height:48.h,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(26.sp),
                            color: Color(0xff8199AC),
                          ),
                        ),
                        Container(
                          child: Center(child: Text("Save" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold"),)),
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
                ],
              )

          ),


        ],
      )

    );
  }
}
class BusinessUnitRow extends StatelessWidget {
  const BusinessUnitRow({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ,style:  TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,

            ),),
            Icon(Icons.delete_outline ,color: AppColors.primaryColor,),
          ],
        ),
      ),
      width: 337.w,
      height: 45.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey,width: 1),
      ),
    );
  }
}
