
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../views/menu.dart';


AppBar CustomAppBar(BuildContext context) {
  return AppBar(
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
        onPressed: () {
          Get.to(() => Menu());
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
    ],
  );
}