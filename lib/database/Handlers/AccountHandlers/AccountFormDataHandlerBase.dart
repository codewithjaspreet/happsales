import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountForm.dart';
import '../DataBaseHandler.dart';

class AccountFormDataHandlerBase {
  static Future<List<AccountForm>> GetAccountFormRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountForm> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTFORM_FILENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountForm_Columns.KEY_ACCOUNTFORM_FILENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountForm>> GetAccountFormRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountForm> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTFORM_FILENAME} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTFORM_FILENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountForm?> GetAccountFormRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountForm? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountForm?> GetMasterAccountFormRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountForm? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      //  Globals.HandleException(context, "AccountFormDataHandlerBase:GetMasterAccountFormRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAccountFormRecord(
      DatabaseHandler databaseHandler, AccountForm dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map();

      if (dataItem.accountFormID != null &&
          dataItem.accountFormID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID] =
            dataItem.accountFormID;
      }

      if (dataItem.accountFormCode != null &&
          dataItem.accountFormCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE] =
            dataItem.accountFormCode;
      }
      if (dataItem.accountFormTitle != null &&
          dataItem.accountFormTitle != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE] =
            dataItem.accountFormTitle;
      }
      if (dataItem.formID != null && dataItem.formID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FORMID] = dataItem.formID;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID] = dataItem.accountID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID] = dataItem.contactID;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID] = dataItem.activityID;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.fileName != null && dataItem.fileName != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FILENAME] = dataItem.fileName;
      }
      if (dataItem.fileUrl != null && dataItem.fileUrl != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FILEURL] = dataItem.fileUrl;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED] = dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_ACCOUNTFORM, values);
//db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:AddAccountFormRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountFormRecord(
      DatabaseHandler databaseHandler, String id1, AccountForm dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = Map();

      if (dataItem.accountFormID != null &&
          dataItem.accountFormID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID] =
            dataItem.accountFormID;
      }

      if (dataItem.accountFormCode != null &&
          dataItem.accountFormCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE] =
            dataItem.accountFormCode;
      }
      if (dataItem.accountFormTitle != null &&
          dataItem.accountFormTitle != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE] =
            dataItem.accountFormTitle;
      }
      if (dataItem.formID != null && dataItem.formID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FORMID] = dataItem.formID;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID] = dataItem.accountID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID] = dataItem.contactID;
      }
      if (dataItem.activityID != null && dataItem.activityID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID] = dataItem.activityID;
      }
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID] =
            dataItem.opportunityID;
      }
      if (dataItem.fileName != null && dataItem.fileName != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FILENAME] = dataItem.fileName;
      }
      if (dataItem.fileUrl != null && dataItem.fileUrl != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_FILEURL] = dataItem.fileUrl;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED] = dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_ACCOUNTFORM, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "DatabaseHandler:UpdateAccountFormRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAccountFormRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACCOUNTFORM,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "DatabaseHandler:DeleteAccountFormRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId =
            result[0][ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID].toString();
      }
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "AccountFormDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId =
            result[0][ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID].toString();
      }
    } catch (ex) {
      //Globals.HandleException(context, "AccountFormDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountForm>> GetAccountFormUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<AccountForm> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTFORM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTFORM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTFORM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountForm?> GetAccountFormRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountForm? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_FORM_FORMNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},G.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTFORM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_FORM} F ON A.${ColumnsBase.KEY_ACCOUNTFORM_FORMID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} G ON A.${ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTFORM_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      for (var element in result) {
        AccountForm dataItem = new AccountForm();
        dataItem.accountFormID =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMID];
        dataItem.accountFormCode =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMCODE];
        dataItem.accountFormTitle =
            element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTFORMTITLE];
        dataItem.formID = element[ColumnsBase.KEY_ACCOUNTFORM_FORMID];
        dataItem.accountID = element[ColumnsBase.KEY_ACCOUNTFORM_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACCOUNTFORM_CONTACTID];
        dataItem.activityID = element[ColumnsBase.KEY_ACCOUNTFORM_ACTIVITYID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTFORM_OPPORTUNITYID];
        dataItem.fileName = element[ColumnsBase.KEY_ACCOUNTFORM_FILENAME];
        dataItem.fileUrl = element[ColumnsBase.KEY_ACCOUNTFORM_FILEURL];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNTFORM_CREATEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNTFORM_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNTFORM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTFORM_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTFORM_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNTFORM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNTFORM_ISDELETED];
        dataItem.formName = element[ColumnsBase.KEY_FORM_FORMNAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
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
      // Globals.HandleException(context, "AccountFormDataHandlerBase:GetAccountFormRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
