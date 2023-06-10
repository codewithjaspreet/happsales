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
       
        Account dataItem =  Account();

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
      if (searchString.trim().isNotEmpty)
        selectQuery +=
            "${" AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}"}%'";
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
    }
    
     catch (ex) {
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

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME},C.${ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME},D.${ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME},J.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME},G.${ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
        String selectQuery = "${"SELECT A.* " + ",B." + ColumnsBase.KEY_ACCOUNTSEGMENT_ACCOUNTSEGMENTNAME + ",C." + ColumnsBase.KEY_ACCOUNTSTATUS_ACCOUNTSTATUSNAME + ",D." + ColumnsBase.KEY_ACCOUNTTYPE_ACCOUNTTYPENAME + ",J." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTNAME + ",G." + ColumnsBase.KEY_CREDITRATING_CREDITRATINGNAME},H.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACCOUNT} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSEGMENT} B ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSEGMENTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTSTATUS} C ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTSTATUSID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNTTYPE} D ON A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTTYPEID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CREDITRATING} G ON A.${ColumnsBase.KEY_ACCOUNT_CREDITRATINGID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} H ON A.${ColumnsBase.KEY_ACCOUNT_CURRENCYID} = H.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} J ON A.${ColumnsBase.KEY_ACCOUNT_PARENTACCOUNTID} = J.${ColumnsBase.KEY_ID}";
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
       String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNT + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'false' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + Tables.TABLE_ACCOUNT + " WHERE " + Columns.KEY_ISDIRTY + " = 'true' AND " + Columns.KEY_ISDELETED + " = 'true' " + " AND " + Columns.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
  } catch ( ex) {
    // Globals.handleException(context, "AccountDataHandlerBase:getLocalId()", ex);
    throw ex;
  }
  return localId;
}

}
