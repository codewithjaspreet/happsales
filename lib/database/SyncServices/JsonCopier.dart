import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountSegmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactMediaDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/DatabaseHandler.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CreditRatingDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CurrencyDataHandlerBase.dart';
import 'package:happsales_crm/database/models/OtherModels/BusinessUnit.dart';

import '../Globals.dart';
import '../Handlers/AccountHandlers/AccountDataHandler.dart';
import '../Handlers/AccountHandlers/AccountSegmentDataHandler.dart';
import '../Handlers/AccountHandlers/AccountTypeHandlerBase.dart';
import '../Handlers/OtherHandlers/BusinessUnitDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CurrencyDataHandler.dart';
import '../models/AccountModels/Account.dart';
import '../models/AccountModels/AccountAddress.dart';
import '../models/AccountModels/AccountBusinessPlan.dart';
import '../models/AccountModels/AccountBusinessUnit.dart';
import '../models/AccountModels/AccountBuyingProcess.dart';
import '../models/AccountModels/AccountCategory.dart';
import '../models/AccountModels/AccountSegment.dart';
import '../models/AccountModels/AccountStatus.dart';
import '../models/AccountModels/AccountType.dart';
import '../models/ContactModels.dart/Contact.dart';
import '../models/OtherModels/CreditRating.dart';
import '../models/OtherModels/Currency.dart';

import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import 'Utility.dart';

class JSONCopier{


