import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppLog.dart';
import '../DataBaseHandler.dart';

class AppLogDataHandlerBase {
  static Future<List<AppLog>> GetAppLogRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AppLog> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPLOG_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPLOG_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPLOG_APPLOGCODE} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppLog_Columns.KEY_APPLOG_APPLOGCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
          "AppLogDataHandlerBase:GetAppLogRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AppLog>> GetAppLogRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AppLog> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPLOG_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPLOG_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPLOG_APPLOGCODE} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_APPLOG_APPLOGCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
      Globals.handleException("AppLogDataHandlerBase:GetAppLogRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppLog?> GetAppLogRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppLog? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
      Globals.handleException("AppLogDataHandlerBase:GetAppLogRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AppLog?> GetMasterAppLogRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppLog? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPLOG_APPLOGID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
          "AppLogDataHandlerBase:GetMasterAppLogRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAppLogRecord(
      DatabaseHandler databaseHandler, AppLog dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.appLogID != null && dataItem.appLogID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGID] = dataItem.appLogID;
      }

      if (dataItem.appLogCode != null && dataItem.appLogCode != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGCODE] = dataItem.appLogCode;
      }

      if (dataItem.appLogDetail != null && dataItem.appLogDetail != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGDETAIL] = dataItem.appLogDetail;
      }

      if (dataItem.operatingSystem != null &&
          dataItem.operatingSystem != "null") {
        values[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM] =
            dataItem.operatingSystem;
      }

      if (dataItem.operatingSystemVersion != null &&
          dataItem.operatingSystemVersion != "null") {
        values[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION] =
            dataItem.operatingSystemVersion;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPLOG_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPLOG_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPLOG_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPUSERGROUPID] = dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPLOG_ISARCHIVED] = dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPLOG_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_APPLOG, values);
      //db.close();
    } catch (ex) {
      //Globals.HandleException( "DatabaseHandler:AddAppLogRecord()", ex);
      //throw ex;
    }
    return id;
  }

  static Future<int> UpdateAppLogRecord(
      DatabaseHandler databaseHandler, String id1, AppLog dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.appLogID != null && dataItem.appLogID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGID] = dataItem.appLogID;
      }

      if (dataItem.appLogCode != null && dataItem.appLogCode != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGCODE] = dataItem.appLogCode;
      }

      if (dataItem.appLogDetail != null && dataItem.appLogDetail != "null") {
        values[ColumnsBase.KEY_APPLOG_APPLOGDETAIL] = dataItem.appLogDetail;
      }

      if (dataItem.operatingSystem != null &&
          dataItem.operatingSystem != "null") {
        values[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM] =
            dataItem.operatingSystem;
      }

      if (dataItem.operatingSystemVersion != null &&
          dataItem.operatingSystemVersion != "null") {
        values[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION] =
            dataItem.operatingSystemVersion;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPLOG_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPLOG_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPLOG_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPLOG_APPUSERGROUPID] = dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPLOG_ISARCHIVED] = dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPLOG_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_APPLOG, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      // Globals.handleException( "DatabaseHandler:UpdateAppLogRecord()", ex);
      //throw ex;
    }
    return id;
  }

  static Future<int> DeleteAppLogRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_APPLOG,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteAppLogRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_APPLOG_APPLOGID}";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_APPLOG_APPLOGID].toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException("AppLogDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPLOG_APPLOGID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0]["${ColumnsBase.KEY_ID}"].toString();
      }
    } catch (ex) {
      Globals.handleException("AppLogDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AppLog>> GetAppLogUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AppLog> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_APPLOG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPLOG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPLOG} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_APPLOG_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
          "AppLogDataHandlerBase:GetAppLogUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppLog?> GetAppLogRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AppLog? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPLOG} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPLOG_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_APPLOG_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppLog dataItem = new AppLog();

        dataItem.appLogID = element[ColumnsBase.KEY_APPLOG_APPLOGID];

        dataItem.appLogCode = element[ColumnsBase.KEY_APPLOG_APPLOGCODE];

        dataItem.appLogDetail = element[ColumnsBase.KEY_APPLOG_APPLOGDETAIL];

        dataItem.operatingSystem =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEM];

        dataItem.operatingSystemVersion =
            element[ColumnsBase.KEY_APPLOG_OPERATINGSYSTEMVERSION];

        dataItem.createdBy = element[ColumnsBase.KEY_APPLOG_CREATEDBY];

        dataItem.createdOn = element[ColumnsBase.KEY_APPLOG_CREATEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPLOG_DEVICEIDENTIFIER];

        dataItem.uid = element[ColumnsBase.KEY_APPLOG_UID];

        dataItem.appUserID = element[ColumnsBase.KEY_APPLOG_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPLOG_APPUSERGROUPID];

        dataItem.isArchived = element[ColumnsBase.KEY_APPLOG_ISARCHIVED];

        dataItem.isDeleted = element[ColumnsBase.KEY_APPLOG_ISDELETED];

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
          "AppLogDataHandlerBase:GetAppLogRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
