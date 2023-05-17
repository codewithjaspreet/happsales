import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

class DropDownHelper extends StatefulWidget {
  const DropDownHelper({Key? key}) : super(key: key);

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  List dropDownListData = [
    {"title": "Meeting", "value": "1","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Call", "value": "2","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Mail", "value": "3","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Trade Show", "value": "4","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Demo", "value": "5","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Others", "value": "6","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Service", "value": "7","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Collection", "value": "8","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Negotiation", "value": "9","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Sample", "value": "10","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Tech Support", "value": "11","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Replacement", "value": "12","image" : 'assets/activities/unselectmeeting.png'},
    {"title": "Show Sample", "value": "13","image" : 'assets/activities/unselectmeeting.png'},


  ];



  String selectedCourseValue = "";
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(12.sp),
      height: 100.h,
      child: ListView(
        children: [
         
         
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              contentPadding: const EdgeInsets.all(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                
                value: selectedCourseValue,
                hint: Text(
                  "Select Activity Type*",
                  style: TextStyle(
                  ),
                ),
                icon: Image.asset('assets/accounts/down.png',color: AppColors.primaryColor,),

                isDense: true,
                isExpanded: true,
                menuMaxHeight: 350,
                items: [
                  const DropdownMenuItem(
                    
                  
                      child: Text(
                        "",
                      ),
                      value: ""),
                  ...dropDownListData.map<DropdownMenuItem<String>>((e) {

                    return DropdownMenuItem(
                      
                        child: Row(
                          children: [
                        Image.asset(
                          e['image'],
                        
                        ),
                        SizedBox(width: 10.w,),

                            Text(
                              e['title'],
                            ),
                          ],
                        
                        ), value: e['value']);
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
