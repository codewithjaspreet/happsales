import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import '../../../../../utils/color.dart';
import 'add_notes.dart';
class NotesListing extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(context),
      body: Column(
        children: [
          HelperRow(title: 'Notes', direct: AddNotes()),
          Image.asset("assets/contacts/contact_banner.png"),
          buildNotesList(),
        ],
      ),
    );
  }
}
buildNotesList() {
  return  Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(12.sp),
        itemCount:6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 13.w  , vertical: 6.h),
            height: 99.h,
            width: 336.w,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffB4C6D4).withOpacity(0.8)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left : 12.sp,bottom: 18.h),
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: const Color(0xff00A6D6),
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Image.asset('assets/notes/photo.png',scale: 0.7,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      margin: EdgeInsets.only(left : 16.sp),
                      child:Text('The',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold
                          )),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Created By',
                                style: TextStyle(
                                  fontFamily: 'roboto_regular',

                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff00A6D6),


                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'deepak',
                                style: TextStyle(

                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Created Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'roboto_regular',
                                  color: Color(0xff00A6D6),


                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                '25 Mar 2023',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),


                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left : 40.w,top: 10.h),
                  child: Column(
                    children: [
                      Image.asset('assets/notes/delete.png')
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ));
}