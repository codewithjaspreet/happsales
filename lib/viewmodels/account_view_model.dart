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

    var response = await Dio().post(url,
        data: {
          "pageindex": "0",
          "pagesize": "10",
          "objectdate1": "2000-01-01T00:00:00",
          "objectdate2": "2000-01-01T00:00:00"
        },
        options: Options(
          headers: {
            'Authorization': "Bearer ejvnsvnc",
          },
        ));

    // sort response data


  }
}
