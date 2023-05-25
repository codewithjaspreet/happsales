
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ImportContactController extends GetxController{

  @override
  
  void onInit() {
    super.onInit();
    permissionCheck();
    fetchContacts();

    
  }

  List<Contact> contactList = [];
  List<Contact> selectedContactList = [];
  RxBool isLoading= true.obs;
  RxBool isCheckboxSelected = false.obs;

  void permissionCheck() async {

    if(await Permission.contacts.isGranted){

      fetchContacts();
    }
    

    else{
      Permission.contacts.request();
    }
  }


  void fetchContacts() async {
    
    contactList  = await ContactsService.getContacts();
    isLoading.value = false;
    // update();


 }

 void Mapping(){

  for(int i = 0 ; i < contactList.length ; i++){

    if(isCheckboxSelected.value == true){
      selectedContactList.add(contactList[i]);
    }
  }
  update();
 }

}

