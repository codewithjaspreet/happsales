import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/Addresses/account_addresses.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BusinessPlans/business_process.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/Media/media.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountFourthTypeDetailing.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountMoreDetail.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountThirdTypeDetailing.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountUserDetailCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/SecondTypeDetailing.dart';
import 'package:happsales_crm/viewmodels/account_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../viewmodels/contact_view_model.dart';
import '../contacts/views/edit_contact.dart';
import 'AddItems/Addresses/add_address.dart';
import 'AddItems/BusinessUnits/business_unit.dart';
import 'AddItems/BuyingProcess/views/buying_process.dart';
import 'AddItems/CompetitionActivities/competititon_process.dart';
import 'EditAccount.dart';

class AcccountDetails extends StatelessWidget {
  AcccountDetails({Key? key, required this.accountID}) : super(key: key);


  ContactViewModel contactViewModel = Get.put(ContactViewModel());
  final int accountID;

  AccountViewModel accountViewModel = Get.put(AccountViewModel());

  @override
  Widget build(BuildContext context) {


   Account? account = accountViewModel.getAccountById(accountID);
    // ContactViewModel contactViewModel = Get.put(ContactViewModel());
    // Contact? contact = AccountViewModel().getContactByAccountID(accountID!);
    // print(account!.accountName);
    return Scaffold(
        appBar: CustomAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountUserDetailCard( title : contactViewModel.contacts[0].contactName , designation: contactViewModel.contacts[1].designation ),

              Hdivider(),
              AccountDetailRow(account:account!,),
              Hdivider(),
              AccountMoreDetail(account: account,)
            ],
          ),
        ));
  }

  Column UserDetailCard({String? title , String? designation }) {



    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
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
                            title!.split("")[0][0] + title.split("")[1][0],
                            // firstName![0]+ lastName![0],
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

                          title!,

                          // name of the user getting accessed
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: "roboto_bold"),
                        ),
                      ),
                      Container(
                        child: Text(
                          // "Maintenance Manager",
                          designation!,
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

                        // phNo! ?? "",
                        "99999 12345",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "roboto_bold"),
                      ),
                    ),
                    Container(
                      child: Text(
                        // email!,
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
        ),
      ],
    );
  }
}

class AccountDetailRow extends StatefulWidget {

  AccountDetailRow({Key? key, required this.account}) : super(key: key);
  // ContactViewModel contactViewModel = Get.put(ContactViewModel());
  final  Account account;
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AccountDetailRow> {
  bool _isOpen = false;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: _toggleDropdown,
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
                      'Account Details',
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
                            onTap: (){
                              Get.to(() => EditAccount(
                              ));
                            },
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
                          child:Image.asset(
                              _isOpen ? "assets/contacts/up.png" : "assets/contacts/back.png")),

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

                          // ThirdTypeDetailing(),
                          Padding(
                            padding:  EdgeInsets.only(left: 8.w,top: 10.h),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [

                                       CircularPercentIndicator(

                                        radius: 60.0,
                                        backgroundWidth: 6,
                                        backgroundColor: AppColors.primaryColor,
                                        lineWidth: 25.0,
                                        animation: true,
                                        percent: 0.75,
                                        center:  Text(
                                          "75%",
                                          style:
                                           TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp

                                           ,color: AppColors.primaryColor
                                           ),
                                        ),


                                        linearGradient:const LinearGradient(

                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [

                                              Color(0xff5DD7F9),
                                              Color(0xffE02ADA),
                                            ]
                                      ),
                                      ),
                                      Text("Incomplete" ,style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 70.sp),

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Suvarna Traders",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 20.sp , fontWeight: FontWeight.w500),),

                                        SizedBox(height : 5.h),
                                        Text("Chemicals",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 14.sp , fontWeight: FontWeight.w400),) ,

