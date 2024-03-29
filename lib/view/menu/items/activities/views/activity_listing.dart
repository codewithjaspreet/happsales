import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/activities/views/tabs/completed/completed.dart';
import 'package:happsales_crm/view/menu/items/activities/views/tabs/today/today.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/voiceassistant/sheet.dart';

import '../../../../../utils/color.dart';
import '../../../../voiceassistant/parent.dart';
import '../../opportunity/widgets/menu_popup.dart';
import 'tabs/overdue/overdue.dart';

class ActivityListing extends StatelessWidget {
  const ActivityListing({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(context),
        body: Stack(
          children:[  Container(
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
        
                    tabs:   const [
                      Tab(
        
                        child: FittedBox(child: Text('Overdue',style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: 'roboto_bold'
                          
                        ),)),
                      ),
                      Tab(
        
                        child: FittedBox(fit: BoxFit.cover,child: Text('Today'
                        
                        ,style: TextStyle(
                          fontFamily: 'roboto_bold',
                          color: AppColors.primaryColor
                        ),
                        ),),
                      ),
                      Tab(
        
                        child: FittedBox(child: Text('Week',style: TextStyle(
                          fontFamily: 'roboto_bold',
                          color: AppColors.primaryColor
                        ),)),
                      ),
                      Tab(
        
                        child: FittedBox(child: Text('Completed',style: TextStyle(
                          fontFamily: 'roboto_bold',
                          color: AppColors.primaryColor
                        ),)),
                      ),
                     
                      
                    ],
                  ),
                ),
                SizedBox(width: 10.w,),
        
        
                 const OpportunitiesPopup(),
                  
                  // child: Image.asset('assets/notes/more.png',)),
                  ],
                ),
                
                 Expanded(
                    child: TabBarView(
                      children:  [
                        const ActivityOverDue(),
                        ActivityToday(),
                        const Center(child: Text('Calls Page'),),
                        const ActivityCompleted(),
                      ],
                    )
                ),
        
        
                bottomPanel()
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