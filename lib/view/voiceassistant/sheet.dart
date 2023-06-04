import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/voiceassistant/voice.dart';

import 'ami_row.dart';

Widget bottomDetailsSheet() {

List<String> animalNames = ['Elephant', 'Tiger', 'Kangaroo'];
List<String> animalFamily = ['Elephantidae', 'Panthera', 'Macropodidae'];
List<String> animalLifeSpan = ['60-70', '8-10', '15-20'];
List<String> animalWeight = ['2700-6000', '90-310', '47-66'];
int selectedTile = 0;

return DraggableScrollableSheet(
  initialChildSize: 0.18,
  minChildSize: 0.18,
  maxChildSize: .6,
  builder: (BuildContext context, ScrollController scrollController) {
  return Stack(
          clipBehavior: Clip.none,

    children: [

      
Container(
    decoration: BoxDecoration(
      boxShadow:  [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 6,
          blurRadius: 12,
          offset: Offset(0, 10), // changes position of shadow
        ),],
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        
        topRight: Radius.circular(15.r),
      ),
    ),
    child: ListView(
    controller: scrollController,
    children: [
    
      Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 55.h),
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
                margin: EdgeInsets.only(top: 8.h),

                    child: Text("Powered by HappSales",style: TextStyle(
                        fontFamily: 'roboto_regular',
                        color: Colors.grey,
                        fontSize: 10.sp
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
  ),

  Positioned(
        top: -50,
        left: 150.w,
        
        child: Container(
        
          child: Center(
            child: Image.asset('assets/ami/ami_logo.png'),
          ),
        
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
        boxShadow:  [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(-0, -2), // changes position of shadow
        ),],
          color: Colors.white,
          shape: BoxShape.circle, 
        
        ),
            
            )),
    ],
  );
  },
);
}
 class CustomClip extends CustomClipper<Path> {
      @override
      Path getClip(Size size) {
        double radius = 100;
    
        Path path = Path();
        path
          ..moveTo(size.width / 2, 0)
          ..arcToPoint(Offset(size.width, size.height),
              radius: Radius.circular(radius))
          ..lineTo(0, size.height)
          ..arcToPoint(
            Offset(size.width / 2, 0),
            radius: Radius.circular(radius),
          )
          ..close();
    
        return path;
      }
    
      @override
      bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
        return true;
      }
    }