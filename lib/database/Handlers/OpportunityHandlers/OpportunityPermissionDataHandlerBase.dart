import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityPermission.dart';
import '../DataBaseHandler.dart';

class OpportunityPermissionDataHandlerBase {
  static Future<List<OpportunityPermission>>
      GetOpportunityPermissionRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<OpportunityPermission> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityPermission_ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetOpportunityPermissionRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityPermission>> GetOpportunityPermissionRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityPermission> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetOpportunityPermissionRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityPermission?> GetOpportunityPermissionRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityPermission? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetOpportunityPermissionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityPermission?> GetMasterOpportunityPermissionRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityPermission? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetMasterOpportunityPermissionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityPermissionRecord(
      DatabaseHandler databaseHandler, OpportunityPermission dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityPermissionID != null &&
          dataItem.opportunityPermissionID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID] =
            dataItem.opportunityPermissionID;
      }
      if (dataItem.opportunityPermissionCode != null &&
          dataItem.opportunityPermissionCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE] =
            dataItem.opportunityPermissionCode;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.permissionLevel != null &&
          dataItem.permissionLevel != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL] =
            dataItem.permissionLevel;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYPERMISSION, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityPermissionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityPermissionRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityPermission dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityPermissionID != null &&
          dataItem.opportunityPermissionID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID] =
            dataItem.opportunityPermissionID;
      }
      if (dataItem.opportunityPermissionCode != null &&
          dataItem.opportunityPermissionCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE] =
            dataItem.opportunityPermissionCode;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.permissionLevel != null &&
          dataItem.permissionLevel != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL] =
            dataItem.permissionLevel;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_OPPORTUNITYPERMISSION, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityPermissionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityPermissionRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPERMISSION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityPermissionRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
                [ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityPermissionDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID} = $id";
      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0]
                [ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityPermissionDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityPermission>>
      GetOpportunityPermissionUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityPermission> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE coalesce(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'') <> '')";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetOpportunityPermissionUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityPermission?> GetOpportunityPermissionRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityPermission? dataItem;
    try {
      String selectQuery =
          "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPERMISSION} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} D ON A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPermission dataItem = new OpportunityPermission();
        dataItem.opportunityPermissionID = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONID];
        dataItem.opportunityPermissionCode = element[
            ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYPERMISSIONCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_OPPORTUNITYID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.permissionLevel =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_PERMISSIONLEVEL];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPERMISSION_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityPermissionDataHandlerBase:GetOpportunityPermissionRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
