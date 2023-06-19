
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityProduct.dart';
import '../DataBaseHandler.dart';
import 'ActivityProductDataHandlerBase.dart';

class ActivityProductDataHandler extends ActivityProductDataHandlerBase {

     static Future<List<ActivityProduct>> GetActivityProductRecordsByActivityId(DatabaseHandler databaseHandler,  String activityId)async {
        List<ActivityProduct> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = $activityId" ;

           final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityProduct dataItem = new ActivityProduct();
        dataItem.activityProductID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID];
        dataItem.activityProductCode =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
        dataItem.activityID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID];
        dataItem.productID = element[ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID];
        dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCT_PRICE];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCT_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_REFERENCEIDENTIFIER];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }
        } catch ( ex) {
            Globals.handleException( "ActivityProductDataHandlerBase:GetActivityProductRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<String>> GetActivityProductUpSyncRecordsActivityIds(DatabaseHandler databaseHandler,  String changeType) async{
        List<String> dataList = [];
        try {
            String selectQuery = "SELECT DISTINCT ${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT DISTINCT ${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
        /*    if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT DISTINCT " + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID  + " FROM " + TablesBase.TABLE_ACTIVITYPRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT DISTINCT " + ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID  + "  FROM " + TablesBase.TABLE_ACTIVITYPRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for (var element in result) {
                dataList.add(element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID]);
            }

          
        } catch ( ex) {
            Globals.handleException( "ActivityProductDataHandlerBase:GetActivityProductUpSyncRecordsActivityIds()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityProduct>> GetActivityProductUpSyncRecordsByActivityId(DatabaseHandler databaseHandler,  String changeType, String activityId) async {
        List<ActivityProduct> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType ==(AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = $activityId";

            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityProduct dataItem = new ActivityProduct();
        dataItem.activityProductID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID];
        dataItem.activityProductCode =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
        dataItem.activityID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID];
        dataItem.productID = element[ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID];
        dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCT_PRICE];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCT_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_REFERENCEIDENTIFIER];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.productName = element[ColumnsBase.KEY_PRODUCT_PRODUCTNAME];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }
        } catch ( ex) {
            Globals.handleException( "ActivityProductDataHandlerBase:GetActivityProductUpSyncRecordsByActivityId()", ex);
            throw ex;
        }
        return dataList;
    }

    /*-------------------HAPPSALES-------------------*/

}