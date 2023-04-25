import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';

import '../../../../../../utils/color.dart';
import '../../../contacts/widgets/HDivider.dart';
import '../../../contacts/widgets/InputOne.dart';
import '../BuyingProcess/widgets/buy_sec_row.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'Add Address',
                    style: TextStyle(
                        fontFamily: 'roboto_medium',
                        fontSize: 20.sp,
                        color: AppColors.primaryColor),
                  ),
                ),



              ],
            ),
          ),

          Column(
            children: [
              Input(
                title: 'Account Name',
              ),
              Input(

                title: 'Contact Name',
              ),
              CustomDropDown(items: [], labelText: 'Address Type',),
            ],
          )
        ]
      ),
    );
  }
}
