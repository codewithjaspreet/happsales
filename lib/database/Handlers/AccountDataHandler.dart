import 'package:sqflite/sqflite.dart';
import '../AppTables/Columns.dart';
import '../AppTables/ColumnsBase.dart';
import 'DatabaseHandler.dart';
import '../AppTables/Globals.dart';
import '../AppTables/TablesBase.dart';
import '../models/Account.dart';

class AccountDataHandler {
 

  // static Future<int> GetAccountProfileCompleteness(Database databaseHandler, String accountId) async
  //   {

  //       int profilePercentage = 0;

  //       final db = await databaseHandler.database;
  //       String sql = "";
  //       try
  //       {
  //           sql = "SELECT AccountSegmentID FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT Phone FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT IndustryName FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 10;

  //           sql = "SELECT Website FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 10;

  //           sql = "SELECT Turnover FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 10;

  //           sql = "SELECT NumberOfEmployees FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 10;

  //           sql = "SELECT CreditRatingID FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.isNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT COUNT(AccountCategoryMappingID) FROM AccountCategoryMapping WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(db.executeScalar(sql) > 0) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT COUNT(ContactID) FROM Contact WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(databaseHandler.executeScalar(sql) > 0) profilePercentage = profilePercentage + 20;

  //           sql = "SELECT COUNT(AccountAddressID) FROM AccountAddress WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(databaseHandler.executeScalar(sql) > 0) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT TerritoryName FROM Account WHERE Id = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(!Globals.IsNullOrEmpty(databaseHandler.ExecuteStringValue(sql))) profilePercentage = profilePercentage + 5;

  //           sql = "SELECT COUNT(AccountBuyingProcessID) FROM AccountBuyingProcess WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(databaseHandler.executeScalar(sql) > 0) profilePercentage = profilePercentage + 4;

  //           sql = "SELECT COUNT(AccountBusinessPlanID) FROM AccountBusinessPlan WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(databaseHandler.executeScalar(sql) > 0) profilePercentage = profilePercentage + 3;

  //           sql = "SELECT COUNT(AccountCompetitionActivityID) FROM AccountCompetitionActivity WHERE AccountID = $accountId AND AppUserGroupID = ${Globals.AppUserGroupID}";
  //           if(databaseHandler.executeScalar(sql) > 0) profilePercentage = profilePercentage + 3;

  //       }
  //       catch ( ex) {
  //           // Globals.HandleException(context, "AccountDataHandler:GetAccountProfileCompleteness()", ex);
  //           throw ex;
  //       }
  //       return profilePercentage;
  //   }

  static Future<List<Account>> GetAccountLogoUploadRecords(
      DatabaseHandler databaseHandler, String changeType) async {
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
          " WHERE A.${Columns.KEY_ACCOUNT_LOGO_ISUPLOADED} = 'false' AND A.${ColumnsBase.KEY_ISDELETED} = 'false' "; //" AND A." + ColumnsBase.KEY_UPSYNCINDEX + " <= " + Globals.SyncIndex;
      selectQuery +=
          " AND COALESCE(A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTCODE},'') <> ''";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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

        // Add any other property assignments here
        dataList.add(dataItem);
      }
    } catch (e) {
      print(e.toString());
    }

    return dataList;
  }

  static Future<List<Account>> GetSupplierAccountRecords(
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
      selectQuery += " AND A.${ColumnsBase.KEY_ACCOUNT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACCOUNT_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ID} IN (SELECT C1.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID}";
      selectQuery += " FROM ${TablesBase.TABLE_ACCOUNTCATEGORYMAPPING} A1 ";
      selectQuery +=
          " INNER JOIN ${TablesBase.TABLE_ACCOUNTCATEGORY} B1 ON A1.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTCATEGORYID} = B1.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " INNER JOIN ${TablesBase.TABLE_ACCOUNT} C1 ON A1.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_ACCOUNTID} = C1.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A1.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A1.${ColumnsBase.KEY_ACCOUNTCATEGORYMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND B1.${ColumnsBase.KEY_ACCOUNTCATEGORY_ACCOUNTCATEGORYNAME} = 'Supplier')";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '${searchString.replaceAll("'", "''")}%' ";
      }
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} COLLATE NOCASE ASC ";

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

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
        dataList.add(dataItem);
      }
    } catch (e) {
      print(e.toString());
    }

    return dataList;
  }

  static Future<Account> GetAccountRecordByAccountName(
      DatabaseHandler databaseHandler, String accountName) async {
    Account dataItem = Account();

    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACCOUNT} WHERE ${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} = '${accountName.replaceAll("'", "''")}'";

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

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (e) {
      print(e.toString());
    }

    return dataItem;
  }

  static Future<Account?> GetAccountRecordContainsAccountNameAndLocation(
      DatabaseHandler databaseHandler,
      String accountName,
      String location) async {
    Account? dataItem;
    try {
      String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNT}";
      selectQuery += " WHERE ${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} = '${accountName.replaceAll("'", "''")}' COLLATE NOCASE ";
      selectQuery += " AND ${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} = '${location.replaceAll("'", "''")}' COLLATE NOCASE";

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

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
    } catch (e) {
      print(e.toString());
    }

    return dataItem;
  }

  static Future<List<Account>> GetAccountRecordContainsAccountName(DatabaseHandler databaseHandler , String accountName) async{
        
        
        List<Account> dataList =  [];

        try{

           String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNT} WHERE ${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${accountName.replaceAll("'","''")}%' COLLATE NOCASE";
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

        /// some setters left - sir will give another class for this

        // Add any other property assignments here
      }
        }
        catch(e){
          print(e.toString());
        }

        return dataList;



  }

   static Future<Account> GetAccountRecordByAccountNameAndAccountLocation(
      DatabaseHandler databaseHandler, String accountName,String accountLocation) async {
    Account dataItem = Account();

    try {
      String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACCOUNT} WHERE ${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} = '${accountName.replaceAll("'","''")}'";
            selectQuery += "${" AND ${ColumnsBase.KEY_ACCOUNT_ACCOUNTLOCATION} = '${accountLocation.replaceAll("'","''")}"}'";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);

      for (var element in result) {
         dataItem =  Account();

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
    } catch (e) {
      print(e.toString());
    }

    return dataItem;
  }
  

}
