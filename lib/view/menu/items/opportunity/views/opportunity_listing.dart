import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/tabs/closed/views/closed.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/tabs/closed/widgets/popup.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/tabs/overdue/views/overdue.dart';
import 'package:happsales_crm/view/voiceassistant/parent.dart';

import '../../../views/menu.dart';
import '../../notes/widgets/notes_popup.dart';
import '../widgets/menu_popup.dart';

class OpportunityListing extends StatelessWidget {
  const OpportunityListing({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(context),
        body: Container(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                height: 50.h,
                width: 312.w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50.sp)
                ),
                child:  TabBar(
                  unselectedLabelColor: const Color(0xffB5B6B9),
              labelColor: const Color(0xff171A63),
                  
                  padding: EdgeInsets.all(2.sp),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.circular(25.0)
                  ) ,

                  tabs:   [
                    Tab(

                      child: FittedBox(child: Text('Overdue',style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'roboto_bold'
                        
                      ),)),
                    ),
                    Tab(

                      child: FittedBox(child: Text('Today'
                      
                      ,style: TextStyle(
                        fontFamily: 'roboto_bold',
                        color: AppColors.primaryColor
                      ),
                      ),fit: BoxFit.cover,),
                    ),
                    Tab(

                      child: FittedBox(child: Text('Week',style: TextStyle(
                        fontFamily: 'roboto_bold',
                        color: AppColors.primaryColor
                      ),)),
                    ),
                    Tab(

                      child: FittedBox(child: Text('Ongoing',style: TextStyle(
                        fontFamily: 'roboto_bold',
                        color: AppColors.primaryColor
                      ),),fit: BoxFit.contain),
                    ),
                    Tab(

                      child: FittedBox(child: Text('Closed',style: TextStyle(
                        fontFamily: 'roboto_bold',
                        color: AppColors.primaryColor
                      ),)),
                    ),
                    
                  ],
                ),
              ),
              SizedBox(width: 10.w,),


               OpportunitiesPopup(),
                
                // child: Image.asset('assets/notes/more.png',)),
                ],
              ),
              
               Expanded(
                  child: TabBarView(
                    children:  [
                      OverDue(),
                      Center(child: Text("Status Pages"),),
                      Center(child: Text('Calls Page'),),
                      Center(child: Text('Settings Page'),),
                      Closed()
                    ],
                  )
              ),


              bottomPanel()
            ],
          ),
        )
      ),
    );
  }
}