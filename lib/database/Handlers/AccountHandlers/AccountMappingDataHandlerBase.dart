/*************************************************************************
 *
 * HAPPSALES CONFIDENTIAL
 * ____________________________________
 *
 *  [2019-23] HappSales Private Limited
 *  www.happsales.com
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains the property of HappSales Private Limited.
 * The intellectual and technical concepts contained herein are proprietary to HappSales Private Limited
 * and  are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material is strictly forbidden unless prior
 * written permission is obtained from HappSales Private Limited.
 */
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountCategoryMapping.dart';
import '../DataBaseHandler.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : AccountCategoryMappingDataHandlerBase
// Created By    : Vijay Kumar Vettath
// Created Date  : Oct-2019
// Purpose       : Class containing the base data handler methods for AccountCategoryMapping table.
// Details       :
// Change History:-
// Date:
// Author:
// Change:
//////////////////////////////////////////////////////////////////////////////////////////////////

class AccountCategoryMappingDataHandlerBase {
  static Future<List<AccountCategoryMapping>>
      GetAccountCategoryMappingRecordsPaged(
          DatabaseHandler databaseHandler,
          String searchString,
          String sortColumn,
          String sortDirection,
          Map<String, String> filterHashMap,
          int pageIndex,
          int pageSize) async {
    List<AccountCategoryMapping> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountCategoryMapping_Columns.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(accountCategoryMapping);
      }
      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetAccountCategoryMappingRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountCategoryMapping>> GetAccountCategoryMappingRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountCategoryMapping> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
        dataList.add(accountCategoryMapping);
      } //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetAccountCategoryMappingRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountCategoryMapping?> GetAccountCategoryMappingRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountCategoryMapping? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetAccountCategoryMappingRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<AccountCategoryMapping?> GetMasterAccountCategoryMappingRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountCategoryMapping? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
      }
      //db.close();
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetMasterAccountCategoryMappingRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddAccountCategoryMappingRecord(
      DatabaseHandler databaseHandler, AccountCategoryMapping dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = Map<String, dynamic>();

      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID] =
            dataItem.accountCategoryID;
      }

      if (dataItem.accountCategoryMappingCode != null &&
          dataItem.accountCategoryMappingCode != "null") {
        values[ColumnsBase
                .KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE] =
            dataItem.accountCategoryMappingCode;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID] =
            dataItem.accountID;
      }
      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID] =
            dataItem.accountCategoryID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED] =
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
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;

      values[ColumnsBase.KEY_ISACTIVE] = "true";

      values[ColumnsBase.KEY_ISDELETED] = "false";

      id = await db.insert(TablesBase.TABLE_ACCOUNTCATEGORYMAPPING, values);
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "DatabaseHandler:AddAccountCategoryMappingRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountCategoryMappingRecord(
      DatabaseHandler databaseHandler,
      String id1,
      AccountCategoryMapping dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = Map<String, dynamic>();

      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != ("null")) {
        values[ColumnsBase
                .KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID] =
            dataItem.accountCategoryID;
      }

      if (dataItem.accountCategoryMappingCode != null &&
          dataItem.accountCategoryMappingCode != "null") {
        values[ColumnsBase
                .KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE] =
            dataItem.accountCategoryMappingCode;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID] =
            dataItem.accountID;
      }
      if (dataItem.accountCategoryID != null &&
          dataItem.accountCategoryID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID] =
            dataItem.accountCategoryID;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY] =
            dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON] =
            dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY] =
            dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON] =
            dataItem.modifiedOn;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE] =
            dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID] =
            dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED] =
            dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED] =
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
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      }
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      }

      id = await db.update(TablesBase.TABLE_ACCOUNTCATEGORYMAPPING, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "DatabaseHandler:UpdateAccountCategoryMappingRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> DeleteAccountCategoryMappingRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACCOUNTCATEGORYMAPPING,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      //   Globals.HandleException(context, "DatabaseHandler:DeleteAccountCategoryMappingRecord()", ex);
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
          "SELECT A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        serverId = result[0]
            [ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetServerId()", ex);
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID} = $id";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        localId = result[0]
            [ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountCategoryMapping>>
      GetAccountCategoryMappingUpSyncRecords(
          DatabaseHandler databaseHandler, String changeType) async {
    List<AccountCategoryMapping> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCATEGORYMAPPING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACCOUNTCATEGORYMAPPING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
      }
      //db.close();
    } catch (ex) {
      //  Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetAccountCategoryMappingUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountCategoryMapping?> GetAccountCategoryMappingRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountCategoryMapping? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,C.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} C ON A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> res = await db.rawQuery(selectQuery, null);

      for (var element in res) {
        AccountCategoryMapping accountCategoryMapping =
            AccountCategoryMapping();

        accountCategoryMapping.accountCategoryID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingID = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGID];
        accountCategoryMapping.accountCategoryMappingCode = element[
            ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYMAPPINGCODE];
        accountCategoryMapping.accountID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID];
        accountCategoryMapping.accountCategoryID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID];
        accountCategoryMapping.createdBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDBY];
        accountCategoryMapping.createdOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_CREATEDON];
        accountCategoryMapping.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDBY];
        accountCategoryMapping.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_MODIFIEDON];
        accountCategoryMapping.isActive =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISACTIVE];
        accountCategoryMapping.uid =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_UID];
        accountCategoryMapping.appUserID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERID];
        accountCategoryMapping.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID];
        accountCategoryMapping.isArchived =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISARCHIVED];
        accountCategoryMapping.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ISDELETED];
        accountCategoryMapping.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountCategoryMapping.accountCategoryName =
            element[ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME];

        accountCategoryMapping.id = element[ColumnsBase.KEY_ID];
        accountCategoryMapping.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        accountCategoryMapping.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        accountCategoryMapping.upSyncMessage =
            element[ColumnsBase.KEY_UPSYNCMESSAGE];

        accountCategoryMapping.downSyncMessage =
            element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        accountCategoryMapping.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        accountCategoryMapping.sModifiedOn =
            element[ColumnsBase.KEY_SMODIFIEDON];

        accountCategoryMapping.createdByUser =
            element[ColumnsBase.KEY_CREATEDBYUSER];
        accountCategoryMapping.modifiedByUser =
            element[ColumnsBase.KEY_MODIFIEDBYUSER];
        accountCategoryMapping.ownerUserID =
            element[ColumnsBase.KEY_OWNERUSERID];
      }
    } catch (ex) {
      //Globals.HandleException(context, "AccountCategoryMappingDataHandlerBase:GetAccountCategoryMappingRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
