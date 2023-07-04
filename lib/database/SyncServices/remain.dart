import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactTitleDataHandlerBase.dart';

import '../AppConstants.dart';
import '../Globals.dart';
import '../Handlers/DataBaseHandler.dart';
import '../models/AccountModels/AccountBuyingProcess.dart';
import 'JsonCopier.dart';
import 'Utility.dart';
import 'package:http/http.dart' as http;

class Remain {

  static DatabaseHandler dbHandler = DatabaseHandler();
  Future<bool> updateDownSyncPageStatus(AppSyncItem dataItem) async {
    bool isAllPagesDone = false;
    try {
      int records = Globals.tryParseInt(dataItem.records);
      int pageSize = Globals.tryParseInt(dataItem.pgSize);
      int totalPages = (records / pageSize).ceil();
      int pageNow = Globals.tryParseInt(dataItem.page);

      if (pageNow + 1 >= totalPages) {
        dataItem.page = '0';
        dataItem.records = '0';
        dataItem.lMaxDate = dataItem.sMaxDate;
        isAllPagesDone = true;
      } else {
        dataItem.page = (pageNow + 1).toString();
        isAllPagesDone = false;
      }

      int rid = await SyncDataHandler.updateAppSyncItemRecord(
          dbHandler, dataItem.id, dataItem);

      logMessage(
          'Completed ${pageNow + 1} of $totalPages of ${dataItem.tableName}');
      Globals.DownSyncCountStatus =
          'Completed ${pageNow + 1} of $totalPages of ${dataItem.tableName}';
    } catch (ex) {
      Globals.handleException('SyncService:UpdateDownSyncPageStatus()', ex);
    }
    return isAllPagesDone;
  }



  String getPostDataString(Map<String, dynamic> params) {
    StringBuffer result = StringBuffer();
    try {
      bool first = true;

      params.forEach((key, value) {
        if (first) {
          first = false;
        } else {
          result.write("&");
        }

        result.write(Uri.encodeQueryComponent(key));
        result.write("=");
        result.write(Uri.encodeQueryComponent(value.toString()));
      });
    } catch (error) {
      Globals.handleException("SyncService:GetPostDataString()", error);
    }
    return result.toString();
  }

// read file path and give content of it as a bytes array

// Future<Uint8List> readFileAsBytes(String filePath) async {
//   try {
//     File file = File(filePath);
//     Uint8List bytes = await file.readAsBytes();
//     return bytes;
//   } catch (error) {
//     Globals.handleException( "SyncService:ReadFileAsBytes()", error);
//     return null;
//   }

