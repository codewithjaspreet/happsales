import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserLocation.dart';
import '../DataBaseHandler.dart';

class AppUserLocationDataHandlerBase {
  static Future<List<AppUserLocation>> GetAppUserLocationRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AppUserLocation> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserLocation_Columns.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AppUserLocation dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
          "AppUserLocationDataHandlerBase:GetAppUserLocationRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AppUserLocation>> GetAppUserLocationRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AppUserLocation> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AppUserLocation dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "AppUserLocationDataHandlerBase:GetAppUserLocationRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppUserLocation?> GetAppUserLocationRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppUserLocation? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
          "AppUserLocationDataHandlerBase:GetAppUserLocationRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AppUserLocation?> GetMasterAppUserLocationRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppUserLocation? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
          "AppUserLocationDataHandlerBase:GetMasterAppUserLocationRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAppUserLocationRecord(
      DatabaseHandler databaseHandler, AppUserLocation dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.appUserLocationID != null &&
          dataItem.appUserLocationID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID] =
            dataItem.appUserLocationID;
      }
      if (dataItem.appUserLocationCode != null &&
          dataItem.appUserLocationCode != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE] =
            dataItem.appUserLocationCode;
      }
      if (dataItem.appUserLocationTitle != null &&
          dataItem.appUserLocationTitle != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE] =
            dataItem.appUserLocationTitle;
      }
      if (dataItem.appUserLocationDate != null &&
          dataItem.appUserLocationDate != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE] =
            dataItem.appUserLocationDate;
      }
      if (dataItem.appUserLocationCoordinates != null &&
          dataItem.appUserLocationCoordinates != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES] =
            dataItem.appUserLocationCoordinates;
      }
      if (dataItem.appUserLocationAddress != null &&
          dataItem.appUserLocationAddress != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS] =
            dataItem.appUserLocationAddress;
      }
      if (dataItem.checkSum != null && dataItem.checkSum != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM] = dataItem.checkSum;
      }

      if (dataItem.checkSum != null && dataItem.checkSum != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM] = dataItem.checkSum;
      }
      if (dataItem.lastLocationCoordinates != null &&
          dataItem.lastLocationCoordinates != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES] =
            dataItem.lastLocationCoordinates;
      }
      if (dataItem.lastLocationAddress != null &&
          dataItem.lastLocationAddress != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS] =
            dataItem.lastLocationAddress;
      }
      if (dataItem.lastLocationTime != null &&
          dataItem.lastLocationTime != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME] =
            dataItem.lastLocationTime;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LOCATION] = dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED] = dataItem.isDeleted;
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

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_APPUSERLOCATION, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddAppUserLocationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAppUserLocationRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AppUserLocation dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.appUserLocationID != null &&
          dataItem.appUserLocationID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID] =
            dataItem.appUserLocationID;
      }
      if (dataItem.appUserLocationCode != null &&
          dataItem.appUserLocationCode != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE] =
            dataItem.appUserLocationCode;
      }
      if (dataItem.appUserLocationTitle != null &&
          dataItem.appUserLocationTitle != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE] =
            dataItem.appUserLocationTitle;
      }
      if (dataItem.appUserLocationDate != null &&
          dataItem.appUserLocationDate != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE] =
            dataItem.appUserLocationDate;
      }
      if (dataItem.appUserLocationCoordinates != null &&
          dataItem.appUserLocationCoordinates != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES] =
            dataItem.appUserLocationCoordinates;
      }
      if (dataItem.appUserLocationAddress != null &&
          dataItem.appUserLocationAddress != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS] =
            dataItem.appUserLocationAddress;
      }
      if (dataItem.checkSum != null && dataItem.checkSum != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM] = dataItem.checkSum;
      }

      if (dataItem.checkSum != null && dataItem.checkSum != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM] = dataItem.checkSum;
      }
      if (dataItem.lastLocationCoordinates != null &&
          dataItem.lastLocationCoordinates != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES] =
            dataItem.lastLocationCoordinates;
      }
      if (dataItem.lastLocationAddress != null &&
          dataItem.lastLocationAddress != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS] =
            dataItem.lastLocationAddress;
      }
      if (dataItem.lastLocationTime != null &&
          dataItem.lastLocationTime != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME] =
            dataItem.lastLocationTime;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_LOCATION] = dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_APPUSERLOCATION, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateAppUserLocationRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAppUserLocationRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_APPUSERLOCATION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteAppUserLocationRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID]
            .toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "AppUserLocationDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID].toString();
      }
    } catch (ex) {
      Globals.handleException(
          "AppUserLocationDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AppUserLocation>> GetAppUserLocationUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AppUserLocation> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_APPUSERLOCATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPUSERLOCATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPUSERLOCATION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AppUserLocation dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
          "AppUserLocationDataHandlerBase:GetAppUserLocationUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppUserLocation?> GetAppUserLocationRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AppUserLocation? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_APPUSERLOCATION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERLOCATION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AppUserLocation dataItem = AppUserLocation();

        dataItem.appUserLocationID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONID];
        dataItem.appUserLocationCode =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE];
        dataItem.appUserLocationTitle =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONTITLE];
        dataItem.appUserLocationDate =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONDATE];
        dataItem.appUserLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONCOORDINATES];
        dataItem.appUserLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERLOCATIONADDRESS];
        dataItem.checkSum = element[ColumnsBase.KEY_APPUSERLOCATION_CHECKSUM];
        dataItem.lastLocationCoordinates =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONCOORDINATES];
        dataItem.lastLocationAddress =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONADDRESS];
        dataItem.lastLocationTime =
            element[ColumnsBase.KEY_APPUSERLOCATION_LASTLOCATIONTIME];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSERLOCATION_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPUSERLOCATION_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSERLOCATION_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_APPUSERLOCATION_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSERLOCATION_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSERLOCATION_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSERLOCATION_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_APPUSERLOCATION_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERLOCATION_ISDELETED];

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
          "AppUserLocationDataHandlerBase:GetAppUserLocationRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
