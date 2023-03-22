import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';

import '../models/contact.dart';
import '../models/database.dart';

class ContactViewModel extends GetxController {

  RxList contactList = [].obs;

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
      contactList.add(contact);
      // Uncomment the following line if DBProvider is properly configured
      DBProvider.db.createEmployee(contact);

    });

    return contactList;
  }

  Contact? getUserById(int id) {
    return contactList.firstWhere((user) => user.contactID == id, orElse: () => null);
  }
}
