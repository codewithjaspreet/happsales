import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../../../../utils/color.dart';
import '../../../../../../../voiceassistant/sheet.dart';

class ImportContact extends StatelessWidget {
  const ImportContact({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),
      body: Stack(children: [

        Column(children: [

          Container(
      padding: EdgeInsets.all(12.sp),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Import Contacts' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  // Get.to(direct);
                },
                child: Container(
                  margin:  EdgeInsets.only(right: 16.w),
                  width: 30.w,
                  height: 30.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),

                  ),
                  child: const Center(
                    child: Icon(Icons.add ,color: Colors.white,),
                  ),
                ),
              ),
              Center(

                child:  Container(
                  margin:  EdgeInsets.only(right: 16.w),
                  width: 25.w,
                  height: 25.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff171A63),

                  ),
                  child: const Center(
                    child: Icon(Icons.search ,color: Colors.white,),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),

        ],),

        bottomDetailsSheet()
      ]),
    );
  }
}