import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';

import '../models/contact.dart';
import '../models/database.dart';
import 'package:http/http.dart' as http;


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

    for (var employee in (response.data as List)) {
      // print('Inserting $employee');
      DBProvider.db.createEmployee(employee);
    }

    downloaded.value = true;
    downloaded.refresh();
    contactList.value = await DBProvider.db.getAllEmployees();
    contactList.refresh();
    // if (response.statusCode == 200) {
    //
    //
    //   print(response.data);
    //   // final contactsJson = jsonDecode(response.data);
    //   // final contacts = contactsJson
    //   //     .map((contactJson) => Contact.fromJson(contactJson))
    //   //     .toList();
    //   //
    //   // for (final contact in contacts) {
    //   //   await DBProvider.db.saveContact(contact);
    //   // }
    //   //
    //   // downloaded.value = true;
    //   // contactList.value = await DBProvider.db.getAllEmployees(); // await the result of getAllEmployees() before assigning it to contactList.value
    //   // contactList.refresh();
    //
    // } else {
    //   throw Exception('Failed to fetch contacts');
    // }
  }
}
