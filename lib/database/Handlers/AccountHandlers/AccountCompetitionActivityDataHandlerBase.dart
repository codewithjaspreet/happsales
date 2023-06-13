import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountCompetitionActivity.dart';
import '../DataBaseHandler.dart';

class AccountCompetitionActivityDataHandlerBase {
  static Future<List<AccountCompetitionActivity>>
      GetAccountCompetitionActivityRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<AccountCompetitionActivity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountCompetitionActivity_Columns.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountCompetitionActivity>>
      GetAccountCompetitionActivityRecords(
          DatabaseHandler databaseHandler, String searchString) async {
    List<AccountCompetitionActivity> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME} LIKE '$searchString%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountCompetitionActivity?>
      GetAccountCompetitionActivityRecord(
          DatabaseHandler databaseHandler, String id) async {
    AccountCompetitionActivity? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountCompetitionActivity?>
      GetAccountCompetitionActivityRecordByUid(
          DatabaseHandler databaseHandler, String uid) async {
    AccountCompetitionActivity? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      //Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountCompetitionActivity?>
      GetMasterAccountCompetitionActivityRecord(
          DatabaseHandler databaseHandler, String id) async {
    AccountCompetitionActivity? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} E ON A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetMasterAccountCompetitionActivityRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAccountCompetitionActivityRecord(
      DatabaseHandler databaseHandler,
      AccountCompetitionActivity dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = new Map();

      if (dataItem.accountCompetitionActivityID != null &&
          dataItem.accountCompetitionActivityID != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID] =
            dataItem.accountCompetitionActivityID;
      }

      if (dataItem.accountCompetitionActivityCode != null &&
          dataItem.accountCompetitionActivityCode != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE] =
            dataItem.accountCompetitionActivityCode;
      }

      if (dataItem.competitionActivity != null &&
          dataItem.competitionActivity != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY] =
            dataItem.competitionActivity;
      }

      if (dataItem.accountID != null && dataItem.accountID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID] =
            dataItem.accountID;
      }

      if (dataItem.opportunityID != null &&
          dataItem.opportunityID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID] =
            dataItem.opportunityID;
      }

      if (dataItem.competitorName != null &&
          dataItem.competitorName != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME] =
            dataItem.competitorName;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE] =
            dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.insert(TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY, values);
      //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "DatabaseHandler:AddAccountCompetitionActivityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountCompetitionActivityRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AccountCompetitionActivity dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = new Map();

      if (dataItem.accountCompetitionActivityID != null &&
          dataItem.accountCompetitionActivityID != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID] =
            dataItem.accountCompetitionActivityID;
      }

      if (dataItem.accountCompetitionActivityCode != null &&
          dataItem.accountCompetitionActivityCode != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE] =
            dataItem.accountCompetitionActivityCode;
      }

      if (dataItem.competitionActivity != null &&
          dataItem.competitionActivity != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY] =
            dataItem.competitionActivity;
      }

      if (dataItem.accountID != null && dataItem.accountID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID] =
            dataItem.accountID;
      }

      if (dataItem.opportunityID != null &&
          dataItem.opportunityID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID] =
            dataItem.opportunityID;
      }

      if (dataItem.competitorName != null &&
          dataItem.competitorName != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME] =
            dataItem.competitorName;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY] =
            dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON] =
            dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY] =
            dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON] =
            dataItem.modifiedOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isActive != null && dataItem.isActive != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE] =
            dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID] =
            dataItem.appUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED] =
            dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != ("null")) {
        values[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED] =
            dataItem.isDeleted;
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

      id = await db.update(TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "DatabaseHandler:UpdateAccountCompetitionActivityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAccountCompetitionActivityRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "DatabaseHandler:DeleteAccountCompetitionActivityRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0][ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID]
            .toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0][ColumnsBase
                .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID]
            .toString();
      }
      //db.close();
    } catch (ex) {
      //    Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountCompetitionActivity>>
      GetAccountCompetitionActivityUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<AccountCompetitionActivity> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " +
              Globals.SyncIndex.toString();
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCOMPETITIONACTIVITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " +
          Globals.AppUserID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID} = " +
              Globals.AppUserGroupID.toString();
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        AccountCompetitionActivity dataItem = new AccountCompetitionActivity();

        dataItem.accountCompetitionActivityID = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYID];
        dataItem.accountCompetitionActivityCode = element[ColumnsBase
            .KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTCOMPETITIONACTIVITYCODE];
        dataItem.competitionActivity = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITIONACTIVITY];
        dataItem.accountID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ACCOUNTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_OPPORTUNITYID];
        dataItem.competitorName =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_COMPETITORNAME];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier = element[
            ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_REFERENCEIDENTIFIER];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCOMPETITIONACTIVITY_ISDELETED];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
      //  Globals.HandleException(context, "AccountCompetitionActivityDataHandlerBase:GetAccountCompetitionActivityUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }
}
