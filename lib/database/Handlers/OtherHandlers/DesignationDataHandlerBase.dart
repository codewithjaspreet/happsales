import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Designation.dart';
import '../DataBaseHandler.dart';

class DesignationDataHandlerBase {
  static Future<List<Designation>> GetDesignationRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Designation> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Designation_Columns.KEY_DESIGNATION_DESIGNATIONNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetDesignationRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Designation>> GetDesignationRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Designation> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_DESIGNATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} LIKE '$searchString%'";
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetDesignationRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Designation?> GetDesignationRecord(
      DatabaseHandler databaseHandler, String id) async {
    Designation? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetDesignationRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Designation?> GetMasterDesignationRecord(
      DatabaseHandler databaseHandler, String id) async {
    Designation? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetMasterDesignationRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddDesignationRecord(
      DatabaseHandler databaseHandler, Designation dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.designationID != null && dataItem.designationID != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID] =
            dataItem.designationID;

      if (dataItem.designationCode != null &&
          dataItem.designationCode != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE] =
            dataItem.designationCode;

      if (dataItem.designationName != null &&
          dataItem.designationName != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME] =
            dataItem.designationName;

      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_DESIGNATION_CREATEDON] = dataItem.createdOn;

      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_DESIGNATION_CREATEDBY] = dataItem.createdBy;

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_DESIGNATION_MODIFIEDON] = dataItem.modifiedOn;

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY] = dataItem.modifiedBy;

      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISACTIVE] = dataItem.isActive;

      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_DESIGNATION_UID] = dataItem.uid;

      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_DESIGNATION_APPUSERID] = dataItem.appUserID;

      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;

      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISARCHIVED] = dataItem.isArchived;

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISDELETED] = dataItem.isDeleted;

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

      int id = await db.insert(TablesBase.TABLE_DESIGNATION, values);
//db.close();

      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddDesignationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateDesignationRecord(
      DatabaseHandler databaseHandler, String id1, Designation dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.designationID != null && dataItem.designationID != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID] =
            dataItem.designationID;

      if (dataItem.designationCode != null &&
          dataItem.designationCode != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE] =
            dataItem.designationCode;

      if (dataItem.designationName != null &&
          dataItem.designationName != "null")
        values[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME] =
            dataItem.designationName;

      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_DESIGNATION_CREATEDON] = dataItem.createdOn;

      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_DESIGNATION_CREATEDBY] = dataItem.createdBy;

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_DESIGNATION_MODIFIEDON] = dataItem.modifiedOn;

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY] = dataItem.modifiedBy;

      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISACTIVE] = dataItem.isActive;

      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_DESIGNATION_UID] = dataItem.uid;

      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_DESIGNATION_APPUSERID] = dataItem.appUserID;

      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;

      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISARCHIVED] = dataItem.isArchived;

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_DESIGNATION_ISDELETED] = dataItem.isDeleted;

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

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_DESIGNATION, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateDesignationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteDesignationRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_DESIGNATION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteDesignationRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
      }
    } catch (ex) {
      Globals.handleException("DesignationDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_DESIGNATION_DESIGNATIONID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("DesignationDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<Designation>> GetDesignationUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<Designation> dataList = [];
    try {
      String selectQuery = "SELECT * FROM ${TablesBase.TABLE_DESIGNATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery = "SELECT * FROM ${TablesBase.TABLE_DESIGNATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery = "SELECT * FROM ${TablesBase.TABLE_DESIGNATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND ${ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetDesignationUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Designation?> GetDesignationRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Designation? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_DESIGNATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_DESIGNATION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Designation dataItem = new Designation();

        dataItem.designationID =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONID];
        dataItem.designationCode =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONCODE];
        dataItem.designationName =
            element[ColumnsBase.KEY_DESIGNATION_DESIGNATIONNAME];
        dataItem.createdOn = element[ColumnsBase.KEY_DESIGNATION_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_DESIGNATION_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_DESIGNATION_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_DESIGNATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_DESIGNATION_UID];
        dataItem.isDeleted = element[ColumnsBase.KEY_DESIGNATION_ISDELETED];
        dataItem.isArchived = element[ColumnsBase.KEY_DESIGNATION_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_DESIGNATION_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_DESIGNATION_APPUSERID];

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
          "DesignationDataHandlerBase:GetDesignationRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}