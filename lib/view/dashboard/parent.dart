import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/view/dashboard/pages/dashboard.dart';
import 'package:happsales_crm/view/dashboard/pages/opportunities.dart';
import 'package:happsales_crm/view/dashboard/pages/recommendations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../menu/views/menu.dart';


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
              SlidingUpPanel(
                backdropColor: Colors.white,
                renderPanelSheet: false,
                panel: _floatingPanel(),
                collapsed: _floatingCollapsed(),

              )
            ],
          ),
        ),
      ),
    );
  }
}


Widget _floatingCollapsed(){
  return Stack(
    clipBehavior: Clip.none,


      children :[

        Positioned(
          top: -5.h,
          left: 160.w,
          child: GestureDetector(
            onTap: () {
              _floatingPanel();
            },
            child:
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: const BoxDecoration(

                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/ami/ami_logo.png"),
                ),


          ),
        ),
        Positioned(
          left: 125.w,
          top: 76.h,
          child: Container(
          child: Text("Powered by HappSales",style: TextStyle(
              fontFamily: "roboto_regular",
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color:const Color(0xffB4C6D4)
          ),),
        ),)



      ]
  );
}

Widget _floatingPanel(){
  return Container(
  decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24.sp)),

  ),
  // margin: const EdgeInsets.all(24.0),
  child: Column(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 52.h),
          child:    Column(
            children: [
              Container(
                child: Text("Hi I'm Ami, how can I help you?",style: TextStyle(
                    fontFamily: 'roboto_bold',
                    fontSize: 18.sp
                    ,
                    fontWeight: FontWeight.w500

                ),),
              ),


              Container(
                margin: EdgeInsets.only(top: 22.h),

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AmiRow("assets/ami/building.png" , "I want to know about my company")
                      ,AmiRow("assets/ami/people.png" , "Want to create a contact?")
                      ,AmiRow("assets/ami/money.png" , "Want to create an opportunity?")
                      ,AmiRow("assets/ami/calender.png" , "Want to create an activity?")

                    ],
                  ),

              ),

              Container(

                margin: EdgeInsets.only(top: 20.h),

                  child: AmiVoice()),

              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Text("Powered by HappSales",style: TextStyle(
                    fontFamily: "roboto_regular",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color:const Color(0xffB4C6D4)
                ),),
              )
            ],
          )
        ),
      ),

    ],
  ),
    );
}


Widget AmiRow(String imageUrl , String title ){


  return Container(
    margin: EdgeInsets.only(top: 12.h),
    width: 323.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: const Color(0xff171A63),
      borderRadius: BorderRadius.circular(24.sp),
    ),
    child: Container(

      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageUrl),
              Container(
                margin: EdgeInsets.only(left: 8.w),
                child: Text(title,style: TextStyle(
                    fontFamily: 'roboto_medium',
                    fontSize: 14.sp
                    ,
                    color: Colors.white,
                    fontWeight: FontWeight.w400

                ),),
              ),

            ],
          ),
          Container(
            child: Image.asset("assets/ami/forward.png"),
          )
        ],
      ),
    ),
  );

}


Widget AmiVoice(){

  return Container(

    width: 323.w,
    height: 50.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xffB4C6D4),
        width: 1,
      ),
      color:  Colors.white,
      borderRadius: BorderRadius.circular(24.sp),
    ),

    child: Container(
      margin : EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Chat or give a voice command to Ami!",style: TextStyle(
            color: Color(0xffB4C6D4)
          ),),

          SizedBox(
            width: 22.h,
            height: 22.h,
              child: Image.asset("assets/ami/voice.png"))
        ],
      ),
    ),
  );

}