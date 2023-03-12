import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
    "HappSales",
    style: TextStyle(
    color: Colors.black, fontSize: 16.sp, fontFamily: 'roboto_bold'),
    ),
    centerTitle: true,
    leading: IconButton(
    icon: const Icon(
    Icons.arrow_back_ios,
    color: Colors.black,
    ),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    actions: [
    IconButton(
    onPressed: () {},
icon: const Icon(
Icons.menu,
color: Colors.black,
),
),
],
);
  }
}
