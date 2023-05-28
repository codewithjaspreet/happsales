import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/tabs/closed/views/closed.dart';
import 'package:happsales_crm/view/menu/items/opportunity/views/tabs/overdue/views/overdue.dart';
import 'package:happsales_crm/view/voiceassistant/parent.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../widgets/menu_popup.dart';

class OpportunityListing extends StatelessWidget {
  const OpportunityListing({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(context),
        body: Stack(
          children:[ Container(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                  height: 50.h,
                  width:320.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50.sp)
                  ),
                  child:  TabBar(
                    unselectedLabelColor: const Color(0xffB5B6B9),
                labelColor: const Color(0xff171A63),
                    
                    // padding: EdgeInsets.all(2.sp),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.circular(16.0)
                    ) ,
        
                    tabs:    [
                      Tab(
        
                        child: Container(
                          child: Text('Overdue',style: TextStyle(
                            fontSize: 9.sp,
                            color: AppColors.primaryColor,
                            fontFamily: 'roboto_bold'
                            
                          ),),
                        ),
                      ),
                      Tab(
        
                        child: Text('Today'
                        
                        ,style: TextStyle(
                                                    fontSize: 9.sp,
        
                          fontFamily: 'roboto_bold',
                          color: AppColors.primaryColor
                        ),
                        ),
                      ),
                      Tab(
        
                        child: Text('Week',style: TextStyle(
                          fontFamily: 'roboto_bold',
                                                    fontSize: 9.sp,
        
                          color: AppColors.primaryColor
                        ),),
                      ),
                      Tab(
        
                        child: Text('Ongoing',style: TextStyle(
                          fontFamily: 'roboto_bold',
                                                    fontSize: 9.sp,
        
                          color: AppColors.primaryColor
                        ),),
                      ),
                      Tab(
        
                        child: Text('Closed',style: TextStyle(
                                                    fontSize: 9.sp,
        
                          fontFamily: 'roboto_bold',
                          color: AppColors.primaryColor
                        ),),
                      ),
                      
                    ],
                ),
                ),
                SizedBox(width: 10.w,),
        
        
                 const OpportunitiesPopup(),
                  
                  // child: Image.asset('assets/notes/more.png',)),
                  ],
                ),
                
                 const Expanded(
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
        
        
               
              ],
            ),
          ),
          bottomDetailsSheet()
          ]
        )
      ),
    );
  }
}