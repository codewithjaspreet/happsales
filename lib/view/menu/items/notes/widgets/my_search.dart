
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';

import '../views/view_notes.dart';

class MySearchAlert extends StatelessWidget {
  const MySearchAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w , vertical: 30.h),
      title: Row(
        children: [
          Image.asset('assets/accounts/close.png'),
          SizedBox(width: 70.w,),
          Text("Search Note",style: TextStyle(color: AppColors.primaryColor , fontSize: 20.sp , fontWeight: FontWeight.bold),),
                    SizedBox(width: 70.w,),

          Container(
            width: 25.w,
            height: 25.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor
            )
      ,
            child: const Center(child: Icon(
              Icons.add,
              color: Colors.white,
            )),
          ),
        
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      content: Container(
        width: 339.w,
        height: 604.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
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
                     suffixIcon: const Icon(Icons.search , color: Colors.grey,),
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
              _buildEmployeeListView(),



            ],
          ),
        )
      ),

    );
  }
}
_buildEmployeeListView() {

 

  return  SingleChildScrollView(
    child: SizedBox(
      height: 704.h,
      child: ListView.builder(

        itemCount: 10,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: (){
              Get.to(const ViewnNotes());
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 4.h
              ),
              height: 99.h,
              width: 336.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB4C6D4).withOpacity(0.8)),
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
                                    color: const Color(0xff00A6D6),
          
          
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
                                    color: const Color(0xff00A6D6),
          
          
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
          
                  
                ],
              ),
            ),
          );
          // return GestureDetector(
          //   onTap: (){

          //     //print("THE ID IS${contactController.contacts[index].contactID}");
          //     //Get.to(() => ContactDetails(Id : contactController.contacts[index].contactID,));
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(top : 12.sp),
          //     height: 80.h,
          //     width: 337.w,
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey),

          //       color: Colors.white ,
          //       borderRadius: BorderRadius.circular(10.r),

          //     ),

          //     child: Row(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(left : 12.sp),
          //           width: 40.w,
          //           height: 40.w,
          //           decoration: BoxDecoration(
          //               color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
          //               ,
          //               shape: BoxShape.circle
          //           ),
          //           child: GestureDetector(
          //             onTap: (){
          //               //Get.to(AddContact());
          //             },
          //             child: Center(
          //               child: Text('S'.toUpperCase(),style: TextStyle(
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20.sp
          //               ),),
          //             ),
          //           ),
          //         ),

          //         Column(

          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(

          //               margin: EdgeInsets.only(left : 16.sp),
          //               child: Text('Jaspreet',style: TextStyle(
          //                   color: AppColors.primaryColor,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 16.sp
          //               ),),
          //             ),Container(
          //               margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
          //               child: Text('Tester',
          //                   style: TextStyle(
          //                     fontSize: 14.sp,
          //                       color: AppColors.primaryColor
          //                   )),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // );
        },
      ),
    ),
  );
}


buildNotesList() {
  return  Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(12.sp),
        itemCount:6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.to(const ViewnNotes());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13.w  , vertical: 6.h),
              height: 99.h,
              width: 336.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB4C6D4).withOpacity(0.8)),
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
                                    color: const Color(0xff00A6D6),
          
          
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
                                    color: const Color(0xff00A6D6),
          
          
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
            ),
          );
        },
      ));
}