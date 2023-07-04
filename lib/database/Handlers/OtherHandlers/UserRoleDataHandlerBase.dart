import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/UserRole.dart';
import '../DataBaseHandler.dart';

class UserRoleDataHandlerBase {
  static Future<List<UserRole>> GetUserRoleRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<UserRole> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_USERROLE_USERROLENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_UserRole_Columns.KEY_USERROLE_USERROLENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetUserRoleRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<UserRole>> GetUserRoleRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<UserRole> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_USERROLE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_USERROLE_USERROLENAME} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_USERROLE_USERROLENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetUserRoleRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<UserRole?> GetUserRoleRecord(
      DatabaseHandler databaseHandler, String id) async {
    UserRole? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetUserRoleRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<UserRole?> GetMasterUserRoleRecord(
      DatabaseHandler databaseHandler, String id) async {
    UserRole? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_USERROLE_USERROLEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetMasterUserRoleRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddUserRoleRecord(
      DatabaseHandler databaseHandler, UserRole dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.userRoleID != null && dataItem.userRoleID != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLEID] = dataItem.userRoleID;
      }
      if (dataItem.userRoleCode != null && dataItem.userRoleCode != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLECODE] = dataItem.userRoleCode;
      }
      if (dataItem.userRoleName != null && dataItem.userRoleName != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLENAME] = dataItem.userRoleName;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_USERROLE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_USERROLE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_USERROLE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_USERROLE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_USERROLE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.isSystemDefined != null &&
          dataItem.isSystemDefined != "null") {
        values[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED] =
            dataItem.isSystemDefined;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_USERROLE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_USERROLE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_USERROLE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_USERROLE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_USERROLE_ISDELETED] = dataItem.isDeleted;
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
      values[ColumnsBase.KEY_USERROLE_ISACTIVE] = "true";
      values[ColumnsBase.KEY_USERROLE_ISDELETED] = "false";

// Assuming you have a reference to the database, you can use the following code to insert the values into the table
      id = await db.insert(TablesBase.TABLE_USERROLE, values);

      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddUserRoleRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateUserRoleRecord(
      DatabaseHandler databaseHandler, String id1, UserRole dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.userRoleID != null && dataItem.userRoleID != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLEID] = dataItem.userRoleID;
      }
      if (dataItem.userRoleCode != null && dataItem.userRoleCode != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLECODE] = dataItem.userRoleCode;
      }
      if (dataItem.userRoleName != null && dataItem.userRoleName != "null") {
        values[ColumnsBase.KEY_USERROLE_USERROLENAME] = dataItem.userRoleName;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_USERROLE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_USERROLE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_USERROLE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_USERROLE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_USERROLE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.isSystemDefined != null &&
          dataItem.isSystemDefined != "null") {
        values[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED] =
            dataItem.isSystemDefined;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_USERROLE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_USERROLE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_USERROLE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_USERROLE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_USERROLE_ISDELETED] = dataItem.isDeleted;
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
      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_USERROLE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateUserRoleRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteUserRoleRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_USERROLE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteUserRoleRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_USERROLE_USERROLEID}";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_USERROLE_USERROLEID];
      }

      //db.close();
    } catch (ex) {
      Globals.handleException("UserRoleDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_USERROLE_USERROLEID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("UserRoleDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<UserRole>> GetUserRoleUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<UserRole> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_USERROLE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_USERROLE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_USERROLE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_USERROLE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetUserRoleUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<UserRole?> GetUserRoleRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    UserRole? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_USERROLE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_USERROLE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_USERROLE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        UserRole dataItem = new UserRole();

        dataItem.userRoleID = ele[ColumnsBase.KEY_USERROLE_USERROLEID];
        dataItem.userRoleCode = ele[ColumnsBase.KEY_USERROLE_USERROLECODE];
        dataItem.userRoleName = ele[ColumnsBase.KEY_USERROLE_USERROLENAME];
        dataItem.createdBy = ele[ColumnsBase.KEY_USERROLE_CREATEDBY];
        dataItem.createdOn = ele[ColumnsBase.KEY_USERROLE_CREATEDON];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_USERROLE_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_USERROLE_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_USERROLE_ISACTIVE];
        dataItem.isSystemDefined =
            ele[ColumnsBase.KEY_USERROLE_ISSYSTEMDEFINED];
        dataItem.uid = ele[ColumnsBase.KEY_USERROLE_UID];
        dataItem.appUserID = ele[ColumnsBase.KEY_USERROLE_APPUSERID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_USERROLE_APPUSERGROUPID];
        dataItem.isArchived = ele[ColumnsBase.KEY_USERROLE_ISARCHIVED];
        dataItem.isDeleted = ele[ColumnsBase.KEY_USERROLE_ISDELETED];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "UserRoleDataHandlerBase:GetUserRoleRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
