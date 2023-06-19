import 'dart:ffi';

import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityTravelExpense.dart';
import '../DataBaseHandler.dart';

class ActivityTravelExpenseDataHandlerBase {
  static Future<List<ActivityTravelExpense>>
      GetActivityTravelExpenseRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<ActivityTravelExpense> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityTravelExpense_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityTravelExpense_Columns.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseRecordsPaged()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ActivityTravelExpense>> GetActivityTravelExpenseRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<ActivityTravelExpense> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE},'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ActivityTravelExpense_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE} LIKE '${searchString.replaceAll("'", "''")}"}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<ActivityTravelExpense?> GetActivityTravelExpenseRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityTravelExpense? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityTravelExpense?> GetActivityTravelExpenseRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    ActivityTravelExpense? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseRecordByUid()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<ActivityTravelExpense?> GetMasterActivityTravelExpenseRecord(
      DatabaseHandler databaseHandler, String id) async {
    ActivityTravelExpense? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE},E.${ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME},F.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTRAVEL} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_EXPENSETYPE} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} F ON A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetMasterActivityTravelExpenseRecord()",
          ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddActivityTravelExpenseRecord(
      DatabaseHandler databaseHandler, ActivityTravelExpense dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map<String, dynamic>();
      if (dataItem.activityTravelExpenseID != null &&
          dataItem.activityTravelExpenseID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID] =
            dataItem.activityTravelExpenseID;
      }
      if (dataItem.activityTravelExpenseCode != null &&
          dataItem.activityTravelExpenseCode != "null") {
        values[ColumnsBase
                .KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE] =
            dataItem.activityTravelExpenseCode;
      }
      if (dataItem.activityTravelExpenseTitle != null &&
          dataItem.activityTravelExpenseTitle != "null") {
        values[ColumnsBase
                .KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE] =
            dataItem.activityTravelExpenseTitle;
      }
      if (dataItem.activityTravelID != null &&
          dataItem.activityTravelID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID] =
            dataItem.activityTravelID;
      }
      if (dataItem.expenseTypeID != null && dataItem.expenseTypeID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID] =
            dataItem.expenseTypeID;
      }
      if (dataItem.distanceTravelled != null &&
          dataItem.distanceTravelled != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED] =
            dataItem.distanceTravelled;
      }
      if (dataItem.modeOfTravelID != null &&
          dataItem.modeOfTravelID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID] =
            dataItem.modeOfTravelID;
      }
      if (dataItem.amount != null && dataItem.amount != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT] = dataItem.amount;
      }
      if (dataItem.remarks != null && dataItem.remarks != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS] =
            dataItem.remarks;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED] =
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

      id = await db.insert(TablesBase.TABLE_ACTIVITYTRAVELEXPENSE, values);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:AddActivityTravelExpenseRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateActivityTravelExpenseRecord(
      DatabaseHandler databaseHandler,
      String id1,
      ActivityTravelExpense dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map<String, dynamic>();
      if (dataItem.activityTravelExpenseID != null &&
          dataItem.activityTravelExpenseID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID] =
            dataItem.activityTravelExpenseID;
      }
      if (dataItem.activityTravelExpenseCode != null &&
          dataItem.activityTravelExpenseCode != "null") {
        values[ColumnsBase
                .KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE] =
            dataItem.activityTravelExpenseCode;
      }
      if (dataItem.activityTravelExpenseTitle != null &&
          dataItem.activityTravelExpenseTitle != "null") {
        values[ColumnsBase
                .KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE] =
            dataItem.activityTravelExpenseTitle;
      }
      if (dataItem.activityTravelID != null &&
          dataItem.activityTravelID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID] =
            dataItem.activityTravelID;
      }
      if (dataItem.expenseTypeID != null && dataItem.expenseTypeID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID] =
            dataItem.expenseTypeID;
      }
      if (dataItem.distanceTravelled != null &&
          dataItem.distanceTravelled != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED] =
            dataItem.distanceTravelled;
      }
      if (dataItem.modeOfTravelID != null &&
          dataItem.modeOfTravelID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID] =
            dataItem.modeOfTravelID;
      }
      if (dataItem.amount != null && dataItem.amount != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT] = dataItem.amount;
      }
      if (dataItem.remarks != null && dataItem.remarks != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS] =
            dataItem.remarks;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.location != null && dataItem.location != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION] =
            dataItem.location;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED] =
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

      id = await db.update(TablesBase.TABLE_ACTIVITYTRAVELEXPENSE, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:UpdateActivityTravelExpenseRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteActivityTravelExpenseRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITYTRAVELEXPENSE,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "DatabaseHandler:DeleteActivityTravelExpenseRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        serverId = result[0]
                [ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID]
            .toString();
      }

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ActivityTravelExpenseDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID} = $id";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        localId = result[0]
                [ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID]
            .toString();
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityTravelExpenseDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<ActivityTravelExpense>>
      GetActivityTravelExpenseUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<ActivityTravelExpense> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
        selectQuery =
            "SELECT * FROM ${TablesBase.TABLE_ACTIVITYTRAVELEXPENSE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      }
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravelExpense dataItem = new ActivityTravelExpense();

        dataItem.activityTravelExpenseID = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSEID];
        dataItem.activityTravelExpenseCode = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSECODE];
        dataItem.activityTravelExpenseTitle = element[
            ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELEXPENSETITLE];
        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ACTIVITYTRAVELID];
        dataItem.expenseTypeID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_EXPENSETYPEID];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODEOFTRAVELID];
        dataItem.amount = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_AMOUNT];
        dataItem.remarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REMARKS];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDBY];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_REFERENCEIDENTIFIER];
        dataItem.location =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_LOCATION];
        dataItem.isActive =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISARCHIVED];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYTRAVELEXPENSE_ISDELETED];

        dataItem.ActivityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.ExpenseTypeName =
            element[ColumnsBase.KEY_EXPENSETYPE_EXPENSETYPENAME];
        dataItem.ModeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];

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
          "ActivityTravelExpenseDataHandlerBase:GetActivityTravelExpenseUpSyncRecords()",
          ex);
      throw ex;
    }
    return dataList;
  }
}
