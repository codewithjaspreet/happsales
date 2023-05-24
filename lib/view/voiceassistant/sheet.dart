import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bottomDetailsSheet() {
  List<String> animalNames = ['Elephant', 'Tiger', 'Kangaroo'];
List<String> animalFamily = ['Elephantidae', 'Panthera', 'Macropodidae'];
List<String> animalLifeSpan = ['60-70', '8-10', '15-20'];
List<String> animalWeight = ['2700-6000', '90-310', '47-66'];
int selectedTile = 0;

return DraggableScrollableSheet(
  initialChildSize: .6,
  minChildSize: .1,
  maxChildSize: .6,
  builder: (BuildContext context, ScrollController scrollController) {
  return Container(
    height: 200.h,
    color: Colors.lightGreen[100],
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
  );
  },
);
}
