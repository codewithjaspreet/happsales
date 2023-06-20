import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityName.dart';
import '../DataBaseHandler.dart';

class OpportunityNameDataHandlerBase {
  static Future<List<OpportunityName>> GetOpportunityNameRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityName> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().isNotEmpty)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityName_ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";
      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetOpportunityNameRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityName>> GetOpportunityNameRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityName> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().isNotEmpty)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE} COLLATE NOCASE ASC ";
      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetOpportunityNameRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityName?> GetOpportunityNameRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityName? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetOpportunityNameRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityName?> GetMasterOpportunityNameRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityName? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetMasterOpportunityNameRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityNameRecord(
      DatabaseHandler databaseHandler, OpportunityName dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityNameID != null &&
          dataItem.opportunityNameID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID] =
            dataItem.opportunityNameID;
      }
      if (dataItem.opportunityNameCode != null &&
          dataItem.opportunityNameCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE] =
            dataItem.opportunityNameCode;
      }
      if (dataItem.opportunityNameEntry != null &&
          dataItem.opportunityNameEntry != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY] =
            dataItem.opportunityNameEntry;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER] =
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

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYNAME, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddOpportunityNameRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityNameRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityName dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityNameID != null &&
          dataItem.opportunityNameID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID] =
            dataItem.opportunityNameID;
      }
      if (dataItem.opportunityNameCode != null &&
          dataItem.opportunityNameCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE] =
            dataItem.opportunityNameCode;
      }
      if (dataItem.opportunityNameEntry != null &&
          dataItem.opportunityNameEntry != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY] =
            dataItem.opportunityNameEntry;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER] =
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

      id = await db.update(TablesBase.TABLE_OPPORTUNITYNAME, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityNameRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityNameRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYNAME,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityNameRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.isNotEmpty) {
        serverId = result[0][ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityNameDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.isNotEmpty) {
        localId = result[0][ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityNameDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityName>> GetOpportunityNameUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityName> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYNAME} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYNAME} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYNAME} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetOpportunityNameUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityName?> GetOpportunityNameRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityName? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYNAME} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYNAME_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityName dataItem = new OpportunityName();
        dataItem.opportunityNameID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEID];
        dataItem.opportunityNameCode =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMECODE];
        dataItem.opportunityNameEntry =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_OPPORTUNITYNAMEENTRY];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_DESCRIPTION];
        dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYNAME_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYNAME_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYNAME_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYNAME_APPUSERID];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYNAME_REFERENCEIDENTIFIER];
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
          "OpportunityNameDataHandlerBase:GetOpportunityNameRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
