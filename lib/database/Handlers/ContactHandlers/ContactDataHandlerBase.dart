import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:happsales_crm/database/AppTables/Tables.dart';
import 'package:happsales_crm/database/models/BaseEntity.dart';
import 'package:sqflite/sqflite.dart';

import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../Globals.dart';
import '../../models/ContactModels.dart/Contact.dart';
import '../DatabaseHandler.dart';
import '../../AppTables/TablesBase.dart';

class ContactHandlerDataBase {


  static Future<List<Contact>> GetContactRecordsPaged(

      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async
       {
    List<Contact> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION},G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME},E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} E ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} G ON A.${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            "${" AND (A.${ColumnsBase.KEY_CONTACT_CONTACTNAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
        selectQuery +=
            "${" OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '${searchString.replaceAll("'", "''")}"}%'";
        selectQuery +=
            "${" OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} LIKE '${searchString.replaceAll("'", "''")}"}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Contact_Columns.KEY_CONTACT_FIRSTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Contact dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }

      //db.close();
    } catch (ex) {
       Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Contact>> GetContactRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Contact> dataList = [];
    try {
      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME}, E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} E ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} G ON A.${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISDELETED},'false')) = 'false'";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISACTIVE},'true')) = 'true'";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISARCHIVED},'false')) = 'false'";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACT_FIRSTNAME} LIKE '${searchString.replaceAll("'", "''")}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_CONTACT_FIRSTNAME} COLLATE NOCASE ASC";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Contact_Columns.KEY_CONTACT_FIRSTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Contact dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }

      //db.close();
    } catch (ex) {
       Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Contact?> GetContactRecord(
      DatabaseHandler databaseHandler, String id) async {
    Contact? dataItem;

    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME}, E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}, F.${ColumnsBase.KEY_CONTACTCATEGORY_CONTACTCATEGORYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} E ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTCATEGORY} F ON A.${ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} G ON A.${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = ${id}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
       Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Contact?> GetMasterContactRecord(



      DatabaseHandler databaseHandler, String id) async {
    Contact? dataItem;

    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME}, E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} E ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} G ON A.${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACT_CONTACTID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_CONTACT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }


  static Future<int> AddContactRecord(DatabaseHandler databaseHandler, Contact dataItem)async {
        
        int id = 0;
         try{

           final db = await databaseHandler.database;

           Map<String, dynamic> values= <String, dynamic>{};

            if (dataItem.contactID != null && dataItem.contactID != "null") {
              values[ColumnsBase.KEY_CONTACT_CONTACTID] = dataItem.contactID;
            }

            if (dataItem.contactCode != null && dataItem.contactCode != "null") {
              values[ColumnsBase.KEY_CONTACT_CONTACTCODE] = dataItem.contactCode;
            }

            if(dataItem.title != null && dataItem.title != "null"){
              values[ColumnsBase.KEY_CONTACT_TITLE] = dataItem.title;
            }

            if(dataItem.firstName != null && dataItem.firstName != "null"){
              values[ColumnsBase.KEY_CONTACT_FIRSTNAME] = dataItem.firstName;
            }
           
            if(dataItem.middleName != null && dataItem.middleName != "null"){
              values[ColumnsBase.KEY_CONTACT_MIDDLENAME] = dataItem.middleName;
            }

            if(dataItem.lastName != null && dataItem.lastName != "null"){
              values[ColumnsBase.KEY_CONTACT_LASTNAME] = dataItem.lastName;
            }

            if(dataItem.contactName != null && dataItem.contactName != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTNAME] = dataItem.contactName;
            }

            if(dataItem.contactIdentifier != null && dataItem.contactIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER] = dataItem.contactIdentifier;
            }

            if(dataItem.accountID != null && dataItem.accountID != "null"){
              values[ColumnsBase.KEY_CONTACT_ACCOUNTID] = dataItem.accountID;
            }

            if(dataItem.contactCategoryID != null && dataItem.contactCategoryID != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID] = dataItem.contactCategoryID;
            }

            if(dataItem.departmentName != null && dataItem.departmentName != "null"){
              values[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME] = dataItem.departmentName;
            }

            if(dataItem.designation != null && dataItem.designation != "null"){
              values[ColumnsBase.KEY_CONTACT_DESIGNATION] = dataItem.designation;
            }

            if(dataItem.rolesAndResponsibilities != null && dataItem.rolesAndResponsibilities != "null"){
              values[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES] = dataItem.rolesAndResponsibilities;
            }

           if(dataItem.reportingManager != null && dataItem.reportingManager != "null"){
              values[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER] = dataItem.reportingManager;
            }

            if(dataItem.reportingContactID != null && dataItem.reportingContactID != "null"){
              values[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID] = dataItem.reportingContactID;
            }

            if(dataItem.mobileNumber != null && dataItem.mobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_MOBILENUMBER] = dataItem.mobileNumber;
            }

            if(dataItem.alternateMobileNumber != null && dataItem.alternateMobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER] = dataItem.alternateMobileNumber;
            }

            if(dataItem.alternateMobileNumber != null && dataItem.alternateMobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER] = dataItem.alternateMobileNumber;
            }

            if(dataItem.residencePhone != null && dataItem.residencePhone != "null"){
              values[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE] = dataItem.residencePhone;
            }

            
            if(dataItem.workPhone != null && dataItem.workPhone != "null"){
              values[ColumnsBase.KEY_CONTACT_WORKPHONE] = dataItem.workPhone;
            }

            if(dataItem.email != null && dataItem.email != "null"){
              values[ColumnsBase.KEY_CONTACT_EMAIL] = dataItem.email;
            }

            if(dataItem.alternateEmail != null && dataItem.alternateEmail != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL] = dataItem.alternateEmail;
            }

            if(dataItem.addressLine1 != null && dataItem.addressLine1 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE1] = dataItem.addressLine1;
            }

            if(dataItem.addressLine2 != null && dataItem.addressLine2 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE2] = dataItem.addressLine2;
            }

            if(dataItem.addressLine3 != null && dataItem.addressLine3 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE3] = dataItem.addressLine3;
            }

            if(dataItem.city != null && dataItem.city != "null"){
              values[ColumnsBase.KEY_CONTACT_CITY] = dataItem.city;
            }

            if(dataItem.state != null && dataItem.state != "null"){
              values[ColumnsBase.KEY_CONTACT_STATE] = dataItem.state;
            }

            if(dataItem.country != null && dataItem.country != "null"){
              values[ColumnsBase.KEY_CONTACT_COUNTRY] = dataItem.country;
            }

            if(dataItem.pin != null && dataItem.pin != "null"){
              values[ColumnsBase.KEY_CONTACT_PIN] = dataItem.pin;
            }

            if(dataItem.gpsCoordinates != null && dataItem.gpsCoordinates != "null"){
              values[ColumnsBase.KEY_CONTACT_GPSCOORDINATES] = dataItem.gpsCoordinates;
            }

            if(dataItem.linkedIn != null && dataItem.linkedIn != "null"){
              values[ColumnsBase.KEY_CONTACT_LINKEDIN] = dataItem.linkedIn;
            }

            if(dataItem.pastAccounts != null && dataItem.pastAccounts != "null"){
              values[ColumnsBase.KEY_CONTACT_PASTACCOUNTS] = dataItem.pastAccounts;
            }

            
            if(dataItem.pastDesignations != null && dataItem.pastDesignations != "null"){
              values[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS] = dataItem.pastDesignations;
            }

            if(dataItem.dateOfBirth != null && dataItem.dateOfBirth != "null"){
              values[ColumnsBase.KEY_CONTACT_DATEOFBIRTH] = dataItem.dateOfBirth;
            }

            if(dataItem.remindBirthday != null && dataItem.remindBirthday != "null"){
              values[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY] = dataItem.remindBirthday;
            }

            if(dataItem.contactAlignmentID != null && dataItem.contactAlignmentID != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID] = dataItem.contactAlignmentID;
            }

            if(dataItem.remarks != null && dataItem.remarks != "null"){
              values[ColumnsBase.KEY_CONTACT_REMARKS] = dataItem.remarks;
            }

            if(dataItem.referenceHistory != null && dataItem.referenceHistory != "null"){
              values[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY] = dataItem.referenceHistory;
            }

            if(dataItem.isPrimaryContact != null && dataItem.isPrimaryContact != "null"){
              values[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT] = dataItem.isPrimaryContact;
            }

            if(dataItem.tags != null && dataItem.tags != "null"){
              values[ColumnsBase.KEY_CONTACT_TAGS] = dataItem.tags;
            }

            if(dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1] = dataItem.freeTextField1;
            }

            if(dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2] = dataItem.freeTextField2;
            }

            if(dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3] = dataItem.freeTextField3;
            }

            if(dataItem.companyName != null && dataItem.companyName != "null"){
              values[ColumnsBase.KEY_CONTACT_COMPANYNAME] = dataItem.companyName;
            }

            if(dataItem.taxPayerIdentificationNumber != null && dataItem.taxPayerIdentificationNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER] = dataItem.taxPayerIdentificationNumber;
            }

            if(dataItem.socialSecurityNumber != null && dataItem.socialSecurityNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER] = dataItem.socialSecurityNumber;
            }

            if(dataItem.passportNumber != null && dataItem.passportNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER] = dataItem.passportNumber;
            }

            if(dataItem.drivingLicenseNumber != null && dataItem.drivingLicenseNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER] = dataItem.drivingLicenseNumber;
            }

            if(dataItem.voterIDCardNumber != null && dataItem.voterIDCardNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER] = dataItem.voterIDCardNumber;
            }

            if(dataItem.marketingContactID != null && dataItem.marketingContactID != "null"){
              values[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID] = dataItem.marketingContactID;
            }

            if(dataItem.createdBy != null && dataItem.createdBy != "null"){
              values[ColumnsBase.KEY_CONTACT_CREATEDBY] = dataItem.createdBy;
            }

            if(dataItem.createdOn != null && dataItem.createdOn != "null"){
              values[ColumnsBase.KEY_CONTACT_CREATEDON] = dataItem.createdOn;
            }

            if(dataItem.modifiedBy != null && dataItem.modifiedBy != "null"){
              values[ColumnsBase.KEY_CONTACT_MODIFIEDBY] = dataItem.modifiedBy;
            }

            if(dataItem.modifiedOn != null && dataItem.modifiedOn != "null"){
              values[ColumnsBase.KEY_CONTACT_MODIFIEDON] = dataItem.modifiedOn;
            }

            if(dataItem.isDeleted != null && dataItem.isDeleted != "null"){
              values[ColumnsBase.KEY_CONTACT_ISDELETED] = dataItem.isDeleted;
            }


            if(dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
            }

            if(dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
            }


            if(dataItem.isActive != null && dataItem.isActive != "null"){
              values[ColumnsBase.KEY_CONTACT_ISACTIVE] = dataItem.isActive;
            }

            if(dataItem.uid != null && dataItem.uid != "null"){
              values[ColumnsBase.KEY_CONTACT_UID] = dataItem.uid;
            }

            if(dataItem.appUserID != null && dataItem.appUserID != "null"){
              values[ColumnsBase.KEY_CONTACT_APPUSERID] = dataItem.appUserID;
            }

            if(dataItem.assignedByAppUserID != null && dataItem.assignedByAppUserID != "null"){
              values[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID] = dataItem.assignedByAppUserID;
            }

            if(dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null"){
              values[ColumnsBase.KEY_CONTACT_APPUSERGROUPID] = dataItem.appUserGroupID;
            }

            if(dataItem.isArchived != null && dataItem.isArchived != "null"){
              values[ColumnsBase.KEY_CONTACT_ISARCHIVED] = dataItem.isArchived;
            }

            if(dataItem.isDeleted != null && dataItem.isDeleted != "null"){
              values[ColumnsBase.KEY_CONTACT_ISDELETED] = dataItem.isDeleted;
            }

            if(dataItem.leadQualificationID != null && dataItem.leadQualificationID != "null"){
              values[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID] = dataItem.leadQualificationID;
            }

            if(dataItem.contactCodeInternal != null && dataItem.contactCodeInternal != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL] = dataItem.contactCodeInternal;
            }

            if(dataItem.id != null && dataItem.id != "null"){
              values[ColumnsBase.KEY_ID] = dataItem.id;
            }

            if(dataItem.isDirty != null && dataItem.isDirty != "null"){
              values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
            }

            if(dataItem.isDeleted1 != null && dataItem.isDeleted != "null"){
              values[BaseEntity.KEY_ISDELETED] = dataItem.isDeleted1;
            }

            if(dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null"){
              values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
            }

            if(dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null"){
              values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
            }

            if(dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null"){
              values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
            }

            if(dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null"){
              values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
            }

            if(dataItem.createdByUser != null && dataItem.createdByUser != "null"){
              values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
            }

            if(dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null"){
              values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
            }

            if(dataItem.ownerUserID != null && dataItem.ownerUserID != "null"){
              values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
            }

            values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
            values[ColumnsBase.KEY_ISACTIVE] = "true";
            values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.insert(TablesBase.TABLE_CONTACT, values);

           
         }
         catch(ex){
           throw ex;
         }

         return id;
   }


  static Future<int> UpdateContactRecord(DatabaseHandler databaseHandler, String id1,Contact dataItem)async {
        
        int id = 0;
         try{

           final db = await databaseHandler.database;

           Map<String, dynamic> values= <String, dynamic>{};

            if (dataItem.contactID != null && dataItem.contactID != "null") {
              values[ColumnsBase.KEY_CONTACT_CONTACTID] = dataItem.contactID;
            }

            if (dataItem.contactCode != null && dataItem.contactCode != "null") {
              values[ColumnsBase.KEY_CONTACT_CONTACTCODE] = dataItem.contactCode;
            }

            if(dataItem.title != null && dataItem.title != "null"){
              values[ColumnsBase.KEY_CONTACT_TITLE] = dataItem.title;
            }

            if(dataItem.firstName != null && dataItem.firstName != "null"){
              values[ColumnsBase.KEY_CONTACT_FIRSTNAME] = dataItem.firstName;
            }
           
            if(dataItem.middleName != null && dataItem.middleName != "null"){
              values[ColumnsBase.KEY_CONTACT_MIDDLENAME] = dataItem.middleName;
            }

            if(dataItem.lastName != null && dataItem.lastName != "null"){
              values[ColumnsBase.KEY_CONTACT_LASTNAME] = dataItem.lastName;
            }

            if(dataItem.contactName != null && dataItem.contactName != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTNAME] = dataItem.contactName;
            }

            if(dataItem.contactIdentifier != null && dataItem.contactIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER] = dataItem.contactIdentifier;
            }

            if(dataItem.accountID != null && dataItem.accountID != "null"){
              values[ColumnsBase.KEY_CONTACT_ACCOUNTID] = dataItem.accountID;
            }

            if(dataItem.contactCategoryID != null && dataItem.contactCategoryID != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID] = dataItem.contactCategoryID;
            }

            if(dataItem.departmentName != null && dataItem.departmentName != "null"){
              values[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME] = dataItem.departmentName;
            }

            if(dataItem.designation != null && dataItem.designation != "null"){
              values[ColumnsBase.KEY_CONTACT_DESIGNATION] = dataItem.designation;
            }

            if(dataItem.rolesAndResponsibilities != null && dataItem.rolesAndResponsibilities != "null"){
              values[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES] = dataItem.rolesAndResponsibilities;
            }

           if(dataItem.reportingManager != null && dataItem.reportingManager != "null"){
              values[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER] = dataItem.reportingManager;
            }

            if(dataItem.reportingContactID != null && dataItem.reportingContactID != "null"){
              values[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID] = dataItem.reportingContactID;
            }

            if(dataItem.mobileNumber != null && dataItem.mobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_MOBILENUMBER] = dataItem.mobileNumber;
            }

            if(dataItem.alternateMobileNumber != null && dataItem.alternateMobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER] = dataItem.alternateMobileNumber;
            }

            if(dataItem.alternateMobileNumber != null && dataItem.alternateMobileNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER] = dataItem.alternateMobileNumber;
            }

            if(dataItem.residencePhone != null && dataItem.residencePhone != "null"){
              values[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE] = dataItem.residencePhone;
            }

            
            if(dataItem.workPhone != null && dataItem.workPhone != "null"){
              values[ColumnsBase.KEY_CONTACT_WORKPHONE] = dataItem.workPhone;
            }

            if(dataItem.email != null && dataItem.email != "null"){
              values[ColumnsBase.KEY_CONTACT_EMAIL] = dataItem.email;
            }

            if(dataItem.alternateEmail != null && dataItem.alternateEmail != "null"){
              values[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL] = dataItem.alternateEmail;
            }

            if(dataItem.addressLine1 != null && dataItem.addressLine1 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE1] = dataItem.addressLine1;
            }

            if(dataItem.addressLine2 != null && dataItem.addressLine2 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE2] = dataItem.addressLine2;
            }

            if(dataItem.addressLine3 != null && dataItem.addressLine3 != "null"){
              values[ColumnsBase.KEY_CONTACT_ADDRESSLINE3] = dataItem.addressLine3;
            }

            if(dataItem.city != null && dataItem.city != "null"){
              values[ColumnsBase.KEY_CONTACT_CITY] = dataItem.city;
            }

            if(dataItem.state != null && dataItem.state != "null"){
              values[ColumnsBase.KEY_CONTACT_STATE] = dataItem.state;
            }

            if(dataItem.country != null && dataItem.country != "null"){
              values[ColumnsBase.KEY_CONTACT_COUNTRY] = dataItem.country;
            }

            if(dataItem.pin != null && dataItem.pin != "null"){
              values[ColumnsBase.KEY_CONTACT_PIN] = dataItem.pin;
            }

            if(dataItem.gpsCoordinates != null && dataItem.gpsCoordinates != "null"){
              values[ColumnsBase.KEY_CONTACT_GPSCOORDINATES] = dataItem.gpsCoordinates;
            }

            if(dataItem.linkedIn != null && dataItem.linkedIn != "null"){
              values[ColumnsBase.KEY_CONTACT_LINKEDIN] = dataItem.linkedIn;
            }

            if(dataItem.pastAccounts != null && dataItem.pastAccounts != "null"){
              values[ColumnsBase.KEY_CONTACT_PASTACCOUNTS] = dataItem.pastAccounts;
            }

            
            if(dataItem.pastDesignations != null && dataItem.pastDesignations != "null"){
              values[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS] = dataItem.pastDesignations;
            }

            if(dataItem.dateOfBirth != null && dataItem.dateOfBirth != "null"){
              values[ColumnsBase.KEY_CONTACT_DATEOFBIRTH] = dataItem.dateOfBirth;
            }

            if(dataItem.remindBirthday != null && dataItem.remindBirthday != "null"){
              values[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY] = dataItem.remindBirthday;
            }

            if(dataItem.contactAlignmentID != null && dataItem.contactAlignmentID != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID] = dataItem.contactAlignmentID;
            }

            if(dataItem.remarks != null && dataItem.remarks != "null"){
              values[ColumnsBase.KEY_CONTACT_REMARKS] = dataItem.remarks;
            }

            if(dataItem.referenceHistory != null && dataItem.referenceHistory != "null"){
              values[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY] = dataItem.referenceHistory;
            }

            if(dataItem.isPrimaryContact != null && dataItem.isPrimaryContact != "null"){
              values[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT] = dataItem.isPrimaryContact;
            }

            if(dataItem.tags != null && dataItem.tags != "null"){
              values[ColumnsBase.KEY_CONTACT_TAGS] = dataItem.tags;
            }

            if(dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1] = dataItem.freeTextField1;
            }

            if(dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2] = dataItem.freeTextField2;
            }

            if(dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null"){
              values[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3] = dataItem.freeTextField3;
            }

            if(dataItem.companyName != null && dataItem.companyName != "null"){
              values[ColumnsBase.KEY_CONTACT_COMPANYNAME] = dataItem.companyName;
            }

            if(dataItem.taxPayerIdentificationNumber != null && dataItem.taxPayerIdentificationNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER] = dataItem.taxPayerIdentificationNumber;
            }

            if(dataItem.socialSecurityNumber != null && dataItem.socialSecurityNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER] = dataItem.socialSecurityNumber;
            }

            if(dataItem.passportNumber != null && dataItem.passportNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER] = dataItem.passportNumber;
            }

            if(dataItem.drivingLicenseNumber != null && dataItem.drivingLicenseNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER] = dataItem.drivingLicenseNumber;
            }

            if(dataItem.voterIDCardNumber != null && dataItem.voterIDCardNumber != "null"){
              values[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER] = dataItem.voterIDCardNumber;
            }

            if(dataItem.marketingContactID != null && dataItem.marketingContactID != "null"){
              values[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID] = dataItem.marketingContactID;
            }

            if(dataItem.createdBy != null && dataItem.createdBy != "null"){
              values[ColumnsBase.KEY_CONTACT_CREATEDBY] = dataItem.createdBy;
            }

            if(dataItem.createdOn != null && dataItem.createdOn != "null"){
              values[ColumnsBase.KEY_CONTACT_CREATEDON] = dataItem.createdOn;
            }

            if(dataItem.modifiedBy != null && dataItem.modifiedBy != "null"){
              values[ColumnsBase.KEY_CONTACT_MODIFIEDBY] = dataItem.modifiedBy;
            }

            if(dataItem.modifiedOn != null && dataItem.modifiedOn != "null"){
              values[ColumnsBase.KEY_CONTACT_MODIFIEDON] = dataItem.modifiedOn;
            }

            if(dataItem.isDeleted != null && dataItem.isDeleted != "null"){
              values[ColumnsBase.KEY_CONTACT_ISDELETED] = dataItem.isDeleted;
            }


            if(dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
            }

            if(dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null"){
              values[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
            }


            if(dataItem.isActive != null && dataItem.isActive != "null"){
              values[ColumnsBase.KEY_CONTACT_ISACTIVE] = dataItem.isActive;
            }

            if(dataItem.uid != null && dataItem.uid != "null"){
              values[ColumnsBase.KEY_CONTACT_UID] = dataItem.uid;
            }

            if(dataItem.appUserID != null && dataItem.appUserID != "null"){
              values[ColumnsBase.KEY_CONTACT_APPUSERID] = dataItem.appUserID;
            }

            if(dataItem.assignedByAppUserID != null && dataItem.assignedByAppUserID != "null"){
              values[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID] = dataItem.assignedByAppUserID;
            }

            if(dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null"){
              values[ColumnsBase.KEY_CONTACT_APPUSERGROUPID] = dataItem.appUserGroupID;
            }

            if(dataItem.isArchived != null && dataItem.isArchived != "null"){
              values[ColumnsBase.KEY_CONTACT_ISARCHIVED] = dataItem.isArchived;
            }

            if(dataItem.isDeleted != null && dataItem.isDeleted != "null"){
              values[ColumnsBase.KEY_CONTACT_ISDELETED] = dataItem.isDeleted;
            }

            if(dataItem.leadQualificationID != null && dataItem.leadQualificationID != "null"){
              values[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID] = dataItem.leadQualificationID;
            }

            if(dataItem.contactCodeInternal != null && dataItem.contactCodeInternal != "null"){
              values[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL] = dataItem.contactCodeInternal;
            }

            if(dataItem.id != null && dataItem.id != "null"){
              values[ColumnsBase.KEY_ID] = dataItem.id;
            }

            if(dataItem.isDirty != null && dataItem.isDirty != "null"){
              values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
            }

            if(dataItem.isDeleted1 != null && dataItem.isDeleted != "null"){
              values[BaseEntity.KEY_ISDELETED] = dataItem.isDeleted1;
            }

            if(dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null"){
              values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
            }

            if(dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null"){
              values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
            }

            if(dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null"){
              values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
            }

            if(dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null"){
              values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
            }

            if(dataItem.createdByUser != null && dataItem.createdByUser != "null"){
              values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
            }

            if(dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null"){
              values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
            }

            if(dataItem.ownerUserID != null && dataItem.ownerUserID != "null"){
              values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
            }

            if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null"){
              values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
            }

          
            id = await db.update(TablesBase.TABLE_CONTACT, values, where: "${ColumnsBase.KEY_ID} = $id1" , whereArgs: null);

           
         }
         catch(ex){
           throw ex;
         }

         return id;
   }

  static Future<int> DeleteContactRecord(DatabaseHandler databaseHandler, String id1) async {
        int id = 0;
        try {

            final db   = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_CONTACT,  where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteContactRecord()", ex);
            throw ex;
        }
        return id;
    }
    

  Future<String> getServerId(Database databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

       String selectQuery = "SELECT A.${ColumnsBase.KEY_CONTACT_CONTACTID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        serverId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
      }
      //db.close();
    } catch (ex) {
      Globals.handleException( "AccountDataHandlerBase:GetServerId()", ex);
      throw ex;
    }
    return serverId;
  }

  Future<String> getLocalId(DatabaseHandler databaseHandler, String id) async {
  String localId = "";
  try {
    id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CONTACT_CONTACTID} = $id";

    
  
      Database db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);


       if (result.isNotEmpty) {
        localId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
      }
    
    //db.close();
  } catch ( ex) {
    Globals.handleException( "AccountDataHandlerBase:getLocalId()", ex);
    throw ex;
  }
  return localId;
}

  static Future<List<Contact>> GetContactUpSyncRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Contact> dataList = [];
    try {
     String selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_CONTACT + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_CONTACT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_CONTACT_ACCOUNTID + " IN (SELECT Q." + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " Q WHERE CAST(COALESCE(Q." + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'0') AS long) > 0)";

     
      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Contact dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];

        dataList.add(dataItem);
      }

      //db.close();
    } catch (ex) {
     Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }



