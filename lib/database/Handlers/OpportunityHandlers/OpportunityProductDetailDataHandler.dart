import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityProductDetail.dart';
import '../DataBaseHandler.dart';
import 'OpportunityProductDetailDataHandlerBase.dart';

class OpportunityProductDetailDataHandler
    extends OpportunityProductDetailDataHandlerBase {
  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailRecordsByOpportunityId(
          DatabaseHandler databaseHandler, String opportunityId) async {
    List<OpportunityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " INNER JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = $opportunityId";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityProductDetail dataItem = new OpportunityProductDetail();
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];

        dataItem.opportunityProductID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID];

        dataItem.attribute =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE];

        dataItem.price =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE];

        dataItem.quantity =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY];

        dataItem.amount =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT];

        dataItem.supplierAccountID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID];

        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON];

        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY];

        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON];

        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE];

        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED];

        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED];

        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER];

        dataItem.supplierAccountName =
            element[Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME];

        dataItem.opportunityProductCode =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE];

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
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecordsByOpportunityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailRecordsByOpportunityProductId(
          DatabaseHandler databaseHandler, String opportunityProductId) async {
    List<OpportunityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = $opportunityProductId";
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID}";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityProductDetail dataItem = new OpportunityProductDetail();
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];

        dataItem.opportunityProductID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID];

        dataItem.attribute =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE];

        dataItem.price =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE];

        dataItem.quantity =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY];

        dataItem.amount =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT];

        dataItem.supplierAccountID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID];

        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON];

        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY];

        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON];

        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE];

        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED];

        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED];

        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER];

        dataItem.supplierAccountName =
            element[Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME];

        dataItem.opportunityProductCode =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE];

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
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<int> DeleteOpportunityProductDetailRecordByOpportunityProductId(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL,
          where:
              "${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = $id1",
          whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityProductDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailUpSyncRecordsByOpportunityId(
          DatabaseHandler databaseHandler,
          String changeType,
          String opportunityId) async {
    List<OpportunityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} B ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT A.* FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} B ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_ISDELETED} = 'false'  AND A.${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT A.* FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A INNER JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} B ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = B.${ColumnsBase.KEY_ID} WHERE A.${ColumnsBase.KEY_ISDIRTY} = 'true' AND A.${ColumnsBase.KEY_ISDELETED} = 'false'  AND A.${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND B.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = $opportunityId";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityProductDetail dataItem = new OpportunityProductDetail();
        dataItem.opportunityProductDetailID = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID];
        dataItem.opportunityProductDetailCode = element[ColumnsBase
            .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE];

        dataItem.opportunityProductID = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID];

        dataItem.attribute =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE];

        dataItem.price =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE];

        dataItem.quantity =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY];

        dataItem.amount =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT];

        dataItem.supplierAccountID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID];

        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON];

        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY];

        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON];

        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE];

        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED];

        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED];

        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER];

        dataItem.supplierAccountName =
            element[Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME];

        dataItem.opportunityProductCode =
            element[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE];

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
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailUpSyncRecordsByOpportunityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
