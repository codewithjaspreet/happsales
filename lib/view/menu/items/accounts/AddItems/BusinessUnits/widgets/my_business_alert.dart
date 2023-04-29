import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';
import '../../../../contacts/widgets/HDivider.dart';


class MyBusinessAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 60.h),
      title: Row(
        children: [
          Image.asset('assets/accounts/close.png'),
          SizedBox(width: 20.w,),
          Text("Select Business Units",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      content: Container(
          width: 339.w,
          height: 450.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search , color: AppColors.primaryColor,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w
                        ),
                        hintStyle: TextStyle(color: Color(0xff707070)),
                        hintText: "Search",

                        fillColor: Color(0xffF5F6F9)),
                  ),

                  width: 337.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xffF5F6F9)
                  ),
                ),

                SizedBox(height: 12.h,),
                NoteItem(),
                NoteItem(),
                NoteItem(),


              ],
            ),
          )
      ),

    );
  }
}

class NoteItem extends StatefulWidget {
  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Icon(
                  isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Colors.blue ,
                ),
              ),
              SizedBox(width: 10.w,),
              Text(
                "Item Name",
                style: TextStyle(
                  color:  AppColors.primaryColor  ,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

Container getNotecheckList() {
  return Container(
    height: 450.h,
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (_, int index) {
        return NoteItem();
      },
    ),
  );
}
