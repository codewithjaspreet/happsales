import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/TagGroup.dart';
import '../DataBaseHandler.dart';

class TagGroupDataHandlerBase {
  static Future<List<TagGroup>> GetTagGroupRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<TagGroup> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAGGROUP_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAGGROUP_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_TagGroup_Columns.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetTagGroupRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<TagGroup>> GetTagGroupRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<TagGroup> dataList = [];
    try {
      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAGGROUP_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_TAGGROUP_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetTagGroupRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<TagGroup?> GetTagGroupRecord(
      DatabaseHandler databaseHandler, String id) async {
    TagGroup? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetTagGroupRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<TagGroup?> GetMasterTagGroupRecord(
      DatabaseHandler databaseHandler, String id) async {
    TagGroup? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetMasterTagGroupRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddTagGroupRecord(
      DatabaseHandler databaseHandler, TagGroup dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.tagGroupID != null && dataItem.tagGroupID != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPID] = dataItem.tagGroupID;
      if (dataItem.tagGroupCode != null && dataItem.tagGroupCode != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE] = dataItem.tagGroupCode;
      if (dataItem.tagGroupName != null && dataItem.tagGroupName != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME] = dataItem.tagGroupName;
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null")
        values[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      if (dataItem.linkTo != null && dataItem.linkTo != "null")
        values[ColumnsBase.KEY_TAGGROUP_LINKTO] = dataItem.linkTo;
      if (dataItem.sortOrder != null && dataItem.sortOrder != "null")
        values[ColumnsBase.KEY_TAGGROUP_SORTORDER] = dataItem.sortOrder;
      if (dataItem.displayInApp != null && dataItem.displayInApp != "null")
        values[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP] = dataItem.displayInApp;
      if (dataItem.positionIndex != null && dataItem.positionIndex != "null")
        values[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX] = dataItem.positionIndex;
      if (dataItem.allowNewValues != null && dataItem.allowNewValues != "null")
        values[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES] =
            dataItem.allowNewValues;
      if (dataItem.useInBusinessTarget != null &&
          dataItem.useInBusinessTarget != "null")
        values[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET] =
            dataItem.useInBusinessTarget;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_TAGGROUP_CREATEDON] = dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_TAGGROUP_CREATEDBY] = dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_TAGGROUP_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_TAGGROUP_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_TAGGROUP_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_TAGGROUP_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_TAGGROUP_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_TAGGROUP, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddTagGroupRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateTagGroupRecord(
      DatabaseHandler databaseHandler, String id1, TagGroup dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.tagGroupID != null && dataItem.tagGroupID != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPID] = dataItem.tagGroupID;
      if (dataItem.tagGroupCode != null && dataItem.tagGroupCode != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE] = dataItem.tagGroupCode;
      if (dataItem.tagGroupName != null && dataItem.tagGroupName != "null")
        values[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME] = dataItem.tagGroupName;
      if (dataItem.businessFeatureID != null &&
          dataItem.businessFeatureID != "null")
        values[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID] =
            dataItem.businessFeatureID;
      if (dataItem.linkTo != null && dataItem.linkTo != "null")
        values[ColumnsBase.KEY_TAGGROUP_LINKTO] = dataItem.linkTo;
      if (dataItem.sortOrder != null && dataItem.sortOrder != "null")
        values[ColumnsBase.KEY_TAGGROUP_SORTORDER] = dataItem.sortOrder;
      if (dataItem.displayInApp != null && dataItem.displayInApp != "null")
        values[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP] = dataItem.displayInApp;
      if (dataItem.positionIndex != null && dataItem.positionIndex != "null")
        values[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX] = dataItem.positionIndex;
      if (dataItem.allowNewValues != null && dataItem.allowNewValues != "null")
        values[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES] =
            dataItem.allowNewValues;
      if (dataItem.useInBusinessTarget != null &&
          dataItem.useInBusinessTarget != "null")
        values[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET] =
            dataItem.useInBusinessTarget;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_TAGGROUP_CREATEDON] = dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_TAGGROUP_CREATEDBY] = dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_TAGGROUP_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_TAGGROUP_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_TAGGROUP_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_TAGGROUP_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_TAGGROUP_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(
        TablesBase.TABLE_TAGGROUP,
        values,
        where: "${ColumnsBase.KEY_ID} = $id1",
        whereArgs: null,
      );
// db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateTagGroupRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteTagGroupRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_TAGGROUP,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteTagGroupRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPID}";
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_TAGGROUP_TAGGROUPID].toString();
      }
    } catch (ex) {
      Globals.handleException("TagGroupDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_TAGGROUP_TAGGROUPID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException("TagGroupDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<TagGroup>> GetTagGroupUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<TagGroup> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_TAGGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_TAGGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_TAGGROUP} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetTagGroupUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<TagGroup?> GetTagGroupRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    TagGroup? dataItem;
    try {
      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME;
      selectQuery += " FROM ${TablesBase.TABLE_TAGGROUP} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSFEATURE} D ON A.${ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_TAGGROUP_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
        TagGroup dataItem = new TagGroup();
        dataItem.tagGroupID = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPID];
        dataItem.tagGroupCode = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPCODE];

        dataItem.tagGroupName = ele[ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME];
        dataItem.businessFeatureID =
            ele[ColumnsBase.KEY_TAGGROUP_BUSINESSFEATUREID];
        dataItem.linkTo = ele[ColumnsBase.KEY_TAGGROUP_LINKTO];
        dataItem.sortOrder = ele[ColumnsBase.KEY_TAGGROUP_SORTORDER];
        dataItem.displayInApp = ele[ColumnsBase.KEY_TAGGROUP_DISPLAYINAPP];
        dataItem.positionIndex = ele[ColumnsBase.KEY_TAGGROUP_POSITIONINDEX];
        dataItem.allowNewValues = ele[ColumnsBase.KEY_TAGGROUP_ALLOWNEWVALUES];
        dataItem.useInBusinessTarget =
            ele[ColumnsBase.KEY_TAGGROUP_USEINBUSINESSTARGET];
        dataItem.createdOn = ele[ColumnsBase.KEY_TAGGROUP_CREATEDON];
        dataItem.createdBy = ele[ColumnsBase.KEY_TAGGROUP_CREATEDBY];
        dataItem.modifiedBy = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDBY];
        dataItem.modifiedOn = ele[ColumnsBase.KEY_TAGGROUP_MODIFIEDON];
        dataItem.isActive = ele[ColumnsBase.KEY_TAGGROUP_ISACTIVE];
        dataItem.uid = ele[ColumnsBase.KEY_TAGGROUP_UID];
        dataItem.appUserGroupID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERGROUPID];
        dataItem.appUserID = ele[ColumnsBase.KEY_TAGGROUP_APPUSERID];
        dataItem.isDeleted = ele[ColumnsBase.KEY_TAGGROUP_ISDELETED];

        dataItem.businessFeatureName =
            ele[ColumnsBase.KEY_BUSINESSFEATURE_BUSINESSFEATURENAME];
        dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      Globals.handleException(
          "TagGroupDataHandlerBase:GetTagGroupRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
