import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';

class CustomDropDown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String labelText;

  const CustomDropDown({Key? key, required this.items, required this.labelText})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
      child: TextField(
        decoration: InputDecoration(
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffB4C6D4),
            ),
          ),
          suffixIcon: Container(
            child: Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: DropdownButtonFormField(
                dropdownColor: AppColors.secColor,
                hint: Text(widget.labelText,),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),

                value: dropdownValue.isNotEmpty ? dropdownValue : null,

                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue.toString();
                  });
                },
                items: widget.items,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: "roboto_bold",
                  fontSize: 14.sp,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}


