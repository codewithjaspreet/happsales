import 'dart:js';

import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityMedia.dart';
import '../DataBaseHandler.dart';

class OpportunityMediaDataHandlerBase {
  static Future<List<OpportunityMedia>> GetOpportunityMediaRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityMedia> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityMedia_ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";
      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityMediaDataHandlerBase:GetOpportunityMediaRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityMedia>> GetOpportunityMediaRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityMediaDataHandlerBase:GetOpportunityMediaRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityMedia?> GetOpportunityMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityMediaDataHandlerBase:GetOpportunityMediaRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityMedia?> GetMasterOpportunityMediaRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityMedia? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityMediaDataHandlerBase:GetMasterOpportunityMediaRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityMediaRecord(
      DatabaseHandler databaseHandler, OpportunityMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityMediaID != null &&
          dataItem.opportunityMediaID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID] =
            dataItem.opportunityMediaID;
      }
      if (dataItem.opportunityMediaCode != null &&
          dataItem.opportunityMediaCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE] =
            dataItem.opportunityMediaCode;
      }
      if (dataItem.opportunityMediaName != null &&
          dataItem.opportunityMediaName != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME] =
            dataItem.opportunityMediaName;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      }
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH] = dataItem.mediaPath;
      }
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT] =
            dataItem.mediaContent;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS] = dataItem.tags;
      }
      if (dataItem.localMediaPath != null &&
          dataItem.localMediaPath != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH] =
            dataItem.localMediaPath;
      }
      if (dataItem.isUploaded != null && dataItem.isUploaded != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED] =
            dataItem.isUploaded;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYMEDIA, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityMediaRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityMedia dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityMediaID != null &&
          dataItem.opportunityMediaID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID] =
            dataItem.opportunityMediaID;
      }
      if (dataItem.opportunityMediaCode != null &&
          dataItem.opportunityMediaCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE] =
            dataItem.opportunityMediaCode;
      }
      if (dataItem.opportunityMediaName != null &&
          dataItem.opportunityMediaName != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME] =
            dataItem.opportunityMediaName;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.contentTypeID != null && dataItem.contentTypeID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID] =
            dataItem.contentTypeID;
      }
      if (dataItem.mediaPath != null && dataItem.mediaPath != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH] = dataItem.mediaPath;
      }
      if (dataItem.mediaContent != null && dataItem.mediaContent != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT] =
            dataItem.mediaContent;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS] = dataItem.tags;
      }
      if (dataItem.localMediaPath != null &&
          dataItem.localMediaPath != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH] =
            dataItem.localMediaPath;
      }
      if (dataItem.isUploaded != null && dataItem.isUploaded != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED] =
            dataItem.isUploaded;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED] = dataItem.isDeleted;
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
      id = await db.update(TablesBase.TABLE_OPPORTUNITYMEDIA, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityMediaRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityMediaRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYMEDIA,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityMediaRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId =
            result[0][ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityMediaDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId =
            result[0][ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityMediaDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityMedia>> GetOpportunityMediaUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityMedia> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      /*    if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYMEDIA + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE coalesce(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'') <> '')";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityMediaDataHandlerBase:GetOpportunityMediaUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityMedia?> GetOpportunityMediaRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityMedia? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTENTTYPE_CONTENTTYPENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEDIA} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTENTTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEDIA_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        OpportunityMedia dataItem = new OpportunityMedia();
        dataItem.opportunityMediaID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIAID];
        dataItem.opportunityMediaCode =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIACODE];
        dataItem.opportunityMediaName =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYMEDIANAME];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_OPPORTUNITYID];
        dataItem.contentTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CONTENTTYPEID];
        dataItem.mediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIAPATH];
        dataItem.mediaContent =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MEDIACONTENT];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_DESCRIPTION];
        dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_TAGS];
        dataItem.localMediaPath =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH];
        dataItem.isUploaded =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISUPLOADED];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEDIA_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYMEDIA_ISDELETED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
          "OpportunityMediaDataHandlerBase:GetOpportunityMediaRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
