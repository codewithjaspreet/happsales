

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppSyncItem.dart';
import '../DataBaseHandler.dart';

 class SyncDataHandler {


     static Future<List<AppSyncItem>> GetAppSyncItemRecords(DatabaseHandler databaseHandler, )async {
        List<AppSyncItem> dataList = [];
        try {
            String selectQuery = "SELECT A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " ORDER BY A.ID";

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppSyncItem dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];

                    dataList.add(dataItem);

            }
          
            //db.close();
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecordsMin()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppSyncItem>> GetAppSyncItemRecordsMin(DatabaseHandler databaseHandler, )async {
        List<AppSyncItem> dataList = [];
        try {
            String selectQuery = "SELECT A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_TABLENAME} NOT LIKE 'Chat%'";

          
            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppSyncItem dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];

                    dataList.add(dataItem);

            }
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecordsMin()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppSyncItem>> GetAppSyncItemRecordsMin_Chat(DatabaseHandler databaseHandler, ) async{
        List<AppSyncItem> dataList = [];
        try {
            String selectQuery = "SELECT A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_TABLENAME} LIKE 'Chat%'";

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppSyncItem dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];

                    dataList.add(dataItem);

            }
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecordsMin()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<AppSyncItem?> GetAppSyncItemRecord(DatabaseHandler databaseHandler, String tableName)async {
        AppSyncItem? dataItem ;
        try {
            String selectQuery = "SELECT A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_TABLENAME} = '$tableName'";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                     dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];


            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> UpdateAppSyncItemRecord(DatabaseHandler databaseHandler, String id1, AppSyncItem dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            
            Map<String, dynamic> values = {};
if (dataItem.tableName != null && dataItem.tableName != "null") {
  values[ColumnsBase.KEY_APPSYNC_TABLENAME] = dataItem.tableName;
}
if (dataItem.lMaxDate != null && dataItem.lMaxDate != "null") {
  values[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE] = dataItem.lMaxDate;
}
if (dataItem.sMaxDate != null && dataItem.sMaxDate != "null") {
  values[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE] = dataItem.sMaxDate;
}
if (dataItem.pgSize != null && dataItem.pgSize != "null") {
  values[ColumnsBase.KEY_APPSYNC_PAGESIZE] = dataItem.pgSize;
}
if (dataItem.records != null && dataItem.records != "null") {
  values[ColumnsBase.KEY_APPSYNC_RECORDS] = dataItem.records;
}
if (dataItem.page != null && dataItem.page != "null") {
  values[ColumnsBase.KEY_APPSYNC_PAGE] = dataItem.page;
}
if (dataItem.syncTime != null && dataItem.syncTime != "null") {
  values[ColumnsBase.KEY_APPSYNC_SYNCTIME] = dataItem.syncTime;
}

id = await db.update(
  TablesBase.TABLE_APPSYNC,
  values,
  where: '${ColumnsBase.KEY_ID} = $id1',
);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:UpdateAppSyncItemRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<AppSyncItem?> GetNextSyncRecord(DatabaseHandler databaseHandler, ) async{
        AppSyncItem? dataItem ;
        try {
            String selectQuery = "SELECT  A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString()}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_TABLENAME} NOT LIKE 'Chat%'";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_RECORDS} <> 0 ORDER BY CAST(A.${Columns.KEY_APPSYNC_SEQUENTIALORDER} AS INTEGER) LIMIT 1";
            //selectQuery += " AND A." + ColumnsBase.KEY_APPSYNC_RECORDS + " <> 0 ORDER BY ID LIMIT 1";
final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppSyncItem dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];


            }
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppSyncItem?> GetNextSyncRecord_Chat(DatabaseHandler databaseHandler, ) async{
        AppSyncItem? dataItem ;
        try {
            String selectQuery = "SELECT  A.*  FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_TABLENAME} LIKE 'Chat%'";
            selectQuery += " AND A.${ColumnsBase.KEY_APPSYNC_RECORDS} <> 0 ORDER BY ID LIMIT 1";

            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){

                    AppSyncItem dataItem = new AppSyncItem();

                    dataItem.id = element[ColumnsBase.KEY_ID];
                    dataItem.tableName = element[ColumnsBase.KEY_APPSYNC_TABLENAME];
                    dataItem.lMaxDate = element[ColumnsBase.KEY_APPSYNC_LOCALMAXDATE];
                    dataItem.sMaxDate = element[ColumnsBase.KEY_APPSYNC_SERVERMAXDATE];
                    dataItem.pgSize = element[ColumnsBase.KEY_APPSYNC_PAGESIZE];
                    dataItem.records = element[ColumnsBase.KEY_APPSYNC_RECORDS];
                    dataItem.page = element[ColumnsBase.KEY_APPSYNC_PAGE];
                    dataItem.syncTime = element[ColumnsBase.KEY_APPSYNC_SYNCTIME];


            }
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> GetAppSyncItemCount(DatabaseHandler databaseHandler, ) async{
        int itemCount = 0;
        try {

            String selectQuery = "SELECT SUM(Records) " ;
            selectQuery += " FROM ${TablesBase.TABLE_APPSYNC} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPSYNC_APPUSERID} = ${Globals.AppUserID} AND A.${ColumnsBase.KEY_APPSYNC_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " ORDER BY A.ID";


            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                itemCount = element[0];
            }
            
        } catch ( ex) {
            Globals.handleException( "SyncDataHandler:GetAppSyncItemCount()", ex);
            throw ex;
        }
        return itemCount;
    }


    /*-------------------HAPPSALES-------------------*/

}