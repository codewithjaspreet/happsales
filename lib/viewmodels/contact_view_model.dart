import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';

import '../models/account_model.dart';
import '../models/contact.dart';
import '../models/database.dart';

class ContactViewModel extends GetxController {
  var accountList = RxList<Contact>();

  RxBool downloading = false.obs;

  Future<void> getContactList() async {
    // var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getAccountPaged;

    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getContactPaged;
    var response = await Dio().post(url,
        data: {
          "pageindex": "1",
          "pagesize": "100",
          "objectdate1": "2000-01-01T00:00:00",
          "objectdate2": "2023-03-07T09:44:24.267005"
        },
        options: Options(
          headers: {
            'Authorization': "Bearer ejvnsvnc",
          },
        ));

    if (response.statusCode == 200) {
      var data = response.data;
      print(data);
    } else {
      print("ERROR ->${response.statusCode}");
    }

    // sort response data
  }
}
