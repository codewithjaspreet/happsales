import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityContact.dart';
import '../DataBaseHandler.dart';

class OpportunityContactDataHandlerBase {
  static Future<List<OpportunityContact>> GetOpportunityContactRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<OpportunityContact> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityContact_Columns.KEY_OPPORTUNITYCONTACT_CONTACTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<OpportunityContact>> GetOpportunityContactRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<OpportunityContact> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME} LIKE '${searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<OpportunityContact?> GetOpportunityContactRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityContact? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityContact?> GetOpportunityContactRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    OpportunityContact? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<OpportunityContact?> GetMasterOpportunityContactRecord(
      DatabaseHandler databaseHandler, String id) async {
    OpportunityContact? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} D ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetMasterOpportunityContactRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddOpportunityContactRecord(
      DatabaseHandler databaseHandler, OpportunityContact dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityContactID != null &&
          dataItem.opportunityContactID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID] =
            dataItem.opportunityContactID;
      }
      if (dataItem.opportunityContactCode != null &&
          dataItem.opportunityContactCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE] =
            dataItem.opportunityContactCode;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID] =
            dataItem.contactID;
      }
      if (dataItem.contactName != null && dataItem.contactName != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME] =
            dataItem.contactName;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
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

      id = await db.insert(TablesBase.TABLE_OPPORTUNITYCONTACT, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddOpportunityContactRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateOpportunityContactRecord(
      DatabaseHandler databaseHandler,
      String id1,
      OpportunityContact dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
      if (dataItem.opportunityContactID != null &&
          dataItem.opportunityContactID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID] =
            dataItem.opportunityContactID;
      }
      if (dataItem.opportunityContactCode != null &&
          dataItem.opportunityContactCode != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE] =
            dataItem.opportunityContactCode;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID] =
            dataItem.contactID;
      }
      if (dataItem.contactName != null && dataItem.contactName != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME] =
            dataItem.contactName;
      }
      if (dataItem.description != null && dataItem.description != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION] =
            dataItem.description;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED] =
            dataItem.isDeleted;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
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

      id = await db.update(TablesBase.TABLE_OPPORTUNITYCONTACT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateOpportunityContactRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteOpportunityContactRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_OPPORTUNITYCONTACT,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteOpportunityContactRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID}";
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityContactDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);
      if (result.length > 0) {
        localId = result[0][ColumnsBase.KEY_ID];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityContactDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<OpportunityContact>> GetOpportunityContactUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<OpportunityContact> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYCONTACT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }

      /*    if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYCONTACT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYCONTACT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_OPPORTUNITY} WHERE coalesce(${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID},'') <> '')";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        OpportunityContact dataItem = new OpportunityContact();
        dataItem.opportunityContactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTID];
        dataItem.opportunityContactCode =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYCONTACTCODE];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_OPPORTUNITYID];
        dataItem.contactID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTID];
        dataItem.contactName =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CONTACTNAME];
        dataItem.description =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_DESCRIPTION];
        dataItem.createdBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_MODIFIEDON];
        dataItem.isActive =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYCONTACT_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISDELETED];
        dataItem.isArchived =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_ISARCHIVED];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_OPPORTUNITYCONTACT_REFERENCEIDENTIFIER];
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
          "OpportunityContactDataHandlerBase:GetOpportunityContactUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
