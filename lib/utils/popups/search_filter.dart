import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';
import 'package:search_choices/search_choices.dart';

class SearchAndFilter extends StatefulWidget {

  String selectedValueSingleDialog = "";


  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(
      value: 'option1',
      child: Text('Option 1'),
    ),
    DropdownMenuItem(
      value: 'option2',
      child: Text('Option 2'),
    ),
    DropdownMenuItem(
      value: 'option3',
      child: Text('Option 3'),
    ),
    DropdownMenuItem(
      value: 'option4',
      child: Text('Option 4'),
    ),
  ];

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();


}

class _SearchAndFilterState extends State<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    return SearchChoices.single(
      displayClearIcon: false,

      items: widget.items,
      value: widget.selectedValueSingleDialog,
      searchInputDecoration: InputDecoration(
        suffixIcon: Icon(Icons.search, color: AppColors.primaryColor,),

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(5.sp),
          borderSide: BorderSide(
            color: Color(0xffB4C6D4),
          ),
        ),

      ),
      searchHint:  Row(
        children: [
          Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),

              ),

              child: Icon(Icons.close,color: Colors.grey,)),
          SizedBox(width: 15.w,),
          Text("Select Contact Alignment" ,style: TextStyle(
            color: AppColors.primaryColor,fontSize: 18.sp , fontFamily: "roboto_bold",

          ),)
        ],
      ),
      onChanged: (value) {
        setState(() {
          widget.selectedValueSingleDialog = value;
        });
      },
      isExpanded: true,
    );
  }
}
