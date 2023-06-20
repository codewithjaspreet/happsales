import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityPriority.dart';
import '../DataBaseHandler.dart';

class OpportunityPriorityDataHandlerBase {
  static Future<List<OpportunityPriority>> GetOpportunityPriorityRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityPriority> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityPriority_ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityPriority>> GetOpportunityPriorityRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityPriority> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityPriority?> GetOpportunityPriorityRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityPriority? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityPriority?> GetMasterOpportunityPriorityRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityPriority? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetMasterOpportunityPriorityRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityPriorityRecord(
      DatabaseHandler databaseHandler, OpportunityPriority dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.opportunityPriorityID != null &&
          dataItem.opportunityPriorityID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID] =
            dataItem.opportunityPriorityID;
      if (dataItem.opportunityPriorityCode != null &&
          dataItem.opportunityPriorityCode != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE] =
            dataItem.opportunityPriorityCode;
      if (dataItem.opportunityPriorityName != null &&
          dataItem.opportunityPriorityName != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME] =
            dataItem.opportunityPriorityName;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION] =
            dataItem.description;
      if (dataItem.isDefault != null && dataItem.isDefault != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT] =
            dataItem.isDefault;
      if (dataItem.priorityOrder != null && dataItem.priorityOrder != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER] =
            dataItem.priorityOrder;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED] =
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
      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYPRIORITY, values);

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityPriorityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityPriorityRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityPriority dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityPriorityID != null &&
          dataItem.opportunityPriorityID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID] =
            dataItem.opportunityPriorityID;
      if (dataItem.opportunityPriorityCode != null &&
          dataItem.opportunityPriorityCode != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE] =
            dataItem.opportunityPriorityCode;
      if (dataItem.opportunityPriorityName != null &&
          dataItem.opportunityPriorityName != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME] =
            dataItem.opportunityPriorityName;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION] =
            dataItem.description;
      if (dataItem.isDefault != null && dataItem.isDefault != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT] =
            dataItem.isDefault;
      if (dataItem.priorityOrder != null && dataItem.priorityOrder != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER] =
            dataItem.priorityOrder;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED] =
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
      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;

      id = await db.update(TablesBase.TABLE_OPPORTUNITYPRIORITY, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityPriorityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityPriorityRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYPRIORITY,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityPriorityRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_ID];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityPriorityDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityPriorityDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityPriority>> GetOpportunityPriorityUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityPriority> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityPriority?> GetOpportunityPriorityRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityPriority? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYPRIORITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityPriority dataItem = new OpportunityPriority();
        dataItem.opportunityPriorityID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYID];
        dataItem.opportunityPriorityCode = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYCODE];

        dataItem.opportunityPriorityName = element[
            ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_PRIORITYORDER];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDON];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_MODIFIEDBY];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_ISDELETED];
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
          "OpportunityPriorityDataHandlerBase:GetOpportunityPriorityRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
