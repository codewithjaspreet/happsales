import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

class MySalesPerformance extends StatelessWidget {
  const MySalesPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(16.sp),
            child: Text(
              'My Sales Performance'
              ,style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.primaryColor ,
                fontWeight: FontWeight.bold
              
              ),
            ),
          )
        ],
      ),
    );
  }
}