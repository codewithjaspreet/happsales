import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityProduct.dart';
import '../DataBaseHandler.dart';

class OpportunityProductDataHandlerBase {
  static Future<List<OpportunityProduct>> GetOpportunityProductRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityProduct> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

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
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityProduct_ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

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
          "OpportunityProductDataHandlerBase:GetOpportunityProductRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityProduct>> GetOpportunityProductRecords(
      DatabaseHandler databaseHandler, String searchString) async {
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
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE} LIKE '${searchString.replaceAll("'", "''")}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE} COLLATE NOCASE ASC ";

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
          "OpportunityProductDataHandlerBase:GetOpportunityProductRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityProduct?> GetOpportunityProductRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityProduct? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityProduct?> GetMasterOpportunityProductRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityProduct? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetMasterOpportunityProductRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityProductRecord(
      DatabaseHandler databaseHandler, OpportunityProduct dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityProductID != null &&
          dataItem.opportunityProductID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID] =
            dataItem.opportunityProductID;
      if (dataItem.opportunityProductCode != null &&
          dataItem.opportunityProductCode != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE] =
            dataItem.opportunityProductCode;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID] =
            dataItem.opportunityID;
      if (dataItem.productID != null && dataItem.productID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID] =
            dataItem.productID;
      if (dataItem.price != null && dataItem.price != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRICE] = dataItem.price;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED] =
            dataItem.isDeleted;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYPRODUCT, values);
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityProductRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityProductRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityProduct dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityProductID != null &&
          dataItem.opportunityProductID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID] =
            dataItem.opportunityProductID;
      if (dataItem.opportunityProductCode != null &&
          dataItem.opportunityProductCode != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTCODE] =
            dataItem.opportunityProductCode;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID] =
            dataItem.opportunityID;
      if (dataItem.productID != null && dataItem.productID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID] =
            dataItem.productID;
      if (dataItem.price != null && dataItem.price != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRICE] = dataItem.price;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_ISDELETED] =
            dataItem.isDeleted;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRODUCT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;

      id = await db.update(TablesBase.TABLE_OPPORTUNITYPRODUCT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityProductRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityProductRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPRODUCT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityProductRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0]
                [ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID]
            .toString();
      }
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0]
                [ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYPRODUCTID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityProduct>> GetOpportunityProductUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityProduct> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityProduct?> GetOpportunityProductRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityProduct? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRODUCT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRODUCT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityProductDataHandlerBase:GetOpportunityProductRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
