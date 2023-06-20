import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityProductDetail.dart';
import '../DataBaseHandler.dart';

class OpportunityProductDetailDataHandlerBase {
  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<OpportunityProductDetail> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

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
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
      }

      /* FILTER */
      /*String groups = "";
			String tags = "";
			String groupitem = "";
			for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
				String key1 = entry.getKey();
				String value1 = entry.getValue();
				if (entry.getKey().equals("XXXXX")) {
					groupitem = value1;
				} else {
					groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
					tags += (tags.equals("") ? value1 : "," + value1);
				}
			}
			if (groupitem.trim().length() > 0)
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityProductDetail_ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

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
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailRecords(
          DatabaseHandler databaseHandler, String searchString) async {
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
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE} COLLATE NOCASE ASC ";

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
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityProductDetail?> GetOpportunityProductDetailRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityProductDetail? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityProductDetail?>
      GetMasterOpportunityProductDetailRecord(
          DatabaseHandler databaseHandler, String id) async {
    OpportunityProductDetail? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetMasterOpportunityProductDetailRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityProductDetailRecord(
      DatabaseHandler databaseHandler,
      OpportunityProductDetail dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.opportunityProductDetailID != null &&
          dataItem.opportunityProductDetailID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID] =
            dataItem.opportunityProductDetailID;
      }
      if (dataItem.opportunityProductDetailCode != null &&
          dataItem.opportunityProductDetailCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE] =
            dataItem.opportunityProductDetailCode;
      }
      if (dataItem.opportunityProductID != null &&
          dataItem.opportunityProductID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID] =
            dataItem.opportunityProductID;
      }
      if (dataItem.attribute != null && dataItem.attribute != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE] =
            dataItem.attribute;
      }
      if (dataItem.price != null && dataItem.price != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE] = dataItem.price;
      }
      if (dataItem.quantity != null && dataItem.quantity != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY] =
            dataItem.quantity;
      }
      if (dataItem.amount != null && dataItem.amount != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT] =
            dataItem.amount;
      }
      if (dataItem.supplierAccountID != null &&
          dataItem.supplierAccountID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID] =
            dataItem.supplierAccountID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.id != null && dataItem.id != "null") {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      if (dataItem.isDirty != null && dataItem.isDirty != "null") {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityProductDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityProductDetailRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityProductDetail dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.opportunityProductDetailID != null &&
          dataItem.opportunityProductDetailID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID] =
            dataItem.opportunityProductDetailID;
      }
      if (dataItem.opportunityProductDetailCode != null &&
          dataItem.opportunityProductDetailCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILCODE] =
            dataItem.opportunityProductDetailCode;
      }
      if (dataItem.opportunityProductID != null &&
          dataItem.opportunityProductID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID] =
            dataItem.opportunityProductID;
      }
      if (dataItem.attribute != null && dataItem.attribute != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ATTRIBUTE] =
            dataItem.attribute;
      }
      if (dataItem.price != null && dataItem.price != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_PRICE] = dataItem.price;
      }
      if (dataItem.quantity != null && dataItem.quantity != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_QUANTITY] =
            dataItem.quantity;
      }
      if (dataItem.amount != null && dataItem.amount != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_AMOUNT] =
            dataItem.amount;
      }
      if (dataItem.supplierAccountID != null &&
          dataItem.supplierAccountID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID] =
            dataItem.supplierAccountID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.id != null && dataItem.id != "null") {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      if (dataItem.isDirty != null && dataItem.isDirty != "null") {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null") {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }
      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityProductDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityProductDetailRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityProductDetailRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase
                .KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  static Future<String> GetLocalId(
      DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTDETAILID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityProductDetail>>
      GetOpportunityProductDetailUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityProductDetail> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityProductDetail?>
      GetOpportunityProductDetailRecordByUid(
          DatabaseHandler databaseHandler, String uid) async {
    OpportunityProductDetail? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE},E.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCTDETAIL} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYPRODUCT} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_OPPORTUNITYPRODUCTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_SUPPLIERACCOUNTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPRODUCTDETAIL_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailUpSyncRecords()",
          ex);
      throw ex;
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDetailDataHandlerBase:GetOpportunityProductDetailRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