  Future<void> downSyncMaxDates() async {
    try {
      if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
        final url =
            AppConstants.API_VERSION_URL + '/DownSyncManager/GetMaxServerDate';

        final dbHandler = DatabaseHandler();
        final syncItems = SyncDataHandler.GetAppSyncItemRecordsMin(
          dbHandler,
        );
        final userdata = json.encode(syncItems);

        final postData = {'UserData': userdata};

        final headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
          'Content-Type': 'application/json',
        };

        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            final dataString = jsonResponse['DataObject'];

            if (Globals.isJSONArray(dataString)) {
              final jsonArray = json.decode(dataString) as List<dynamic>;

              for (final jsonObject in jsonArray) {
                if (jsonObject != null) {
                  final tableName = jsonObject['TableName'];
                  final serverMaxDate = jsonObject['SMaxDate'];
                  final recordCount = jsonObject['Records'];
                  final lastSyncTime = jsonObject['SCreatedOn'];

                  if (tableName != null && tableName != '') {
                    final appSyncItem = SyncDataHandler.GetAppSyncItemRecord(
                        dbHandler, tableName);
                    if (appSyncItem != null) {
                      appSyncItem.setSMaxDate(serverMaxDate);
                      appSyncItem.setRecords(recordCount);
                      appSyncItem.setSyncTime(lastSyncTime);
                      final rid = SyncDataHandler.UpdateAppSyncItemRecord(
                          dbHandler, appSyncItem.getId(), appSyncItem);
                    }
                  }
                }
              }
              LogMessage('DownSyncMaxDates - Completed.');
            }
          }
        } else {
          final error = response.body;
          // Handle the error accordingly
          LogError('HTTP Error: $error');
        }
      }
    } catch (e) {
      // Handle any exceptions that occur
      LogError('Error: SyncService:DownSyncMaxDates() -> $e');
    } finally {
      ResetPageIndexes();
      currentDownload = '';
    }
  }

  Future<void> downSyncAccounts(String typeOfData) async {
    try {
      if (await Utility.isNetworkConnected(context) &&
          Globals.USER_TOKEN != '') {
        String url =
            AppConstants.API_VERSION_URL + '/DownSyncManager/GetAccountPaged';

        final dataItem = SyncDataHandler.GetAppSyncItemRecord(
            dbHandler,  typeOfData);
        if (dataItem != null && dataItem.records != '0') {
          int records = Globals.TryParseInt(dataItem.records);
          int pageSize = Globals.TryParseInt(dataItem.pgSize);
          int totalPages = (records / pageSize).ceil();

          int pageNow = Globals.TryParseInt(dataItem.page);
          AccountsPageCurrent = pageNow + 1;

          var postData = {
            'pageindex': AccountsPageCurrent,
            'pagesize': pageSize,
            'objectdate1': dataItem.lMaxDate,
            'objectdate2': dataItem.sMaxDate,
          };

          var headers = {
            'Authorization': 'Bearer ${Globals.USER_TOKEN}',
          };

          var response = await http.post(Uri.parse(url),
              headers: headers, body: jsonEncode(postData));
          if (response.statusCode == 200) {
            var jsonArray = jsonDecode(response.body) as List<dynamic>;
            for (var jsonObject in jsonArray) {
              var id = jsonObject['AccountID'].toString();
              var uid = jsonObject['Uid'].toString();
              var account = AccountDataHandler.GetMasterAccountRecord(
                  dbHandler,  id);
              if (account == null && doDoubleCheck && uid != '') {
                account = AccountDataHandler.GetAccountRecordByUid(
                    dbHandler,  uid);
              }

              if (account == null) {
                account = Account();
                account = JSONCopier.CopyJsonDataToAccount(
                     dbHandler, jsonObject, account, true);
                var rid = AccountDataHandlerBase.AddAccountRecord(
                    dbHandler, account);
              } else {
                var isUploaded = Globals.getStringValue(account.isUploaded);
                account = JSONCopier.CopyJsonDataToAccount(
                    dbHandler, jsonObject, account, false);
                account.isUploaded = isUploaded;
                var rid = AccountDataHandlerBase.UpdateAccountRecord(
                    dbHandler, account.id, account);
              }
            }

            bool isAllPagesDone = await updateDownSyncPageStatus(dataItem);
            if (isAllPagesDone) AccountsPageCurrent = 0;
          } else if (response.statusCode == 401) {
            // Handle authentication failure
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500 && response.statusCode < 600) {
            try {
              String errorResponse = utf8.decode(response.bodyBytes);
              LogError('Server Error: ${response.statusCode}\n$errorResponse');
            } catch (e) {
              LogError('Error decoding server error response: $e');
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    } catch (e) {
      LogError('Error: SyncService:DownSyncAccount() 3-> $e');
    }
  }



Future<void> downSyncAccountAddresses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountAddressPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountAddressesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountAddressesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountAddress accountAddress;
              var id = jsonObject['AccountAddressID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountAddress = AccountAddressDataHandler.GetMasterAccountAddressRecord(dbHandler,  id);
              }
              if (accountAddress == null && doDoubleCheck && uid.isNotEmpty) {
                accountAddress = AccountAddressDataHandler.GetAccountAddressRecordByUid(dbHandler,  uid);
              }

              if (accountAddress == null) {
                accountAddress = AccountAddress();
                accountAddress = JSONCopier.CopyJsonDataToAccountAddress( dbHandler, jsonObject, accountAddress, true);
                var rid = AccountAddressDataHandlerB.AddAccountAddressRecord(dbHandler,  accountAddress);
              } else {
                accountAddress = JSONCopier.CopyJsonDataToAccountAddress( dbHandler, jsonObject, accountAddress, false);
                var rid = AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddress);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountAddressesPageCurrent = 0;
        } 
        
        else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } 
        
        else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountAddress() 3-> $e');
  }
}


