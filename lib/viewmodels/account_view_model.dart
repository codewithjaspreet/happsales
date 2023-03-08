import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';

import '../models/account_model.dart';
import '../models/database.dart';

class AccountViewModel extends GetxController {
  var accountList = RxList<Account>();

  RxBool downloading = false.obs;

  Future<void> getAccountList() async {
    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getAccountPaged;
    var token = ApiEndPoints.authEndpoints.token;



    var response = await Dio().post(
      url,
      data: {
        "pageindex": "1",
        "pagesize": "100",
        "objectdate1": "2000-01-01T00:00:00",
        "objectdate2": "2023-03-08T13:10:16.732894"
      },
      options: Options(
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json', // set Content-Type header
        },
      ),
    );

    if (response.statusCode == 200) {
      var data = response.data;
      print(data); // check response data

      // parse response data
      var accounts = List<Account>.from(
        data.map((accountData) => Account.fromJson(accountData)),
      );

      accountList.value = accounts; // set accountList value
    } else {
      print("ERROR ->${response.statusCode}");
    }
  }
}
