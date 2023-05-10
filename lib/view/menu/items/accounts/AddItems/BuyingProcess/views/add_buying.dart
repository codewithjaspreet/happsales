import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
import '../../../../contacts/widgets/CustomAppBar.dart';
import '../../../../contacts/widgets/InputOne.dart';
import '../../../../contacts/widgets/ToggleButtonRow.dart';
import '../../widgets/new_process_add_feild.dart';

class AddBuying extends StatelessWidget {
  const AddBuying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: CustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.all(12.sp),
              child: Text("New Buying Process" , style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20.sp,
                fontFamily: 'roboto_bold'
              ),),
            ),


            const Input(title: 'Account Name *'),
            SizedBox(height: 12.h,),

            const NewProcessAddFeild(title: 'Buying Process Code *',),




            ToggleButtonRow(title: 'Is Active', isAlreadyActive: true,),
            Container(
              margin:   EdgeInsets.symmetric(horizontal : 15.w , vertical: 45.h),
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
      ),
    );
  }
}
