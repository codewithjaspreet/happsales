import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/accounts.dart';
import '../models/database.dart';
import '../utils/api_endpoints.dart';

class AccountViewModel extends GetxController{

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

    print("ONINITTTTT called ${accounts.length} ");

    var result = checkInternetConnectivity();
    print("result is $result");
    getAccountList();
  }

  RxList accountList = [].obs;
  var accounts = [].obs;

  Future<RxList> getAccountList() async {
    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getAccountPaged;
    var token = ApiEndPoints.authEndpoints.token;

    try {
      var response = await Dio().post(
        url,
        data: {
          "pageindex": "1",
          "pagesize": "100",
          "objectdate1": "2000-01-01T00:00:00",
          "objectdate2": "2023-04-01T13:10:16.732894"
        },
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json',
          },
        ),
      );
      // Handle response data
      print("response coming from api is  $response");
      (response.data as List).forEach((employee) {
        Account account = Account.fromJson(employee);
        accountList.add(account);
        // Uncomment the following line if DBProvider is properly configured
        DBProvider.db.createAccount(account);

      });
    } catch (error) {
      print(error.toString());
    }


    return accountList;
  }
  //
  // Contact? getUserById(int id) {
  //   return contacts.firstWhere((user) => user.contactID == id, orElse: () => null);
  // }
  fetchAccounts() async {
    var dbAccounts = await DBProvider.db.getAllAccounts();
    accounts.value = dbAccounts;
  }
}