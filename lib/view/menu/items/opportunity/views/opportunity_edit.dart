import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/CustomAppBar.dart';
import 'package:happsales_crm/view/menu/items/contacts/widgets/HelperRow.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/popups/custom_dropdown.dart';
import '../../contacts/widgets/InputOne.dart';

class OpportunityEdit extends StatelessWidget {
  const OpportunityEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: CustomAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
           Container(
        padding: EdgeInsets.all(6.sp),
        child: Row(
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8.w),
              child: Text('Edit Opportunity' , style: TextStyle(fontFamily: 'roboto_bold' , fontSize: 20.sp,color: AppColors.primaryColor),)),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff171A63),
      
                    ),
                    child: const Center(
                      child: Icon(Icons.add ,color: Colors.white,),
                    ),
                  ),
                ),
              
              ],
            ),
          ],
        ),
          ),
      
          OpportunityEditDetails(),
      
      
        ]),
      ),
    );
  }
}

class OpportunityEditDetails extends StatefulWidget {
  const OpportunityEditDetails({super.key});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<OpportunityEditDetails> {
  bool _isOpen = true;
  double _value = 40.0;
  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });


  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleDropdown();
      },
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
                    'Contact Details',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "roboto_medium",
                        fontSize: 14.sp),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: _toggleDropdown,
                  child: Image.asset(_isOpen
                      ? "assets/contacts/back.png"
                      : "assets/contacts/up.png")),
            ],
          ),
        ),
        if (_isOpen)
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // DropDownInput(hint : 'Title *'),
                const Input(
                  title: 'Account Name*',
                ),
                const Input(
                  title: 'Opportunity Name',
                ),
                const Input(
                  title: 'Opportunity Detail',
                ),
              

                // DropDownInput(hint : 'Mobile Number'),
                const Input(
                  title: 'Contact Name',
                ),
                const Input(
                  title: 'Opportunity Value',
                ),
                const Input(
                  title: 'Currency',
                ),
                const Input(
                  title: 'Closure Date',
                ),
               
               Container(
                  margin: EdgeInsets.only(left: 18.w , top: 16.h),
                child: Text('How does the closure property looks like ?'),
               ),
               SfSlider(
                inactiveColor: Colors.grey,
                activeColor: Colors.grey,
                thumbIcon: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                    ,color: Colors.blue
                  ),
                ),
                min: 0.0,
                max: 100.0,
                value: _value,
                interval: 20,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value){
                  setState(() {
                    _value = value;
                  });
       },
     ),
          Container(
                  margin: EdgeInsets.only(left: 18.w , top: 5.h),
                child: Text('Opportunity Stage', style: TextStyle(fontFamily: 'roboto_bold' ,color: Colors.blue, fontSize: 12.sp),),
               ),



     
              ],
            ),
          ),
      ]),
    );
  }
}
