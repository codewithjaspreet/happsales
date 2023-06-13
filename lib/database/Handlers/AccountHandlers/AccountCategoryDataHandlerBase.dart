import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountCategory.dart';
import '../DataBaseHandler.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : AccountCategoryDataHandlerBase
// Created By    : Vijay Kumar Vettath
// Created Date  : Oct-2019
// Purpose       : Class containing the base data handler methods for AccountCategory table.
// Details       :
// Change History:-
// Date:
// Author:
// Change:
//////////////////////////////////////////////////////////////////////////////////////////////////

class AccountCategoryDataHandlerBase {
  static Future<List<AccountCategory>> GetAccountCategoryRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountCategory> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountCategory_Columns.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCategory dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      //Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetAccountCategoryRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountCategory>> GetAccountCategoryRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountCategory> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCategory dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      //Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetAccountCategoryRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountCategory?> GetAccountCategoryRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountCategory? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      //Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetAccountCategoryRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountCategory?> GetMasterAccountCategoryRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountCategory? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      // Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetMasterAccountCategoryRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAccountCategoryRecord(
      DatabaseHandler databaseHandler, AccountCategory dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();

      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID] =
            dataItem.accountCategoryID;
      }

      if (dataItem.accountCategoryCode != null &&
          dataItem.accountCategoryCode != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE] =
            dataItem.accountCategoryCode;
      }

      if (dataItem.accountCategoryName != null &&
          dataItem.accountCategoryName != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME] =
            dataItem.accountCategoryName;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE] = dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED] = dataItem.isDeleted;
      }

      if (dataItem.id != null && dataItem.id != ("null")) {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }

      if (dataItem.isDirty != null && dataItem.isDirty != ("null")) {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }

      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != ("null")) {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }

      if (dataItem.upSyncMessage != null &&
          dataItem.upSyncMessage != ("null")) {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }

      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != ("null")) {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }

      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != ("null")) {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }

      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != ("null")) {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }

      if (dataItem.createdByUser != null &&
          dataItem.createdByUser != ("null")) {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }

      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != ("null")) {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }

      if (dataItem.ownerUserID != null && dataItem.ownerUserID != ("null")) {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;

      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_ACCOUNTCATEGORY, values);
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:AddAccountCategoryRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountCategoryRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AccountCategory dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();

      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID] =
            dataItem.accountCategoryID;
      }

      if (dataItem.accountCategoryCode != null &&
          dataItem.accountCategoryCode != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE] =
            dataItem.accountCategoryCode;
      }

      if (dataItem.accountCategoryName != null &&
          dataItem.accountCategoryName != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME] =
            dataItem.accountCategoryName;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE] = dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED] = dataItem.isDeleted;
      }

      if (dataItem.id != null && dataItem.id != ("null")) {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }

      if (dataItem.isDirty != null && dataItem.isDirty != ("null")) {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }

      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != ("null")) {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }

      if (dataItem.upSyncMessage != null &&
          dataItem.upSyncMessage != ("null")) {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }

      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != ("null")) {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }

      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != ("null")) {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }

      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != ("null")) {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }

      if (dataItem.createdByUser != null &&
          dataItem.createdByUser != ("null")) {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }

      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != ("null")) {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }

      if (dataItem.ownerUserID != null && dataItem.ownerUserID != ("null")) {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(TablesBase.TABLE_ACCOUNTCATEGORY, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "DatabaseHandler:UpdateAccountCategoryRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAccountCategoryRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACCOUNTCATEGORY,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "DatabaseHandler:DeleteAccountCategoryRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.isNotEmpty) {
        serverId = result[0][ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
      }
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.isNotEmpty) {
        localId = result[0][ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
      }
      //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountCategory>> GetAccountCategoryUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AccountCategory> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCATEGORY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCATEGORY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCategory dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      } //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetAccountCategoryUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountCategory?> GetAccountCategoryRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountCategory? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORY_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = AccountCategory();
        dataItem.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYID];
        dataItem.accountCategoryCode =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYCODE];
        dataItem.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTCATEGORY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCATEGORY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTCATEGORY_ISDELETED];

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
      // Globals.HandleException(context, "AccountCategoryDataHandlerBase:GetAccountCategoryRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
