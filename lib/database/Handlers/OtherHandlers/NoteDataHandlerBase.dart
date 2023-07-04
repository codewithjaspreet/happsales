import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Note.dart';
import '../DataBaseHandler.dart';

class NoteDataHandlerBase {
  static Future<List<Note>> GetNoteRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId) async {
    List<Note> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTE_NOTECONTENT} LIKE '%${searchString.replaceAll("'", "''")}%'";

      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_NOTE_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = $opportunityId";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Note_Columns.KEY_NOTE_NOTECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Note>> GetNoteRecordsPaged2(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Note> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_NOTE_NOTECONTENT} LIKE '%${searchString.replaceAll("'", "''")}"}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Note_Columns.KEY_NOTE_NOTECODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Note>> GetNoteRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Note> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},H.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} H ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_NOTE_NOTETITLE} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_NOTE_NOTETITLE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Note?> GetNoteRecord(
      DatabaseHandler databaseHandler, String id) async {
    Note? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},H.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} H ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Note?> GetMasterNoteRecord(
      DatabaseHandler databaseHandler, String id) async {
    Note? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},H.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} H ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTE_NOTEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetMasterNoteRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddNoteRecord(
      DatabaseHandler databaseHandler, Note dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.noteID != null && dataItem.noteID != "null")
        values[ColumnsBase.KEY_NOTE_NOTEID] = dataItem.noteID;
      if (dataItem.noteCode != null && dataItem.noteCode != "null")
        values[ColumnsBase.KEY_NOTE_NOTECODE] = dataItem.noteCode;
      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_NOTE_ACCOUNTID] = dataItem.accountID;
      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_NOTE_CONTACTID] = dataItem.contactID;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_NOTE_OPPORTUNITYID] = dataItem.opportunityID;
      if (dataItem.activityID != null && dataItem.activityID != "null")
        values[ColumnsBase.KEY_NOTE_ACTIVITYID] = dataItem.activityID;
      if (dataItem.opportunityStageID != null &&
          dataItem.opportunityStageID != "null")
        values[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID] =
            dataItem.opportunityStageID;
      if (dataItem.isPersonal != null && dataItem.isPersonal != "null")
        values[ColumnsBase.KEY_NOTE_ISPERSONAL] = dataItem.isPersonal;
      if (dataItem.noteTitle != null && dataItem.noteTitle != "null")
        values[ColumnsBase.KEY_NOTE_NOTETITLE] = dataItem.noteTitle;
      if (dataItem.noteDate != null && dataItem.noteDate != "null")
        values[ColumnsBase.KEY_NOTE_NOTEDATE] = dataItem.noteDate;
      if (dataItem.noteContent != null && dataItem.noteContent != "null")
        values[ColumnsBase.KEY_NOTE_NOTECONTENT] = dataItem.noteContent;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_NOTE_TAGS] = dataItem.tags;
      if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD1] = dataItem.freeTextField1;
      if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD2] = dataItem.freeTextField2;
      if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD3] = dataItem.freeTextField3;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_NOTE_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_NOTE_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_NOTE_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_NOTE_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_NOTE_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_NOTE_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_NOTE_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_NOTE_APPUSERGROUPID] = dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_NOTE_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_NOTE_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_NOTE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddNoteRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateNoteRecord(
      DatabaseHandler databaseHandler, String id1, Note dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = {};

      if (dataItem.noteID != null && dataItem.noteID != "null")
        values[ColumnsBase.KEY_NOTE_NOTEID] = dataItem.noteID;
      if (dataItem.noteCode != null && dataItem.noteCode != "null")
        values[ColumnsBase.KEY_NOTE_NOTECODE] = dataItem.noteCode;
      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_NOTE_ACCOUNTID] = dataItem.accountID;
      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_NOTE_CONTACTID] = dataItem.contactID;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_NOTE_OPPORTUNITYID] = dataItem.opportunityID;
      if (dataItem.activityID != null && dataItem.activityID != "null")
        values[ColumnsBase.KEY_NOTE_ACTIVITYID] = dataItem.activityID;
      if (dataItem.opportunityStageID != null &&
          dataItem.opportunityStageID != "null")
        values[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID] =
            dataItem.opportunityStageID;
      if (dataItem.isPersonal != null && dataItem.isPersonal != "null")
        values[ColumnsBase.KEY_NOTE_ISPERSONAL] = dataItem.isPersonal;
      if (dataItem.noteTitle != null && dataItem.noteTitle != "null")
        values[ColumnsBase.KEY_NOTE_NOTETITLE] = dataItem.noteTitle;
      if (dataItem.noteDate != null && dataItem.noteDate != "null")
        values[ColumnsBase.KEY_NOTE_NOTEDATE] = dataItem.noteDate;
      if (dataItem.noteContent != null && dataItem.noteContent != "null")
        values[ColumnsBase.KEY_NOTE_NOTECONTENT] = dataItem.noteContent;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_NOTE_TAGS] = dataItem.tags;
      if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD1] = dataItem.freeTextField1;
      if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD2] = dataItem.freeTextField2;
      if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null")
        values[ColumnsBase.KEY_NOTE_FREETEXTFIELD3] = dataItem.freeTextField3;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_NOTE_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_NOTE_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_NOTE_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_NOTE_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_NOTE_ISACTIVE] = dataItem.isActive;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_NOTE_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_NOTE_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_NOTE_APPUSERGROUPID] = dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_NOTE_ISARCHIVED] = dataItem.isArchived;
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_NOTE_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_NOTE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateNoteRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteNoteRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_NOTE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:DeleteNoteRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<String> GetServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_NOTE_NOTEID}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase.KEY_NOTE_NOTEID].toString();
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTE_NOTEID} = $id";

      final db = await databaseHandler.database;

      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.isNotEmpty) {
        localId = result[0][ColumnsBase.KEY_NOTE_NOTEID].toString();
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<Note>> GetNoteUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<Note> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_NOTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_NOTE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
                Globals.SyncIndex.toString();
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Note?> GetNoteRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Note? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},H.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} H ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_NOTE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
      //selectQuery += " AND A." + ColumnsBase.KEY_NOTE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<List<Note>> GetSearchNoteRecords(
      DatabaseHandler databaseHandler,
      String accountId,
      String contactId,
      String opportunityId,
      String activityId,
      String searchString) async {
    List<Note> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE}";
      selectQuery += " FROM ${TablesBase.TABLE_NOTE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_NOTE_CONTACTID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_NOTE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_NOTE_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTE_NOTECONTENT} LIKE '${searchString.replaceAll("'", "''")}%'";

      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_NOTE_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_NOTE_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTE_OPPORTUNITYID} = $opportunityId";

      if (Globals.isIntegerString(activityId))
        selectQuery +=
            " AND A.${ColumnsBase.KEY_NOTE_ACTIVITYID} = $activityId";

      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_NOTE_NOTECODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);
      for (var element in list) {
        Note dataItem = Note();
        dataItem.noteID = element[ColumnsBase.KEY_NOTE_NOTEID];
        dataItem.noteCode = element[ColumnsBase.KEY_NOTE_NOTECODE];
        dataItem.accountID = element[ColumnsBase.KEY_NOTE_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_NOTE_CONTACTID];
        dataItem.opportunityID = element[ColumnsBase.KEY_NOTE_OPPORTUNITYID];
        dataItem.activityID = element[ColumnsBase.KEY_NOTE_ACTIVITYID];
        dataItem.opportunityStageID =
            element[ColumnsBase.KEY_NOTE_OPPORTUNITYSTAGEID];
        dataItem.isPersonal = element[ColumnsBase.KEY_NOTE_ISPERSONAL];
        dataItem.noteTitle = element[ColumnsBase.KEY_NOTE_NOTETITLE];
        dataItem.noteDate = element[ColumnsBase.KEY_NOTE_NOTEDATE];
        dataItem.noteContent = element[ColumnsBase.KEY_NOTE_NOTECONTENT];
        dataItem.tags = element[ColumnsBase.KEY_NOTE_TAGS];
        dataItem.freeTextField1 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD1];
        dataItem.freeTextField2 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD2];
        dataItem.freeTextField3 = element[ColumnsBase.KEY_NOTE_FREETEXTFIELD3];
        dataItem.createdBy = element[ColumnsBase.KEY_NOTE_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_NOTE_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_NOTE_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_NOTE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_NOTE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_NOTE_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_NOTE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_NOTE_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_NOTE_APPUSERID];
        dataItem.appUserGroupID = element[ColumnsBase.KEY_NOTE_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_NOTE_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_NOTE_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

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

        // Add the dataItem to your desired collection or perform any other necessary operations
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("NoteDataHandlerBase:GetNoteRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
