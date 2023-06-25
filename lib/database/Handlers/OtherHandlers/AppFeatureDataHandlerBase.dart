import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppFeature.dart';
import '../DataBaseHandler.dart';

class AppFeatureDataHandlerBase {
  static Future<List<AppFeature>> GetAppFeatureRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AppFeature> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} B ON A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPFEATURE_APPFEATURENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppFeature_Columns.KEY_APPFEATURE_APPFEATURENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeature dataItem = AppFeature();
        dataItem.appFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
        dataItem.appFeatureCode =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE];
        dataItem.appFeatureName =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID];
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID];
        dataItem.description = element[ColumnsBase.KEY_APPFEATURE_DESCRIPTION];
        dataItem.formName = element[ColumnsBase.KEY_APPFEATURE_FORMNAME];
        dataItem.appFeatureOrder =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATURE_APPICON];
        dataItem.consoleIcon = element[ColumnsBase.KEY_APPFEATURE_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML];
        dataItem.isConsoleFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE];
        dataItem.isAppFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE];
        dataItem.internalCode =
            element[ColumnsBase.KEY_APPFEATURE_INTERNALCODE];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATURE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATURE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATURE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATURE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATURE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPFEATURE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATURE_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
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

        // Add the dataItem to your collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetAppFeatureRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AppFeature>> GetAppFeatureRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AppFeature> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} B ON A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATURE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPFEATURE_APPFEATURENAME} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_APPFEATURE_APPFEATURENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeature dataItem = AppFeature();
        dataItem.appFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
        dataItem.appFeatureCode =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE];
        dataItem.appFeatureName =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID];
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID];
        dataItem.description = element[ColumnsBase.KEY_APPFEATURE_DESCRIPTION];
        dataItem.formName = element[ColumnsBase.KEY_APPFEATURE_FORMNAME];
        dataItem.appFeatureOrder =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATURE_APPICON];
        dataItem.consoleIcon = element[ColumnsBase.KEY_APPFEATURE_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML];
        dataItem.isConsoleFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE];
        dataItem.isAppFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE];
        dataItem.internalCode =
            element[ColumnsBase.KEY_APPFEATURE_INTERNALCODE];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATURE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATURE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATURE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATURE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATURE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPFEATURE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATURE_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
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

        // Add the dataItem to your collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetAppFeatureRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppFeature?> GetAppFeatureRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppFeature? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} B ON A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeature dataItem = AppFeature();
        dataItem.appFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
        dataItem.appFeatureCode =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE];
        dataItem.appFeatureName =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID];
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID];
        dataItem.description = element[ColumnsBase.KEY_APPFEATURE_DESCRIPTION];
        dataItem.formName = element[ColumnsBase.KEY_APPFEATURE_FORMNAME];
        dataItem.appFeatureOrder =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATURE_APPICON];
        dataItem.consoleIcon = element[ColumnsBase.KEY_APPFEATURE_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML];
        dataItem.isConsoleFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE];
        dataItem.isAppFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE];
        dataItem.internalCode =
            element[ColumnsBase.KEY_APPFEATURE_INTERNALCODE];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATURE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATURE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATURE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATURE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATURE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPFEATURE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATURE_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
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

        // Add the dataItem to your collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetAppFeatureRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AppFeature?> GetMasterAppFeatureRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppFeature? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} B ON A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREID} = $id";
      // ignore: prefer_interpolation_to_compose_strings
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetMasterAppFeatureRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAppFeatureRecord(
      DatabaseHandler databaseHandler, AppFeature dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.appFeatureID != null && dataItem.appFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREID] = dataItem.appFeatureID;
      }
      if (dataItem.appFeatureCode != null &&
          dataItem.appFeatureCode != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE] =
            dataItem.appFeatureCode;
      }
      if (dataItem.appFeatureName != null &&
          dataItem.appFeatureName != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME] =
            dataItem.appFeatureName;
      }
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      }
      if (dataItem.appFeatureGroupID != null &&
          dataItem.appFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID] =
            dataItem.appFeatureGroupID;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTION] = dataItem.description;
      }
      if (dataItem.formName != null && dataItem.formName != "null") {
        values[ColumnsBase.KEY_APPFEATURE_FORMNAME] = dataItem.formName;
      }
      if (dataItem.appFeatureOrder != null &&
          dataItem.appFeatureOrder != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER] =
            dataItem.appFeatureOrder;
      }
      if (dataItem.appIcon != null && dataItem.appIcon != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPICON] = dataItem.appIcon;
      }
      if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CONSOLEICON] = dataItem.consoleIcon;
      }
      if (dataItem.descriptionText != null &&
          dataItem.descriptionText != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT] =
            dataItem.descriptionText;
      }
      if (dataItem.descriptionHtml != null &&
          dataItem.descriptionHtml != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML] =
            dataItem.descriptionHtml;
      }
      if (dataItem.isConsoleFeature != null &&
          dataItem.isConsoleFeature != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE] =
            dataItem.isConsoleFeature;
      }
      if (dataItem.isAppFeature != null && dataItem.isAppFeature != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE] = dataItem.isAppFeature;
      }
      if (dataItem.internalCode != null && dataItem.internalCode != "null") {
        values[ColumnsBase.KEY_APPFEATURE_INTERNALCODE] = dataItem.internalCode;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPFEATURE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPFEATURE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_APPFEATURE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddAppFeatureRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAppFeatureRecord(
      DatabaseHandler databaseHandler, String id1, AppFeature dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.appFeatureID != null && dataItem.appFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREID] = dataItem.appFeatureID;
      }
      if (dataItem.appFeatureCode != null &&
          dataItem.appFeatureCode != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE] =
            dataItem.appFeatureCode;
      }
      if (dataItem.appFeatureName != null &&
          dataItem.appFeatureName != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME] =
            dataItem.appFeatureName;
      }
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      }
      if (dataItem.appFeatureGroupID != null &&
          dataItem.appFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID] =
            dataItem.appFeatureGroupID;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTION] = dataItem.description;
      }
      if (dataItem.formName != null && dataItem.formName != "null") {
        values[ColumnsBase.KEY_APPFEATURE_FORMNAME] = dataItem.formName;
      }
      if (dataItem.appFeatureOrder != null &&
          dataItem.appFeatureOrder != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER] =
            dataItem.appFeatureOrder;
      }
      if (dataItem.appIcon != null && dataItem.appIcon != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPICON] = dataItem.appIcon;
      }
      if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CONSOLEICON] = dataItem.consoleIcon;
      }
      if (dataItem.descriptionText != null &&
          dataItem.descriptionText != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT] =
            dataItem.descriptionText;
      }
      if (dataItem.descriptionHtml != null &&
          dataItem.descriptionHtml != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML] =
            dataItem.descriptionHtml;
      }
      if (dataItem.isConsoleFeature != null &&
          dataItem.isConsoleFeature != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE] =
            dataItem.isConsoleFeature;
      }
      if (dataItem.isAppFeature != null && dataItem.isAppFeature != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE] = dataItem.isAppFeature;
      }
      if (dataItem.internalCode != null && dataItem.internalCode != "null") {
        values[ColumnsBase.KEY_APPFEATURE_INTERNALCODE] = dataItem.internalCode;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPFEATURE_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPFEATURE_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPFEATURE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPFEATURE_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_APPFEATURE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateAppFeatureRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAppFeatureRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_APPFEATURE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteAppFeatureRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREID}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
      }
    } catch (ex) {
      Globals.handleException("AppFeatureDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("AppFeatureDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AppFeature>> GetAppFeatureUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AppFeature> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_APPFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPFEATURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeature dataItem = AppFeature();
        dataItem.appFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
        dataItem.appFeatureCode =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE];
        dataItem.appFeatureName =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID];
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID];
        dataItem.description = element[ColumnsBase.KEY_APPFEATURE_DESCRIPTION];
        dataItem.formName = element[ColumnsBase.KEY_APPFEATURE_FORMNAME];
        dataItem.appFeatureOrder =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATURE_APPICON];
        dataItem.consoleIcon = element[ColumnsBase.KEY_APPFEATURE_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML];
        dataItem.isConsoleFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE];
        dataItem.isAppFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE];
        dataItem.internalCode =
            element[ColumnsBase.KEY_APPFEATURE_INTERNALCODE];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATURE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATURE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATURE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATURE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATURE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPFEATURE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATURE_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
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
        // Add the dataItem to your collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetAppFeatureUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppFeature?> GetAppFeatureRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AppFeature? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},B.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATURE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} B ON A.${ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} E ON A.${ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPFEATURE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeature dataItem = AppFeature();
        dataItem.appFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREID];
        dataItem.appFeatureCode =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURECODE];
        dataItem.appFeatureName =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATURENAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATURE_BUSINESSFEATUREID];
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREGROUPID];
        dataItem.description = element[ColumnsBase.KEY_APPFEATURE_DESCRIPTION];
        dataItem.formName = element[ColumnsBase.KEY_APPFEATURE_FORMNAME];
        dataItem.appFeatureOrder =
            element[ColumnsBase.KEY_APPFEATURE_APPFEATUREORDER];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATURE_APPICON];
        dataItem.consoleIcon = element[ColumnsBase.KEY_APPFEATURE_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATURE_DESCRIPTIONHTML];
        dataItem.isConsoleFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISCONSOLEFEATURE];
        dataItem.isAppFeature =
            element[ColumnsBase.KEY_APPFEATURE_ISAPPFEATURE];
        dataItem.internalCode =
            element[ColumnsBase.KEY_APPFEATURE_INTERNALCODE];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATURE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATURE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPFEATURE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPFEATURE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATURE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATURE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATURE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATURE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPFEATURE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATURE_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
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

        // Add the dataItem to your collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureDataHandlerBase:GetAppFeatureRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
