import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityPermission.dart';
import '../DataBaseHandler.dart';

class ActivityPermissionDataHandlerBase {
  static Future<List<ActivityPermission>> GetActivityPermissionRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<ActivityPermission> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityPermission_Columns.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed

            dataList.add(dataItem);
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ActivityPermission>> GetActivityPermissionRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ActivityPermission> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE} LIKE '${searchString.replaceAll("'", "''")}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed

            dataList.add(dataItem);
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ActivityPermission?> GetActivityPermissionRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityPermission? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  Future<ActivityPermission?> GetMasterActivityPermissionRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityPermission? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetMasterActivityPermissionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddActivityPermissionRecord(
      DatabaseHandler databaseHandler, ActivityPermission dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map();
      if (dataItem.activityPermissionID != null &&
          dataItem.activityPermissionID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID] =
            dataItem.activityPermissionID;
      if (dataItem.activityPermissionCode != null &&
          dataItem.activityPermissionCode != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE] =
            dataItem.activityPermissionCode;
      if (dataItem.activityID != null && dataItem.activityID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID] =
            dataItem.activityID;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.permissionLevel != null &&
          dataItem.permissionLevel != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL] =
            dataItem.permissionLevel;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_UID] = dataItem.uid;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_ACTIVITYPERMISSION, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddActivityPermissionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateActivityPermissionRecord(
      DatabaseHandler databaseHandler,
      String id1,
      ActivityPermission dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map();
      if (dataItem.activityPermissionID != null &&
          dataItem.activityPermissionID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID] =
            dataItem.activityPermissionID;
      if (dataItem.activityPermissionCode != null &&
          dataItem.activityPermissionCode != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE] =
            dataItem.activityPermissionCode;
      if (dataItem.activityID != null && dataItem.activityID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID] =
            dataItem.activityID;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.permissionLevel != null &&
          dataItem.permissionLevel != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL] =
            dataItem.permissionLevel;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_UID] = dataItem.uid;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED] =
            dataItem.isDeleted;
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
      id = await db.update(TablesBase.TABLE_ACTIVITYPERMISSION, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateActivityPermissionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteActivityPermissionRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITYPERMISSION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteActivityPermissionRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ActivityPermission>> GetActivityPermissionUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<ActivityPermission> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACTIVITY} WHERE coalesce(${ColumnsBase.KEY_ACTIVITY_ACTIVITYID},'') <> '')";
      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed
            dataList.add(dataItem);
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionRecord()",
          ex);
      throw ex;
    }
    return dataList;
  }

  Future<ActivityPermission?> GetMasterActivityPermissionRecord2(
      DatabaseHandler databaseHandler, String id) async {
    ActivityPermission? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityPermission?> GetActivityPermissionRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ActivityPermission? dataItem;
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYPERMISSION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPermission dataItem = new ActivityPermission();

        for (var element in result) {
          for (var element in result) {
            dataItem.activityPermissionID = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONID];
            dataItem.activityPermissionCode = element[
                ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYPERMISSIONCODE];
            dataItem.activityID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ACTIVITYID];
            dataItem.appUserID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERID];
            dataItem.permissionLevel =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_PERMISSIONLEVEL];
            dataItem.createdOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDON];
            dataItem.createdBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_CREATEDBY];
            dataItem.modifiedOn =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDON];
            dataItem.modifiedBy =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_MODIFIEDBY];
            dataItem.isActive =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISACTIVE];
            dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPERMISSION_UID];
            dataItem.appUserGroupID =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_APPUSERGROUPID];
            dataItem.isArchived =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISARCHIVED];
            dataItem.isDeleted =
                element[ColumnsBase.KEY_ACTIVITYPERMISSION_ISDELETED];
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

            // Process dataItem as needed
          }
        }
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityPermissionDataHandlerBase:GetActivityPermissionRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
