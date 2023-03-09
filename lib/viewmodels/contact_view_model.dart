import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';

import '../models/contact.dart';
import '../models/database.dart';


class ContactViewModel extends GetxController {
  var contactList = RxList<Contact>();

  RxBool downloaded = false.obs;

  Future<void> getContactList() async {
    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getContactPaged;
    var token = ApiEndPoints.authEndpoints.token;

    var response = await Dio().post(url,
        data: {
          "pageindex": "1",
          "pagesize": "100",
          "objectdate1": "2000-01-01T00:00:00",
          "objectdate2": "2023-03-08T09:44:24.267005"
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ));

    print(response.data);

    for (var employee in (response.data as List)) {
      DBProvider.db.createEmployee(employee);
    }

    downloaded.value = true;
    downloaded.refresh();
    contactList.value = await DBProvider.db.getAllEmployees();
    contactList.refresh();
  }

  Future<void> getAllEmployees() async {
    if (!downloaded.value) {
      getContactList();
    }


    else {
      contactList.value = await DBProvider.db.getAllEmployees();
      contactList.refresh();
    }
  }
}
