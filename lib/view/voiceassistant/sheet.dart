import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/voiceassistant/sheet_controller.dart';
import 'package:happsales_crm/view/voiceassistant/voice.dart';
import 'package:get/get.dart';
import '../menu/items/contacts/widgets/InputOne.dart';
import 'ami_row.dart';

class bottomDetailsSheet extends StatelessWidget {
  PageController pageController = PageController(initialPage: 0);
  SheetController sheetController = Get.put(SheetController());
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.18,
      minChildSize: 0.18,
      maxChildSize: 1,
      // maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 6,
                      blurRadius: 12,
                      offset: Offset(0, 10), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: PageView(
                  controller: pageController,
                  children: [
                    // page 0
                    ListView(
                      controller: scrollController,
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 55.h),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "PAGE - 0",
                                      style: TextStyle(
                                          fontFamily: 'roboto_bold',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      "Powered by HappSales",
                                      style: TextStyle(
                                          fontFamily: 'roboto_regular',
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 22.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              // Get.to(AccountAmi)
                                            },
                                            child: GestureDetector(
                                                onTap: () {
                                                  pageController.jumpToPage(1);
                                                },
                                                child: AmiRow(
                                                    "assets/ami/building.png",
                                                    "Want to setup an Account? "))),
                                        GestureDetector(
                                            onTap: () {
                                              pageController.jumpToPage(2);
                                            },
                                            child: AmiRow(
                                                "assets/ami/people.png",
                                                "Want to create a contact?")),
                                        AmiRow("assets/ami/money.png",
                                            "Want to create an opportunity?"),
                                        AmiRow("assets/ami/calender.png",
                                            "Want to create an activity?"),
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Command Examples',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20.h),
                                          width: 300.w,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 3,
                                                blurRadius: 2,
                                                offset: Offset(0,
                                                    4), // changes position of shadow
                                              ),
                                            ],
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.2)),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: AmiVoice()),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      "Powered by HappSales",
                                      style: TextStyle(
                                          fontFamily: "roboto_regular",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xffB4C6D4)),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),

