 import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubDetailExpense2 extends StatelessWidget {
   SubDetailExpense2({super.key, required this.title1, required this.subTitle1, });

  final String title1;
  final String subTitle1;


  @override
  Widget build(BuildContext context) {
    return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            
                      Expanded(child:
                      Container(
                  margin: EdgeInsets.only(
                    left: 14.w,
                    top: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( title1,style: TextStyle(
                        fontSize: 13.sp ,
                        color: const Color(0xff00A6D6),
                        fontWeight: FontWeight.bold,
                        fontFamily: "roboto_bold",
                      ),),
                      SizedBox(height: 3.h,),
                      Text(subTitle1),
                    ],
                  ),
                      ) ),
                      
            
            
                    ],
                  ),
                );
  }
}