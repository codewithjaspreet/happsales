import 'package:sqflite/sqflite.dart';

import '../Columns.dart';
import '../ColumnsBase.dart';
import '../ColumnsBase.dart';
import '../DatabaseHandler.dart';
import '../Models/Account.dart';
import '../Globals.dart';
import '../TablesBase.dart';
import '../Models/AccountBase.dart';
import '../Models/Account.dart';

class AccountDataHandlerBase {
  static Future<List<Account>> GetAccountRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Account> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND (A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
        selectQuery +=
            "${" OR A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} LIKE '${searchString.replaceAll("'", "''")}"}%'";
        selectQuery +=
            "${" OR A.${ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME} LIKE '${searchString.replaceAll("'", "''")}"}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Account_Columns.KEY_ACCOUNT_ACCOUNTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Account dataItem = Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.isDeleted = element[ColumnsBase.KEY_ID];

        // dataItem.IsDeleted = element[ColumnsBase.KEY_ISDIRTY];

        //dataItem.id = element[ColumnsBase.KEY_ISDIRTY];
        // dataItem. = element[ColumnsBase.KEY_ISDELETED];
        // dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        // dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        // dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        // dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        // dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        // dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        // dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        dataList.add(dataItem);

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Account>> GetAccountRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Account> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().isNotEmpty) {
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Account dataItem = new Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

        dataList.add(dataItem);

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Account?> GetAccountRecord(
      DatabaseHandler databaseHandler, String id) async {
    Account? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        dataItem = Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Account?> GetMasterAccountRecord(
      DatabaseHandler databaseHandler, String id) async {
    Account? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Account dataItem = new Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Account?> GetAccountRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Account? dataItem;
    try {
      String selectQuery =
          "${"SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME}"},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
      selectQuery += "${" WHERE A.${ColumnsBase.KEY_ACCOUNT_UID} = '$uid"}'";
      //selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + Columns.KEY_ACCOUNT_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Account dataItem = new Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<List<Account>> GetAccountUpSyncRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Account> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNT + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'false' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNT + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'true' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
        Account dataItem = new Account();

        // Update property assignments using dot notation
        dataItem.accountID = element[ColumnsBase.KEY_ID];
        dataItem.accountCode = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.accountLocation =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION];
        dataItem.accountIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER];
        dataItem.accountSegmentID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID];
        dataItem.accountStatusID =
            element[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID];
        dataItem.accountTypeID = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID];
        dataItem.parentAccountID =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.industryName = element[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME];
        dataItem.website = element[ColumnsBase.KEY_ACCOUNT_WEBSITE];
        dataItem.turnover = element[ColumnsBase.KEY_ACCOUNT_TURNOVER];
        dataItem.numberOfEmployees =
            element[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES];
        dataItem.creditRatingID =
            element[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID];
        dataItem.currencyID = element[ColumnsBase.KEY_ACCOUNT_CURRENCYID];
        dataItem.primaryContactName =
            element[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME];
        dataItem.phone = element[ColumnsBase.KEY_ACCOUNT_PHONE];
        dataItem.email = element[ColumnsBase.KEY_ACCOUNT_EMAIL];
        dataItem.fax = element[ColumnsBase.KEY_ACCOUNT_FAX];
        dataItem.addressLine1 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1];
        dataItem.addressLine2 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2];
        dataItem.addressLine3 = element[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3];
        dataItem.city = element[ColumnsBase.KEY_ACCOUNT_CITY];
        dataItem.state = element[ColumnsBase.KEY_ACCOUNT_STATE];
        dataItem.country = element[ColumnsBase.KEY_ACCOUNT_COUNTRY];
        dataItem.pin = element[ColumnsBase.KEY_ACCOUNT_PIN];
        dataItem.territoryName = element[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME];
        dataItem.gpsCoordinates =
            element[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES];
        dataItem.logoImagePath = element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH];
        dataItem.logoImageContent =
            element[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT];
        dataItem.taxPayerIdentificationNumber =
            element[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3];
        dataItem.tags = element[ColumnsBase.KEY_ACCOUNT_TAGS];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACCOUNT_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACCOUNT_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACCOUNT_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_ACCOUNT_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACCOUNT_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACCOUNT_APPUSERID];
        dataItem.assignedByAppUserID =
            element[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACCOUNT_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACCOUNT_ISDELETED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID];

        dataItem.localMediaPath =
            element[Columns.KEY_ACCOUNT_LOGO_LOCALMEDIAPATH];
        dataItem.isUploaded = element[Columns.KEY_ACCOUNT_LOGO_ISUPLOADED];

        dataItem.accountSegmentName =
            element[ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME];
        dataItem.accountStatusName =
            element[ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME];
        dataItem.accountTypeName =
            element[ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME];
        dataItem.parentAccountName =
            element[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME];
        dataItem.creditRatingName =
            element[ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];

        dataList.add(dataItem);

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (ex) {
      // Globals.HandleException(context, "AccountDataHandlerBase:GetAccountRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  Future<int> deleteAccountRecord(Database databaseHandler, String id1) async {
    final db = await databaseHandler.database;

    // Remove the account from the database by id.
    int id = await db.delete(
      TablesBase.TABLE_ACCOUNT,

      // Use a `where` clause to delete a specific account by id.
      where: "${ColumnsBase.KEY_ID} = $id1",

      whereArgs: [null],
    );

    return id;
  }

