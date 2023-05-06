import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
class BuySecondRow extends StatelessWidget {
  const BuySecondRow({Key? key, required this.compTitle, required this.compSubTitle}) : super(key: key);

  final String compTitle;
  final String compSubTitle;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w , vertical:14.h
      ),
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
                    color: const Color(0xff00A6D6),


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
