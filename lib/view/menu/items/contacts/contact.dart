import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/ContactRow.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:happsales_crm/viewmodels/contact_view_model.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var isLoading = false;

  ContactViewModel contactController = Get.put(ContactViewModel());
  @override
  void initState() {
    // TODO: implement initState

    contactController.getContactList();
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
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
      ),
      // Container(
      //   padding: EdgeInsets.all(28.sp),
      //   child:  Image.asset("assets/contacts/contact_banner.png"),
      // )

      body: isLoading
          ? const CircularProgressIndicator()
          : Container(
              child: Column(
                children: [
                  const HelperRow(
                    title: "My Contacts",
                  ),
                  Image.asset("assets/contacts/contact_banner.png"),

                  Expanded(
                      child: Obx(() => ListView.builder(
                            itemCount: contactController.contactList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding:
                                      EdgeInsets.only(left: 14.sp, top: 20.h),
                                  child: ContactRow(
                                    firstName: contactController
                                        .contactList[index].firstName
                                        .toString(),
                                    lastName: contactController
                                        .contactList[index].lastName
                                        .toString(),
                                    employeeDesignation: contactController
                                        .contactList[index].designation
                                        .toString(),
                                  ));
                            },
                          )))
                  // Container(
                  //   padding: EdgeInsets.only( left : 14.sp,top: 20.h),
                  //     child: const ContactRow(firstName: 'Jaspreet'  , lastName: 'Singh' , employeeDesignation: "bc",)),
                  // Container(
                  //   padding: EdgeInsets.only( left : 14.sp,top: 20.h),
                  //     child: const ContactRow(firstName: 'Jaspreet'  , lastName: 'Singh' , employeeDesignation: "bc",)),
                ],
              ),
            ),
    );
  }
}

