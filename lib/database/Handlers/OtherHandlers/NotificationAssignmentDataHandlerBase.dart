import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/NotificationAssignment.dart';
import '../DataBaseHandler.dart';

class NotificationAssignmentDataHandlerBase {
  static Future<List<NotificationAssignment>>
      GetNotificationAssignmentRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<NotificationAssignment> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTIFICATION} D ON A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_NotificationAssignment_Columns.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE + " IN(" + groupitem.trim() + ")";
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
        NotificationAssignment dataItem = new NotificationAssignment();

        dataItem.notificationAssignmentID = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
        dataItem.notificationAssignmentCode = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE];
        dataItem.notificationAssignmentTitle = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE];
        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];

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
          "NotificationAssignmentDataHandlerBase:GetNotificationAssignmentRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<NotificationAssignment?> GetNotificationAssignmentRecord(
      DatabaseHandler databaseHandler, String id) async {
    NotificationAssignment? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTIFICATION} D ON A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NotificationAssignment dataItem = new NotificationAssignment();

        dataItem.notificationAssignmentID = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
        dataItem.notificationAssignmentCode = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE];
        dataItem.notificationAssignmentTitle = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE];
        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];

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
          "NotificationAssignmentDataHandlerBase:GetNotificationAssignmentRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<NotificationAssignment?> GetMasterNotificationAssignmentRecord(
      DatabaseHandler databaseHandler, String id) async {
    NotificationAssignment? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTIFICATION} D ON A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NotificationAssignment dataItem = new NotificationAssignment();

        dataItem.notificationAssignmentID = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
        dataItem.notificationAssignmentCode = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE];
        dataItem.notificationAssignmentTitle = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE];
        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];

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
          "NotificationAssignmentDataHandlerBase:GetMasterNotificationAssignmentRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddNotificationAssignmentRecord(
      DatabaseHandler databaseHandler, NotificationAssignment dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.notificationAssignmentID != null &&
          dataItem.notificationAssignmentID != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID] =
            dataItem.notificationAssignmentID;
      }
      if (dataItem.notificationAssignmentCode != null &&
          dataItem.notificationAssignmentCode != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE] =
            dataItem.notificationAssignmentCode;
      }
      if (dataItem.notificationAssignmentTitle != null &&
          dataItem.notificationAssignmentTitle != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE] =
            dataItem.notificationAssignmentTitle;
      }
      if (dataItem.notificationID != null &&
          dataItem.notificationID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID] =
            dataItem.notificationID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED] =
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

      id = await db.insert(TablesBase.TABLE_NOTIFICATIONASSIGNMENT, values);

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddNotificationAssignmentRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateNotificationAssignmentRecord(
      DatabaseHandler databaseHandler,
      String id1,
      NotificationAssignment dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.notificationAssignmentID != null &&
          dataItem.notificationAssignmentID != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID] =
            dataItem.notificationAssignmentID;
      }
      if (dataItem.notificationAssignmentCode != null &&
          dataItem.notificationAssignmentCode != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE] =
            dataItem.notificationAssignmentCode;
      }
      if (dataItem.notificationAssignmentTitle != null &&
          dataItem.notificationAssignmentTitle != "null") {
        values[ColumnsBase
                .KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE] =
            dataItem.notificationAssignmentTitle;
      }
      if (dataItem.notificationID != null &&
          dataItem.notificationID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID] =
            dataItem.notificationID;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID] = dataItem.uid;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED] =
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

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_NOTIFICATIONASSIGNMENT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateNotificationAssignmentRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteNotificationAssignmentRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      id = await db.delete(TablesBase.TABLE_NOTIFICATIONASSIGNMENT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteNotificationAssignmentRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
      }
    } catch (ex) {
      Globals.handleException(
          "NotificationAssignmentDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "NotificationAssignmentDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<NotificationAssignment>>
      GetNotificationAssignmentUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<NotificationAssignment> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NotificationAssignment dataItem = new NotificationAssignment();

        dataItem.notificationAssignmentID = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
        dataItem.notificationAssignmentCode = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE];
        dataItem.notificationAssignmentTitle = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE];
        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];

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
          "NotificationAssignmentDataHandlerBase:GetNotificationAssignmentUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<NotificationAssignment?> GetNotificationAssignmentRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    NotificationAssignment? dataItem;
    try {
      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_NOTIFICATIONASSIGNMENT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTIFICATION} D ON A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NotificationAssignment dataItem = new NotificationAssignment();

        dataItem.notificationAssignmentID = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTID];
        dataItem.notificationAssignmentCode = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTCODE];
        dataItem.notificationAssignmentTitle = element[
            ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONASSIGNMENTTITLE];
        dataItem.notificationID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_NOTIFICATIONID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_UID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_ISARCHIVED];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTIFICATIONASSIGNMENT_APPUSERGROUPID];
        dataItem.notificationTitle =
            element[ColumnsBase.KEY_NOTIFICATION_NOTIFICATIONTITLE];

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
          "NotificationAssignmentDataHandlerBase:GetNotificationAssignmentRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
