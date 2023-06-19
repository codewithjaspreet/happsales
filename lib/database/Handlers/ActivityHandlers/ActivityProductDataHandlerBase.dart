import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityProduct.dart';
import '../DataBaseHandler.dart';

class ActivityProductDataHandlerBase {
  static Future<List<ActivityProduct>> GetActivityProductRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ActivityProduct> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityProduct_Columns.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

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
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetActivityProductRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ActivityProduct>> GetActivityProductRecords(
      DatabaseHandler databaseHandler, String searchString) async {
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
      if (searchString.trim().length > 0) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE} LIKE '$searchString%'";
      }
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE} COLLATE NOCASE ASC ";

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
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetActivityProductRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ActivityProduct?> GetActivityProductRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityProduct? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetActivityProductRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityProduct?> GetMasterActivityProductRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityProduct? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetMasterActivityProductRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddActivityProductRecord(
      DatabaseHandler databaseHandler, ActivityProduct dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.activityProductID != null &&
          dataItem.activityProductID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID] =
            dataItem.activityProductID;
      }
      if (dataItem.activityProductCode != null &&
          dataItem.activityProductCode != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE] =
            dataItem.activityProductCode;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID] =
            dataItem.activityID;
      }
      if (dataItem.productID != null && dataItem.productID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID] = dataItem.productID;
      }
      if (dataItem.price != null && dataItem.price != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_PRICE] = dataItem.price;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED] = dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_REFERENCEIDENTIFIER] =
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
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_ACTIVITYPRODUCT, values);
//db.close(); // change to dart, remove the 'get' keyword, and follow camel case
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddActivityProductRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateActivityProductRecord(
      DatabaseHandler databaseHandler,
      String id1,
      ActivityProduct dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.activityProductID != null &&
          dataItem.activityProductID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID] =
            dataItem.activityProductID;
      }
      if (dataItem.activityProductCode != null &&
          dataItem.activityProductCode != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTCODE] =
            dataItem.activityProductCode;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID] =
            dataItem.activityID;
      }
      if (dataItem.productID != null && dataItem.productID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID] = dataItem.productID;
      }
      if (dataItem.price != null && dataItem.price != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_PRICE] = dataItem.price;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_ISDELETED] = dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYPRODUCT_REFERENCEIDENTIFIER] =
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
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(TablesBase.TABLE_ACTIVITYPRODUCT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateActivityProductRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteActivityProductRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITYPRODUCT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteActivityProductRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID];
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYPRODUCTID];
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ActivityProduct>> GetActivityProductUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<ActivityProduct> dataList = [];
    try {
      String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetActivityProductUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ActivityProduct?> GetActivityProductRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ActivityProduct? dataItem;
    try {
      String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_PRODUCT_PRODUCTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPRODUCT} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCT} E ON A.${ColumnsBase.KEY_ACTIVITYPRODUCT_PRODUCTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYPRODUCT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRODUCT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

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
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityProductDataHandlerBase:GetActivityProductRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