Future<void> downSyncAccountBusinessPlans(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountBusinessPlanPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountBusinessPlansPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBusinessPlansPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBusinessPlan accountBusinessPlan;
              var id = jsonObject['AccountBusinessPlanID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBusinessPlan = AccountBusinessPlanDataHandler.GetMasterAccountBusinessPlanRecord(dbHandler,  id);
              }
              if (accountBusinessPlan == null && doDoubleCheck && uid.isNotEmpty) {
                accountBusinessPlan = AccountBusinessPlanDataHandler.GetAccountBusinessPlanRecordByUid(dbHandler,  uid);
              }

              if (accountBusinessPlan == null) {
                accountBusinessPlan = AccountBusinessPlan();
                accountBusinessPlan = JSONCopier.CopyJsonDataToAccountBusinessPlan( dbHandler, jsonObject, accountBusinessPlan, true);
                var rid = AccountBusinessPlanDataHandler.AddAccountBusinessPlanRecord(dbHandler,  accountBusinessPlan);
              } else {
                accountBusinessPlan = JSONCopier.CopyJsonDataToAccountBusinessPlan( dbHandler, jsonObject, accountBusinessPlan, false);
                var rid = AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler,  accountBusinessPlan.id, accountBusinessPlan);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBusinessPlansPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountBusinessPlan() 3-> $e');
  }
}


Future<void> downSyncAccountBusinessUnits(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountBusinessUnitPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountBusinessUnitsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBusinessUnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBusinessUnit accountBusinessUnit;
              var id = jsonObject['AccountBusinessUnitID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBusinessUnit = AccountBusinessUnitDataHandler.GetMasterAccountBusinessUnitRecord(dbHandler,  id);
              }
              if (accountBusinessUnit == null && doDoubleCheck && uid.isNotEmpty) {
                accountBusinessUnit = AccountBusinessUnitDataHandler.GetAccountBusinessUnitRecordByUid(dbHandler,  uid);
              }

              if (accountBusinessUnit == null) {
                accountBusinessUnit = AccountBusinessUnit();
                accountBusinessUnit = JSONCopier.CopyJsonDataToAccountBusinessUnit( dbHandler, jsonObject, accountBusinessUnit, true);
                var rid = AccountBusinessUnitDataHandler.AddAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit);
              } else {
                accountBusinessUnit = JSONCopier.CopyJsonDataToAccountBusinessUnit( dbHandler, jsonObject, accountBusinessUnit, false);
                var rid = AccountBusinessUnitDataHandler.UpdateAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit.id, accountBusinessUnit);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBusinessUnitsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountBusinessUnit() 3-> $e');
  }
}


Future<void> downSyncAccountBuyingProcesses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountBuyingProcessPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountBuyingProcessesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBuyingProcessesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBuyingProcess accountBuyingProcess;
              var id = jsonObject['AccountBuyingProcessID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBuyingProcess = AccountBuyingProcessDataHandler.GetMasterAccountBuyingProcessRecord(dbHandler,  id);
              }
              if (accountBuyingProcess == null && doDoubleCheck && uid.isNotEmpty) {
                accountBuyingProcess = AccountBuyingProcessDataHandler.GetAccountBuyingProcessRecordByUid(dbHandler,  uid);
              }

              if (accountBuyingProcess == null) {
                accountBuyingProcess = AccountBuyingProcess();
                accountBuyingProcess = JSONCopier.CopyJsonDataToAccountBuyingProcess( dbHandler, jsonObject, accountBuyingProcess, true);
                var rid = AccountBuyingProcessDataHandler.AddAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess);
              } else {
                accountBuyingProcess = JSONCopier.CopyJsonDataToAccountBuyingProcess( dbHandler, jsonObject, accountBuyingProcess, false);
                var rid = AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBuyingProcessesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountBuyingProcess() 3-> $e');
  }
}