// page 1 - account creation
                    ListView(
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 55.h, right: 20.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.r),
                                                topRight: Radius.circular(15.r),
                                                bottomLeft:
                                                    Radius.circular(15.r),
                                              )),
                                          width: 130.w,
                                          height: 80.h,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'You',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.themeColor,
                                                      fontFamily:
                                                          'roboto_bold'),
                                                ),
                                                Text(
                                                  'Create Account',
                                                  style: TextStyle(),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 23.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '25 May-2023 04:19',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 30.h, left: 10.w),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(15.r),
                                              bottomLeft: Radius.circular(15.r),
                                            )),
                                        width: 210.w,
                                        height: 80.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'You',
                                                style: TextStyle(
                                                    color: AppColors.themeColor,
                                                    fontFamily: 'roboto_bold'),
                                              ),
                                              Text(
                                                'Please fill the form given below',
                                                style: TextStyle(),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 23.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '25 May-2023 04:19',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                          ],
                        ),
                        Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10.h, left: 10.w),
                                      child: Text(
                                        'Ami',
                                        style: TextStyle(
                                            color: AppColors.themeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.sp),
                                  child: Container(
                                    padding: EdgeInsets.all(12.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Account Details',
                                          style: TextStyle(
                                              fontFamily: 'roboto_bold',
                                              fontSize: 16.sp,
                                              color: AppColors.primaryColor),
                                        ),
                                        Obx(() => GestureDetector(
                                              onTap: () {
                                                sheetController
                                                        .isAccountFormOpen
                                                        .value =
                                                    !sheetController
                                                        .isAccountFormOpen
                                                        .value;
                                              },
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        sheetController
                                                                .isAccountFormOpen
                                                                .value =
                                                            !sheetController
                                                                .isAccountFormOpen
                                                                .value;
                                                      },
                                                      child: Image.asset(sheetController
                                                              .isAccountFormOpen
                                                              .value
                                                          ? "assets/contacts/up.png"
                                                          : "assets/contacts/back.png")),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() =>
                                    sheetController.isAccountFormOpen.value
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: 3.h,
                                                left: 10.w,
                                                right: 10.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Input(title: 'Account Name*'),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Input(title: 'Location*'),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Input(title: 'Segment'),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Input(title: 'Status'),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Input(title: 'Type'),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink()),
                              ],
                            ),
                            margin: EdgeInsets.only(
                                top: 20.h, left: 10.w, right: 10.w),
                            height: 600.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r)))
                      ],
                    ),




                    // page 2
 ListView(
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 55.h, right: 20.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.r),
                                                topRight: Radius.circular(15.r),
                                                bottomLeft:
                                                    Radius.circular(15.r),
                                              )),
                                          width: 130.w,
                                          height: 80.h,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'You',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.themeColor,
                                                      fontFamily:
                                                          'roboto_bold'),
                                                ),
                                                Text(
                                                  'Create Contact',
                                                  style: TextStyle(),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 23.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '25 May-2023 04:19',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(15.r),
                                              bottomRight: Radius.circular(15.r),
                                            )),
                                        width: 140.w,
                                        height: 80.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ami',
                                                style: TextStyle(
                                                    color: AppColors.themeColor,
                                                    fontFamily: 'roboto_bold'),
                                              ),
                                              Text(
                                                'Cancelled',
                                                style: TextStyle(),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 23.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '25 May-2023 04:19',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                          ],
                        ),

                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.h, right: 20.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.r),
                                                topRight: Radius.circular(15.r),
                                                bottomLeft:
                                                    Radius.circular(15.r),
                                              )),
                                          width: 130.w,
                                          height: 80.h,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'You',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.themeColor,
                                                      fontFamily:
                                                          'roboto_bold'),
                                                ),
                                                Text(
                                                  'Create Contact',
                                                  style: TextStyle(),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 23.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '25 May-2023 04:19',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 30.h, left: 10.w),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(15.r),
                                              bottomRight: Radius.circular(15.r),
                                            )),
                                        width: 280.w,
                                        height: 95.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ami',
                                                style: TextStyle(
                                                    color: AppColors.themeColor,
                                                    fontFamily: 'roboto_bold'),
                                              ),
                                              Text(
                                                'Do you have the business card of the contact',
                                                style: TextStyle(),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 23.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '25 May-2023 04:19',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                          ],
                        ),
                        Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10.h, left: 10.w),
                                        child: Text(
                                          'Ami',
                                          style: TextStyle(
                                              color: AppColors.themeColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12.sp),
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Account Details',
                                            style: TextStyle(
                                                fontFamily: 'roboto_bold',
                                                fontSize: 16.sp,
                                                color: AppColors.primaryColor),
                                          ),
                                          Obx(() => GestureDetector(
                                                onTap: () {
                                                  sheetController
                                                          .isAccountFormOpen
                                                          .value =
                                                      !sheetController
                                                          .isAccountFormOpen
                                                          .value;
                                                },
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          sheetController
                                                                  .isAccountFormOpen
                                                                  .value =
                                                              !sheetController
                                                                  .isAccountFormOpen
                                                                  .value;
                                                        },
                                                        child: Image.asset(sheetController
                                                                .isAccountFormOpen
                                                                .value
                                                            ? "assets/contacts/up.png"
                                                            : "assets/contacts/back.png")),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(() =>
                                      sheetController.isAccountFormOpen.value
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  top: 3.h,
                                                  left: 10.w,
                                                  right: 10.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Input(title: 'Account Name*'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Location*'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Segment'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Status'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Type'),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink()),
                              Hdivider(),
                                           Container(
                                    padding: EdgeInsets.all(12.sp),
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Account Details',
                                            style: TextStyle(
                                                fontFamily: 'roboto_bold',
                                                fontSize: 16.sp,
                                                color: AppColors.primaryColor),
                                          ),
                                          Obx(() => GestureDetector(
                                                onTap: () {
                                                  sheetController
                                                          .isAccountFormOpen
                                                          .value =
                                                      !sheetController
                                                          .isAccountFormOpen
                                                          .value;
                                                },
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          sheetController
                                                                  .isAccountFormOpen
                                                                  .value =
                                                              !sheetController
                                                                  .isAccountFormOpen
                                                                  .value;
                                                        },
                                                        child: Image.asset(sheetController
                                                                .isAccountFormOpen
                                                                .value
                                                            ? "assets/contacts/up.png"
                                                            : "assets/contacts/back.png")),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(() =>
                                      sheetController.isAccountFormOpen.value
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  top: 3.h,
                                                  left: 10.w,
                                                  right: 10.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Input(title: 'Account Name*'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Location*'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Segment'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Status'),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Input(title: 'Type'),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink()),
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(
                                top: 20.h, left: 10.w, right: 10.w),
                            height: 600.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r)))
                      ],
                    ),
                   
                  ],
                )),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(-0, -14), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )),
          ],
        );
      },
    );
  }
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
