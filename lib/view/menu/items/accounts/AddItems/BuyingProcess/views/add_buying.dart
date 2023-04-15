import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
import '../../../../contacts/widgets/CustomAppBar.dart';
import '../../../../contacts/widgets/HelperRow.dart';
import '../../../../contacts/widgets/InputOne.dart';

class AddBuying extends StatelessWidget {
  const AddBuying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: CustomAppBar(context),
      body: Column(
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

          Input( title: "Account Name*" ,)
        ],
      ),
    );
  }
}
