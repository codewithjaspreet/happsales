import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';

import '../../../../../../../utils/color.dart';
import '../widgets/buy_row.dart';
import 'add_buying.dart';
class BuyingProcess extends StatelessWidget {
  const BuyingProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: CustomAppBar(context),
      
      body : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            HelperRow(title: "Buying Process", direct: AddBuying()),

            Container(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: [
                  Stack(
                    children: [

                      Positioned(child: Container(
                        child: Center(

                          child: Text("S",style: TextStyle(color: Color(0xff00C6FF),fontSize: 37.sp),),
                        ),

                        width: 68.w,
                        height: 68.h,
                        decoration: BoxDecoration(
                          color: Color(0xffE5F6FF),
                          borderRadius: BorderRadius.circular(9.sp),

                        ),
                      )),

                      Positioned(
                          left: 45.w,

                          top: 4.h,
                          child: Container(

                            width: 15.w,
                            height: 15.h,

                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff00C6FF)
                            ),

                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                            ),
                          ))



                    ],
                  ),
                  SizedBox(width: 20.w,),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Suvarna Traders",style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 20.sp , fontWeight: FontWeight.w500),),

                      SizedBox(height : 5.h),
                      Text("Chemicals",style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 14.sp , fontWeight: FontWeight.w400),) ,

                      SizedBox(height: 5.h,),
                      Text("Bangalore",style: TextStyle(color: AppColors.primaryColor,

                          fontSize: 14.sp , fontWeight: FontWeight.w200),)
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(

                    padding :  EdgeInsets.all(10.sp),

                    child: BuyRow(title: "HPSTBP001" , date: "2021-09-01", content : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod ….. invidunt ut labore et dolore magna.")),
                Container(

                    padding :  EdgeInsets.all(10.sp),

                    child: BuyRow(title: "HPSTBP001" , date: "2021-09-01", content : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod ….. invidunt ut labore et dolore magna.")),
                Container(

                    padding :  EdgeInsets.all(10.sp),

                    child: BuyRow(title: "HPSTBP001" , date: "2021-09-01", content : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod ….. invidunt ut labore et dolore magna.")),

              ],
            )

          ],
        ),
      )
      
      
    );
  }
}

