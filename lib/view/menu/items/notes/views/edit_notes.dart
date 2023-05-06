import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/InputOne.dart';
import '../../../../../utils/color.dart';
import '../../contacts/widgets/add_tag.dart';
class EditNotes extends StatelessWidget {

  const EditNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

  Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Edit Notes' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          
        ],
      ),
    ),

    Input(title: 'Note Content * ', ),
    SizedBox(height: 10.h,),
    Input(title: 'Note Date ', ),
    SizedBox(height: 20.h,),

    Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Text('Link this Note to',style: TextStyle(
    
        fontFamily: 'roboto_regular',
        color: Colors.grey,
        fontSize: 14.sp,
      ),),
    ),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24, right: 24),
        children: [
        
          
          
        ],
      ),


TagInputWidget(),
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

    
          ]),

    );
  }
}