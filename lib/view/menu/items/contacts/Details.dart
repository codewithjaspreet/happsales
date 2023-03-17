import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserDetailCard(),
                Hdivider(),
                DetailRow(),
                Hdivider(),
                DetailRow(),

              ],
            ),
          ),
        ));
  }

  Column UserDetailCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 20.w),
                child: Row(
                  children: [
                    Container(
                      width: 63.w,
                      height: 63.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 2.w),
                        child: Center(
                          child: Text(
                            "ST",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 44.sp),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "Suvarna traders",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h, left: 25.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Radha Krishna",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: "roboto_bold"),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Maintenance Manager",
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.h, left: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "99999 12345",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"),
                      ),
                    ),
                    Container(
                      child: Text(
                        "radha.krishna@SuvarnaTraders.com",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          width: 337.w,
          height: 216.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffAA80F9),
                  Color(0xff6165D7),
                ],
              )),
        ),
      ],
    );
  }
}

class DetailRow extends StatefulWidget {
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<DetailRow> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact Details',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
             Container(

               child: Row(

                 children: [
                   Container(
                      margin: EdgeInsets.only(right: 10.w),
                     child: GestureDetector(
                         onTap: (){},
                         child: Container(
                           child: Center(
                             child: Image.asset("assets/contacts/edit.png"),
                           ),
                           width: 24.w,
                           height: 24.h,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: AppColors.primaryColor,
                           ),
                         )),
                   ),
                   GestureDetector(
                       onTap: _toggleDropdown,
                       child: Icon(
                           _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down)),

                 ],
               ),
             )
            ],
          ),
        ),
        if (_isOpen)
          SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Detaling(
                          title: 'contact name',
                          subTitle: 'Mr. Radha R Krishna',
                        ),
                        SecondTypeDetailing(
                          title: 'Account name',
                          subTitle: 'Mr. Radha R Krishna',
                        ),
                        // ThirdTypeDetailing(),
                        ThirdTypeDetailing(
                          title1: 'Department',
                          subTitle1: 'Sales',
                          title2: 'Designation',
                          subTitle2: 'Sales Manager',
                        ),

                        FourthTypeDetailing(
                          title1: 'Mobile number',
                          subTitle1: '9999912345',
                          title2: 'Mobile number',
                          subTitle2: '9999912346',
                        ),
                        FourthTypeDetailing(
                          title1: 'Work Phone',
                          subTitle1: '08022225555',
                          title2: 'Residence Phone',
                          subTitle2: '08033335555',
                        ),

                        FifthTypeDetailing(
                          title: 'Email Address',
                          subTitle: 'radha.krishna@suvarnatraders.com',
                        ),
                        FifthTypeDetailing(
                          title: 'Alt. Email Address',
                          subTitle: 'radha.krishna33@gmail.com',
                        ),

                        ThirdTypeDetailing(
                            title1: 'Address',
                            subTitle1:
                                'Lorem ipsum dolor,\nipsum dolor, \nDelhi 110004',
                            title2: 'GPS Coordinate',
                            subTitle2: 'subTitle2')
                        // ThirdTypeDetailing(
                        //
                        //   title1: 'Mobile number',
                        //   subTitle1: '99999 12345',
                        //   title2: 'alt. Mobile number',
                        //   subTitle2: '99999 12346',
                        //
                        // ),
                      ]),
                ),
              ],
            ),
          )
      ]),
    );
  }
}

class Detaling extends StatelessWidget {
  const Detaling({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.h, top: 10.h, right: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: Color(0xff00A6D6),
                              fontFamily: "roboto_bold",
                              fontSize: 13.sp)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "roboto_bold",
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Image.asset("assets/contacts/web.png")
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class SecondTypeDetailing extends StatelessWidget {
  const SecondTypeDetailing(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16.h, top: 10.h, right: 16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                color: Color(0xff00A6D6),
                                fontFamily: "roboto_bold",
                                fontSize: 13.sp)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subTitle,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "roboto_bold",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ThirdTypeDetailing extends StatelessWidget {
  ThirdTypeDetailing(
      {Key? key,
      required this.title1,
      required this.subTitle1,
      required this.title2,
      required this.subTitle2})
      : super(key: key);

  final String title1;
  final String subTitle1;
  final String title2;
  final String subTitle2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.h,
        top: 20.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title1,
                          style: TextStyle(
                              color: Color(0xff00A6D6),
                              fontFamily: "roboto_bold",
                              fontSize: 13.sp)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        subTitle1,

                        style: TextStyle(
                          fontSize: 16.sp,
                          
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 110.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title2,
                            style: TextStyle(
                                color: Color(0xff00A6D6),
                                fontFamily: "roboto_bold",
                                fontSize: 13.sp)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 110.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              subTitle2,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "roboto_bold",
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),



                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FourthTypeDetailing extends StatelessWidget {
  const FourthTypeDetailing(
      {Key? key,
      required this.title1,
      required this.subTitle1,
      required this.title2,
      required this.subTitle2})
      : super(key: key);

  final String title1;
  final String subTitle1;
  final String title2;
  final String subTitle2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.h, top: 20.h),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(title1,
                          style: TextStyle(
                              color: Color(0xff00A6D6),
                              fontFamily: "roboto_bold",
                              fontSize: 13.sp)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subTitle1,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "roboto_bold",
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.w),
                        child: Image.asset("assets/contacts/call.png"),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 55.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title2,
                            style: TextStyle(
                                color: Color(0xff00A6D6),
                                fontFamily: "roboto_bold",
                                fontSize: 13.sp)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 55.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subTitle2,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "roboto_bold",
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: Image.asset("assets/contacts/call.png"),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FifthTypeDetailing extends StatelessWidget {
  const FifthTypeDetailing(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 14.w,
            top: 20.h,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: "roboto_bold",
              color: Color(0xff00A6D6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                subTitle,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "roboto_bold",
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              Image.asset("assets/contacts/mail.png")
            ],
          ),
        )
      ],
    );
  }
}
