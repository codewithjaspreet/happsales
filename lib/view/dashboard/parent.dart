import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/pages/dashboard.dart';
import 'package:happsales_crm/view/dashboard/pages/notifications.dart';
import 'package:happsales_crm/view/dashboard/pages/opportunities.dart';
import 'package:happsales_crm/view/dashboard/pages/recommendations.dart';
import 'package:happsales_crm/view/dashboard/pages/workflow.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../utils/color.dart';
import '../menu/views/menu.dart';
import '../voiceassistant/parent.dart';



class DashBoardPage extends StatelessWidget {
    DashBoardPage({Key? key}) : super(key: key);

  List list = [
    'assets/dashboard/activity.png',
    'assets/dashboard/oppor.png',
    'assets/dashboard/performance.png',
    'assets/dashboard/workflow.png',
    'assets/dashboard/notification.png',

  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: DefaultTabController(
        initialIndex: 1,
        length: 5,
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
            indicatorColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal:12.w),
              unselectedLabelColor: Colors.grey,
              labelColor:  AppColors.primaryColor,
              tabs: [

                
                Tab(
                  child: Column(
                    children: [
                      Container(
                        width: 22.w,
                        height: 22.h,
                        child: Image.asset(list[0], )),
                      SizedBox(height: 3.h,),
                      FittedBox(child: 
                       
                    
                      Text('Activities',style: TextStyle(
                          fontSize: 7.sp
                        
                        ),),
                      )
                    ],
                  )

                ),


                  Tab(
                  child: Column(
                    children: [
                       Container(
                        width: 22.w,
                        height: 22.h,
                        child: Image.asset(list[1])),
                      SizedBox(height: 3.h,),
                       FittedBox(child:  Text('Opportunities',style: TextStyle(
                        fontSize: 7.sp
                       ),))
                    ],
                  )

                ),
                Tab(
                  child: Column(
                    children: [
                       Container(
                        width: 22.w,
                        height: 22.h,
                        child: Image.asset(list[2])),
                      SizedBox(height: 3.h,),
                      FittedBox(child: Text('Performance',style: TextStyle(
                        fontSize: 7.sp
                      ),))
                    ],
                  )

                ),
                Tab(
                  child: Column(
                    children: [
                      Container(
                        width: 22.w,
                        height: 22.h,
                        child: Image.asset(list[3])),
                      SizedBox(height: 3.h,),
                       FittedBox(child: Text('Workflow',style: TextStyle(
                        fontSize: 7.sp
                      
                      ),))
                    ],
                  )

                ),
                  Tab(
                  child: Container(
                    width: 80.w,
                    height: 40.h,
                    child: Column(
                      children: [
                       Stack(
                        clipBehavior: Clip.none,
                          children: [
                            Container(
                          width: 60.w,
                          height: 20.h,
                          child: Image.asset(list[4])),
                  
                          Positioned(
                            left: 20.w,
                            top: -10,
                            child:Container(
                              margin: EdgeInsets.only(left: 10.w,bottom: 4.h),
                              child: Center(
                                child: Text('2',style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'roboto_bold',
                                  fontSize: 7.sp
                                ),),
                              
                              ),
                            height: 16.h,
                            width: 16.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              color : AppColors.themeColor
                            ),
                          ))
                          ],
                        ),
                        SizedBox(height: 3.h,),
                        FittedBox(child: Text('Notifications',style: TextStyle(
                          fontSize: 7.sp
                        ),))
                      ],
                    ),
                  )

                ),
              ],
            ),
          ),
          body:   Stack(
            children: [ Column(
              children: [
                const Expanded(
                  child: TabBarView(
                  children:  [
                    DashBoardItem(),
                    Opportunities(),
                    Recommendations(),
                    WorkFlowPage(),
                    NotificationPage(),
                    
          
                  ],
          
          
                    ),
                ),
          
                // bottomPanel(),
                
          
              ],
            ),
            bottomDetailsSheet()
            ]
          ),
        ),
      ),
    );
  }
}








