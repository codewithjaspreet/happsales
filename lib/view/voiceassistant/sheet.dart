import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomDetailsSheet() {

List<String> animalNames = ['Elephant', 'Tiger', 'Kangaroo'];
List<String> animalFamily = ['Elephantidae', 'Panthera', 'Macropodidae'];
List<String> animalLifeSpan = ['60-70', '8-10', '15-20'];
List<String> animalWeight = ['2700-6000', '90-310', '47-66'];
int selectedTile = 0;

return DraggableScrollableSheet(
  initialChildSize: .1,
  minChildSize: .1,
  maxChildSize: .6,
  builder: (BuildContext context, ScrollController scrollController) {
  return Stack(
          clipBehavior: Clip.none,

    children: [

      
Container(
    decoration: BoxDecoration(
      boxShadow:  [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 6,
          blurRadius: 12,
          offset: Offset(0, 10), // changes position of shadow
        ),],
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        
        topRight: Radius.circular(15.r),
      ),
    ),
    child: ListView(
    controller: scrollController,
    children: [

      
      ListTile(
      title: Text(
        "NAME",
      ),
      subtitle: Text(
        animalNames[selectedTile],
      ),
      ),
      ListTile(
      title: Text(
        "FAMILY",
      ),
      subtitle: Text(
        animalFamily[selectedTile],
      ),
      ),
      ListTile(
      title: Text(
        "LIFESPAN",
      ),
      subtitle: Text(
        animalLifeSpan[selectedTile],
      ),
      ),
      ListTile(
      title: Text(
        "WEIGHT",
      ),
      subtitle: Text(
        animalWeight[selectedTile],
      ),
      ),
    ],
    ),
  ),

  Positioned(
        top: -30,
        left: 145.w,
        child: Container(

          child: Center(
            child: Image.asset('assets/ami/ami_logo.png'),
          ),
        
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          boxShadow:  [
        BoxShadow(
          color: Colors.black.withOpacity(0.0),
          spreadRadius: 8,
          blurRadius: 2,
          offset: Offset(0.5, 10), // changes position of shadow
        ),],
          color: Colors.white,
          shape: BoxShape.circle,
        
        ),
            
      )),
    ],
  );
  },
);
}
