// ignore: file_names

import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityBusinessUnit.dart';
import '../DataBaseHandler.dart';

class OpportunityBusinessUnitDataHandlerBase {
  static Future<List<OpportunityBusinessUnit>>
      GetOpportunityBusinessUnitRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<OpportunityBusinessUnit> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityBusinessUnit_Columns.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityBusinessUnit>>
      GetOpportunityBusinessUnitRecords(
          DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityBusinessUnit> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE} LIKE '${searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityBusinessUnit?> GetOpportunityBusinessUnitRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityBusinessUnit? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityBusinessUnit?> GetOpportunityBusinessUnitRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityBusinessUnit? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  // ignore: non_constant_identifier_names
  static Future<OpportunityBusinessUnit?>
      GetMasterOpportunityBusinessUnitRecord(
          DatabaseHandler databaseHandler, String id) async {
    OpportunityBusinessUnit? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_BUSINESSUNIT} D ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetMasterOpportunityBusinessUnitRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityBusinessUnitRecord(
      DatabaseHandler databaseHandler, OpportunityBusinessUnit dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();
      if (dataItem.opportunityBusinessUnitID != null &&
          dataItem.opportunityBusinessUnitID != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID] =
            dataItem.opportunityBusinessUnitID;
      }
      if (dataItem.opportunityBusinessUnitCode != null &&
          dataItem.opportunityBusinessUnitCode != "null") {
        values[ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE] =
            dataItem.opportunityBusinessUnitCode;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.businessUnitID != null &&
          dataItem.businessUnitID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID] =
            dataItem.businessUnitID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED] =
            dataItem.isArchived;
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

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityBusinessUnitRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityBusinessUnitRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityBusinessUnit dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map<String, dynamic>();
      if (dataItem.opportunityBusinessUnitID != null &&
          dataItem.opportunityBusinessUnitID != "null")
        values[ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID] =
            dataItem.opportunityBusinessUnitID;
      if (dataItem.opportunityBusinessUnitCode != null &&
          dataItem.opportunityBusinessUnitCode != "null")
        values[ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE] =
            dataItem.opportunityBusinessUnitCode;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID] =
            dataItem.opportunityID;
      if (dataItem.businessUnitID != null && dataItem.businessUnitID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID] =
            dataItem.businessUnitID;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY] =
            dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON] =
            dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY] =
            dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON] =
            dataItem.modifiedOn;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE] =
            dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID] =
            dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED] =
            dataItem.isDeleted;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED] =
            dataItem.isArchived;
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

      id = await db.update(TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityBusinessUnitRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityBusinessUnitRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityBusinessUnitRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0][ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityBusinessUnitDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID} = $id";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0][ColumnsBase
                .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityBusinessUnitDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityBusinessUnit>>
      GetOpportunityBusinessUnitUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityBusinessUnit> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      /*   if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYBUSINESSUNIT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityBusinessUnit dataItem = new OpportunityBusinessUnit();
        dataItem.opportunityBusinessUnitID = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITID];
        dataItem.opportunityBusinessUnitCode = element[ColumnsBase
            .KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYBUSINESSUNITCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_OPPORTUNITYID];
        dataItem.businessUnitID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_BUSINESSUNITID];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_APPUSERGROUPID];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_REFERENCEIDENTIFIER];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYBUSINESSUNIT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.businessUnitName =
            element[ColumnsBase.KEY_BUSINESSUNIT_BUSINESSUNITNAME];

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
          "OpportunityBusinessUnitDataHandlerBase:GetOpportunityBusinessUnitUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
