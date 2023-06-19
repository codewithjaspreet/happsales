import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityProductDetail.dart';
import '../DataBaseHandler.dart';
import 'ActivityProductDetailDataHandlerBase.dart';

class ActivityProductDetailDataHandler
    extends ActivityProductDetailDataHandlerBase {
  static Future<List<ActivityProductDetail>>
      GetActivityProductDetailRecordsByActivityProductId(
          DatabaseHandler databaseHandler, String activityProductId) async {
    List<ActivityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRODUCT} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = $activityProductId";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityProductDetail dataItem = new ActivityProductDetail();

        dataItem.activityProductDetailID = element[
            ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
        dataItem.activityProductDetailCode = element[
            ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
        dataItem.activityProductID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
        dataItem.attribute =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
        dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
        dataItem.quantity =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
        dataItem.supplierAccountID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
        dataItem.activityProductCode =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
        dataItem.supplierAccountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDetailDataHandlerBase:GetActivityProductDetailRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<int> DeleteActivityProductDetailRecordByActivityProductId(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITYPRODUCTDETAIL,
          where:
              "${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = $id1",
          whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteActivityProductDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<List<ActivityProductDetail>>
      GetActivityProductDetailUpSyncRecordsByActivityId(
          DatabaseHandler databaseHandler,
          String changeType,
          String activityId) async {
    List<ActivityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* FROM ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_ACTIVITYPRODUCT} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT A.* FROM ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_ACTIVITYPRODUCT} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_ISDELETED} = 'false'  AND A.${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT A.* FROM ${TablesBase.TABLE_ACTIVITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_ACTIVITYPRODUCT} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_ISDELETED} = 'false'  AND A.${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND B.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = $activityId";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityProductDetail dataItem = new ActivityProductDetail();

        dataItem.activityProductDetailID = element[
            ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILID];
        dataItem.activityProductDetailCode = element[
            ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTDETAILCODE];
        dataItem.activityProductID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ACTIVITYPRODUCTID];
        dataItem.attribute =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ATTRIBUTE];
        dataItem.price = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_PRICE];
        dataItem.quantity =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_QUANTITY];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_AMOUNT];
        dataItem.supplierAccountID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_SUPPLIERACCOUNTID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_MODIFIEDON];

        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_ISDELETED];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYPRODUCTDETAIL_REFERENCEIDENTIFIER];
        dataItem.activityProductCode =
            element[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE];
        dataItem.supplierAccountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDetailDataHandlerBase:GetActivityProductDetailUpSyncRecordsByActivityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