                                        SizedBox(height: 5.h,),
                                        Text("Bangalore",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 14.sp , fontWeight: FontWeight.w200),)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),


                          AccountThirdTypeDetailing(

                            title1: 'Segment',
                            subTitle1: widget.account.accountSegmentName!.toString(),
                            title2: 'Status',
                            subTitle2: widget.account.accountStatusName!.toString() ,
                          ),

                          AccountFourthTypeDetailing(
                            title1: 'Type',
                            subTitle1: widget.account.tags!.toString(),
                            title2: 'Industry',
                            subTitle2: "-",
                            // subTitle2: widget.account.industryName!.toString(),
                          ),

                          SecondTypeDetailing(
                            title: 'Work Phone',
                            subTitle: "-",
                            // subTitle: widget.account.phone!.toString()  ,
                          ),SecondTypeDetailing(
                            title: 'Website',
                            subTitle: "-",
                            // subTitle: widget.account.website!.toString(),
                          ),SecondTypeDetailing(
                            title: 'No. Of Employees',
                            subTitle: "-",
                            // subTitle: widget.account.numberOfEmployees!.toString(),
                          ),SecondTypeDetailing(
                            title: 'Currency',
                            subTitle: widget.account.currencyName!.toString(),
                          ),

                          AccountFourthTypeDetailing(
                            title1: 'Tags',
                            subTitle1: widget.account.tags!.toString(),
                            title2: 'Category',
                            subTitle2: widget.account.companyName!.toString(),
                          ),
                          // FourthTypeDetailing(
                          //   title1: 'Work Phone',
                          //   subTitle1: widget.contact.workPhone!.toString(),
                          //   title2: 'Residence Phone',
                          //   subTitle2: widget.contact.residencePhone!.toString(),
                          // ),

                          // FifthTypeDetailing(
                          //   title: 'Email Address',
                          //   subTitle: widget.contact.email!.toString(),
                          //   // subTitle: controller.contactList[0].email,
                          // ),

                          // FifthTypeDetailing(
                          //   title: 'Alt. Email Address',
                          //   subTitle:   widget.contact.alternateEmail!.toString(),
                          // ),

                          // ThirdTypeDetailing(
                          //     title1: 'Address',
                          //     subTitle1:
                          //     widget.contact.addressLine1!.toString(),
                          //     title2: 'GPS Coordinate',
                          //     subTitle2: widget.contact.gPSCoordinates!.toString()),

                        ]
                    ),
                  ),


                ],
              ),
            )
        ]),
      ),
    );
  }
}

class Detaling extends StatelessWidget {
  const Detaling({Key? key, required this.title, required this.subTitle, required this.imgUrl})
      : super(key: key);

  final String title;
  final String subTitle;
  final String imgUrl;
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
                      Flexible(
                        child: Text(
                          subTitle,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Image.asset(imgUrl)
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
class AccountDetailItems extends StatelessWidget {
  const AccountDetailItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountIndividualItem(imageUrl: 'assets/accounts/more_1.png', title: 'Activity',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_2.png', title: 'Opportunity',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_3.png', title: 'Notes',),
            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountIndividualItem(imageUrl: 'assets/accounts/more_4.png', title: 'Contacts',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_5.png', title: 'Opportunities',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_6.png', title: 'Activities',),
            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountIndividualItem(imageUrl: 'assets/accounts/more_7.png', title: 'Notes',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_8.png', title: 'Organization Hierarchy',),
              GestureDetector(
                  onTap: () {
                    Get.to(() => BuyingProcess());
                  },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_9.png', title: 'Buying Process',)),
            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(() => BusinessProcess());
                  },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_10.png', title: 'Business Plans',)),
              GestureDetector(
                  onTap: () {
                    Get.to(() => BusinessUnit());
                  },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_11.png', title: 'Business Unit',)),
              GestureDetector(

                  onTap: (){
                    Get.to(() => CompetitionProcess());
                  },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_12.png', title: 'Competition Activities',)),
            ],
          ),

        ), Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountIndividualItem(imageUrl: 'assets/accounts/more_13.png', title: 'Documents',),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_14.png', title: 'Forms',),
              GestureDetector(
                  onTap: () {
                    Get.to(() => MediaPage());
                  },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_15.png', title: 'Media',)),
            ],
          ),

        ), Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AccountIndividualItem(imageUrl: 'assets/accounts/more_16.png', title: 'Share Account',),
              GestureDetector(
                 onTap: () {
                   Get.to(() => AccountAddress());
                 },
                  child: AccountIndividualItem(imageUrl: 'assets/accounts/more_17.png', title: 'Addresses',)),
              AccountIndividualItem(imageUrl: 'assets/accounts/more_18.png', title: 'Chat History',),
            ],
          ),

        ),
      ],
    );

  }
}
class AccountIndividualItem extends StatelessWidget {
  const AccountIndividualItem({Key? key, required this.imageUrl, required this.title}) : super(key: key);

  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Color(0xffF5F6F9),

            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(imageUrl),
                Text(

                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff00A6D6),
                    fontWeight: FontWeight.w500,
                  ),
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
