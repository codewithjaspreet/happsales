import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/view/menu/items/notes/widgets/search_alert.dart';
import 'package:popover/popover.dart';



class NotePopup extends StatelessWidget {
  const NotePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:  Image.asset('assets/notes/ic_menu.png',scale: 0.7,),
     onTap: () {
        showPopover(
          arrowWidth: 10.w,
          radius: 0.0,
          context: context,
          bodyBuilder: (context) => const ListItems(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.bottom,
          width: 100.w,
          height: 100.h,
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
                   Image.asset('assets/notes/refresh.png'),
                  
                  SizedBox(width: 5.w,),
                  const Text('Refresh',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,


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
                  Image.asset('assets/notes/search.png'),
                                  SizedBox(width: 5.w,),
             
                 const Text('Search',style: TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 14,
                   
             
                 ),),
               
               ],),
             ),
               SizedBox(height: 15.h,),

                InkWell(
                child: Row(
                  children: [
                   Image.asset('assets/notes/sort.png'),
                   SizedBox(width: 5.w,),
                   const Text('Sort',style: TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 14,
                    

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