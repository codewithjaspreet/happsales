import 'package:get_storage/get_storage.dart';
import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/NoteMedia.dart';
import '../DataBaseHandler.dart';

class NoteMediaDataHandlerBase {
  static Future<List<NoteMedia>> GetNoteMediaRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<NoteMedia> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_NoteMedia_Columns.KEY_NOTEMEDIA_NOTEMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetNoteMediaRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<NoteMedia>> GetNoteMediaRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<NoteMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A." + ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME + " LIKE '" + searchString.replaceAll("'", "''")}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetNoteMediaRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<NoteMedia?> GetNoteMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    NoteMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetNoteMediaRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<NoteMedia?> GetMasterNoteMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    NoteMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetMasterNoteMediaRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddNoteMediaRecord(
      DatabaseHandler databaseHandler, NoteMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.noteMediaID != null && dataItem.noteMediaID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID] = dataItem.noteMediaID;
      if (dataItem.noteMediaCode != null && dataItem.noteMediaCode != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE] =
            dataItem.noteMediaCode;
      if (dataItem.noteMediaName != null && dataItem.noteMediaName != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME] =
            dataItem.noteMediaName;
      if (dataItem.noteID != null && dataItem.noteID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEID] = dataItem.noteID;
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH] = dataItem.mediaPath;
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT] = dataItem.mediaContent;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION] = dataItem.description;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_TAGS] = dataItem.tags;
      if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH] =
            dataItem.localMediaPath;
      if (dataItem.isUploaded != null && dataItem.isUploaded != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED] = dataItem.isUploaded;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_NOTEMEDIA, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddNoteMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateNoteMediaRecord(
      DatabaseHandler databaseHandler, String id1, NoteMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = {};

      if (dataItem.noteMediaID != null && dataItem.noteMediaID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID] = dataItem.noteMediaID;
      if (dataItem.noteMediaCode != null && dataItem.noteMediaCode != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE] =
            dataItem.noteMediaCode;
      if (dataItem.noteMediaName != null && dataItem.noteMediaName != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME] =
            dataItem.noteMediaName;
      if (dataItem.noteID != null && dataItem.noteID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_NOTEID] = dataItem.noteID;
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH] = dataItem.mediaPath;
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT] = dataItem.mediaContent;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION] = dataItem.description;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_TAGS] = dataItem.tags;
      if (dataItem.localMediaPath != null && dataItem.localMediaPath != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH] =
            dataItem.localMediaPath;
      if (dataItem.isUploaded != null && dataItem.isUploaded != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED] = dataItem.isUploaded;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_NOTEMEDIA_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_NOTEMEDIA, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateNoteMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteNoteMediaRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_NOTEMEDIA,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteNoteMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];
      }
    } catch (ex) {
      Globals.handleException("NoteMediaDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID} = $id";
      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("NoteMediaDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<NoteMedia>> GetNoteMediaUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<NoteMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_NOTEMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTEMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTEMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND COALESCE(${ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH},'') <> ''"; //Only if the media is uploaded
      selectQuery +=
          " AND ${ColumnsBase.KEY_NOTEMEDIA_NOTEID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_NOTE} WHERE coalesce(${ColumnsBase.KEY_NOTE_NOTEID},'') <> '')"; //For upsynced notes only

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetNoteMediaUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<NoteMedia?> GetNoteMediaRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    NoteMedia? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_NOTE_NOTECODE},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTEMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_NOTE} E ON A.${ColumnsBase.KEY_NOTEMEDIA_NOTEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTEMEDIA_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        NoteMedia dataItem = new NoteMedia();

        dataItem.noteMediaID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIAID];

        dataItem.noteMediaCode =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIACODE];

        dataItem.noteMediaName =
            element[ColumnsBase.KEY_NOTEMEDIA_NOTEMEDIANAME];

        dataItem.noteID = element[ColumnsBase.KEY_NOTEMEDIA_NOTEID];

        dataItem.contentTypeID =
            element[ColumnsBase.KEY_NOTEMEDIA_CONTENTTYPEID];

        dataItem.mediaPath = element[ColumnsBase.KEY_NOTEMEDIA_MEDIAPATH];

        dataItem.mediaContent = element[ColumnsBase.KEY_NOTEMEDIA_MEDIACONTENT];

        dataItem.description = element[ColumnsBase.KEY_NOTEMEDIA_DESCRIPTION];

        dataItem.tags = element[ColumnsBase.KEY_NOTEMEDIA_TAGS];

        dataItem.localMediaPath =
            element[ColumnsBase.KEY_NOTEMEDIA_LOCALMEDIAPATH];

        dataItem.isUploaded = element[ColumnsBase.KEY_NOTEMEDIA_ISUPLOADED];

        dataItem.createdOn = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDON];

        dataItem.createdBy = element[ColumnsBase.KEY_NOTEMEDIA_CREATEDBY];

        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDBY];

        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTEMEDIA_MODIFIEDON];

        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_DEVICEIDENTIFIER];

        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTEMEDIA_REFERENCEIDENTIFIER];

        dataItem.isActive = element[ColumnsBase.KEY_NOTEMEDIA_ISACTIVE];

        dataItem.uid = element[ColumnsBase.KEY_NOTEMEDIA_UID];

        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_NOTEMEDIA_APPUSERGROUPID];

        dataItem.appUserID = element[ColumnsBase.KEY_NOTEMEDIA_APPUSERID];

        dataItem.isDeleted = element[ColumnsBase.KEY_NOTEMEDIA_ISDELETED];

        dataItem.isArchived = element[ColumnsBase.KEY_NOTEMEDIA_ISARCHIVED];

        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];

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
      }
    } catch (ex) {
      Globals.handleException(
          "NoteMediaDataHandlerBase:GetNoteMediaRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
