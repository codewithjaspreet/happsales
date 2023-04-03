import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';
import '../models/contact.dart';
import '../models/database.dart';

class ContactViewModel extends GetxController {

  @override
  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // var result = await Connectivity().checkConnectivity();

    print("ONINITTTTT called${contacts.length} ");

    var result = checkInternetConnectivity();
    print("result is $result");
    getContactList();
    fetchContacts();
    // getContactList();
  }

  RxList contacts = [].obs;

  Future<RxList> getContactList() async {
    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getContactPaged;
    var token = ApiEndPoints.authEndpoints.token;

    var response = await Dio().post(
      url,
      data: {
        "pageindex": "1",
        "pagesize": "100",
        "objectdate1": "2000-01-01T00:00:00",
        "objectdate2": "2023-03-16T09:44:24.267005"
      },
      options: Options(
        headers: {
          'Authorization': "Bearer $token",
        },
      ),
    );
     print(response.data);
    (response.data as List).forEach((employee) {
      Contact contact = Contact.fromJson(employee);
      contacts.add(contact);
      // Uncomment the following line if DBProvider is properly configured
      DBProvider.db.createEmployee(contact);

    });

    return contacts;
  }

  Contact? getUserById(int id) {
    return contacts.firstWhere((user) => user.contactID == id, orElse: () => null);
  }

  fetchContacts() async {
    var dbcontacts = await DBProvider.db.getAllEmployees();
    contacts.value =  dbcontacts;


  }


}