Future<void> downSyncAccountCategories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountCategoryPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountCategoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountCategoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountCategory accountCategory;
              var id = jsonObject['AccountCategoryID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountCategory = AccountCategoryDataHandler.GetMasterAccountCategoryRecord(dbHandler,  id);
              }
              if (accountCategory == null && doDoubleCheck && uid.isNotEmpty) {
                accountCategory = AccountCategoryDataHandler.GetAccountCategoryRecordByUid(dbHandler,  uid);
              }

              if (accountCategory == null) {
                accountCategory = AccountCategory();
                accountCategory = JSONCopier.CopyJsonDataToAccountCategory( dbHandler, jsonObject, accountCategory, true);
                var rid = AccountCategoryDataHandler.AddAccountCategoryRecord(dbHandler,  accountCategory);
              } else {
                accountCategory = JSONCopier.CopyJsonDataToAccountCategory( dbHandler, jsonObject, accountCategory, false);
                var rid = AccountCategoryDataHandler.UpdateAccountCategoryRecord(dbHandler,  accountCategory.id, accountCategory);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountCategoriesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountCategory() 3-> $e');
  }
}



  Future<void> resetRecordCount(AppSyncItem dataItem) async {
  try {
    dataItem.page = "0";
    dataItem.records = "0";
    // dataItem.lMaxDate = dataItem.sMaxDate;
    int rid = await syncDataHandler.updateAppSyncItemRecord(dbHandler,  dataItem.id, dataItem);
    logMessage("Reset of paging ${dataItem.tableName}");
  } catch ( ex) {
     Globals.handleException( "SyncService:ResetRecordCount()", ex);
  }
}



Future<void> downSyncAccountCategoryMappings(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/DownSyncManager/GetAccountCategoryMappingPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.TryParseInt(dataItem.records);
        int pageSize = Globals.TryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.page);
        AccountCategoryMappingsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountCategoryMappingsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountCategoryMapping accountCategoryMapping;
              var id = jsonObject['AccountCategoryMappingID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountCategoryMapping = AccountCategoryMappingDataHandler.GetMasterAccountCategoryMappingRecord(dbHandler,  id);
              }
              if (accountCategoryMapping == null && doDoubleCheck && uid.isNotEmpty) {
                accountCategoryMapping = AccountCategoryMappingDataHandler.GetAccountCategoryMappingRecordByUid(dbHandler,  uid);
              }

              if (accountCategoryMapping == null) {
                accountCategoryMapping = AccountCategoryMapping();
                accountCategoryMapping = JSONCopier.CopyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, accountCategoryMapping, true);
                var rid = AccountCategoryMappingDataHandler.AddAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping);
              } else {
                accountCategoryMapping = JSONCopier.CopyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, accountCategoryMapping, false);
                var rid = AccountCategoryMappingDataHandler.UpdateAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping.getId(), accountCategoryMapping);
              }
            }
          }

          bool isAllPagesDone = await UpdateDownSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountCategoryMappingsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncAccountCategoryMapping() 3-> $e');
  }
}


void downSyncContactTitles(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactTitlePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler, context, typeOfData);
      if (dataItem != null && dataItem.getRecords() != '0') {
        int records = Globals.TryParseInt(dataItem.getRecords());
        int pageSize = Globals.TryParseInt(dataItem.getPgSize());
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.TryParseInt(dataItem.getPage());
        ContactTitlesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactTitlesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContactTitle contactTitle;
                  var id = jsonObject['ContactTitleID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contactTitle = ContactTitleDataHandler.GetMasterContactTitleRecord(dbHandler, context, id);
                  }

                  if (contactTitle == null && doDoubleCheck && uid != null && uid != '') {
                    contactTitle = ContactTitleDataHandler.GetContactTitleRecordByUid(dbHandler, context, uid);
                  }

                  if (contactTitle == null) {
                    contactTitle = ContactTitle();
                    contactTitle = JSONCopier.CopyJsonDataToContactTitle(context, dbHandler, jsonObject, contactTitle, true);
                    var rid = await ContactTitleDataHandlerBase.addContactTitleRecord(dbHandler, contactTitle);
                  } else {
                    contactTitle = JSONCopier.CopyJsonDataToContactTitle(context, dbHandler, jsonObject, contactTitle, false);
                    var rid = ContactTitleDataHandler.UpdateContactTitleRecord(dbHandler, context, contactTitle.getId(), contactTitle);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactTitlesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch (Exception ex) {
            LogError('Error: SyncService:DownSyncContactTitle() 1-> ' + ex.getMessage());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContactTitle() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (Exception e) {
    LogError('Error: SyncService:DownSyncContactTitle() 3-> ' + e.getMessage());
  }
}

}
