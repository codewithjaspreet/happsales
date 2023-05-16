import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';

class DropDownHelper extends StatefulWidget {
  const DropDownHelper({Key? key, required this.labelText, required this.dropDownListData}) : super(key: key);


  final String labelText;

  final List dropDownListData;

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  

  String selectedCourseValue = "";
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10.sp),
      height: 100.h,
      child: ListView(
        children: [
         
           SizedBox(
            height: 15.h,
          ),
          InputDecorator(
            
            
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              contentPadding:  EdgeInsets.all(12.sp),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Image.asset('assets/accounts/down.png',color: AppColors.primaryColor,),
                value: selectedCourseValue,
                isDense: true,
                isExpanded: true,
                menuMaxHeight: 350.h,
                items: [
                 
                  ...widget.dropDownListData.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      
                        child: Text(e['title']), value: e['value']);
                  }).toList(),
                ],
                onChanged: (newValue) {
                  setState(
                    () {
                      selectedCourseValue = newValue!;
                      print(selectedCourseValue);
                    },
                  );
                },
              ),
            ),
          ),
          
        ],
      ),
    );
    
  }
}
