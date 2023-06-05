import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountAmiCreation extends StatelessWidget {
  const AccountAmiCreation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      child: ListView.builder(
        controller: ScrollController() ,
        itemBuilder: (context,index){
    
        return Column(
    
          
        );
      }),
    );
  }
}