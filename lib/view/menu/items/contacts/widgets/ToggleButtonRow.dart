import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color.dart';

class ToggleButtonRow extends StatefulWidget {

  ToggleButtonRow({
    required this.title,
    required this.isAlreadyActive
});

  bool isAlreadyActive;

  final String title;
  @override
  State<ToggleButtonRow> createState() => _ToggleButtonRowState();
}

class _ToggleButtonRowState extends State<ToggleButtonRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp,  vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title ,style: TextStyle(
              color: AppColors.primaryColor,fontWeight: FontWeight.w400 ,fontSize: 14.sp
          ),),
          Switch(
            // thumb color (round icon)
            activeColor: AppColors.primaryColor,
            activeTrackColor: Colors.blue,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            // boolean variable value
            value: widget.isAlreadyActive,
            // changes the state of the switch
            onChanged: (value) => setState(() => widget.isAlreadyActive = value),
          ),


        ],
      ),
    );
  }
}
