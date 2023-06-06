
import 'package:get/get.dart';
class SheetController extends GetxController{

   RxBool isAccountFormOpen  = false.obs;


    void openAccountForm(){
      isAccountFormOpen.value = true;
    }
}