import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../utils/color.dart';


class MyBusinessAlert extends StatelessWidget {
  const MyBusinessAlert({super.key});

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
                  width: 337.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xffF5F6F9)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search , color: AppColors.primaryColor,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w
                        ),
                        hintStyle: const TextStyle(color: Color(0xff707070)),
                        hintText: "Search",

                        fillColor: const Color(0xffF5F6F9)),
                  ),
                ),

                SizedBox(height: 12.h,),
                const NoteItem(),
                const NoteItem(),
                const NoteItem(),


              ],
            ),
          )
      ),

    );
  }
}

class NoteItem extends StatefulWidget {
  const NoteItem({super.key});

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
          const Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

SizedBox getNotecheckList() {
  return SizedBox(
    height: 450.h,
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (_, int index) {
        return  const NoteItem();
      },
    ),
  );
}
