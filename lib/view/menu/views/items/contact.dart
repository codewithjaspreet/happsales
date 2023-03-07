import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Text("My Contact" , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 16.sp,color: Color(0xff171A63)),),

        actions: [
          Container(
            margin:  EdgeInsets.only(right: 10.w),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff171A63),

            ),
            child: Center(
              child: Icon(Icons.add ,color: Colors.white,),
            ),
          ),
          Container(
            margin:  EdgeInsets.only(right: 10.w),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff171A63),

            ),
            child: Center(
              child: Icon(Icons.more_vert ,color: Colors.white,),
            ),
          )
        ],
      ),


      body: const Center(
        child: Text("Contact Page"),
      ),
    );
  }
}
