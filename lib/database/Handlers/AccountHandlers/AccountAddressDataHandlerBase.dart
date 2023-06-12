import 'dart:ffi';

import 'package:happsales_crm/database/models/BaseEntity.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/AccountModels/AccountAddress.dart';
import '../DataBaseHandler.dart';

class AccountAddressDataHandlerBase {
  
  static Future<List<AccountAddress>> GetAccountAddressRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<AccountAddress> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AccountAddress_Columns.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountAddress accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(accountAddress);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<AccountAddress>> GetAccountAddressRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountAddress> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          "${" LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID}"} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          "${" LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID}"} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          "${" AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED}"},'false')) = 'false' ";
      selectQuery +=
          "${" AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE}"},'true')) = 'true' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} LIKE '$searchString%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountAddress accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(accountAddress);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountAddress?> GetAccountAddressRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountAddress? accountAddress;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountAddress;
  }

  static Future<AccountAddress?> GetMasterAccountAddressRecord(
      DatabaseHandler databaseHandler, String id) async {
    AccountAddress? accountAddress;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountAddress;
  }

  static Future<int> AddAccountAddressRecord(
      DatabaseHandler databaseHandler, AccountAddress dataItem) async {
    int id;
    try {
      final db = await databaseHandler.database;
      final values = <String, dynamic>{};

      if (dataItem.accountAddressID != null &&
          dataItem.accountAddressID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID] =
            dataItem.accountAddressID;
      }
      if (dataItem.accountAddressCode != null &&
          dataItem.accountAddressCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE] =
            dataItem.accountAddressCode;
      }
      if (dataItem.addressTypeName != null &&
          dataItem.addressTypeName != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME] =
            dataItem.addressTypeName;
      }
      if (dataItem.addressLine1 != null && dataItem.addressLine1 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1] =
            dataItem.addressLine1;
      }
      if (dataItem.addressLine2 != null && dataItem.addressLine2 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2] =
            dataItem.addressLine2;
      }
      if (dataItem.addressLine3 != null && dataItem.addressLine3 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3] =
            dataItem.addressLine3;
      }
      if (dataItem.city != null && dataItem.city != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CITY] = dataItem.city;
      }
      if (dataItem.state != null && dataItem.state != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_STATE] = dataItem.state;
      }
      if (dataItem.country != null && dataItem.country != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY] = dataItem.country;
      }
      if (dataItem.pin != null && dataItem.pin != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_PIN] = dataItem.pin;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID] = dataItem.accountID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID] = dataItem.contactID;
      }
      if (dataItem.gpsCoordinates != null &&
          dataItem.gpsCoordinates != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES] =
            dataItem.gpsCoordinates;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED] = dataItem.isDeleted;
      }
      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
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

      id = await db.insert(TablesBase.TABLE_ACCOUNTADDRESS, values);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }

    return id;
  }

  static Future<int> UpdateAccountAddressRecord(DatabaseHandler databaseHandler,
      String id1, AccountAddress dataItem) async {
    int id;
    try {
      final db = await databaseHandler.database;
      final values = <String, dynamic>{};

      if (dataItem.accountAddressID != null &&
          dataItem.accountAddressID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID] =
            dataItem.accountAddressID;
      }
      if (dataItem.accountAddressCode != null &&
          dataItem.accountAddressCode != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE] =
            dataItem.accountAddressCode;
      }
      if (dataItem.addressTypeName != null &&
          dataItem.addressTypeName != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME] =
            dataItem.addressTypeName;
      }
      if (dataItem.addressLine1 != null && dataItem.addressLine1 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1] =
            dataItem.addressLine1;
      }
      if (dataItem.addressLine2 != null && dataItem.addressLine2 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2] =
            dataItem.addressLine2;
      }
      if (dataItem.addressLine3 != null && dataItem.addressLine3 != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3] =
            dataItem.addressLine3;
      }
      if (dataItem.city != null && dataItem.city != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CITY] = dataItem.city;
      }
      if (dataItem.state != null && dataItem.state != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_STATE] = dataItem.state;
      }
      if (dataItem.country != null && dataItem.country != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY] = dataItem.country;
      }
      if (dataItem.pin != null && dataItem.pin != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_PIN] = dataItem.pin;
      }
      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID] = dataItem.accountID;
      }
      if (dataItem.contactID != null && dataItem.contactID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID] = dataItem.contactID;
      }
      if (dataItem.gpsCoordinates != null &&
          dataItem.gpsCoordinates != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES] =
            dataItem.gpsCoordinates;
      }
      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY] = dataItem.createdBy;
      }
      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON] = dataItem.createdOn;
      }
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY] = dataItem.modifiedBy;
      }
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON] = dataItem.modifiedOn;
      }
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }
      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE] = dataItem.isActive;
      }
      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_UID] = dataItem.uid;
      }
      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID] = dataItem.appUserID;
      }
      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }
      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED] = dataItem.isArchived;
      }
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED] = dataItem.isDeleted;
      }
      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null") {
        values[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
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

      id = await db.update(TablesBase.TABLE_ACCOUNTADDRESS, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }

    return id;
  }

  static Future<int> DeleteAccountAddressRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(
        TablesBase.TABLE_ACCOUNTADDRESS,

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

      String selectQuery =
          "SELECT A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        serverId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
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
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        localId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
      }
      //db.close();
    } catch (ex) {
      // Globals.handleException(context, "AccountDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<List<AccountAddress>> GetAccountAddressUpSyncRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<AccountAddress> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNTADDRESS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNTADDRESS + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'false' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNTADDRESS + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'true' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} IN (SELECT  ${ColumnsBase.KEY_ID} FROM ${TablesBase.TABLE_ACCOUNT} WHERE CAST(COALESCE(${ColumnsBase.KEY_ACCOUNT_ACCOUNTID},'0') AS long) > 0)";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        AccountAddress accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(accountAddress);
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<AccountAddress?> GetAccountAddressRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    AccountAddress? accountAddress;
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTADDRESS} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNTADDRESS_UID} = '$uid'";
      //selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + Columns.KEY_ACCOUNTADDRESS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        accountAddress = AccountAddress();

        accountAddress.accountAddressID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSID];
        accountAddress.accountAddressCode =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTADDRESSCODE];
        accountAddress.addressTypeName =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSTYPENAME];
        accountAddress.addressLine1 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE1];
        accountAddress.addressLine2 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE2];
        accountAddress.addressLine3 =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ADDRESSLINE3];
        accountAddress.city = element[ColumnsBase.KEY_ACCOUNTADDRESS_CITY];
        accountAddress.state = element[ColumnsBase.KEY_ACCOUNTADDRESS_STATE];
        accountAddress.country =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_COUNTRY];
        accountAddress.pin = element[ColumnsBase.KEY_ACCOUNTADDRESS_PIN];
        accountAddress.accountID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ACCOUNTID];
        accountAddress.contactID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CONTACTID];
        accountAddress.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_GPSCOORDINATES];
        accountAddress.createdBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDBY];
        accountAddress.createdOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_CREATEDON];
        accountAddress.modifiedBy =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDBY];
        accountAddress.modifiedOn =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_MODIFIEDON];
        accountAddress.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_DEVICEIDENTIFIER];
        accountAddress.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_REFERENCEIDENTIFIER];
        accountAddress.isActive =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISACTIVE];
        accountAddress.uid = element[ColumnsBase.KEY_ACCOUNTADDRESS_UID];
        accountAddress.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERGROUPID];
        accountAddress.appUserID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_APPUSERID];
        accountAddress.isArchived =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISARCHIVED];
        accountAddress.isDeleted =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_ISDELETED];
        accountAddress.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNTADDRESS_LEADQUALIFICATIONID];
        accountAddress.accountName =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        accountAddress.contactName =
            element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

        accountAddress.id = element[BaseEntity.KEY_ID];
        accountAddress.isDirty = element[BaseEntity.KEY_ISDIRTY];
        accountAddress.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        accountAddress.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        accountAddress.downSyncMessage =
            element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        accountAddress.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        accountAddress.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        accountAddress.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        accountAddress.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        accountAddress.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "AccountAddressDataHandlerBase:GetAccountAddressRecordsPaged()", ex);
      throw ex;
    }
    return accountAddress;
  }
}
