import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
import '../../../../contacts/widgets/CustomAppBar.dart';

class BuyDetails extends StatelessWidget {
  const BuyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),

      body: Column(
        children: [
          RowOne(),
          RowTwo(),
          RowThree(),
        ],
      ),

    );
  }
}

class RowOne extends StatelessWidget {
  const RowOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("Buying Process code" , style: TextStyle(
                    color: Color(0xff00A6D6),
                    fontSize: 14.sp,
                    fontFamily: 'roboto_bold'
                ),),

              ),
              Container(
                child: Text("HPSTBP001" , style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'roboto_regular'
                ),),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w,bottom: 16.h),
            child: GestureDetector(
                onTap: (){


                },
                child: Container(
                  child: Center(
                    child: Image.asset("assets/contacts/edit.png"),
                  ),
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                )),
          ),




        ],
      ),
    );
  }
}
class RowTwo extends StatelessWidget {
  const RowTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("Account name" , style: TextStyle(
                    color: Color(0xff00A6D6),
                    fontSize: 14.sp,
                    fontFamily: 'roboto_bold'
                ),),

              ),
              Container(
                child: Text("Suvarna Traders" , style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'roboto_regular'
                ),),
              ),
            ],
          ),





        ],
      ),
    );
  }
}
class RowThree extends StatelessWidget {
  const RowThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("Buying Process code" , style: TextStyle(
                    color: Color(0xff00A6D6),
                    fontSize: 14.sp,
                    fontFamily: 'roboto_bold'
                ),),

              ),


            ],
          ),





        ],
      ),
    );
  }
}