// getting  account server id from local id

  Future<String> getServerId(Database databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

      Database db = await databaseHandler.database;
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
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID} ";
      selectQuery += "FROM ${TablesBase.TABLE_ACCOUNT} A ";
      selectQuery += "WHERE A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $id";

      Database db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      if (result.isNotEmpty) {
        localId = result.first[ColumnsBase.KEY_ACCOUNT_ACCOUNTID].toString();
      }

      //db.close();
    } catch (ex) {
      // Globals.handleException(context, "AccountDataHandlerBase:getLocalId()", ex);
      throw ex;
    }
    return localId;
  }

  static Future<int> AddAccountRecord(
      DatabaseHandler databaseHandler, Account dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = Map();

      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTID] = dataItem.accountID;
      }

      if (dataItem.accountCode != null && dataItem.accountCode != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE] = dataItem.accountCode;
      }

      if (dataItem.accountName != null && dataItem.accountName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME] = dataItem.accountName;
      }

      if (dataItem.accountLocation != null &&
          dataItem.accountLocation != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION] =
            dataItem.accountLocation;
      }

      if (dataItem.accountIdentifier != null &&
          dataItem.accountIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER] =
            dataItem.accountIdentifier;
      }

      if (dataItem.accountSegmentID != null &&
          dataItem.accountSegmentID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID] =
            dataItem.accountSegmentID;
      }

      if (dataItem.accountStatusID != null &&
          dataItem.accountStatusID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID] =
            dataItem.accountStatusID;
      }

      if (dataItem.accountTypeID != null && dataItem.accountTypeID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID] = dataItem.accountTypeID;
      }

      if (dataItem.parentAccountID != null &&
          dataItem.parentAccountID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID] =
            dataItem.parentAccountID;
      }

      if (dataItem.creditRatingID != null &&
          dataItem.creditRatingID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID] =
            dataItem.creditRatingID;
      }

      if (dataItem.accountCode != null && dataItem.accountCode != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE] = dataItem.accountCode;
      }

      if (dataItem.industryName != null && dataItem.industryName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME] = dataItem.industryName;
      }

      if (dataItem.website != null && dataItem.website != "null") {
        values[ColumnsBase.KEY_ACCOUNT_WEBSITE] = dataItem.website;
      }

      if (dataItem.turnover != null && dataItem.turnover != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TURNOVER] = dataItem.turnover;
      }

      if (dataItem.numberOfEmployees != null &&
          dataItem.numberOfEmployees != "null") {
        values[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES] =
            dataItem.numberOfEmployees;
      }

      if (dataItem.creditRatingID != null &&
          dataItem.creditRatingID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID] =
            dataItem.creditRatingID;
      }

      if (dataItem.currencyID != null && dataItem.currencyID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CURRENCYID] = dataItem.currencyID;
      }

      if (dataItem.primaryContactName != null &&
          dataItem.primaryContactName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME] =
            dataItem.primaryContactName;
      }

      if (dataItem.phone != null && dataItem.phone != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PHONE] = dataItem.phone;
      }

      if (dataItem.email != null && dataItem.email != "null") {
        values[ColumnsBase.KEY_ACCOUNT_EMAIL] = dataItem.email;
      }

      if (dataItem.fax != null && dataItem.fax != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FAX] = dataItem.fax;
      }

      if (dataItem.addressLine1 != null && dataItem.addressLine1 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1] = dataItem.addressLine1;
      }

      if (dataItem.addressLine2 != null && dataItem.addressLine2 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2] = dataItem.addressLine2;
      }

      if (dataItem.addressLine3 != null && dataItem.addressLine3 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3] = dataItem.addressLine3;
      }

      if (dataItem.city != null && dataItem.city != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CITY] = dataItem.city;
      }

      if (dataItem.state != null && dataItem.state != "null") {
        values[ColumnsBase.KEY_ACCOUNT_STATE] = dataItem.state;
      }

      if (dataItem.country != null && dataItem.country != "null") {
        values[ColumnsBase.KEY_ACCOUNT_COUNTRY] = dataItem.country;
      }

      if (dataItem.pin != null && dataItem.pin != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PIN] = dataItem.pin;
      }

      if (dataItem.territoryName != null && dataItem.territoryName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME] = dataItem.territoryName;
      }

      if (dataItem.gpsCoordinates != null &&
          dataItem.gpsCoordinates != "null") {
        values[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES] =
            dataItem.gpsCoordinates;
      }

      if (dataItem.logoImagePath != null && dataItem.logoImagePath != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH] = dataItem.logoImagePath;
      }

      if (dataItem.logoImageContent != null &&
          dataItem.logoImageContent != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT] =
            dataItem.logoImageContent;
      }

      if (dataItem.taxPayerIdentificationNumber != null &&
          dataItem.taxPayerIdentificationNumber != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER] =
            dataItem.taxPayerIdentificationNumber;
      }

      if (dataItem.freeTextField1 != null &&
          dataItem.freeTextField1 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1] =
            dataItem.freeTextField1;
      }

      if (dataItem.freeTextField2 != null &&
          dataItem.freeTextField2 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2] =
            dataItem.freeTextField2;
      }

      if (dataItem.freeTextField3 != null &&
          dataItem.freeTextField3 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3] =
            dataItem.freeTextField3;
      }

      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TAGS] = dataItem.tags;
      }

      if (dataItem.marketingContactID != null &&
          dataItem.marketingContactID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID] =
            dataItem.marketingContactID;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY] = dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MODIFIEDON] = dataItem.modifiedOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISACTIVE] = dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNT_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.assignedByAppUserID != null &&
          dataItem.assignedByAppUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID] =
            dataItem.assignedByAppUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISARCHIVED] = dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISDELETED] = dataItem.isDeleted;
      }

      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
      }

      if (dataItem.accountCodeInternal != null &&
          dataItem.accountCodeInternal != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODEINTERNAL] =
            dataItem.accountCodeInternal;
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

      id = await db.insert(TablesBase.TABLE_ACCOUNT, values);

      // id = await db.insert(TablesBase.TABLE_ACCOUNT, values);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:AddAccountRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateAccountRecord(
      DatabaseHandler databaseHandler, Account dataItem, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;

      Map<String, dynamic> values = Map();

      if (dataItem.accountID != null && dataItem.accountID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTID] = dataItem.accountID;
      }

      if (dataItem.accountCode != null && dataItem.accountCode != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE] = dataItem.accountCode;
      }

      if (dataItem.accountName != null && dataItem.accountName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME] = dataItem.accountName;
      }

      if (dataItem.accountLocation != null &&
          dataItem.accountLocation != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION] =
            dataItem.accountLocation;
      }

      if (dataItem.accountIdentifier != null &&
          dataItem.accountIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTIDENTIFIER] =
            dataItem.accountIdentifier;
      }

      if (dataItem.accountSegmentID != null &&
          dataItem.accountSegmentID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID] =
            dataItem.accountSegmentID;
      }

      if (dataItem.accountStatusID != null &&
          dataItem.accountStatusID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID] =
            dataItem.accountStatusID;
      }

      if (dataItem.accountTypeID != null && dataItem.accountTypeID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID] = dataItem.accountTypeID;
      }

      if (dataItem.parentAccountID != null &&
          dataItem.parentAccountID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID] =
            dataItem.parentAccountID;
      }

      if (dataItem.creditRatingID != null &&
          dataItem.creditRatingID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID] =
            dataItem.creditRatingID;
      }

      if (dataItem.accountCode != null && dataItem.accountCode != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE] = dataItem.accountCode;
      }

      if (dataItem.industryName != null && dataItem.industryName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_INDUSTRYNAME] = dataItem.industryName;
      }

      if (dataItem.website != null && dataItem.website != "null") {
        values[ColumnsBase.KEY_ACCOUNT_WEBSITE] = dataItem.website;
      }

      if (dataItem.turnover != null && dataItem.turnover != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TURNOVER] = dataItem.turnover;
      }

      if (dataItem.numberOfEmployees != null &&
          dataItem.numberOfEmployees != "null") {
        values[ColumnsBase.KEY_ACCOUNT_NUMBEROFEMPLOYEES] =
            dataItem.numberOfEmployees;
      }

      if (dataItem.creditRatingID != null &&
          dataItem.creditRatingID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREDITRATINGID] =
            dataItem.creditRatingID;
      }

      if (dataItem.currencyID != null && dataItem.currencyID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CURRENCYID] = dataItem.currencyID;
      }

      if (dataItem.primaryContactName != null &&
          dataItem.primaryContactName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PRIMARYCONTACTNAME] =
            dataItem.primaryContactName;
      }

      if (dataItem.phone != null && dataItem.phone != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PHONE] = dataItem.phone;
      }

      if (dataItem.email != null && dataItem.email != "null") {
        values[ColumnsBase.KEY_ACCOUNT_EMAIL] = dataItem.email;
      }

      if (dataItem.fax != null && dataItem.fax != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FAX] = dataItem.fax;
      }

      if (dataItem.addressLine1 != null && dataItem.addressLine1 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE1] = dataItem.addressLine1;
      }

      if (dataItem.addressLine2 != null && dataItem.addressLine2 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE2] = dataItem.addressLine2;
      }

      if (dataItem.addressLine3 != null && dataItem.addressLine3 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ADDRESSLINE3] = dataItem.addressLine3;
      }

      if (dataItem.city != null && dataItem.city != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CITY] = dataItem.city;
      }

      if (dataItem.state != null && dataItem.state != "null") {
        values[ColumnsBase.KEY_ACCOUNT_STATE] = dataItem.state;
      }

      if (dataItem.country != null && dataItem.country != "null") {
        values[ColumnsBase.KEY_ACCOUNT_COUNTRY] = dataItem.country;
      }

      if (dataItem.pin != null && dataItem.pin != "null") {
        values[ColumnsBase.KEY_ACCOUNT_PIN] = dataItem.pin;
      }

      if (dataItem.territoryName != null && dataItem.territoryName != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TERRITORYNAME] = dataItem.territoryName;
      }

      if (dataItem.gpsCoordinates != null &&
          dataItem.gpsCoordinates != "null") {
        values[ColumnsBase.KEY_ACCOUNT_GPSCOORDINATES] =
            dataItem.gpsCoordinates;
      }

      if (dataItem.logoImagePath != null && dataItem.logoImagePath != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LOGOIMAGEPATH] = dataItem.logoImagePath;
      }

      if (dataItem.logoImageContent != null &&
          dataItem.logoImageContent != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LOGOIMAGECONTENT] =
            dataItem.logoImageContent;
      }

      if (dataItem.taxPayerIdentificationNumber != null &&
          dataItem.taxPayerIdentificationNumber != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TAXPAYERIDENTIFICATIONNUMBER] =
            dataItem.taxPayerIdentificationNumber;
      }

      if (dataItem.freeTextField1 != null &&
          dataItem.freeTextField1 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD1] =
            dataItem.freeTextField1;
      }

      if (dataItem.freeTextField2 != null &&
          dataItem.freeTextField2 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD2] =
            dataItem.freeTextField2;
      }

      if (dataItem.freeTextField3 != null &&
          dataItem.freeTextField3 != "null") {
        values[ColumnsBase.KEY_ACCOUNT_FREETEXTFIELD3] =
            dataItem.freeTextField3;
      }

      if (dataItem.tags != null && dataItem.tags != "null") {
        values[ColumnsBase.KEY_ACCOUNT_TAGS] = dataItem.tags;
      }

      if (dataItem.marketingContactID != null &&
          dataItem.marketingContactID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MARKETINGCONTACTID] =
            dataItem.marketingContactID;
      }

      if (dataItem.createdBy != null && dataItem.createdBy != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREATEDBY] = dataItem.createdBy;
      }

      if (dataItem.createdOn != null && dataItem.createdOn != "null") {
        values[ColumnsBase.KEY_ACCOUNT_CREATEDON] = dataItem.createdOn;
      }

      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MODIFIEDBY] = dataItem.modifiedBy;
      }

      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
        values[ColumnsBase.KEY_ACCOUNT_MODIFIEDON] = dataItem.modifiedOn;
      }

      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
      }

      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null") {
        values[ColumnsBase.KEY_ACCOUNT_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      }

      if (dataItem.isActive != null && dataItem.isActive != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISACTIVE] = dataItem.isActive;
      }

      if (dataItem.uid != null && dataItem.uid != "null") {
        values[ColumnsBase.KEY_ACCOUNT_UID] = dataItem.uid;
      }

      if (dataItem.appUserID != null && dataItem.appUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_APPUSERID] = dataItem.appUserID;
      }

      if (dataItem.assignedByAppUserID != null &&
          dataItem.assignedByAppUserID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ASSIGNEDBYAPPUSERID] =
            dataItem.assignedByAppUserID;
      }

      if (dataItem.appUserGroupID != null &&
          dataItem.appUserGroupID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      }

      if (dataItem.isArchived != null && dataItem.isArchived != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISARCHIVED] = dataItem.isArchived;
      }

      if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ISDELETED] = dataItem.isDeleted;
      }

      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null") {
        values[ColumnsBase.KEY_ACCOUNT_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
      }

      if (dataItem.accountCodeInternal != null &&
          dataItem.accountCodeInternal != "null") {
        values[ColumnsBase.KEY_ACCOUNT_ACCOUNTCODEINTERNAL] =
            dataItem.accountCodeInternal;
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

      id = await db.update(TablesBase.TABLE_ACCOUNT, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);

      // id = await db.insert(TablesBase.TABLE_ACCOUNT, values);

      //db.close();
    } catch (ex) {
      // Globals.HandleException(context, "DatabaseHandler:AddAccountRecord()", ex);
      throw ex;
    }
    return id;
  }
}