  static Future<Account> CopyJsonDataToAccount( DatabaseHandler dbHandler,     Map<String, dynamic> jsonObj, Account account, bool isForNew) async{
        try {

          if (jsonObj.containsKey('AccountID')) {
  account.accountID = jsonObj['AccountID'] ?? '';
}

if (jsonObj.containsKey('AccountCode')) {
  account.accountCode = jsonObj['AccountCode'] ?? '';
}

if (jsonObj.containsKey('AccountName')) {
  account.accountName = jsonObj['AccountName'] ?? '';
}

if (jsonObj.containsKey('AccountLocation')) {
  account.accountLocation = jsonObj['AccountLocation'] ?? '';
}

if (jsonObj.containsKey('AccountIdentifier')) {
  account.accountIdentifier = jsonObj['AccountIdentifier'] ?? '';
}

if (jsonObj.containsKey('AccountSegmentID')) {
  String? accountSegmentId = jsonObj['AccountSegmentID'];
  accountSegmentId = accountSegmentId != null && accountSegmentId.isNotEmpty ? accountSegmentId : '-1';
  AccountSegment? accountSegment = await AccountSegmentDataHandlerBase.GetMasterAccountSegmentRecord(dbHandler, accountSegmentId);
  if (accountSegment != null) {
    account.accountSegmentID = accountSegment.id;
  }
}



  if (jsonObj.containsKey('AccountStatusID')) {
  String? accountStatusId = jsonObj['AccountStatusID'];
  accountStatusId = accountStatusId != null && accountStatusId.isNotEmpty ? accountStatusId : "-1";
  AccountStatus? accountStatus = await AccountStatusDataHandlerBase.GetMasterAccountStatusRecord(dbHandler, accountStatusId);
  if (accountStatus != null) {
    account.accountStatusID = accountStatus.id;
  }
}



            if (jsonObj.containsKey('AccountTypeID')) {
  String? accountTypeId = jsonObj['AccountTypeID'];
  accountTypeId = accountTypeId != null && accountTypeId.isNotEmpty ? accountTypeId : '-1';
  AccountType? accountType = await  AccountTypeDataHandlerBase.GetMasterAccountTypeRecord(dbHandler, accountTypeId);
  if (accountType != null) {
    account.accountTypeID = accountType.id;
  }
}


if (jsonObj.containsKey("ParentAccountID")) {
  String accountId = jsonObj["ParentAccountID"];
  accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
  Account? account1 =  await AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
  if (account1 != null) {
    account.parentAccountID = account1.id;
  }
}

if (jsonObj.containsKey('IndustryName')) {
  account.industryName = jsonObj['IndustryName'];
}

if (jsonObj.containsKey('Website')) {
  account.website = jsonObj['Website'];
}

if (jsonObj.containsKey('Turnover')) {
  account.turnover = jsonObj['Turnover'];
}

if (jsonObj.containsKey('NumberOfEmployees')) {
  account.numberOfEmployees = jsonObj['NumberOfEmployees'];
}

if (jsonObj.containsKey('CreditRatingID')) {
  String? creditRatingId = jsonObj['CreditRatingID'];
  creditRatingId = creditRatingId != null && creditRatingId.isNotEmpty ? creditRatingId : '-1';
  CreditRating? creditRating = await CreditRatingDataHandlerBase.GetMasterCreditRatingRecord(dbHandler, creditRatingId);
  if (creditRating != null) {
    account.creditRatingID = creditRating.id;
  }
}


if (jsonObj.containsKey("CurrencyID")) {
  String currencyId = jsonObj["CurrencyID"];
  currencyId = currencyId != null && currencyId.isNotEmpty ? currencyId : "-1";
  Currency? currency = await CurrencyDataHandlerBase.GetMasterCurrencyRecord(dbHandler, currencyId);
  if (currency != null) {
    account.currencyID = currency.id;
  }
}

if (jsonObj.containsKey("Phone")) {
  account.phone = jsonObj["Phone"];
}



            



          if (jsonObj.containsKey("PrimaryContactName")) {
            account.primaryContactName = Utility.getEmptyIfNull(jsonObj["PrimaryContactName"]);
          }
if (jsonObj.containsKey("Email")) {
  account.email = jsonObj["Email"];
}
if (jsonObj.containsKey("Fax")) {
  account.fax = jsonObj["Fax"];
}
if (jsonObj.containsKey("AddressLine1")) {
  account.addressLine1 = jsonObj["AddressLine1"];
}
if (jsonObj.containsKey("AddressLine2")) {
  account.addressLine2 = jsonObj["AddressLine2"];
}
if (jsonObj.containsKey("AddressLine3")) {
  account.addressLine3 = jsonObj["AddressLine3"];
}
if (jsonObj.containsKey("City")) {
  account.city = jsonObj["City"];
}
if (jsonObj.containsKey("State")) {
  account.state = jsonObj["State"];
}
if (jsonObj.containsKey("Country")) {
  account.country = jsonObj["Country"];
}
if (jsonObj.containsKey("PIN")) {
  account.pin = jsonObj["PIN"];
}
if (jsonObj.containsKey("TerritoryName")) {
  account.territoryName = jsonObj["TerritoryName"];
}
if (jsonObj.containsKey("GPSCoordinates")) {
  account.gpsCoordinates = jsonObj["GPSCoordinates"];
}
if (jsonObj.containsKey("LogoImagePath")) {
  account.logoImagePath = jsonObj["LogoImagePath"];
}
if (jsonObj.containsKey("LogoImageContent")) {
  account.logoImageContent = jsonObj["LogoImageContent"];
}
if (jsonObj.containsKey("TaxPayerIdentificationNumber")) {
  account.taxPayerIdentificationNumber = jsonObj["TaxPayerIdentificationNumber"];
}
if (jsonObj.containsKey("FreeTextField1")) {
  account.freeTextField1 = jsonObj["FreeTextField1"];
}
if (jsonObj.containsKey("FreeTextField2")) {
  account.freeTextField2 = jsonObj["FreeTextField2"];
}
if (jsonObj.containsKey("FreeTextField3")) {
  account.freeTextField3 = jsonObj["FreeTextField3"];
}
if (jsonObj.containsKey("Tags")) {
  account.tags = jsonObj["Tags"];
}
if (jsonObj.containsKey("MarketingContactID")) {
  account.marketingContactID = jsonObj["MarketingContactID"];
}
if (jsonObj.containsKey("AccountCodeInternal")) {
  account.accountCodeInternal = jsonObj["AccountCodeInternal"];
}
if (jsonObj.containsKey("CreatedBy")) {
  account.createdBy = jsonObj["CreatedBy"];
}
if (jsonObj.containsKey("CreatedOn")) {
  account.createdOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedBy")) {
  account.modifiedBy = jsonObj["ModifiedBy"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  account.modifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("DeviceIdentifier")) {
  account.deviceIdentifier = jsonObj["DeviceIdentifier"];
}
if (jsonObj.containsKey("ReferenceIdentifier")) {
  account.referenceIdentifier = jsonObj["ReferenceIdentifier"];
}
if (jsonObj.containsKey("IsActive")) {
  account.isActive = jsonObj["IsActive"];
}
if (jsonObj.containsKey("Uid")) {
  account.uid = jsonObj["Uid"];
}

if (jsonObj.containsKey("AppUserID")) {
  account.appUserID = jsonObj["AppUserID"];
}
if (jsonObj.containsKey("AssignedByAppUserID")) {
  account.assignedByAppUserID = Utility.getEmptyIfNull(jsonObj["AssignedByAppUserID"]);
}
if (jsonObj.containsKey("AppUserGroupID")) {
  account.appUserGroupID = jsonObj["AppUserGroupID"];
}
if (jsonObj.containsKey("IsArchived")) {
  account.isArchived = jsonObj["IsArchived"];
}
if (jsonObj.containsKey("IsDeleted")) {
  account.isDeleted = jsonObj["IsDeleted"];
}
if (jsonObj.containsKey("LeadQualificationID")) {
  account.leadQualificationID = jsonObj["LeadQualificationID"];
}

account.isDirty = false;
account.isDeleted1 = true;
account.upSyncMessage = "";
account.downSyncMessage = "";
if (jsonObj.containsKey("CreatedOn")) {
  account.sCreatedOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  account.sModifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("CreatedByUser")) {
  account.createdByUser = jsonObj["CreatedByUser"];
}
if (jsonObj.containsKey("ModifiedByUser")) {
  account.modifiedByUser = jsonObj["ModifiedByUser"];
}
account.upSyncIndex = "0";

account.ownerUserID = Globals.AppUserID.toString();

        } catch ( ex) {
            Globals.handleException( "JSONDataCopier:CopyJsonDataToAccount()", ex);
        }
        return account;
    }


  static Future<AccountAddress?> CopyJsonDataToAccountAddress( DatabaseHandler dbHandler, Map<String,dynamic> jsonObj, AccountAddress accountAddress, bool isForNew) async{
        try {

            if (jsonObj.containsKey("AccountAddressID")) {
  accountAddress.accountAddressID = jsonObj["AccountAddressID"];
}
if (jsonObj.containsKey("AccountAddressCode")) {
  accountAddress.accountAddressCode = jsonObj["AccountAddressCode"];
}
if (jsonObj.containsKey("AddressTypeName")) {
  accountAddress.addressTypeName = jsonObj["AddressTypeName"];
}
if (jsonObj.containsKey("AddressLine1")) {
  accountAddress.addressLine1 = jsonObj["AddressLine1"];
}
if (jsonObj.containsKey("AddressLine2")) {
  accountAddress.addressLine2 = jsonObj["AddressLine2"];
}
if (jsonObj.containsKey("AddressLine3")) {
  accountAddress.addressLine3 = jsonObj["AddressLine3"];
}
if (jsonObj.containsKey("City")) {
  accountAddress.city = jsonObj["City"];
}
if (jsonObj.containsKey("State")) {
  accountAddress.state = jsonObj["State"];
}
if (jsonObj.containsKey("Country")) {
  accountAddress.country = jsonObj["Country"];
}
if (jsonObj.containsKey("PIN")) {
  accountAddress.pin = jsonObj["PIN"];
}


if (jsonObj.containsKey("AccountID")) {
  String accountId = jsonObj["AccountID"];
  accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
  Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
  if (account != null) {
    accountAddress.accountID = account.id;
  }
}

if (jsonObj.containsKey("ContactID")) {
  String contactId = jsonObj["ContactID"];
  contactId = contactId != null && contactId.isNotEmpty ? contactId : "-1";
  Contact contact = await ContactDataHandlerBase.GetMasterContactRecord(dbHandler, contactId);
  if (contact != null) {
    accountAddress.contactID = contact.id;
  }
}



         if (jsonObj.containsKey("GPSCoordinates")) {
  accountAddress.gpsCoordinates = jsonObj["GPSCoordinates"];
}
if (jsonObj.containsKey("CreatedBy")) {
  accountAddress.createdBy = jsonObj["CreatedBy"];
}
if (jsonObj.containsKey("CreatedOn")) {
  accountAddress.createdOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedBy")) {
  accountAddress.modifiedBy = jsonObj["ModifiedBy"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  accountAddress.modifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("DeviceIdentifier")) {
  accountAddress.deviceIdentifier = jsonObj["DeviceIdentifier"];
}
if (jsonObj.containsKey("ReferenceIdentifier")) {
  accountAddress.referenceIdentifier = jsonObj["ReferenceIdentifier"];
}
if (jsonObj.containsKey("IsActive")) {
  accountAddress.isActive = jsonObj["IsActive"];
}
if (jsonObj.containsKey("Uid")) {
  accountAddress.uid = jsonObj["Uid"];
}

if (jsonObj.containsKey("AppUserID")) {
  accountAddress.appUserID = jsonObj["AppUserID"];
}

if (jsonObj.containsKey("AppUserGroupID")) {
  accountAddress.appUserGroupID = jsonObj["AppUserGroupID"];
}
if (jsonObj.containsKey("IsArchived")) {
  accountAddress.isArchived = jsonObj["IsArchived"];
}
if (jsonObj.containsKey("IsDeleted")) {
  accountAddress.isDeleted = jsonObj["IsDeleted"];
}
if (jsonObj.containsKey("LeadQualificationID")) {
  accountAddress.leadQualificationID = jsonObj["LeadQualificationID"];
}

accountAddress.isDirty = "false";
accountAddress.isDeleted1 = "false";
accountAddress.upSyncMessage = "";
accountAddress.downSyncMessage = "";
if (jsonObj.containsKey("CreatedOn")) {
  accountAddress.sCreatedOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  accountAddress.sModifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("CreatedByUser")) {
  accountAddress.createdByUser = jsonObj["CreatedByUser"];
}
if (jsonObj.containsKey("ModifiedByUser")) {
  accountAddress.modifiedByUser = jsonObj["ModifiedByUser"];
}
accountAddress.upSyncIndex = "0";

/*if (jsonObj.containsKey("AppUserID"))
    accountAddress.ownerUserID = jsonObj["AppUserID"];*/
accountAddress.ownerUserID = Globals.AppUserID.toString();

        } catch ( ex) {
            Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountAddress()", ex);
        }
        return accountAddress;
    }


    static Future<AccountBusinessPlan> CopyJsonDataToAccountBusinessPlan(  DatabaseHandler dbHandler, Map<String,dynamic> jsonObj, AccountBusinessPlan accountBusinessPlan, bool isForNew) async{
        try {

           if (jsonObj.containsKey("AccountBusinessPlanID")) {
  accountBusinessPlan.accountBusinessPlanID = jsonObj["AccountBusinessPlanID"];
}
if (jsonObj.containsKey("AccountBusinessPlanCode")) {
  accountBusinessPlan.accountBusinessPlanCode = jsonObj["AccountBusinessPlanCode"];
}
if (jsonObj.containsKey("BusinessPlans")) {
  accountBusinessPlan.businessPlans = jsonObj["BusinessPlans"];
}

if (jsonObj.containsKey("AccountID")) {
  String accountId = jsonObj["AccountID"];
  accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
  Account? account = await  AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
  if (account != null) {
    accountBusinessPlan.accountID = account.id;
  }
}


            if (jsonObj.containsKey('AccountBusinessPlanID')) {
  accountBusinessPlan.accountBusinessPlanID = jsonObj['AccountBusinessPlanID'];
}
if (jsonObj.containsKey('AccountBusinessPlanCode')) {
  accountBusinessPlan.accountBusinessPlanCode = jsonObj['AccountBusinessPlanCode'];
}
if (jsonObj.containsKey('BusinessPlans')) {
  accountBusinessPlan.businessPlans = jsonObj['BusinessPlans'];
}

if (jsonObj.containsKey('AccountID')) {
  String accountId = jsonObj['AccountID'];
  accountId = accountId != null && accountId.isNotEmpty ? accountId : '-1';
  Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
  if (account != null) {
    accountBusinessPlan.accountID = account.id;
  }
}

if (jsonObj.containsKey('CustomerTargetDate')) {
  accountBusinessPlan.customerTargetDate = jsonObj['CustomerTargetDate'];
}
if (jsonObj.containsKey('CreatedBy')) {
  accountBusinessPlan.createdBy = jsonObj['CreatedBy'];
}
if (jsonObj.containsKey('CreatedOn')) {
  accountBusinessPlan.createdOn = jsonObj['CreatedOn'];
}
if (jsonObj.containsKey('ModifiedBy')) {
  accountBusinessPlan.modifiedBy = jsonObj['ModifiedBy'];
}
if (jsonObj.containsKey('ModifiedOn')) {
  accountBusinessPlan.modifiedOn = jsonObj['ModifiedOn'];
}
if (jsonObj.containsKey('DeviceIdentifier')) {
  accountBusinessPlan.deviceIdentifier = jsonObj['DeviceIdentifier'];
}
if (jsonObj.containsKey('ReferenceIdentifier')) {
  accountBusinessPlan.referenceIdentifier = jsonObj['ReferenceIdentifier'];
}
if (jsonObj.containsKey('IsActive')) {
  accountBusinessPlan.isActive = jsonObj['IsActive'];
}
if (jsonObj.containsKey('Uid')) {
  accountBusinessPlan.uid = jsonObj['Uid'];
}

if (jsonObj.containsKey('AppUserID')) {
  accountBusinessPlan.appUserID = jsonObj['AppUserID'];
}

if (jsonObj.containsKey('AppUserGroupID')) {
  accountBusinessPlan.appUserGroupID = jsonObj['AppUserGroupID'];
}
if (jsonObj.containsKey('IsArchived')) {
  accountBusinessPlan.isArchived = jsonObj['IsArchived'];
}
if (jsonObj.containsKey('IsDeleted')) {
  accountBusinessPlan.isDeleted = jsonObj['IsDeleted'];
}

accountBusinessPlan.isDirty = 'false';
accountBusinessPlan.isDeleted1 = 'false';
accountBusinessPlan.upSyncMessage = '';
accountBusinessPlan.downSyncMessage = '';
if (jsonObj.containsKey('CreatedOn')) {
  accountBusinessPlan.sCreatedOn = jsonObj['CreatedOn'];
}
if (jsonObj.containsKey('ModifiedOn')) {
  accountBusinessPlan.sModifiedOn = jsonObj['ModifiedOn'];
}
if (jsonObj.containsKey('CreatedByUser')) {
  accountBusinessPlan.createdByUser = jsonObj['CreatedByUser'];
}
if (jsonObj.containsKey('ModifiedByUser')) {
  accountBusinessPlan.modifiedByUser = jsonObj['ModifiedByUser'];
}
accountBusinessPlan.upSyncIndex = '0';

/* if (jsonObj.has("AppUserID"))
    accountBusinessPlan.ownerUserID = jsonObj['AppUserID']; */
accountBusinessPlan.ownerUserID = Globals.AppUserID.toString();

        } catch ( ex) {
            Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountBusinessPlan()", ex);
        }
        return accountBusinessPlan;
    }

 
 
 static  Future<AccountBusinessUnit?> CopyJsonDataToAccountBusinessUnit(  DatabaseHandler dbHandler,  Map<String,dynamic> jsonObj, AccountBusinessUnit accountBusinessUnit, bool isForNew) async {
        try {

           if (jsonObj.containsKey("AccountBusinessUnitID")) {
             accountBusinessUnit.accountBusinessUnitID = jsonObj["AccountBusinessUnitID"];
           }
if (jsonObj.containsKey("AccountBusinessUnitCode")) {
  accountBusinessUnit.accountBusinessUnitCode = jsonObj["AccountBusinessUnitCode"];
}

if (jsonObj.containsKey("AccountID")) {
  String accountId = jsonObj["AccountID"];
  accountId = (accountId != null && accountId.isNotEmpty) ? accountId : "-1";
  Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
  if (account != null) {
    accountBusinessUnit.accountID = account.id;
  }
}

if (jsonObj.containsKey("BusinessUnitID")) {
  String businessUnitId = jsonObj["BusinessUnitID"];
  businessUnitId = (businessUnitId != null && businessUnitId.isNotEmpty) ? businessUnitId : "-1";
  BusinessUnit? businessUnit = await  BusinessUnitDataHandlerBase.GetMasterBusinessUnitRecord(dbHandler, businessUnitId);
  if (businessUnit != null) {
    accountBusinessUnit.businessUnitID = businessUnit.id;
  }
}

if (jsonObj.containsKey("CreatedBy")) {
  accountBusinessUnit.createdBy = jsonObj["CreatedBy"];
}
if (jsonObj.containsKey("CreatedOn")) {
  accountBusinessUnit.createdOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedBy")) {
  accountBusinessUnit.modifiedBy = jsonObj["ModifiedBy"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  accountBusinessUnit.modifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("IsActive")) {
  accountBusinessUnit.isActive = jsonObj["IsActive"];
}
if (jsonObj.containsKey("Uid")) {
  accountBusinessUnit.uid = jsonObj["Uid"];
}
if (jsonObj.containsKey("AppUserID")) {
  accountBusinessUnit.appUserID = jsonObj["AppUserID"];
}
if (jsonObj.containsKey("AppUserGroupID")) {
  accountBusinessUnit.appUserGroupID = jsonObj["AppUserGroupID"];
}
if (jsonObj.containsKey("ReferenceIdentifier")) {
  accountBusinessUnit.referenceIdentifier = jsonObj["ReferenceIdentifier"];
}
if (jsonObj.containsKey("IsDeleted")) {
  accountBusinessUnit.isDeleted = jsonObj["IsDeleted"];
}
if (jsonObj.containsKey("IsArchived")) {
  accountBusinessUnit.isArchived = jsonObj["IsArchived"];
}

accountBusinessUnit.isDirty = "false";
accountBusinessUnit.isDeleted1 = "false";
accountBusinessUnit.upSyncMessage = "";
accountBusinessUnit.downSyncMessage = "";
if (jsonObj.containsKey("CreatedOn")) {
  accountBusinessUnit.sCreatedOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  accountBusinessUnit.sModifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("CreatedByUser")) {
  accountBusinessUnit.createdByUser = jsonObj["CreatedByUser"];
}
if (jsonObj.containsKey("ModifiedByUser")) {
  accountBusinessUnit.modifiedByUser = jsonObj["ModifiedByUser"];
}
accountBusinessUnit.upSyncIndex = "0";
accountBusinessUnit.ownerUserID = Globals.AppUserID.toString();

        } catch ( ex) {
            Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountBusinessUnit()", ex);
        }
        return accountBusinessUnit;
    }
}

Future<AccountBuyingProcess> copyJsonDataToAccountBuyingProcess(
     
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AccountBuyingProcess accountBuyingProcess,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AccountBuyingProcessID")) {
      accountBuyingProcess.accountBuyingProcessID =
          jsonObj["AccountBuyingProcessID"].toString();
    }
    if (jsonObj.containsKey("AccountBuyingProcessCode")) {
      accountBuyingProcess.accountBuyingProcessCode =
          jsonObj["AccountBuyingProcessCode"].toString();
    }
    if (jsonObj.containsKey("BuyingProcess")) {
      accountBuyingProcess.buyingProcess =
          jsonObj["BuyingProcess"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account? account =
          await AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
      if (account != null) {
        accountBuyingProcess.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("CreatedBy")) {
      accountBuyingProcess.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountBuyingProcess.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountBuyingProcess.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountBuyingProcess.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      accountBuyingProcess.deviceIdentifier =
          jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      accountBuyingProcess.referenceIdentifier =
          jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      accountBuyingProcess.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      accountBuyingProcess.uid = jsonObj["Uid"].toString();
    }

    if (jsonObj.containsKey("AppUserID")) {
      accountBuyingProcess.appUserID = jsonObj["AppUserID"].toString();
    }

    if (jsonObj.containsKey("AppUserGroupID")) {
      accountBuyingProcess.appUserGroupID =
          jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountBuyingProcess.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountBuyingProcess.isDeleted = jsonObj["IsDeleted"].toString();
    }

    accountBuyingProcess.isDirty = "false";
    accountBuyingProcess.isDeleted1 = "false";
    accountBuyingProcess.upSyncMessage = "";
    accountBuyingProcess.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountBuyingProcess.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountBuyingProcess.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountBuyingProcess.createdByUser =
          jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountBuyingProcess.modifiedByUser =
          jsonObj["ModifiedByUser"].toString();
    }
    accountBuyingProcess.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID"))
      accountBuyingProcess.ownerUserID = jsonObj["AppUserID"].toString();*/
    accountBuyingProcess.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountBuyingProcess()", ex);
  }
  return accountBuyingProcess;


}


AccountCategory copyJsonDataToAccountCategory(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AccountCategory accountCategory,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("AccountCategoryID")) {
      accountCategory.accountCategoryID =
          jsonObj["AccountCategoryID"].toString();
    }
    if (jsonObj.containsKey("AccountCategoryCode")) {
      accountCategory.accountCategoryCode =
          jsonObj["AccountCategoryCode"].toString();
    }
    if (jsonObj.containsKey("AccountCategoryName")) {
      accountCategory.accountCategoryName =
          jsonObj["AccountCategoryName"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountCategory.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      accountCategory.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCategory.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountCategory.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      accountCategory.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      accountCategory.uid = jsonObj["Uid"].toString();
    }

    if (jsonObj.containsKey("AppUserID")) {
      accountCategory.appUserID = jsonObj["AppUserID"].toString();
    }

    if (jsonObj.containsKey("AppUserGroupID")) {
      accountCategory.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountCategory.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountCategory.isDeleted = jsonObj["IsDeleted"].toString();
    }

    accountCategory.isDirty = "false";
    accountCategory.isDeleted1 = "false";
    accountCategory.upSyncMessage = "";
    accountCategory.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountCategory.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCategory.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountCategory.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountCategory.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    accountCategory.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID"))
      accountCategory.ownerUserID = jsonObj["AppUserID"].toString();*/
    accountCategory.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountCategory()", ex);
  }
  return accountCategory;
}


