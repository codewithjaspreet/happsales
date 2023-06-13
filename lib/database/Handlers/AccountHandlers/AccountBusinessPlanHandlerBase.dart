import 'package:happsales_crm/database/models/AccountModels/AccountAddress.dart';
import 'package:happsales_crm/database/models/AccountModels/AccountBusinessPlan.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../Models/BaseEntity.dart';
import '../DataBaseHandler.dart';
import 'AccountAddressDataHandlerBase.dart';

class AccountBusinessPlanDataHandler extends AccountAddressDataHandlerBase {

  static Future<List<AccountBusinessPlan>> GetAccountBusinessPlanRecordsPaged(
      DatabaseHandler databaseHandler,
      String accountId,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountBusinessPlan> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS} LIKE '%$searchString%'";
      }
      if (Globals.isIntegerString(accountId)) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} = $accountId";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountBusinessPlan_Columns.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountBusinessPlan accountBusinessPlan = AccountBusinessPlan();

        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(accountBusinessPlan);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountBusinessPlan>> GetAccountBusinessPlanRecordsPaged2(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountBusinessPlan> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
      selectQuery += "${" FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN}"} A ";
      selectQuery +=
          "${"${" LEFT JOIN ${TablesBase.TABLE_ACCOUNT}"} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID}"} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          "${" AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED}"},'false')) = 'false' ";
      selectQuery +=
          "${" AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE}"},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS}"} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountBusinessPlan_Columns.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountBusinessPlan accountBusinessPlan = AccountBusinessPlan();

        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(accountBusinessPlan);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountBusinessPlan>> GetAccountBusinessPlanRecords(
    DatabaseHandler databaseHandler,
    String searchString,
  ) async {
    List<AccountBusinessPlan> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountBusinessPlan accountBusinessPlan = AccountBusinessPlan();

        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(accountBusinessPlan);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountBusinessPlan?> GetAccountBusinessPlanRecords2(
      DatabaseHandler databaseHandler, String id) async {
    AccountBusinessPlan? accountBusinessPlan;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountBusinessPlan = AccountBusinessPlan();
        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountBusinessPlan;
  }

  static Future<AccountBusinessPlan?> GetMasterAccountBusinessPlanRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountBusinessPlan? accountBusinessPlan;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountBusinessPlan = AccountBusinessPlan();
        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountBusinessPlan;
  }

  static Future<int> AddAccountBusinessPlanRecord(
      DatabaseHandler databaseHandler, AccountBusinessPlan dataItem) async {
    int id;
    try {
      final db = await databaseHandler.database;
      final values = <String, dynamic>{};

      if (dataItem.accountBusinessPlanID != null &&
          dataItem.accountBusinessPlanID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID] =
            dataItem.accountBusinessPlanID;
      }
      if (dataItem.accountBusinessPlanCode != null &&
          dataItem.accountBusinessPlanCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE] =
            dataItem.accountBusinessPlanCode;
      }
      if (dataItem.businessPlans != null && dataItem.businessPlans != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS] =
            dataItem.businessPlans;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID] =
            dataItem.accountID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED] =
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

            id = await  db.insert(TablesBase.TABLE_ACCOUNTBUSINESSPLAN, values);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }

    return id;
  }

  static Future<int> UpdateBusinessPlanRecord(
      DatabaseHandler databaseHandler, AccountBusinessPlan dataItem , String id1) async {
    int id;
    try {
      final db = await databaseHandler.database;
      final values = <String, dynamic>{};

      if (dataItem.accountBusinessPlanID != null &&
          dataItem.accountBusinessPlanID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID] =
            dataItem.accountBusinessPlanID;
      }
      if (dataItem.accountBusinessPlanCode != null &&
          dataItem.accountBusinessPlanCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE] =
            dataItem.accountBusinessPlanCode;
      }
      if (dataItem.businessPlans != null && dataItem.businessPlans != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS] =
            dataItem.businessPlans;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID] =
            dataItem.accountID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED] =
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

            id = await  db.update(TablesBase.TABLE_ACCOUNTBUSINESSPLAN,values , where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }

    return id;
  }
  
  static Future<int> DeleteBusinessPlanRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(
        TablesBase.TABLE_ACCOUNTBUSINESSPLAN,

        // Use a `where` clause to delete a specific account by id.
        where: "${ColumnsBase.KEY_ID} = $id1",

        whereArgs: [null],
      ); //db.close();
    } catch (ex) {
      //    Globals.HandleException(context, "DatabaseHandler:DeleteAccountAddressRecord()", ex);
      throw ex;
    }
    return id;
  }

  Future<String> getServerId(DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

        String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        serverId = result.first[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID].toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.handleException(context, "AccountDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
    String localId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);
      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        localId = result.first[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID].toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.handleException(context, "AccountDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return localId;
  }


  static Future<List<AccountBusinessPlan>> GetAccountBusinessPlanUpSyncRecords(
    DatabaseHandler databaseHandler,
    String changeType,
  ) async {
    List<AccountBusinessPlan> dataList = [];
    try {
     String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNTBUSINESSPLAN} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTBUSINESSPLAN + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTBUSINESSPLAN + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountBusinessPlan accountBusinessPlan = AccountBusinessPlan();

        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(accountBusinessPlan);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }


  static Future<AccountBusinessPlan?> GetAccountBusinessPlanRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountBusinessPlan? accountBusinessPlan;
    try {
     String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_ACCOUNTBUSINESSPLAN + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountBusinessPlan = AccountBusinessPlan();
        accountBusinessPlan.accountBusinessPlanID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANID];
        accountBusinessPlan.accountBusinessPlanCode = element[
            ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTBUSINESSPLANCODE];
        accountBusinessPlan.businessPlans =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_BUSINESSPLANS];
        accountBusinessPlan.accountID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ACCOUNTID];
        accountBusinessPlan.customerTargetDate =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CUSTOMERTARGETDATE];
        accountBusinessPlan.createdOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDON];
        accountBusinessPlan.createdBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_CREATEDBY];
        accountBusinessPlan.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDON];
        accountBusinessPlan.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_MODIFIEDBY];
        accountBusinessPlan.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_DEVICEIDENTIFIER];
        accountBusinessPlan.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_REFERENCEIDENTIFIER];
        accountBusinessPlan.isActive =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISACTIVE];
        accountBusinessPlan.uid =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_UID];
        accountBusinessPlan.appUserID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERID];
        accountBusinessPlan.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_APPUSERGROUPID];
        accountBusinessPlan.isArchived =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISARCHIVED];
        accountBusinessPlan.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTBUSINESSPLAN_ISDELETED];
        accountBusinessPlan.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

        accountBusinessPlan.id = element[ColumnsBase.KEY_ID];
        accountBusinessPlan.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountBusinessPlan.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountBusinessPlan.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];
        accountBusinessPlan.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountBusinessPlan.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountBusinessPlan.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        accountBusinessPlan.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountBusinessPlan.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountBusinessPlan.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountBusinessPlan;
  }

    
}
