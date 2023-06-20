import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityProduct.dart';
import '../DataBaseHandler.dart';
import 'OpportunityProductDataHandlerBase.dart';

class OpportunityProductDataHandler extends OpportunityProductDataHandlerBase {
  static Future<List<String>> GetOpportunityProductUpSyncRecordsOpportunityIds(
      DatabaseHandler databaseHandler, String changeType) async {
    List<String> dataList = [];
    try {
      String selectQuery =
          "SELECT DISTINCT ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT DISTINCT ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }

      /*    if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT DISTINCT " + ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID  + " FROM " + TablesBase.TABLE_OPPORTUNITYPRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT DISTINCT " + ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID  + "  FROM " + TablesBase.TABLE_OPPORTUNITYPRODUCT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE coalesce(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'') <> '')";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (Map<String, dynamic> map in result) {
        dataList.add(map[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID]);
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductUpSyncRecordsOpportunityIds()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProduct>>
      GetOpportunityProductRecordsByOpportunityId(
          DatabaseHandler databaseHandler, String opportunityId) async {
    List<OpportunityProduct> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = $opportunityId";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProduct dataItem = new OpportunityProduct();
        dataItem.opportunityProductID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID];
        dataItem.opportunityProductCode =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID];
        dataItem.productID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID];
        dataItem.price = element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRICE];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDBY];

        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDON];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductRecordsByOpportunityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProduct>>
      GetOpportunityProductUpSyncRecordsByOpportunityId(
          DatabaseHandler databaseHandler,
          String changeType,
          String opportunityId) async {
    List<OpportunityProduct> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = $opportunityId";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityProduct dataItem = new OpportunityProduct();
        dataItem.opportunityProductID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID];
        dataItem.opportunityProductCode =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID];
        dataItem.productID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID];
        dataItem.price = element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRICE];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDBY];

        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDON];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductUpSyncRecordsByOpportunityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
