import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/viewmodels/account_view_model.dart';

import '../../menu.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<AccountPage> {
  var isLoading = false;

  AccountViewModel accountController = Get.put(AccountViewModel());
  @override
  void initState() {
    // TODO: implement initState

    accountController.getAccountList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "HappSales",
          style: TextStyle(
              color: Colors.black, fontSize: 16.sp, fontFamily: 'roboto_bold'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => Menu());
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
      ),


      body: isLoading
          ? const CircularProgressIndicator()
          : Column(
        children: [
          const HelperRow(
            title: "My Accounts",
          ),
          Image.asset("assets/accounts/banner.png"),

          _buildEmployeeListView()
          ,
        ],
      ),
    );
  }
}
_buildEmployeeListView() {

  AccountViewModel accountViewModel = Get.put(AccountViewModel());
  return  Expanded(
      child: Obx(() => ListView.builder(
        padding: EdgeInsets.all(12.sp),

        // padding: EdgeInsets.only(top : 12.sp),
        itemCount: accountViewModel.accounts.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top : 12.sp),
            height: 90.h,
            width: 337.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),

              color: Colors.white ,
              borderRadius: BorderRadius.circular(10.r),

            ),

            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left : 12.sp),
                  child: Icon(Icons.add , color: Colors.white,),
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle
                  ),
                ),

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      margin: EdgeInsets.only(left : 16.sp),
                      child: Text(accountViewModel.accounts[index].accountLocation,style: TextStyle(
                          color: AppColors.primaryColor
                      ),),
                    ),Container(
                      margin: EdgeInsets.only(left : 16.sp,top: 2.sp,),
                      child: Text(accountViewModel.accounts[index].AccountName,
                          style: TextStyle(
                              color: AppColors.primaryColor
                          )),
                    ),Container(
                      margin: EdgeInsets.only(left : 16.sp,top: 4.sp),
                      child: Text(accountViewModel.accounts[index].AccountID.toString(),
                          style: TextStyle(
                              color: AppColors.primaryColor
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        },
      )));
}