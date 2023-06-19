import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityApprovalType.dart';
import '../DataBaseHandler.dart';

class OpportunityApprovalTypeDataHandlerBase {
  static Future<List<OpportunityApprovalType>>
      GetOpportunityApprovalTypeRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<OpportunityApprovalType> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityApprovalType_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityApprovalType_Columns.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetOpportunityApprovalTypeRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityApprovalType>>
      GetOpportunityApprovalTypeRecords(
          DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityApprovalType> dataList = [];
    try {
      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OpportunityApprovalType_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetOpportunityApprovalTypeRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityApprovalType?> GetOpportunityApprovalTypeRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityApprovalType? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetOpportunityApprovalTypeRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityApprovalType?> GetOpportunityApprovalTypeRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityApprovalType? dataItem;
    try {
      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetOpportunityApprovalTypeRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityApprovalType?>
      GetMasterOpportunityApprovalTypeRecord(
          DatabaseHandler databaseHandler, String id) async {
    OpportunityApprovalType? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* " +
          ",D." +
          ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYTYPE} D ON A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetMasterOpportunityApprovalTypeRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityApprovalTypeRecord(
      DatabaseHandler databaseHandler, OpportunityApprovalType dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.opportunityApprovalTypeID != null &&
          dataItem.opportunityApprovalTypeID != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID] =
            dataItem.opportunityApprovalTypeID;
      }

      if (dataItem.opportunityApprovalTypeCode != null &&
          dataItem.opportunityApprovalTypeCode != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE] =
            dataItem.opportunityApprovalTypeCode;
      }

      if (dataItem.opportunityApprovalTypeName != null &&
          dataItem.opportunityApprovalTypeName != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME] =
            dataItem.opportunityApprovalTypeName;
      }

      if (dataItem.description != null && dataItem.description != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION] =
            dataItem.description;
      }

      if (dataItem.opportunityTypeID != null &&
          dataItem.opportunityTypeID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID] =
            dataItem.opportunityTypeID;
      }

      if (dataItem.internalCode != null && dataItem.internalCode != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE] =
            dataItem.internalCode;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED] =
            dataItem.isDeleted;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE] =
            dataItem.isActive;
      }

      //uid

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED] =
            dataItem.isDeleted;
      }

      //id

      if (dataItem.id != null && dataItem.id != ("null")) {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      // FOR ALL remaining base entitiyy

      //is dirty

      if (dataItem.isDirty != null && dataItem.isDirty != ("null")) {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }

      //up sync message

      if (dataItem.upSyncMessage != null &&
          dataItem.upSyncMessage != ("null")) {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }

      //down sync message

      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != ("null")) {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }

      //screated on

      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != ("null")) {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }

      //smodified on

      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != ("null")) {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }

      ///createdbysuer

      if (dataItem.createdByUser != null &&
          dataItem.createdByUser != ("null")) {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }

      //modifiedbyuser

      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != ("null")) {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }

      /// isdeleted1, getowneruserid, getupsyncindex

      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != ("null")) {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }

      if (dataItem.ownerUserID != null && dataItem.ownerUserID != ("null")) {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != ("null")) {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityApprovalTypeRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityApprovalTypeRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityApprovalType dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.opportunityApprovalTypeID != null &&
          dataItem.opportunityApprovalTypeID != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID] =
            dataItem.opportunityApprovalTypeID;
      }

      if (dataItem.opportunityApprovalTypeCode != null &&
          dataItem.opportunityApprovalTypeCode != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE] =
            dataItem.opportunityApprovalTypeCode;
      }

      if (dataItem.opportunityApprovalTypeName != null &&
          dataItem.opportunityApprovalTypeName != ("null")) {
        values[ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME] =
            dataItem.opportunityApprovalTypeName;
      }

      if (dataItem.description != null && dataItem.description != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION] =
            dataItem.description;
      }

      if (dataItem.opportunityTypeID != null &&
          dataItem.opportunityTypeID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID] =
            dataItem.opportunityTypeID;
      }

      if (dataItem.internalCode != null && dataItem.internalCode != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE] =
            dataItem.internalCode;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED] =
            dataItem.isDeleted;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE] =
            dataItem.isActive;
      }

      //uid

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED] =
            dataItem.isDeleted;
      }

      //id

      if (dataItem.id != null && dataItem.id != ("null")) {
        values[ColumnsBase.KEY_ID] = dataItem.id;
      }
      // FOR ALL remaining base entitiyy

      //is dirty

      if (dataItem.isDirty != null && dataItem.isDirty != ("null")) {
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      }

      //up sync message

      if (dataItem.upSyncMessage != null &&
          dataItem.upSyncMessage != ("null")) {
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      }

      //down sync message

      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != ("null")) {
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      }

      //screated on

      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != ("null")) {
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      }

      //smodified on

      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != ("null")) {
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      }

      ///createdbysuer

      if (dataItem.createdByUser != null &&
          dataItem.createdByUser != ("null")) {
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      }

      //modifiedbyuser

      if (dataItem.modifiedByUser != null &&
          dataItem.modifiedByUser != ("null")) {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }

      /// isdeleted1, getowneruserid, getupsyncindex

      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != ("null")) {
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      }

      if (dataItem.ownerUserID != null && dataItem.ownerUserID != ("null")) {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != ("null")) {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }

      id = await db.update(TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityApprovalTypeRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityApprovalTypeRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityApprovalTypeRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0][ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID]
            .toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalTypeDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0][ColumnsBase
                .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID]
            .toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityApprovalTypeDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityApprovalType>>
      GetOpportunityApprovalTypeUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityApprovalType> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYAPPROVALTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      //selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      for (var element in result) {
        OpportunityApprovalType dataItem = new OpportunityApprovalType();
        dataItem.opportunityApprovalTypeID = element[
            ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPEID];
        dataItem.opportunityApprovalTypeCode = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPECODE];
        dataItem.opportunityApprovalTypeName = element[ColumnsBase
            .KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYAPPROVALTYPENAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_DESCRIPTION];
        dataItem.opportunityTypeID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_OPPORTUNITYTYPEID];
        dataItem.internalCode =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_INTERNALCODE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_MODIFIEDBY];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISDELETED];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYAPPROVALTYPE_APPUSERID];
        dataItem.opportunityTypeName =
            element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];

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
          "OpportunityApprovalTypeDataHandlerBase:GetOpportunityApprovalTypeUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
