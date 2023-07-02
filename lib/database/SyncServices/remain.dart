import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountDataHandlerBase.dart';

import '../AppConstants.dart';
import '../Globals.dart';
import '../Handlers/DataBaseHandler.dart';
import 'JsonCopier.dart';
import 'Utility.dart';
import 'package:http/http.dart' as http;

class Remain {
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

  void resetRecordCount(AppSyncItem dataItem) {
    try {
      dataItem.page = '0';
      dataItem.records = '0';
      // dataItem.lMaxDate = dataItem.sMaxDate; // Uncomment this line if needed
      // Assuming that SyncDataHandler.UpdateAppSyncItemRecord() is a synchronous method
      // Replace it with the appropriate asynchronous method if needed
      SyncDataHandler.updateAppSyncItemRecord(dbHandler, dataItem.id, dataItem);
      logMessage("Reset of paging ${dataItem.tableName}");
    } catch (ex) {
      handleException("SyncService:ResetRecordCount()", ex);
    }
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
            dbHandler, context, typeOfData);
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
                  dbHandler, context, id);
              if (account == null && doDoubleCheck && uid != '') {
                account = AccountDataHandler.GetAccountRecordByUid(
                    dbHandler, context, uid);
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
            ResetRecordCount(dataItem);
          }
        }
      }
    } catch (e) {
      LogError('Error: SyncService:DownSyncAccount() 3-> $e');
    }
  }

  


}
