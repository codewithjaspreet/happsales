import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityTeam.dart';
import '../DataBaseHandler.dart';

class ActivityTeamDataHandlerBase {
  static Future<List<ActivityTeam>> GetActivityTeamRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ActivityTeam> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityTeam_Columns.KEY_ACTIVITYTEAM_APPUSERNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetActivityTeamRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ActivityTeam>> GetActivityTeamRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ActivityTeam> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetActivityTeamRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ActivityTeam?> GetActivityTeamRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityTeam? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetActivityTeamRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityTeam?> GetActivityTeamRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ActivityTeam? dataItem;
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYTEAM_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetActivityTeamRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityTeam?> GetMasterActivityTeamRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityTeam? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetMasterActivityTeamRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddActivityTeamRecord(
      DatabaseHandler databaseHandler, ActivityTeam dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.activityTeamID != null &&
          dataItem.activityTeamID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID] =
            dataItem.activityTeamID;
      }
      if (dataItem.activityTeamCode != null &&
          dataItem.activityTeamCode != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE] =
            dataItem.activityTeamCode;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID] = dataItem.activityID;
      }
      if (dataItem.activityTeamAppUserID != null &&
          dataItem.activityTeamAppUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID] =
            dataItem.activityTeamAppUserID;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION] = dataItem.description;
      }
      if (dataItem.appUserName != null && dataItem.appUserName != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME] = dataItem.appUserName;
      }
      if (dataItem.Designation != null && dataItem.Designation != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION] = dataItem.Designation;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_ACTIVITYTEAM, values);
// db.close(); (In Dart, you usually don't need to close the database explicitly)
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddActivityTeamRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateActivityTeamRecord(DatabaseHandler databaseHandler,
      String id1, ActivityTeam dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.activityTeamID != null &&
          dataItem.activityTeamID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID] =
            dataItem.activityTeamID;
      }
      if (dataItem.activityTeamCode != null &&
          dataItem.activityTeamCode != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE] =
            dataItem.activityTeamCode;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID] = dataItem.activityID;
      }
      if (dataItem.activityTeamAppUserID != null &&
          dataItem.activityTeamAppUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID] =
            dataItem.activityTeamAppUserID;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION] = dataItem.description;
      }
      if (dataItem.appUserName != null && dataItem.appUserName != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME] = dataItem.appUserName;
      }
      if (dataItem.Designation != null && dataItem.Designation != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION] = dataItem.Designation;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED] = dataItem.isDeleted;
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
      id = await db.update(TablesBase.TABLE_ACTIVITYTEAM, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateActivityTeamRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteActivityTeamRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITYTEAM,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteActivityTeamRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityTeamDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
      }
    } catch (ex) {
      Globals.handleException("ActivityTeamDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ActivityTeam>> GetActivityTeamUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<ActivityTeam> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACTIVITY} WHERE coalesce(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID},'') <> '')";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
          "ActivityTeamDataHandlerBase:GetActivityTeamUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }
}
