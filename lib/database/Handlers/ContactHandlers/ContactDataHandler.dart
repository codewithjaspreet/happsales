import '../../AppTables/ColumnsBase.dart';
import '../../Globals.dart';
import '../../models/ContactModels.dart/Contact.dart';
import '../DatabaseHandler.dart';
import '../../Models/BaseEntity.dart';
import '../../AppTables/TablesBase.dart';

class ContactDataHandler {

  static Future<List<Contact>> GetContactRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Contact> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION}, G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME}, E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_CONTACT} A ";
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
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_CONTACT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_CONTACT_CONTACTNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery +=
            " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '${searchString.replaceAll("'", "''")}%'";
        selectQuery +=
            " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} LIKE '${searchString.replaceAll("'", "''")}%')";
      }

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
      // Globals.HandleException(context, "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
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
      // Globals.HandleException(context, "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Contact>> GetContactContainsContactName(
      DatabaseHandler databaseHandler,
      String searchString,
      String contactname,
      String accountId) async {
    List<Contact> dataList = [];
    try {
      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, C.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME} FROM ${TablesBase.TABLE_CONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} C ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_CONTACT_CONTACTNAME} LIKE '%${contactname.replaceAll("'", "''")}%' COLLATE NOCASE";

      if (accountId.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = $accountId";
      }

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
        // dataItem.reportingContactName =
        //     element[ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME];
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
      // Globals.HandleException(context, "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Contact?> GetContactRecord(DatabaseHandler databaseHandler,
      String id, String contactname, String accountId) async {
    Contact? dataItem;

    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, C.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME} FROM ${TablesBase.TABLE_CONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} C ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_CONTACT_CONTACTNAME} = '$contactname' COLLATE NOCASE";

      if (accountId.trim().isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = $accountId";
      }

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
      // Globals.HandleException(context, "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Contact?> GetContactRecordByAccountUid(
      DatabaseHandler databaseHandler,
      String uid,
      String contactname,
      String accountId) async {
    Contact? dataItem;

    try {
      String selectQuery =
          "SELECT A.*, B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}, G.${ColumnsBase.KEY_CONTACT_CONTACTNAME} AS ${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTNAME}, E.${ColumnsBase.KEY_CONTACTALIGNMENT_CONTACTALIGNMENTNAME}, F.${ColumnsBase.KEY_CONTACTCATEGORY_CONTACTCATEGORYNAME} FROM ${TablesBase.TABLE_CONTACT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CONTACT_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTALIGNMENT} E ON A.${ColumnsBase.KEY_CONTACT_CONTACTALIGNMENTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACTCATEGORY} F ON A.${ColumnsBase.KEY_CONTACT_CONTACTCATEGORYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} G ON A.${ColumnsBase.KEY_CONTACT_REPORTINGCONTACTID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          "${" WHERE A." + ColumnsBase.KEY_CONTACT_UID + " = '" + uid}'";
// selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
// selectQuery += " AND A." + ColumnsBase.KEY_CONTACT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
      // Globals.HandleException(context, "ContactDataHandlerBase:GetContactRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }


}