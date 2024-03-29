import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/popups/custom_dropdown.dart';
import '../../../../../utils/color.dart';
import '../controllers/location_controller.dart';
import 'InputOne.dart';

class AddContactDetails extends StatefulWidget {
  const AddContactDetails({super.key});

  @override
  _MyRowState createState() => _MyRowState();
}

class _MyRowState extends State<AddContactDetails> {
  bool _isOpen = true;

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
    });


  }

  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleDropdown();
      },
      child: Column(children: [
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
              children: [
                const CustomDropDown(
                  labelText: 'Title *',
                  items: [
                    DropdownMenuItem(
                      value: 'Item 1',
                      child: Text('Mr.'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 2',
                      child: Text('Mrs.'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 3',
                      child: Text('Miss.'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 3',
                      child: Text('Mx.'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 3',
                      child: Text('Dr.'),
                    ),
                  ],
                ),
                // DropDownInput(hint : 'Title *'),
                const Input(
                  title: 'First Name*',
                ),
                const Input(
                  title: 'Last Name',
                ),
                const Input(
                  title: 'Account name',
                ),

                const CustomDropDown(items: [
                  DropdownMenuItem(
                    value: 'Item 1',
                    child: Text('Administration'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 2',
                    child: Text('Department'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 3',
                    child: Text('Finance'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 4',
                    child: Text('Human Resources'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 5',
                    child: Text('Information Technology'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 6',
                    child: Text('Logistics'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 7',
                    child: Text('Maintainance'),
                  ),
                ], labelText: 'Department'),

                // DropDownInput(hint : 'designation'),
                const CustomDropDown(
                  labelText: 'Designation',
                  items: [
                    DropdownMenuItem(
                      value: 'Item 8',
                      child: Text('Accountant'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 9',
                      child: Text('Administrative Assistant'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 10',
                      child: Text('Advocate'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 11',
                      child: Text('Business Analyst 1'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 12',
                      child: Text('Business Development Manager'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 13',
                      child: Text('Chief Executive Officer (CEO)'),
                    ),
                    DropdownMenuItem(
                      value: 'Item 14',
                      child: Text('Chief Financial Officer (CFO)'),
                    ),
                  ],
                ),
                // DropDownInput(hint : 'Mobile Number'),
                const Input(
                  title: 'Mobile Number',
                ),
                const Input(
                  title: 'Alternate Mobile Number',
                ),
                const Input(
                  title: 'Work Phone',
                ),
                const Input(
                  title: 'Residence Phone',
                ),
                const Input(
                  title: 'Email Address',
                ),
                const Input(
                  title: 'Alternate Email Address',
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                  child: TextFormField(

                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // locationController.getCurrentLocation();
                        },
                        child: const Icon(
                          Icons.gps_fixed,
                          color: Color(0xff8F9BB3),
                        ),
                      ),
                      labelText: 'Address Line 1',
                      hintText: 'Address Line 1',
                      labelStyle: TextStyle(
    color: const Color(0xff8F9BB3),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: "roboto_regular"),
                      hintStyle: TextStyle(
                          color: const Color(0xff8F9BB3),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "roboto_regular"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: const BorderSide(
                          color: Color(0xffB4C6D4),
                        ),
                      ),
                    ),
                  ),
                ),
                const Input(
                  title: 'Address Line2',
                ),
                const Input(
                  title: 'Address Line3',
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff8F9BB3),
                      ),
                      labelText: 'City',
                      hintText: 'City',
                      floatingLabelStyle: const TextStyle(
                        color : Color(0xff00A6D6),
                      ),
                      labelStyle: TextStyle(
                          color: const Color(0xff8F9BB3),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "roboto_regular"),
                      hintStyle: TextStyle(
                          color: const Color(0xff8F9BB3),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "roboto_regular"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: const BorderSide(
                          color: Color(0xffB4C6D4),
                        ),
                      ),
                    ),
                  ),
                ),
                const Input(
                  title: 'State',
                ),
                const CustomDropDown(items: [
                  DropdownMenuItem(
                    value: 'Item 1',
                    child: Text('India'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 2',
                    child: Text('USA'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 3',
                    child: Text('Australia'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 4',
                    child: Text('Canada'),
                  ),
                  DropdownMenuItem(
                    value: 'Item 5',
                    child: Text('UK'),
                  ),
                ], labelText: 'Country'),
                const Input(
                  title: 'Pin',
                ),
                const Input(
                  title: 'GPS Coordinate',
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
