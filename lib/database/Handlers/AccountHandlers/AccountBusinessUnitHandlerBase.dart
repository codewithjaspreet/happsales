import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountBusinessUnit.dart';
import '../DataBaseHandler.dart';

class AccountBusinessUnitDataHandlerBase {
  static Future<List<AccountBusinessUnit>> GetAccountBusinessUnitRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountBusinessUnit> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE} LIKE '%" + searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountBusinessUnit_Columns.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountBusinessUnit dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountBusinessUnit>> GetAccountBusinessUnitRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountBusinessUnit> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE} LIKE '" + searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountBusinessUnit dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
        //db.close();
        //}
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountBusinessUnit?> GetAccountBusinessUnitRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountBusinessUnit? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountBusinessUnit dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountBusinessUnit?> GetAccountBusinessUnitRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountBusinessUnit? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountBusinessUnit dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountBusinessUnit?> GetMasterAccountBusinessUnitRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountBusinessUnit? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} E ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitRecord()", ex);
      throw ex;
    }

    return dataItem;
  }

  static Future<int> AddAccountBusinessUnitRecord(
      DatabaseHandler databaseHandler, AccountBusinessUnit dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      var values = Map<String, dynamic>();

      if (dataItem.accountBusinessUnitID != null &&
          dataItem.accountBusinessUnitID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID] =
            dataItem.accountBusinessUnitID;
      }

      if (dataItem.accountBusinessUnitCode != null &&
          dataItem.accountBusinessUnitCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE] =
            dataItem.accountBusinessUnitCode;
      }

      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID] =
            dataItem.accountID;
      }

      if (dataItem.businessUnitID != null &&
          dataItem.businessUnitID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID] =
            dataItem.businessUnitID;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE] =
            dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED] =
            dataItem.isDeleted;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED] =
            dataItem.isArchived;
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

      values[ColumnsBase.KEY_ISACTIVE] = "true";

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;

      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_ACCOUNTBUSINESSUNIT, values);
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:AddAccountBusinessUnitRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountBusinessUnitRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AccountBusinessUnit dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      var values = Map<String, dynamic>();

      if (dataItem.accountBusinessUnitID != null &&
          dataItem.accountBusinessUnitID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID] =
            dataItem.accountBusinessUnitID;
      }

      if (dataItem.accountBusinessUnitCode != null &&
          dataItem.accountBusinessUnitCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE] =
            dataItem.accountBusinessUnitCode;
      }

      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID] =
            dataItem.accountID;
      }

      if (dataItem.businessUnitID != null &&
          dataItem.businessUnitID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID] =
            dataItem.businessUnitID;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE] =
            dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED] =
            dataItem.isDeleted;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED] =
            dataItem.isArchived;
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

      id = await db.update(TablesBase.TABLE_ACCOUNTBUSINESSUNIT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:UpdateAccountBusinessUnitRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAccountBusinessUnitRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACCOUNTBUSINESSUNIT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:DeleteAccountBusinessUnitRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      // SQLiteDatabase db = databaseHandler.getWritableDatabase();
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        serverId = result
            .first[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID]
            .toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID} = $id";

      // SQLiteDatabase db = databaseHandler.getWritableDatabase();
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        localId = result
            .first[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID]
            .toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountBusinessUnit>> GetAccountBusinessUnitUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AccountBusinessUnit> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTBUSINESSUNIT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTBUSINESSUNIT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountBusinessUnit dataItem = AccountBusinessUnit();
        dataItem.accountBusinessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITID];
        dataItem.accountBusinessUnitCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTBUSINESSUNITCODE];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ACCOUNTID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSUNIT_ISARCHIVED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
      // Globals.HandleException(context, "AccountBusinessUnitDataHandlerBase:GetAccountBusinessUnitUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }
}
