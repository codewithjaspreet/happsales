import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
class CompetitionRow extends StatelessWidget {
   CompetitionRow({Key? key, required this.compTitle, required this.compSubTitle}) : super(key: key);

  final String compTitle;
  final String compSubTitle;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  compTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,


                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  compSubTitle,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
