import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Notification.dart';
import '../DataBaseHandler.dart';

class NotificationDataHandlerBase {
  static Future<List<Notification>> GetNotificationRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Notification> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Notification_Columns.KEY_NOTIFICATION_NOTIFICATIONTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetNotificationRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Notification>> GetNotificationRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Notification> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetNotificationRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Notification?> GetNotificationRecord(
      DatabaseHandler databaseHandler, String id) async {
    Notification? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetNotificationRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Notification?> GetMasterNotificationRecord(
      DatabaseHandler databaseHandler, String id) async {
    Notification? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetMasterNotificationRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddNotificationRecord(
      DatabaseHandler databaseHandler, Notification dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.notificationID != null &&
          dataItem.notificationID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID] =
            dataItem.notificationID;
      }
      if (dataItem.notificationCode != null &&
          dataItem.notificationCode != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE] =
            dataItem.notificationCode;
      }
      if (dataItem.notificationTitle != null &&
          dataItem.notificationTitle != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE] =
            dataItem.notificationTitle;
      }
      if (dataItem.notificationDetails != null &&
          dataItem.notificationDetails != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS] =
            dataItem.notificationDetails;
      }
      if (dataItem.notificationDate != null &&
          dataItem.notificationDate != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE] =
            dataItem.notificationDate;
      }
      if (dataItem.sendToAll != null && dataItem.sendToAll != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_SENDTOALL] = dataItem.sendToAll;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_NOTIFICATION, values);

      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddNotificationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateNotificationRecord(DatabaseHandler databaseHandler,
      String id1, Notification dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.notificationID != null &&
          dataItem.notificationID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID] =
            dataItem.notificationID;
      }
      if (dataItem.notificationCode != null &&
          dataItem.notificationCode != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE] =
            dataItem.notificationCode;
      }
      if (dataItem.notificationTitle != null &&
          dataItem.notificationTitle != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE] =
            dataItem.notificationTitle;
      }
      if (dataItem.notificationDetails != null &&
          dataItem.notificationDetails != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS] =
            dataItem.notificationDetails;
      }
      if (dataItem.notificationDate != null &&
          dataItem.notificationDate != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE] =
            dataItem.notificationDate;
      }
      if (dataItem.sendToAll != null && dataItem.sendToAll != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_SENDTOALL] = dataItem.sendToAll;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_NOTIFICATION_ISDELETED] = dataItem.isDeleted;
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
      id = await db.update(TablesBase.TABLE_NOTIFICATION, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateNotificationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteNotificationRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_NOTIFICATION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteNotificationRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId =
            result[0][ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID].toString();
      }
    } catch (ex) {
      Globals.handleException("NotificationDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException("NotificationDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<Notification>> GetNotificationUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<Notification> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_NOTIFICATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTIFICATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTIFICATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetNotificationUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Notification?> GetNotificationRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Notification? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTIFICATION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Notification dataItem = new Notification();

        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONID];
        dataItem.notificationCode =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONCODE];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];
        dataItem.notificationDetails =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDETAILS];
        dataItem.notificationDate =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONDATE];
        dataItem.sendToAll = element[ColumnsBase.KEY_NOTIFICATION_SENDTOALL];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTIFICATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTIFICATION_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTIFICATION_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_NOTIFICATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTIFICATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATION_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTIFICATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTIFICATION_ISDELETED];
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
          "NotificationDataHandlerBase:GetNotificationRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