static Future<Contact?> GetContactRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Contact? dataItem;

    try {

         String selectQuery = "SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",G." + ColumnsBase.KEY_CONTACT_CONTACTNAME + " AS " + ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME + ",E." + ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_CONTACT + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_CONTACT_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACTALIGNMENT + " E ON A." + ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID + " = E." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACTCATEGORY + " F ON A." + ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " G ON A." + ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_CONTACT_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_CONTACT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        dataItem = Contact();

        dataItem.contactID = element[ColumnsBase.KEY_ID];
        dataItem.contactCode = element[ColumnsBase.KEY_CONTACT_CONTACTCODE];
        dataItem.title = element[ColumnsBase.KEY_CONTACT_TITLE];
        dataItem.firstName = element[ColumnsBase.KEY_CONTACT_FIRSTNAME];
        dataItem.middleName = element[ColumnsBase.KEY_CONTACT_MIDDLENAME];
        dataItem.lastName = element[ColumnsBase.KEY_CONTACT_LASTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.contactIdentifier =
            element[ColumnsBase.KEY_CONTACT_CONTACTIDENTIFIER];

        dataItem.accountID = element[ColumnsBase.KEY_CONTACT_ACCOUNTID];
        dataItem.contactCategoryID =
            element[ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID];
        dataItem.departmentName =
            element[ColumnsBase.KEY_CONTACT_DEPARTMENTNAME];
        dataItem.designation = element[ColumnsBase.KEY_CONTACT_DESIGNATION];
        dataItem.rolesAndResponsibilities =
            element[ColumnsBase.KEY_CONTACT_ROLESANDRESPONSIBILITIES];
        dataItem.reportingManager =
            element[ColumnsBase.KEY_CONTACT_REPORTINGMANAGER];
        dataItem.reportingContactID =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.mobileNumber = element[ColumnsBase.KEY_CONTACT_MOBILENUMBER];
        dataItem.alternateMobileNumber =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEMOBILENUMBER];
        dataItem.workPhone = element[ColumnsBase.KEY_CONTACT_WORKPHONE];
        dataItem.residencePhone =
            element[ColumnsBase.KEY_CONTACT_RESIDENCEPHONE];
        dataItem.email = element[ColumnsBase.KEY_CONTACT_EMAIL];
        dataItem.alternateEmail =
            element[ColumnsBase.KEY_CONTACT_ALTERNATEEMAIL];
        dataItem.addressLine1 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_CONTACT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_CONTACT_CITY];
        dataItem.state = element[ColumnsBase.KEY_CONTACT_STATE];
        dataItem.country = element[ColumnsBase.KEY_CONTACT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_CONTACT_PIN];

        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_CONTACT_GPSCOORDINATES];
        dataItem.linkedIn = element[ColumnsBase.KEY_CONTACT_LINKEDIN];
        dataItem.pastAccounts = element[ColumnsBase.KEY_CONTACT_PASTACCOUNTS];
        dataItem.pastDesignations =
            element[ColumnsBase.KEY_CONTACT_PASTDESIGNATIONS];
        dataItem.dateOfBirth = element[ColumnsBase.KEY_CONTACT_DATEOFBIRTH];
        dataItem.remindBirthday =
            element[ColumnsBase.KEY_CONTACT_REMINDBIRTHDAY];
        dataItem.contactAlignmentID =
            element[ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID];
        dataItem.remarks = element[ColumnsBase.KEY_CONTACT_REMARKS];
        dataItem.referenceHistory =
            element[ColumnsBase.KEY_CONTACT_REFERENCEHISTORY];
        dataItem.isPrimaryContact =
            element[ColumnsBase.KEY_CONTACT_ISPRIMARYCONTACT];
        dataItem.tags = element[ColumnsBase.KEY_CONTACT_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_CONTACT_FREETEXTFIELD3];
        dataItem.companyName = element[ColumnsBase.KEY_CONTACT_COMPANYNAME];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_CONTACT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.socialSecurityNumber =
            element[ColumnsBase.KEY_CONTACT_SOCIALSECURITYNUMBER];
        dataItem.passportNumber =
            element[ColumnsBase.KEY_CONTACT_PASSPORTNUMBER];
        dataItem.drivingLicenseNumber =
            element[ColumnsBase.KEY_CONTACT_DRIVINGLICENSENUMBER];
        dataItem.voterIDCardNumber =
            element[ColumnsBase.KEY_CONTACT_VOTERIDCARDNUMBER];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_CONTACT_MARKETINGCONTACTID];

        dataItem.createdBy = element[ColumnsBase.KEY_CONTACT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_CONTACT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_CONTACT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_CONTACT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_CONTACT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_CONTACT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_CONTACT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_CONTACT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_CONTACT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_CONTACT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_CONTACT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_CONTACT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_CONTACT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_CONTACT_LEADQUALIFICATIONID];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.reportingContactName =
            element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
        dataItem.contactAlignmentName =
            element[ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME];
        dataItem.contactCodeInternal =
            element[ColumnsBase.KEY_CONTACT_CONTACTCODEINTERNAL];

        // FROM BASE ENTITY
        dataItem.id = element[BaseEntity.KEY_ID];
        dataItem.isDirty = element[BaseEntity.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[BaseEntity.KEY_ISDELETED];
        dataItem.upSyncMessage = element[BaseEntity.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[BaseEntity.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[BaseEntity.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[BaseEntity.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[BaseEntity.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[BaseEntity.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[BaseEntity.KEY_OWNERUSERID];
      }

      //db.close();
    } catch (ex) {
      Globals.handleException( "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

}