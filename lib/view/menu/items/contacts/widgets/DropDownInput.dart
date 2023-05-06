import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownInput extends StatelessWidget {


   DropDownInput({super.key, required this.hint});
  final String hint;
  final TextEditingController _controller = TextEditingController();
  final List<String>items  = [
    "Mr",
    "Mrs",
    "Ms",
    "Dr",

  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w , right: 16.w,top: 16.h),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(

          hintText:  hint,
          hintStyle: TextStyle(

            fontWeight: FontWeight.w400,
            fontFamily: "roboto_regular",
            fontSize: 14.sp,
            color: const Color(0xff8F9BB3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          suffixIcon: PopupMenuButton<String>(
            icon: Image.asset("assets/contacts/dropdown.png"),
            onSelected: (String value) {
              _controller.text = value;
            },
            itemBuilder: (BuildContext context) {
              return items
                  .map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem(
                    value: value,
                    child:  Text(value));
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

