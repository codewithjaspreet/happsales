 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/notes/widgets/search_alert.dart';
import 'package:popover/popover.dart';



class ClosedPopUp extends StatelessWidget {
  const ClosedPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:Container(
        width: 22.w,
        height: 22.h,
        child: Image.asset('assets/opportunity/filter.png')),
      // child:  Image.asset('assets/notes/more.png',),
     onTap: () {
        showPopover(
          arrowWidth: 10.w,
          radius: 0.0,
          context: context,
          bodyBuilder: (context) => const ListItems(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.bottom,
          width: 120.w,
          height: 110.h,
        );
      },
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                  ..pop()
                  ..push(
                    MaterialPageRoute<SecondRoute>(
                      builder: (context) => const SecondRoute(),
                    ),
                  );
              },
              child: Container(
                child: Row(
                  children: [
                  
                   Text('S5-Won',style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,


                  ),),
                
                ],),
              )
            ),
            SizedBox(height: 15.h,),
             GestureDetector(
              onTap: (){
                showSearchAlert(  context);
              },
               child: Row(
                 children: [
             
                  Text('S5-Lost',style: TextStyle(
                   fontWeight: FontWeight.normal,
                   fontSize: 14.sp,
                   
             
                 ),),
               
               ],),
             ),
               SizedBox(height: 15.h,),

                InkWell(
                child: Row(
                  children: [
                    Text('S5-Discontinue',style: TextStyle(
                   fontWeight: FontWeight.normal,
                   overflow: TextOverflow.clip,
                   fontSize: 14.sp,
                    

                  ),),
                
                ],),
              ),

              
          ],
        ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}