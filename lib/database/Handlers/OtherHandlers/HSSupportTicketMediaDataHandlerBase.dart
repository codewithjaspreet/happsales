import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/HSSupportTicketMedia.dart';
import '../DataBaseHandler.dart';

class HSSupportTicketMediaDataHandlerBase {
  static Future<List<HSSupportTicketMedia>> GetHSSupportTicketMediaRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<HSSupportTicketMedia> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_HSSUPPORTTICKET} E ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSupportTicketMedia_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_HSSupportTicketMedia_Columns.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME + " IN(" + groupitem.trim() + ")";
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
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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
        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetHSSupportTicketMediaRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<HSSupportTicketMedia>> GetHSSupportTicketMediaRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<HSSupportTicketMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_HSSUPPORTTICKET} E ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_HSSupportTicketMedia_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A." + ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME + " LIKE '" + searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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
        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetHSSupportTicketMediaRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<HSSupportTicketMedia?> GetHSSupportTicketMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    HSSupportTicketMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_HSSUPPORTTICKET} E ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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

        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetHSSupportTicketMediaRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<HSSupportTicketMedia?> GetHSSupportTicketMediaRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    HSSupportTicketMedia? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_HSSUPPORTTICKET} E ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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

        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetHSSupportTicketMediaRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<HSSupportTicketMedia?> GetMasterHSSupportTicketMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    HSSupportTicketMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_HSSUPPORTTICKET} E ON A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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

        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetMasterHSSupportTicketMediaRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddHSSupportTicketMediaRecord(
      DatabaseHandler databaseHandler, HSSupportTicketMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      var values = Map<String, dynamic>();
      if (dataItem.hSSupportTicketMediaID != null &&
          dataItem.hSSupportTicketMediaID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID] =
            dataItem.hSSupportTicketMediaID;
      }
      if (dataItem.hSSupportTicketMediaCode != null &&
          dataItem.hSSupportTicketMediaCode != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE] =
            dataItem.hSSupportTicketMediaCode;
      }
      if (dataItem.hSSupportTicketMediaName != null &&
          dataItem.hSSupportTicketMediaName != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME] =
            dataItem.hSSupportTicketMediaName;
      }
      if (dataItem.hSSupportTicketID != null &&
          dataItem.hSSupportTicketID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID] =
            dataItem.hSSupportTicketID;
      }
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      }
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH] =
            dataItem.mediaPath;
      }
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT] =
            dataItem.mediaContent;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS] = dataItem.tags;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED] =
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

      id = await db.insert(TablesBase.TABLE_HSSUPPORTTICKETMEDIA, values);
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddHSSupportTicketMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateHSSupportTicketMediaRecord(
      DatabaseHandler databaseHandler,
      String id1,
      HSSupportTicketMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      var values = Map<String, dynamic>();
      if (dataItem.hSSupportTicketMediaID != null &&
          dataItem.hSSupportTicketMediaID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID] =
            dataItem.hSSupportTicketMediaID;
      }
      if (dataItem.hSSupportTicketMediaCode != null &&
          dataItem.hSSupportTicketMediaCode != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE] =
            dataItem.hSSupportTicketMediaCode;
      }
      if (dataItem.hSSupportTicketMediaName != null &&
          dataItem.hSSupportTicketMediaName != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME] =
            dataItem.hSSupportTicketMediaName;
      }
      if (dataItem.hSSupportTicketID != null &&
          dataItem.hSSupportTicketID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID] =
            dataItem.hSSupportTicketID;
      }
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      }
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH] =
            dataItem.mediaPath;
      }
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT] =
            dataItem.mediaContent;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS] = dataItem.tags;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED] =
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

      id = await db.update(TablesBase.TABLE_HSSUPPORTTICKETMEDIA, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateHSSupportTicketMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteHSSupportTicketMediaRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_HSSUPPORTTICKETMEDIA,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteHSSupportTicketMediaRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID}";
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID];
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIAID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
      ;
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<HSSupportTicketMedia>>
      GetHSSupportTicketMediaUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<HSSupportTicketMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_HSSUPPORTTICKETMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        HSSupportTicketMedia dataItem = new HSSupportTicketMedia();
        dataItem.hSSupportTicketMediaCode = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIACODE];
        dataItem.hSSupportTicketMediaName = element[
            ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETMEDIANAME];
        dataItem.hSSupportTicketID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_HSSUPPORTTICKETID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_TAGS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDBY];

        dataItem.createdOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_UID];

        dataItem.appUserID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_APPUSERGROUPID];

        dataItem.isArchived =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISARCHIVED];

        dataItem.isDeleted =
            element[ColumnsBase.KEY_HSSUPPORTTICKETMEDIA_ISDELETED];

        dataItem.hSSupportTicketTitle =
            element[ColumnsBase.KEY_HSSUPPORTTICKET_HSSUPPORTTICKETTITLE];

        dataItem.contentTypeName =
            element[ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME];

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
        // Rest of your code..
      }
    } catch (ex) {
      Globals.handleException(
          "HSSupportTicketMediaDataHandlerBase:GetHSSupportTicketMediaUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
