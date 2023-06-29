import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppFeatureGroup.dart';
import '../DataBaseHandler.dart';

class AppFeatureGroupDataHandlerBase {
  static Future<List<AppFeatureGroup>> GetAppFeatureGroupRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AppFeatureGroup> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} AS ${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} E ON A.${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppFeatureGroup_Columns.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetAppFeatureGroupRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AppFeatureGroup>> GetAppFeatureGroupRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AppFeatureGroup> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} AS ${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} E ON A.${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetAppFeatureGroupRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppFeatureGroup?> GetAppFeatureGroupRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppFeatureGroup? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} AS ${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} E ON A.${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetAppFeatureGroupRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AppFeatureGroup?> GetMasterAppFeatureGroupRecord(
      DatabaseHandler databaseHandler, String id) async {
    AppFeatureGroup? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} AS ${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} E ON A.${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetMasterAppFeatureGroupRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAppFeatureGroupRecord(
      DatabaseHandler databaseHandler, AppFeatureGroup dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.appFeatureGroupID != null &&
          dataItem.appFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID] =
            dataItem.appFeatureGroupID;
      }
      if (dataItem.appFeatureGroupCode != null &&
          dataItem.appFeatureGroupCode != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE] =
            dataItem.appFeatureGroupCode;
      }
      if (dataItem.appFeatureGroupName != null &&
          dataItem.appFeatureGroupName != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME] =
            dataItem.appFeatureGroupName;
      }
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      }
      if (dataItem.appFeatureGroupOrder != null &&
          dataItem.appFeatureGroupOrder != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER] =
            dataItem.appFeatureGroupOrder;
      }
      if (dataItem.parentAppFeatureGroupID != null &&
          dataItem.parentAppFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID] =
            dataItem.parentAppFeatureGroupID;
      }
//if (dataItem.parentAppFeatureGroupName != null && dataItem.parentAppFeatureGroupName != "null") {
//    values[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME] = dataItem.parentAppFeatureGroupName;
//}
      if (dataItem.appIcon != null && dataItem.appIcon != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPICON] = dataItem.appIcon;
      }
      if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON] =
            dataItem.consoleIcon;
      }
      if (dataItem.descriptionText != null &&
          dataItem.descriptionText != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT] =
            dataItem.descriptionText;
      }
      if (dataItem.descriptionHtml != null &&
          dataItem.descriptionHtml != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML] =
            dataItem.descriptionHtml;
      }
      if (dataItem.menuPosition != null && dataItem.menuPosition != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION] =
            dataItem.menuPosition;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_APPFEATUREGROUP, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddAppFeatureGroupRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAppFeatureGroupRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AppFeatureGroup dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.appFeatureGroupID != null &&
          dataItem.appFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID] =
            dataItem.appFeatureGroupID;
      }
      if (dataItem.appFeatureGroupCode != null &&
          dataItem.appFeatureGroupCode != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE] =
            dataItem.appFeatureGroupCode;
      }
      if (dataItem.appFeatureGroupName != null &&
          dataItem.appFeatureGroupName != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME] =
            dataItem.appFeatureGroupName;
      }
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      }
      if (dataItem.appFeatureGroupOrder != null &&
          dataItem.appFeatureGroupOrder != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER] =
            dataItem.appFeatureGroupOrder;
      }
      if (dataItem.parentAppFeatureGroupID != null &&
          dataItem.parentAppFeatureGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID] =
            dataItem.parentAppFeatureGroupID;
      }
//if (dataItem.parentAppFeatureGroupName != null && dataItem.parentAppFeatureGroupName != "null") {
//    values[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME] = dataItem.parentAppFeatureGroupName;
//}
      if (dataItem.appIcon != null && dataItem.appIcon != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPICON] = dataItem.appIcon;
      }
      if (dataItem.consoleIcon != null && dataItem.consoleIcon != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON] =
            dataItem.consoleIcon;
      }
      if (dataItem.descriptionText != null &&
          dataItem.descriptionText != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT] =
            dataItem.descriptionText;
      }
      if (dataItem.descriptionHtml != null &&
          dataItem.descriptionHtml != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML] =
            dataItem.descriptionHtml;
      }
      if (dataItem.menuPosition != null && dataItem.menuPosition != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION] =
            dataItem.menuPosition;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_APPFEATUREGROUP, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateAppFeatureGroupRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAppFeatureGroupRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_APPFEATUREGROUP,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteAppFeatureGroupRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureGroupDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0]["${ColumnsBase.KEY_ID}"].toString();
      }
    } catch (ex) {
      Globals.handleException(
          "AppFeatureGroupDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AppFeatureGroup>> GetAppFeatureGroupUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AppFeatureGroup> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_APPFEATUREGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPFEATUREGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_APPFEATUREGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetAppFeatureGroupUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AppFeatureGroup?> GetAppFeatureGroupRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AppFeatureGroup? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,D.${ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME},E.${ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME} AS ${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_APPFEATUREGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPFEATUREGROUP} E ON A.${ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_APPFEATUREGROUP_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppFeatureGroup dataItem = AppFeatureGroup();
        dataItem.appFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPID];
        dataItem.appFeatureGroupCode =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPCODE];
        dataItem.appFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPNAME];
        dataItem.businessFeatureID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_BUSINESSFEATUREID];
        dataItem.appFeatureGroupOrder =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPFEATUREGROUPORDER];
        dataItem.parentAppFeatureGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPID];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
        dataItem.appIcon = element[ColumnsBase.KEY_APPFEATUREGROUP_APPICON];
        dataItem.consoleIcon =
            element[ColumnsBase.KEY_APPFEATUREGROUP_CONSOLEICON];
        dataItem.descriptionText =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONTEXT];
        dataItem.descriptionHtml =
            element[ColumnsBase.KEY_APPFEATUREGROUP_DESCRIPTIONHTML];
        dataItem.menuPosition =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MENUPOSITION];
        dataItem.createdBy = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPFEATUREGROUP_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_APPFEATUREGROUP_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_APPFEATUREGROUP_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPFEATUREGROUP_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPFEATUREGROUP_APPUSERGROUPID];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPFEATUREGROUP_ISDELETED];
        dataItem.businessFeatureName =
            element[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.parentAppFeatureGroupName =
            element[ColumnsBase.KEY_APPFEATUREGROUP_PARENTAPPFEATUREGROUPNAME];
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
          "AppFeatureGroupDataHandlerBase:GetAppFeatureGroupRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
