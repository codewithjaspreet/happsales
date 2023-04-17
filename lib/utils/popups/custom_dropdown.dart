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


//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:happsales_crm/utils/color.dart';
//
// class CustomDropDown extends StatefulWidget {
//    CustomDropDown({Key? key, required this.labelText, required this.items} ) : super(key: key);
//    final List<String> items;
//
//    final String labelText;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<CustomDropDown> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       padding: EdgeInsets.only(left: 16.w , right: 16.w, top: 10.h),
//       child: TextField(
//
//         decoration: InputDecoration(
//
//
//           labelText: widget.labelText,
//
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.sp),
//             borderSide: BorderSide(
//               color: Color(0xffB4C6D4),
//             ),
//           ),
//           suffixIcon: Container(
//
//
//             child: DropdownButtonFormField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//               ),
//
//               value: widget.dropdownvalue,
//               onChanged: (newValue) {
//                 setState(() {
//                   widget.dropdownvalue = newValue!;
//                 });
//               },
//               items: widget.items.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   alignment: Alignment.centerLeft,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }