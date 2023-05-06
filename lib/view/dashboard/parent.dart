import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/pages/dashboard.dart';
import 'package:happsales_crm/view/dashboard/pages/opportunities.dart';
import 'package:happsales_crm/view/dashboard/pages/recommendations.dart';

import '../menu/views/menu.dart';
import '../voiceassistant/parent.dart';



class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xffF3F4F8),
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  Get.to(() => const Menu());
                },
                child: Container(
                  margin:  EdgeInsets.only(right: 10.w),
                  child:  const Icon(Icons.menu,color: Colors.black,),
                ),
              )
            ],
            elevation: 0.0,

            backgroundColor: const Color(0xffF3F4F8),
            title: const Text('HappSales' ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            centerTitle: true,
            bottom: TabBar(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              unselectedLabelColor: const Color(0xffB5B6B9),
              labelColor: const Color(0xff171A63),




              indicator:  BubbleTabIndicator(
                indicatorHeight: 46.h,

                indicatorColor: const Color(0xffFFFFFF),

                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),


              tabs: [
                Tab(
                  child: Container(
                    width: 86.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          'Dashboard',
                            style : TextStyle(
                                fontFamily: 'roboto_bold'
                            )

                        ),
                      ),
                    ),
                  ),

                ),


                Tab(
                  child: Container(
                    width: 86.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          'Opportunities',
                            style : TextStyle(
                                fontFamily: 'roboto_bold'
                            )

                        ),
                      ),
                    ),
                  ),

                ),
                Tab(
                  child: Container(
                    width: 86.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: const Center(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Recommendations',
                          style : TextStyle(
                            fontFamily: 'roboto_bold'
                          )

                          // style: GoogleFonts.poppins(
                          //   fontSize: 16.sp,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
          body:   Column(
            children: [
              const Expanded(
                child: TabBarView(
                children:  [
                  DashBoardItem(),
                  Opportunities(),
                  Recommendations(),

                ],


                  ),
              ),

              bottomPanel(),

            ],
          ),
        ),
      ),
    );
  }
}








