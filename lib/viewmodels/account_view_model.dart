import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/models/accounts.dart';
import 'package:happsales_crm/utils/api_endpoints.dart';
import 'package:happsales_crm/viewmodels/contact_view_model.dart';
import '../models/contact.dart';
import '../models/database.dart';

class AccountViewModel extends GetxController {

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    print("ONINITTTTT called${accounts.length} ");


    getAccountList();
    fetchAccounts();
    // getAccountList();
  }

  // RxList accountList = [].obs;
  RxList accounts = [].obs;

  Future<RxList>getAccountList () async {
    var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getAccountPaged;
    var token = ApiEndPoints.authEndpoints.token;

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
    print(response.data);
    for (var employee in (response.data as List)) {
      Account account = Account.fromJson(employee);
      accounts.add(account);
      // Uncomment the following line if DBProvider is properly configured
      DBProvider.db.createAccount(account);


    }

    return accounts;
  }

  Account? getAccountById(int id) {
    return accounts.firstWhere((user) => user.accountID == id, orElse: () => null);
  }


  Contact? getContactByAccountID(String id) {
    return ContactViewModel().contacts.firstWhere((user) => user.accountID.toString() == id, orElse: () => null);
  }
  fetchAccounts() async {
    var dbcontacts = await DBProvider.db.getAllAccounts();
    accounts.value =  dbcontacts;
  }


}
