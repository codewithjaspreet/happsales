import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/Addresses/account_addresses.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/BusinessPlans/business_process.dart';
import 'package:happsales_crm/view/menu/items/accounts/AddItems/Media/media.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountThirdTypeDetailing.dart';
import 'package:happsales_crm/view/menu/items/accounts/widgets/AccountUserDetailCard.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HDivider.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/SecondTypeDetailing.dart';
import 'package:happsales_crm/viewmodels/account_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../viewmodels/contact_view_model.dart';
import '../../accounts/AddItems/BusinessUnits/business_unit.dart';
import '../../accounts/AddItems/BuyingProcess/views/buying_process.dart';
import '../../accounts/AddItems/CompetitionActivities/competititon_process.dart';
import '../../accounts/AddItems/Documents/document.dart';
import '../../accounts/AddItems/ShareAccounts/share_account.dart';
import '../../accounts/EditAccount.dart';

class OpportunitiesDetails extends StatelessWidget {




  @override
  Widget build(BuildContext context) {


    // ContactViewModel contactViewModel = Get.put(ContactViewModel());
    // Contact? contact = AccountViewModel().getContactByAccountID(accountID!);
    // print(account!.accountName);
    return Scaffold(
        appBar: CustomAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Hdivider(),
              AccountDetailRow(),
              Hdivider(),
              // AccountMoreDetail(account: account,)
            ],
          ),
        ));
  }

  
}

class AccountDetailRow extends StatefulWidget {

  // ContactViewModel contactViewModel = Get.put(ContactViewModel());
  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AccountDetailRow> {
  bool _isOpen = true;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            margin: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opportunity Details',
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
                              Get.to(() => const EditAccount(
                              ));
                            },
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              child: Center(
                                child: Image.asset("assets/contacts/edit.png"),
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

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 28.h),
            child: Text('HAPPSALES-OPPTY-0000001',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: "roboto_normal",
                    fontSize: 14.sp)),
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
                            padding:  EdgeInsets.only(top: 10.h),
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
                                        percent: 0.55,
                                        center:  Text(
                                          "55%",
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
                                      Container(
                                        margin:   EdgeInsets.symmetric(horizontal :  12.w ,vertical: 10.h),
                                        child: Text("Probability" ,style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 12.sp,
                                          fontFamily: 'roboto_medium',
                                          fontWeight: FontWeight.normal
                                        ),),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 140.sp,bottom: 28.h),

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Kumar Agency",style: TextStyle( color: const Color(0xff00A6D6),

                                        fontSize: 14.sp , fontWeight: FontWeight.bold),),


                                        SizedBox(height: 5.h,),
                                        Text("sadasd",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 14.sp , fontWeight: FontWeight.bold),),

                                        SizedBox(height: 10.h,),

                                         Text("Value",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 12.sp , fontWeight: FontWeight.normal),),


                                        SizedBox(height: 5.h,),
                                        Text("40280",style: TextStyle(color: AppColors.primaryColor,

                                        fontSize: 14.sp , fontWeight: FontWeight.bold),)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15.h,),


                          
                      
          
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Opportunity Stage',
                                  style: TextStyle(
                                    fontFamily: 'roboto_bold',

          
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff00A6D6),
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'S5-Won',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
      

                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Closure Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'roboto_bold',
                                    color: Color(0xff00A6D6),
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(
                                  height: 5.h,
                                ),

                                Text(
                                  '31 July 2021',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 30.w,),

                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quater',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'roboto_bold',
                                   color: Color(0xff00A6D6),
          
          
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(
                                  height: 5.h,
                                ),

                                Text(
                                  'Q3',
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

Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Opportunity Detail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff00A6D6),
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(

                          child: Text(
                            'sjas',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                       
                        Container(
                         margin: EdgeInsets.only(top: 8.h),

                          child: Text(
                            'Read More',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff00A6D6),
                              fontSize: 12.sp,
                              fontFamily: 'roboto_regular'
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 28.h),
                          child: Text(
                                          'Contact Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff00A6D6),
                        
                        
                                            fontSize: 12.sp,
                                          ),
                                        ),
                        ),
                
                        Container(
                          margin: EdgeInsets.only(top: 3.h),
                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                          'Dr.Jahnvi h i',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          child: Icon(Icons.arrow_forward_ios,size: 18.sp,color: AppColors.primaryColor,))
                                          ],
                                        ),
                        ),

                        Container(
                                margin: EdgeInsets.only(top: 12.h),
                                width: 170.w,
                                height:48.h,
                                decoration: BoxDecoration(
                                  borderRadius:  BorderRadius.circular(26.sp),

                                  shape: BoxShape.rectangle,
                                  color: Color(0xff0ff00A6D6),
                                ),
                                child: Center(child: Text("Workflow Status" , style:   TextStyle(color: Colors.white,fontFamily: "roboto_bold",fontSize: 16.sp),)),
                              ),
                      ],
                    ),
                  ),
                  // Image.asset(imgUrl),

                ],
              ),
            ),
           
          ],
        )
      ],
    ),




                          // const SecondTypeDetailing(
                          //   title: 'Work Phone',
                          //   subTitle: "-",

                          // ),const SecondTypeDetailing(
                          //   title: 'Website',
                          //   subTitle: "-",
                          //   // subTitle: widget.account.website!.toString(),
                          // ),const SecondTypeDetailing(
                          //   title: 'No. Of Employees',
                          //   subTitle: "-",
                          //   // subTitle: widget.account.numberOfEmployees!.toString(),
                          // ),SecondTypeDetailing(
                          //   title: 'Currency',
                          //   subTitle: 'sad'.toString(),
                          // ),


                          // AccountThirdTypeDetailing(
                          //   title1: 'Tags',
                          //   subTitle1: 'asdsa'.toString(),
                          //   title2: 'Category',
                          //   subTitle2: 'sad'.toString(),
                          // ),
                          SizedBox(height: 10.h,),

                          const AccountDetailItems()

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
                              color: const Color(0xff00A6D6),
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
            children: const [
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
            children: const [
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
              const AccountIndividualItem(imageUrl: 'assets/accounts/more_7.png', title: 'Notes',),
              const AccountIndividualItem(imageUrl: 'assets/accounts/more_8.png', title: 'Organization Hierarchy',),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const BuyingProcess());
                  },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_9.png', title: 'Buying Process',)),
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
                    Get.to(() => const BusinessProcess());
                  },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_10.png', title: 'Business Plans',)),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const BusinessUnit());
                  },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_11.png', title: 'Business Unit',)),
              GestureDetector(

                  onTap: (){
                    Get.to(() => const CompetitionProcess());
                  },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_12.png', title: 'Competition Activities',)),
            ],
          ),

        ), Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {

                  Get.to(const DocumentPage());
    },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_13.png', title: 'Documents',)),
              const AccountIndividualItem(imageUrl: 'assets/accounts/more_14.png', title: 'Forms',),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const MediaPage());
                  },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_15.png', title: 'Media',)),
            ],
          ),

        ), Container(
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {

                  Get.to(() => const ShareAccount());
    },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_16.png', title: 'Share Account',)),
              GestureDetector(
                 onTap: () {
                   Get.to(() => const AccountAddress());
                 },
                  child: const AccountIndividualItem(imageUrl: 'assets/accounts/more_17.png', title: 'Addresses',)),
              const AccountIndividualItem(imageUrl: 'assets/accounts/more_18.png', title: 'Chat History',),
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
            color: const Color(0xffF5F6F9),

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
                    color: const Color(0xff00A6D6),
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
