

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';
import 'package:get/get.dart';
import '../controller/opportunity_edit_controller.dart';

class SlantedContainerClipper extends CustomClipper<Path> {
  final double slantHeight;
  final double borderRadius;

  SlantedContainerClipper({this.slantHeight = 10.0, this.borderRadius = 0.0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(borderRadius, 0.0);
    path.lineTo(size.width - borderRadius, 0.0);
    path.lineTo(size.width - borderRadius - slantHeight, size.height);
    path.lineTo(borderRadius + slantHeight, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(SlantedContainerClipper oldClipper) => false;
}


class StageWidget extends StatelessWidget {
  const StageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
      // margin: EdgeInsets.all( 10.h),
      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StageItem(stageWidth: 360,stageName: "LEAD",),
                    StageItem(stageWidth: 340,stageName: "DEMO",),
                    StageItem(stageWidth: 320,stageName: "EVALUATION",),
                    StageItem(stageWidth: 300,stageName: "QUALIFIED",),
                    StageItem(stageWidth: 280,stageName: "NEGOTIATION",),
                    StageItem(stageWidth: 260,stageName: "TEST",),
                    StageItem(stageWidth: 240,stageName: "WON/LOST/DISQUALIFIED",),
    
                    
                  ],
                ),
    );
  }
}

class StageItem extends StatelessWidget {
   StageItem({super.key, required this.stageWidth, required this.stageName});

  final int stageWidth;
  final String stageName;
  OpportunityEditController opportunityEditController = Get.put(OpportunityEditController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => opportunityEditController.isStageOpen.value ? Container(
      margin: EdgeInsets.only(left: 10.h,right: 10.h,top: 10.h),
      child: ClipPath(
                      clipper: SlantedContainerClipper(
                     slantHeight: 12.0, // Adjust the slant height as desired
      ),
                      child: GestureDetector(
                        onTap: () {
                          opportunityEditController.opportunitySelection.value = !opportunityEditController.opportunitySelection.value;
                        },
                        child: Container(
                          
                          width: stageWidth.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                                          
                          
                            color: stageName == "LEAD" ? AppColors.themeColor: Colors.blue.withOpacity(0.1),
                          ),
                          child: Center(child: Text(stageName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color:stageName == "LEAD"?Colors.white : AppColors.themeColor),)),
                        ),
                      ),)
                    ):SizedBox());
    
  }
}