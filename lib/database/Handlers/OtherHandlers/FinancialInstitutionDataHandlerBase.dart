import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FinancialInstitution.dart';
import '../DataBaseHandler.dart';

class FinancialInstitutionDataHandlerBase {
  static Future<List<FinancialInstitution>> GetFinancialInstitutionRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<FinancialInstitution> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_FinancialInstitution_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_FinancialInstitution_Columns.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()}," + pageSize.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetFinancialInstitutionRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<FinancialInstitution>> GetFinancialInstitutionRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<FinancialInstitution> dataList = [];
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_FinancialInstitution_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A." + ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME + " LIKE '" + searchString.replaceAll("'", "''")}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetFinancialInstitutionRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<FinancialInstitution?> GetFinancialInstitutionRecord(
      DatabaseHandler databaseHandler, String id) async {
    FinancialInstitution? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetFinancialInstitutionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<FinancialInstitution?> GetFinancialInstitutionRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    FinancialInstitution? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_FINANCIALINSTITUTION_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetFinancialInstitutionRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<FinancialInstitution?> GetMasterFinancialInstitutionRecord(
      DatabaseHandler databaseHandler, String id) async {
    FinancialInstitution? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND A.${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetMasterFinancialInstitutionRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddFinancialInstitutionRecord(
      DatabaseHandler databaseHandler, FinancialInstitution dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.financialInstitutionID != null &&
          dataItem.financialInstitutionID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID] =
            dataItem.financialInstitutionID;
      if (dataItem.financialInstitutionCode != null &&
          dataItem.financialInstitutionCode != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE] =
            dataItem.financialInstitutionCode;
      if (dataItem.financialInstitutionName != null &&
          dataItem.financialInstitutionName != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME] =
            dataItem.financialInstitutionName;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION] =
            dataItem.description;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_FINANCIALINSTITUTION, values);

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddFinancialInstitutionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateFinancialInstitutionRecord(
      DatabaseHandler databaseHandler,
      String id1,
      FinancialInstitution dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};
      if (dataItem.financialInstitutionID != null &&
          dataItem.financialInstitutionID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID] =
            dataItem.financialInstitutionID;
      if (dataItem.financialInstitutionCode != null &&
          dataItem.financialInstitutionCode != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE] =
            dataItem.financialInstitutionCode;
      if (dataItem.financialInstitutionName != null &&
          dataItem.financialInstitutionName != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME] =
            dataItem.financialInstitutionName;
      if (dataItem.description != null && dataItem.description != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION] =
            dataItem.description;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISARCHIVED] =
            dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED] =
            dataItem.isDeleted;
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
      if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
        values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
      }
      id = await db.update(TablesBase.TABLE_FINANCIALINSTITUTION, values,
         where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateFinancialInstitutionRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteFinancialInstitutionRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_FINANCIALINSTITUTION,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteFinancialInstitutionRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID}";
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
      }

      return serverId;
    } catch (ex) {
      Globals.handleException(
          "FinancialInstitutionDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "FinancialInstitutionDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<FinancialInstitution>>
      GetFinancialInstitutionUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<FinancialInstitution> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_FINANCIALINSTITUTION} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      //selectQuery += " AND " + ColumnsBase.KEY_FINANCIALINSTITUTION_ACCOUNTID + " IN (SELECT " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'') <> '')";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        FinancialInstitution dataItem = new FinancialInstitution();
        dataItem.financialInstitutionID = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONID];
        dataItem.financialInstitutionCode = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONCODE];
        dataItem.financialInstitutionName = element[
            ColumnsBase.KEY_FINANCIALINSTITUTION_FINANCIALINSTITUTIONNAME];
        dataItem.description =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_DESCRIPTION];
        dataItem.createdOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDON];

        dataItem.createdBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_CREATEDBY];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISACTIVE];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_ISDELETED];

        dataItem.uid = element[ColumnsBase.KEY_FINANCIALINSTITUTION_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERGROUPID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_FINANCIALINSTITUTION_APPUSERID];
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
          "FinancialInstitutionDataHandlerBase:GetFinancialInstitutionUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
