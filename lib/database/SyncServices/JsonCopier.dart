import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountAddressDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountFormDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountSegmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityApprovalDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityApprovalTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityPriorityDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityTravelDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactMediaDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CreditRatingDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CurrencyDataHandlerBase.dart';
import 'package:happsales_crm/database/models/ActivityModels/ActivityBusinessUnit.dart';
import 'package:happsales_crm/database/models/OtherModels/BusinessUnit.dart';
import '../Globals.dart';
import '../Handlers/AccountHandlers/AccountDataHandler.dart';
import '../Handlers/AccountHandlers/AccountFormDataHandler.dart';
import '../Handlers/AccountHandlers/AccountSegmentDataHandler.dart';
import '../Handlers/AccountHandlers/AccountTypeHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandlerBase.dart';
import '../Handlers/DatabaseHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityDataHandler.dart';
import '../Handlers/OtherHandlers/AppFeatureDataHandlerBase.dart';
import '../Handlers/OtherHandlers/BusinessUnitDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CurrencyDataHandler.dart';
import '../Handlers/OtherHandlers/FormDataHandlerBase.dart';
import '../models/AccountModels/Account.dart';
import '../models/AccountModels/AccountAddress.dart';
import '../models/AccountModels/AccountBusinessPlan.dart';
import '../models/AccountModels/AccountBusinessUnit.dart';
import '../models/AccountModels/AccountBuyingProcess.dart';
import '../models/AccountModels/AccountCategory.dart';
import '../models/AccountModels/AccountCategoryMapping.dart';
import '../models/AccountModels/AccountCompetitionActivity.dart';
import '../models/AccountModels/AccountForm.dart';
import '../models/AccountModels/AccountFormValue.dart';
import '../models/AccountModels/AccountMedia.dart';
import '../models/AccountModels/AccountPhone.dart';
import '../models/AccountModels/AccountSegment.dart';
import '../models/AccountModels/AccountStatus.dart';
import '../models/AccountModels/AccountTeritory.dart';
import '../models/AccountModels/AccountType.dart';
import '../models/ActivityModels/Activity.dart';
import '../models/ActivityModels/ActivityApproval.dart';
import '../models/ActivityModels/ActivityApprovalType.dart';
import '../models/ActivityModels/ActivityMeasure.dart';
import '../models/ActivityModels/ActivityMedia.dart';
import '../models/ActivityModels/ActivityPermission.dart';
import '../models/ActivityModels/ActivityPriority.dart';
import '../models/ActivityModels/ActivityProduct.dart';
import '../models/ActivityModels/ActivityProductDetail.dart';
import '../models/ActivityModels/ActivityStatus.dart';
import '../models/ActivityModels/ActivityTeam.dart';
import '../models/ActivityModels/ActivityTravel.dart';
import '../models/ActivityModels/ActivityTravelExpense.dart';
import '../models/ActivityModels/ActivityTravelMapping.dart';
import '../models/ActivityModels/ActivityTravelMedia.dart';
import '../models/ActivityModels/ActivityType.dart';
import '../models/ContactModels.dart/Contact.dart';
import '../models/OpportunityModels/Opportunity.dart';
import '../models/OtherModels/AddressType.dart';
import '../models/OtherModels/AppFeature.dart';
import '../models/OtherModels/AppFeatureField.dart';
import '../models/OtherModels/AppFeatureGroup.dart';
import '../models/OtherModels/AppLog.dart';
import '../models/OtherModels/AppReport.dart';
import '../models/OtherModels/AppUsage.dart';
import '../models/OtherModels/AppUser.dart';
import '../models/OtherModels/AppUserLocation.dart';
import '../models/OtherModels/AppUserMessage.dart';
import '../models/OtherModels/AppUserType.dart';
import '../models/OtherModels/BusinessFeature.dart';
import '../models/OtherModels/CreditRating.dart';
import '../models/OtherModels/Currency.dart';
// base entity;


import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import '../models/OtherModels/ExpenseType.dart';
import '../models/OtherModels/Form.dart';
import '../models/OtherModels/FormCellElementBase.dart';
import '../models/OtherModels/ModeOfTravel.dart';
import '../models/OtherModels/Product.dart';
import '../models/OtherModels/Territory.dart';
import 'Utility.dart';

class JSONCopier {
  static Future<Account> CopyJsonDataToAccount(DatabaseHandler dbHandler,
      Map<String, dynamic> jsonObj, Account account, bool isForNew) async {
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
        accountSegmentId =
            accountSegmentId != null && accountSegmentId.isNotEmpty
                ? accountSegmentId
                : '-1';
        AccountSegment? accountSegment =
            await AccountSegmentDataHandlerBase.GetMasterAccountSegmentRecord(
                dbHandler, accountSegmentId);
        if (accountSegment != null) {
          account.accountSegmentID = accountSegment.id;
        }
      }

      if (jsonObj.containsKey('AccountStatusID')) {
        String? accountStatusId = jsonObj['AccountStatusID'];
        accountStatusId = accountStatusId != null && accountStatusId.isNotEmpty
            ? accountStatusId
            : "-1";
        AccountStatus? accountStatus =
            await AccountStatusDataHandlerBase.GetMasterAccountStatusRecord(
                dbHandler, accountStatusId);
        if (accountStatus != null) {
          account.accountStatusID = accountStatus.id;
        }
      }

      if (jsonObj.containsKey('AccountTypeID')) {
        String? accountTypeId = jsonObj['AccountTypeID'];
        accountTypeId = accountTypeId != null && accountTypeId.isNotEmpty
            ? accountTypeId
            : '-1';
        AccountType? accountType =
            await AccountTypeDataHandlerBase.GetMasterAccountTypeRecord(
                dbHandler, accountTypeId);
        if (accountType != null) {
          account.accountTypeID = accountType.id;
        }
      }

      if (jsonObj.containsKey("ParentAccountID")) {
        String accountId = jsonObj["ParentAccountID"];
        accountId =
            accountId != null && accountId.isNotEmpty ? accountId : "-1";
        Account? account1 = await AccountDataHandlerBase.GetMasterAccountRecord(
            dbHandler, accountId);
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
        creditRatingId = creditRatingId != null && creditRatingId.isNotEmpty
            ? creditRatingId
            : '-1';
        CreditRating? creditRating =
            await CreditRatingDataHandlerBase.GetMasterCreditRatingRecord(
                dbHandler, creditRatingId);
        if (creditRating != null) {
          account.creditRatingID = creditRating.id;
        }
      }

      if (jsonObj.containsKey("CurrencyID")) {
        String currencyId = jsonObj["CurrencyID"];
        currencyId =
            currencyId != null && currencyId.isNotEmpty ? currencyId : "-1";
        Currency? currency =
            await CurrencyDataHandlerBase.GetMasterCurrencyRecord(
                dbHandler, currencyId);
        if (currency != null) {
          account.currencyID = currency.id;
        }
      }

      if (jsonObj.containsKey("Phone")) {
        account.phone = jsonObj["Phone"];
      }

      if (jsonObj.containsKey("PrimaryContactName")) {
        account.primaryContactName =
            Utility.getEmptyIfNull(jsonObj["PrimaryContactName"]);
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
        account.taxPayerIdentificationNumber =
            jsonObj["TaxPayerIdentificationNumber"];
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
        account.assignedByAppUserID =
            Utility.getEmptyIfNull(jsonObj["AssignedByAppUserID"]);
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
    } catch (ex) {
      Globals.handleException("JSONDataCopier:CopyJsonDataToAccount()", ex);
    }
    return account;
  }

  static Future<AccountAddress?> CopyJsonDataToAccountAddress(
      DatabaseHandler dbHandler,
      Map<String, dynamic> jsonObj,
      AccountAddress accountAddress,
      bool isForNew) async {
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
        accountId =
            accountId != null && accountId.isNotEmpty ? accountId : "-1";
        Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
            dbHandler, accountId);
        if (account != null) {
          accountAddress.accountID = account.id;
        }
      }

      if (jsonObj.containsKey("ContactID")) {
        String contactId = jsonObj["ContactID"];
        contactId =
            contactId != null && contactId.isNotEmpty ? contactId : "-1";
        Contact contact = await ContactDataHandlerBase.GetMasterContactRecord(
            dbHandler, contactId);
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
    } catch (ex) {
      Globals.handleException(
          "JSONDataCopier:CopyJsonDataToAccountAddress()", ex);
    }
    return accountAddress;
  }

  static Future<AccountBusinessPlan> CopyJsonDataToAccountBusinessPlan(
      DatabaseHandler dbHandler,
      Map<String, dynamic> jsonObj,
      AccountBusinessPlan accountBusinessPlan,
      bool isForNew) async {
    try {
      if (jsonObj.containsKey("AccountBusinessPlanID")) {
        accountBusinessPlan.accountBusinessPlanID =
            jsonObj["AccountBusinessPlanID"];
      }
      if (jsonObj.containsKey("AccountBusinessPlanCode")) {
        accountBusinessPlan.accountBusinessPlanCode =
            jsonObj["AccountBusinessPlanCode"];
      }
      if (jsonObj.containsKey("BusinessPlans")) {
        accountBusinessPlan.businessPlans = jsonObj["BusinessPlans"];
      }

      if (jsonObj.containsKey("AccountID")) {
        String accountId = jsonObj["AccountID"];
        accountId =
            accountId != null && accountId.isNotEmpty ? accountId : "-1";
        Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
            dbHandler, accountId);
        if (account != null) {
          accountBusinessPlan.accountID = account.id;
        }
      }

      if (jsonObj.containsKey('AccountBusinessPlanID')) {
        accountBusinessPlan.accountBusinessPlanID =
            jsonObj['AccountBusinessPlanID'];
      }
      if (jsonObj.containsKey('AccountBusinessPlanCode')) {
        accountBusinessPlan.accountBusinessPlanCode =
            jsonObj['AccountBusinessPlanCode'];
      }
      if (jsonObj.containsKey('BusinessPlans')) {
        accountBusinessPlan.businessPlans = jsonObj['BusinessPlans'];
      }

      if (jsonObj.containsKey('AccountID')) {
        String accountId = jsonObj['AccountID'];
        accountId =
            accountId != null && accountId.isNotEmpty ? accountId : '-1';
        Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
            dbHandler, accountId);
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
        accountBusinessPlan.referenceIdentifier =
            jsonObj['ReferenceIdentifier'];
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
    } catch (ex) {
      Globals.handleException(
          "JSONDataCopier:CopyJsonDataToAccountBusinessPlan()", ex);
    }
    return accountBusinessPlan;
  }

  static Future<AccountBusinessUnit?> CopyJsonDataToAccountBusinessUnit(
      DatabaseHandler dbHandler,
      Map<String, dynamic> jsonObj,
      AccountBusinessUnit accountBusinessUnit,
      bool isForNew) async {
    try {
      if (jsonObj.containsKey("AccountBusinessUnitID")) {
        accountBusinessUnit.accountBusinessUnitID =
            jsonObj["AccountBusinessUnitID"];
      }
      if (jsonObj.containsKey("AccountBusinessUnitCode")) {
        accountBusinessUnit.accountBusinessUnitCode =
            jsonObj["AccountBusinessUnitCode"];
      }

      if (jsonObj.containsKey("AccountID")) {
        String accountId = jsonObj["AccountID"];
        accountId =
            (accountId != null && accountId.isNotEmpty) ? accountId : "-1";
        Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
            dbHandler, accountId);
        if (account != null) {
          accountBusinessUnit.accountID = account.id;
        }
      }

      if (jsonObj.containsKey("BusinessUnitID")) {
        String businessUnitId = jsonObj["BusinessUnitID"];
        businessUnitId = (businessUnitId != null && businessUnitId.isNotEmpty)
            ? businessUnitId
            : "-1";
        BusinessUnit? businessUnit =
            await BusinessUnitDataHandlerBase.GetMasterBusinessUnitRecord(
                dbHandler, businessUnitId);
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
        accountBusinessUnit.referenceIdentifier =
            jsonObj["ReferenceIdentifier"];
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
    } catch (ex) {
      Globals.handleException(
          "JSONDataCopier:CopyJsonDataToAccountBusinessUnit()", ex);
    }
    return accountBusinessUnit;
  }

static Future<AccountBuyingProcess> copyJsonDataToAccountBuyingProcess(
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
      accountBuyingProcess.buyingProcess = jsonObj["BuyingProcess"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler, accountId);
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
      accountBuyingProcess.createdByUser = jsonObj["CreatedByUser"].toString();
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
    Globals.handleException(
        "JSONDataCopier:CopyJsonDataToAccountBuyingProcess()", ex);
  }
  return accountBuyingProcess;
}

static AccountCategory copyJsonDataToAccountCategory(
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
    Globals.handleException(
        "JSONDataCopier:CopyJsonDataToAccountCategory()", ex);
  }
  return accountCategory;
}

static Future<AccountCategoryMapping> copyJsonDataToAccountCategoryMapping(
    DatabaseHandler dbHandler,
    Map<String,dynamic> jsonObj,
    AccountCategoryMapping accountCategoryMapping,
    bool isForNew,
) async{
  try {
    if (jsonObj.containsKey("AccountCategoryMappingID")) {
      accountCategoryMapping.accountCategoryMappingID =
          jsonObj["AccountCategoryMappingID"].toString();
    }
    if (jsonObj.containsKey("AccountCategoryMappingCode")) {
      accountCategoryMapping.accountCategoryMappingCode =
          jsonObj["AccountCategoryMappingCode"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId.isNotEmpty ? accountId : "-1";
      Account? account = await  AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        accountCategoryMapping.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("AccountCategoryID")) {
      String accountCategoryId = jsonObj["AccountCategoryID"].toString();
      accountCategoryId = accountCategoryId.isNotEmpty ? accountCategoryId : "-1";
      AccountCategory? accountCategory = await  AccountCategoryDataHandlerBase.GetMasterAccountCategoryRecord(dbHandler, accountCategoryId);
      if (accountCategory != null) {
        accountCategoryMapping.accountCategoryID = accountCategory.id;
      }
    }

    if (jsonObj.containsKey("CreatedBy")) {
      accountCategoryMapping.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountCategoryMapping.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountCategoryMapping.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCategoryMapping.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      accountCategoryMapping.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      accountCategoryMapping.uid = jsonObj["Uid"].toString();
    }

    if (jsonObj.containsKey("AppUserID")) {
      accountCategoryMapping.appUserID = jsonObj["AppUserID"].toString();
    }

    if (jsonObj.containsKey("AppUserGroupID")) {
      accountCategoryMapping.appUserGroupID =
          jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountCategoryMapping.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountCategoryMapping.isDeleted = jsonObj["IsDeleted"].toString();
    }

    accountCategoryMapping.isDirty = "false";
    accountCategoryMapping.isDeleted1 = "false";
    accountCategoryMapping.upSyncMessage = "";
    accountCategoryMapping.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountCategoryMapping.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCategoryMapping.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountCategoryMapping.createdByUser =
          jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountCategoryMapping.modifiedByUser =
          jsonObj["ModifiedByUser"].toString();
    }
    accountCategoryMapping.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID"))
      accountCategoryMapping.ownerUserID = jsonObj["AppUserID"].toString();*/
    accountCategoryMapping.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
        "JSONDataCopier:CopyJsonDataToAccountCategoryMapping()", ex);
  }
  return accountCategoryMapping;
}

static Future<AccountCompetitionActivity> copyJsonDataToAccountCompetitionActivity(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AccountCompetitionActivity accountCompetitionActivity,
    bool isForNew,
) async{
  try {
    if (jsonObj.containsKey("AccountCompetitionActivityID")) {
      accountCompetitionActivity.accountCompetitionActivityID =
          jsonObj["AccountCompetitionActivityID"].toString();
    }
    if (jsonObj.containsKey("AccountCompetitionActivityCode")) {
      accountCompetitionActivity.accountCompetitionActivityCode =
          jsonObj["AccountCompetitionActivityCode"].toString();
    }
    if (jsonObj.containsKey("CompetitionActivity")) {
      accountCompetitionActivity.competitionActivity =
          jsonObj["CompetitionActivity"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId.isNotEmpty ? accountId : "-1";
      Account? account = await AccountDataHandlerBase.GetMasterAccountRecord( dbHandler, accountId);
      if (account != null) {
        accountCompetitionActivity.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";

      Opportunity? opportunity = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
      if (opportunity != null) {
        accountCompetitionActivity.opportunityID = opportunity.id;
      }
    }

    if (jsonObj.containsKey("CompetitorName")) {
      accountCompetitionActivity.competitorName =
          jsonObj["CompetitorName"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      accountCompetitionActivity.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountCompetitionActivity.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountCompetitionActivity.modifiedBy =
          jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCompetitionActivity.modifiedOn =
          jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      accountCompetitionActivity.deviceIdentifier =
          jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      accountCompetitionActivity.referenceIdentifier =
          jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      accountCompetitionActivity.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      accountCompetitionActivity.uid = jsonObj["Uid"].toString();
    }

    if (jsonObj.containsKey("AppUserID")) {
      accountCompetitionActivity.appUserID = jsonObj["AppUserID"].toString();
    }

    if (jsonObj.containsKey("AppUserGroupID")) {
      accountCompetitionActivity.appUserGroupID =
          jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountCompetitionActivity.isArchived =
          jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountCompetitionActivity.isDeleted =
          jsonObj["IsDeleted"].toString();
    }

    accountCompetitionActivity.isDirty = "false";
    accountCompetitionActivity.isDeleted1 = "false";
    accountCompetitionActivity.upSyncMessage = "";
    accountCompetitionActivity.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountCompetitionActivity.sCreatedOn =
          jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountCompetitionActivity.sModifiedOn =
          jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountCompetitionActivity.createdByUser =
          jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountCompetitionActivity.modifiedByUser =
          jsonObj["ModifiedByUser"].toString();
    }
    accountCompetitionActivity.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID"))
      accountCompetitionActivity.ownerUserID =
          jsonObj["AppUserID"].toString();*/
    accountCompetitionActivity.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
        "JSONDataCopier:CopyJsonDataToAccountCompetitionActivity()", ex);
  }
  return accountCompetitionActivity;
}

 static Future<AccountForm> copyJsonDataToAccountForm(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AccountForm accountForm,
    bool isForNew,
)async {
  try {
    if (jsonObj.containsKey("AccountFormID")) {
      accountForm.accountFormID = jsonObj["AccountFormID"].toString();
    }
    if (jsonObj.containsKey("AccountFormCode")) {
      accountForm.accountFormCode = jsonObj["AccountFormCode"].toString();
    }
    if (jsonObj.containsKey("AccountFormTitle")) {
      accountForm.accountFormTitle = jsonObj["AccountFormTitle"].toString();
    }

    if (jsonObj.containsKey("FormID")) {
      String formId = jsonObj["FormID"].toString();
      formId = formId.isNotEmpty ? formId : "-1";
      Form? form =await  FormDataHandlerBase.GetMasterFormRecord( dbHandler, formId);
      if (form != null) {
        accountForm.formID = form.id;
      }
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId.isNotEmpty ? accountId : "-1";
      Account? account = await  AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        accountForm.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactID")) {
      String contactId = jsonObj["ContactID"].toString();
      contactId = contactId.isNotEmpty ? contactId : "-1";
      Contact? contact = await ContactHandlerDataBase.GetMasterContactRecord(
          dbHandler, contactId);
      if (contact != null) {
        accountForm.contactID = contact.id;
      }
    }

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"].toString();
      activityId = activityId.isNotEmpty ? activityId : "-1";
      Activity? activity = await  ActivityDataHandlerBase.GetMasterActivityRecord( dbHandler, activityId);
      if (activity != null) {
        accountForm.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";
      Opportunity? opportunity = await  OpportunityDataHandlerBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
      if (opportunity != null) {
        accountForm.opportunityID = opportunity.id;
      }
    }

    if (jsonObj.containsKey("FileName")) {
      accountForm.fileName = jsonObj["FileName"].toString();
    }
    if (jsonObj.containsKey("FileUrl")) {
      accountForm.fileUrl = jsonObj["FileUrl"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountForm.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      accountForm.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountForm.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountForm.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      accountForm.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      accountForm.uid = jsonObj["Uid"].toString();
    }

    if (jsonObj.containsKey("AppUserID")) {
      accountForm.appUserID = jsonObj["AppUserID"].toString();
    }

    if (jsonObj.containsKey("AppUserGroupID")) {
      accountForm.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountForm.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountForm.isDeleted = jsonObj["IsDeleted"].toString();
    }

    accountForm.isDirty = "false";
    accountForm.isDeleted1 = "false";
    accountForm.upSyncMessage = "";
    accountForm.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountForm.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountForm.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountForm.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountForm.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    accountForm.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID"))
      accountForm.ownerUserID = jsonObj["AppUserID"].toString();*/
    accountForm.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
        "JSONDataCopier:CopyJsonDataToAccountForm()", ex);
  }
  return accountForm;
}
static Future<AccountFormValue> copyJsonDataToAccountFormValue(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountFormValue accountFormValue,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('AccountFormValueID')) {
      accountFormValue.accountFormValueID =
          jsonObj['AccountFormValueID'].toString();
    }
    if (jsonObj.containsKey('AccountFormValueCode')) {
      accountFormValue.accountFormValueCode =
          jsonObj['AccountFormValueCode'].toString();
    }

    if (jsonObj.containsKey('AccountFormID')) {
      String accountFormId = jsonObj['AccountFormID'].toString();
      accountFormId = (accountFormId != null && accountFormId != '')
          ? accountFormId
          : '-1';
      AccountForm? accountForm = await AccountFormDataHandlerBase.GetMasterAccountFormRecord(dbHandler, accountFormId);
      if (accountForm != null) {
        accountFormValue.accountFormID = accountForm.id;
      }
    }

    if (jsonObj.containsKey('FormCellElementID')) {
      String formCellElementId =
          jsonObj['FormCellElementID'].toString();
      formCellElementId = (formCellElementId != null && formCellElementId != '')
          ? formCellElementId
          : '-1';
      FormCellElement formCellElement = await FormCellElementDataHandler
          .getMasterFormCellElementRecord(dbHandler, context, formCellElementId);
      if (formCellElement != null) {
        accountFormValue.formCellElementID = formCellElement.id;
      }
    }

    if (jsonObj.containsKey('FormCellElementValue')) {
      accountFormValue.formCellElementValue =
          jsonObj['FormCellElementValue'].toString();
    }
    if (jsonObj.containsKey('RowIndex')) {
      accountFormValue.rowIndex = jsonObj['RowIndex'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountFormValue.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      accountFormValue.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountFormValue.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountFormValue.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountFormValue.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountFormValue.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      accountFormValue.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountFormValue.appUserID = jsonObj['AppUserID'].toString();
    }

    if (jsonObj.containsKey('AppUserGroupID')) {
      accountFormValue.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountFormValue.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountFormValue.isDeleted = jsonObj['IsDeleted'].toString();
    }

    accountFormValue.isDirty = 'false';
    accountFormValue.isDeleted1 = 'false';
    accountFormValue.upSyncMessage = '';
    accountFormValue.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountFormValue.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountFormValue.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountFormValue.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountFormValue.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    accountFormValue.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID')) {
      accountFormValue.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountFormValue.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( 'JSONDataCopier:copyJsonDataToAccountFormValue()', ex);
  }
  return accountFormValue;
}
 static Future<AccountMedia> copyJsonDataToAccountMedia(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountMedia accountMedia,
    bool isForNew,
)async {
  try {
    if (jsonObj.containsKey('AccountMediaID')) {
      accountMedia.accountMediaID = jsonObj['AccountMediaID'].toString();
    }
    if (jsonObj.containsKey('AccountMediaCode')) {
      accountMedia.accountMediaCode = jsonObj['AccountMediaCode'].toString();
    }
    if (jsonObj.containsKey('AccountMediaName')) {
      accountMedia.accountMediaName = jsonObj['AccountMediaName'].toString();
    }

    if (jsonObj.containsKey('AccountID')) {
      String accountId = jsonObj['AccountID'].toString();
      accountId = (accountId != null && accountId != '') ? accountId : '-1';
      Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        accountMedia.accountID = account.id;
      }
    }

    if (jsonObj.containsKey('ContentTypeID')) {
      String contentTypeId = jsonObj['ContentTypeID'].toString();
      contentTypeId =
          (contentTypeId != null && contentTypeId != '') ? contentTypeId : '-1';
      ContentType contentType = await ContentTypeDataHandler
          .getMasterContentTypeRecord(dbHandler, context, contentTypeId);
      if (contentType != null) {
        accountMedia.contentTypeID = contentType.id;
      }
    }

    if (jsonObj.containsKey('MediaPath')) {
      accountMedia.mediaPath = jsonObj['MediaPath'].toString();
    }
    if (jsonObj.containsKey('MediaContent')) {
      accountMedia.mediaContent = jsonObj['MediaContent'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      accountMedia.description = jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('Tags')) {
      accountMedia.tags = jsonObj['Tags'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      accountMedia.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountMedia.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountMedia.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountMedia.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      accountMedia.deviceIdentifier = jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      accountMedia.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountMedia.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountMedia.uid = jsonObj['Uid'].toString();
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountMedia.appUserID = jsonObj['AppUserID'].toString();
    }

    if (jsonObj.containsKey('AppUserGroupID')) {
      accountMedia.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountMedia.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountMedia.isDeleted = jsonObj['IsDeleted'].toString();
    }

    accountMedia.isDirty = 'false';
    accountMedia.isDeleted1 = 'false';
    accountMedia.upSyncMessage = '';
    accountMedia.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountMedia.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountMedia.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountMedia.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountMedia.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    accountMedia.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID')) {
      accountMedia.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountMedia.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToAccountMedia()', ex);
  }
  return accountMedia;
}
static Future<AccountPhone> copyJsonDataToAccountPhone(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountPhone accountPhone,
    bool isForNew,
) async{
  try {
    if (jsonObj.containsKey('AccountPhoneID')) {
      accountPhone.accountPhoneID = jsonObj['AccountPhoneID'].toString();
    }
    if (jsonObj.containsKey('AccountPhoneCode')) {
      accountPhone.accountPhoneCode = jsonObj['AccountPhoneCode'].toString();
    }
    if (jsonObj.containsKey('Phone')) {
      accountPhone.phone = jsonObj['Phone'].toString();
    }
    if (jsonObj.containsKey('PhoneTypeName')) {
      accountPhone.phoneTypeName = jsonObj['PhoneTypeName'].toString();
    }

    if (jsonObj.containsKey('AccountID')) {
      String accountId = jsonObj['AccountID'].toString();
      accountId = (accountId != null && accountId != '') ? accountId : '-1';
      Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        accountPhone.accountID = account.id;
      }
    }

    if (jsonObj.containsKey('AccountAddressID')) {
      String accountAddressId = jsonObj['AccountAddressID'].toString();
      accountAddressId =
          (accountAddressId != null && accountAddressId != '')
              ? accountAddressId
              : '-1';
      AccountAddress? accountAddress = await AccountAddressDataHandlerBase
          .GetMasterAccountAddressRecord(dbHandler, accountAddressId);
      if (accountAddress != null) {
        accountPhone.accountAddressID = accountAddress.id;
      }
    }

    if (jsonObj.containsKey('CreatedBy')) {
      accountPhone.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountPhone.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountPhone.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountPhone.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      accountPhone.deviceIdentifier = jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      accountPhone.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountPhone.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountPhone.uid = jsonObj['Uid'].toString();
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountPhone.appUserID = jsonObj['AppUserID'].toString();
    }

    if (jsonObj.containsKey('AppUserGroupID')) {
      accountPhone.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountPhone.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountPhone.isDeleted = jsonObj['IsDeleted'].toString();
    }
    if (jsonObj.containsKey('LeadQualificationID')) {
      accountPhone.leadQualificationID =
          jsonObj['LeadQualificationID'].toString();
    }

    accountPhone.isDirty = 'false';
    accountPhone.isDeleted1 = 'false';
    accountPhone.upSyncMessage = '';
    accountPhone.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountPhone.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountPhone.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountPhone.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountPhone.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    accountPhone.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID')) {
      accountPhone.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountPhone.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToAccountPhone()', ex);
  }
  return accountPhone;
}
static Future<AccountSegment> copyJsonDataToAccountSegment(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountSegment accountSegment,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('AccountSegmentID')) {
      accountSegment.accountSegmentID =
          jsonObj['AccountSegmentID'].toString();
    }
    if (jsonObj.containsKey('AccountSegmentCode')) {
      accountSegment.accountSegmentCode =
          jsonObj['AccountSegmentCode'].toString();
    }
    if (jsonObj.containsKey('AccountSegmentName')) {
      accountSegment.accountSegmentName =
          jsonObj['AccountSegmentName'].toString();
    }
    if (jsonObj.containsKey('MinimumTurnover')) {
      accountSegment.minimumTurnover =
          jsonObj['MinimumTurnover'].toString();
    }

    if (jsonObj.containsKey('CurrencyID')) {
      String currencyId = jsonObj['CurrencyID'].toString();
      currencyId = (currencyId != null && currencyId != '') ? currencyId : '-1';
      Currency? currency = await CurrencyDataHandlerBase.GetMasterCurrencyRecord(
          dbHandler, currencyId);
      if (currency != null) {
        accountSegment.currencyID = currency.id;
      }
    }

    if (jsonObj.containsKey('CreatedOn')) {
      accountSegment.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      accountSegment.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountSegment.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountSegment.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountSegment.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountSegment.uid = jsonObj['Uid'].toString();
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountSegment.appUserID = jsonObj['AppUserID'].toString();
    }

    if (jsonObj.containsKey('AppUserGroupID')) {
      accountSegment.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountSegment.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountSegment.isDeleted = jsonObj['IsDeleted'].toString();
    }

    accountSegment.isDirty = 'false';
    accountSegment.isDeleted1 = 'false';
    accountSegment.upSyncMessage = '';
    accountSegment.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountSegment.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountSegment.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountSegment.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountSegment.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    accountSegment.upSyncIndex = '0';
    /* if (jsonObj.containsKey('AppUserID')) {
      accountSegment.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountSegment.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
        context, 'JSONDataCopier:CopyJsonDataToAccountSegment()', ex);
  }
  return accountSegment;
}
static Future<AccountStatus> copyJsonDataToAccountStatus(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountStatus accountStatus,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('AccountStatusID')) {
      accountStatus.accountStatusID = jsonObj['AccountStatusID'].toString();
    }
    if (jsonObj.containsKey('AccountStatusCode')) {
      accountStatus.accountStatusCode =
          jsonObj['AccountStatusCode'].toString();
    }
    if (jsonObj.containsKey('AccountStatusName')) {
      accountStatus.accountStatusName =
          jsonObj['AccountStatusName'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountStatus.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      accountStatus.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountStatus.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountStatus.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountStatus.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountStatus.uid = jsonObj['Uid'].toString();
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountStatus.appUserID = jsonObj['AppUserID'].toString();
    }

    if (jsonObj.containsKey('AppUserGroupID')) {
      accountStatus.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountStatus.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountStatus.isDeleted = jsonObj['IsDeleted'].toString();
    }

    accountStatus.isDirty = 'false';
    accountStatus.isDeleted1 = 'false';
    accountStatus.upSyncMessage = '';
    accountStatus.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountStatus.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountStatus.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountStatus.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountStatus.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    accountStatus.upSyncIndex = '0';
    /* if (jsonObj.containsKey('AppUserID')) {
      accountStatus.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountStatus.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToAccountStatus()', ex);
  }
  return accountStatus;
}

static Future<AccountTerritory> copyJsonDataToAccountTerritory(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountTerritory accountTerritory,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('AccountTerritoryID')) {
      accountTerritory.accountTerritoryID =
          jsonObj['AccountTerritoryID'].toString();
    }
    if (jsonObj.containsKey('AccountTerritoryCode')) {
      accountTerritory.accountTerritoryCode =
          jsonObj['AccountTerritoryCode'].toString();
    }

    if (jsonObj.containsKey('TerritoryID')) {
      String territoryId = jsonObj['TerritoryID'].toString();
      territoryId = territoryId.isNotEmpty ? territoryId : '-1';
      Territory territory = TerritoryDataHandlerBase.getMasterTerritoryRecord(
        dbHandler,
        context,
        territoryId,
      );
      if (territory != null) {
        accountTerritory.territoryID = territory.id;
      }
    }

    if (jsonObj.containsKey('AccountID')) {
      String accountId = jsonObj['AccountID'].toString();
      accountId = accountId.isNotEmpty ? accountId : '-1';
      Account account = AccountDataHandler.getMasterAccountRecord(
        dbHandler,
        context,
        accountId,
      );
      if (account != null) {
        accountTerritory.accountID = account.id;
      }
    }

    if (jsonObj.containsKey('CreatedBy')) {
      accountTerritory.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountTerritory.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountTerritory.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountTerritory.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      accountTerritory.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      accountTerritory.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      accountTerritory.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      accountTerritory.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountTerritory.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountTerritory.isDeleted = jsonObj['IsDeleted'].toString();
    }

    accountTerritory.isDirty = 'false';
    accountTerritory.isDeleted1 = 'false';
    accountTerritory.upSyncMessage = '';
    accountTerritory.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      accountTerritory.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountTerritory.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountTerritory.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountTerritory.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    accountTerritory.upSyncIndex = '0';
    /* if (jsonObj.containsKey('AppUserID')) {
      accountTerritory.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    accountTerritory.ownerUserID = Globals.appUserID.toString();
  } catch (ex) {
    Globals.handleException(
        context, 'JSONDataCopier:CopyJsonDataToAccountTerritory()', ex);
  }
  return accountTerritory;
}



static Future<AccountType> copyJsonDataToAccountType(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AccountType accountType,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AccountTypeID")) {
      accountType.accountTypeID = jsonObj["AccountTypeID"];
    }
    if (jsonObj.containsKey("AccountTypeCode")) {
      accountType.accountTypeCode = jsonObj["AccountTypeCode"];
    }
    if (jsonObj.containsKey("AccountTypeName")) {
      accountType.accountTypeName = jsonObj["AccountTypeName"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      accountType.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      accountType.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountType.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      accountType.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      accountType.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      accountType.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      accountType.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      accountType.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      accountType.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      accountType.isDeleted = jsonObj["IsDeleted"];
    }

    accountType.isDirty  = "false";
    accountType.isDeleted1 = "false";
    accountType.upSyncMessage = "";
    accountType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      accountType.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      accountType.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      accountType.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      accountType.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    accountType.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID"))
        accountType.ownerUserID = jsonObj["AppUserID"];*/
    accountType.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToAccountType()", ex);
  }
  return accountType;
}


Future<Activity> copyJsonDataToActivity( DatabaseHandler dbHandler, dynamic jsonObj, Activity activity, bool isForNew) async{
  try {
    if (jsonObj.containsKey("ActivityID")) {
      activity.activityID = jsonObj["ActivityID"];
    }
    if (jsonObj.containsKey("ActivityCode")) {
      activity.activityCode = jsonObj["ActivityCode"];
    }
    if (jsonObj.containsKey("ActivityTitle")) {
      activity.activityTitle = jsonObj["ActivityTitle"];
    }

    if (jsonObj.containsKey("ActivityTypeID")) {
      String activityTypeId = jsonObj["ActivityTypeID"];
      activityTypeId = activityTypeId != null && activityTypeId.isNotEmpty ? activityTypeId : "-1";
      ActivityType? activityType = await ActivityTypeDataHandlerBase.GetMasterActivityTypeRecord(dbHandler, context, activityTypeId);
      if (activityType != null) {
        activity.activityTypeID = activityType.id;
      }
    }

    if (jsonObj.containsKey("LeadSource")) {
      activity.leadSource = jsonObj["LeadSource"];
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"];
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account? account =await  AccountDataHandlerBase.GetMasterAccountRecord(dbHandler, accountId);
      if (account != null) {
        activity.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactID")) {
      String contactId = jsonObj["ContactID"];
      contactId = contactId != null && contactId.isNotEmpty ? contactId : "-1";
      Contact? contact =  await ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
      if (contact != null) {
        activity.contactID = contact.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
  String opportunityId = jsonObj["OpportunityID"];
  opportunityId = opportunityId != null && opportunityId.isNotEmpty ? opportunityId : "-1";
  Opportunity? opportunity = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
  if (opportunity != null) {
    activity.opportunityID = opportunity.id;
  }
}
if (jsonObj.containsKey("ActivityMeasure")) {
  activity.activityMeasure = jsonObj["ActivityMeasure"];
}
if (jsonObj.containsKey("ActivityDate")) {
  activity.activityDate = jsonObj["ActivityDate"];
}
if (jsonObj.containsKey("ActivityEndDate")) {
  activity.activityEndDate = jsonObj["ActivityEndDate"];
}
if (jsonObj.containsKey("AssignmentDetails")) {
  activity.assignmentDetails = Utility.getEmptyIfNull(jsonObj["AssignmentDetails"]);
}
if (jsonObj.containsKey("ActivityDetails")) {
  activity.activityDetails = jsonObj["ActivityDetails"];
}

if (jsonObj.containsKey("ActivityPriorityID")) {
  String activityPriorityId = jsonObj["ActivityPriorityID"];
  activityPriorityId = activityPriorityId != null && activityPriorityId.isNotEmpty ? activityPriorityId : "-1";
  ActivityPriority? activityPriority = await ActivityPriorityDataHandlerBase.GetMasterActivityPriorityRecord(dbHandler, activityPriorityId);
  if (activityPriority != null) {
    activity.activityPriorityID = activityPriority.id;
  }
}

if (jsonObj.containsKey("TotalAmount")) {
  activity.totalAmount = jsonObj["TotalAmount"];
}

if (jsonObj.containsKey("AmountCollected")) {
  activity.amountCollected = jsonObj["AmountCollected"];
}

if (jsonObj.containsKey("CurrencyID")) {
  String currencyId = jsonObj["CurrencyID"];
  currencyId = currencyId != null && currencyId.isNotEmpty ? currencyId : "-1";
  Currency? currency = await  CurrencyDataHandlerBase.GetMasterCurrencyRecord(dbHandler, currencyId);
  if (currency != null) {
    activity.currencyID = currency.id;
  }
}

if (jsonObj.containsKey("CollectionDetails")) {
  activity.collectionDetails = jsonObj["CollectionDetails"];
}
if (jsonObj.containsKey("IsTravelled")) {
  activity.isTravelled = jsonObj["IsTravelled"];
}
if (jsonObj.containsKey("TravelPurposeName")) {
  activity.travelPurposeName = jsonObj["TravelPurposeName"];
}

if (jsonObj.containsKey("ActivityStatusID")) {
  String activityStatusId = jsonObj["ActivityStatusID"];
  activityStatusId = activityStatusId != null && activityStatusId.isNotEmpty ? activityStatusId : "-1";
  ActivityStatus? activityStatus = await  ActivityStatusDataHandlerBase.GetMasterActivityStatusRecord(dbHandler, activityStatusId);
  if (activityStatus != null) {
    activity.activityStatusID = activityStatus.id;
  }
}
if (jsonObj.containsKey("IsNeedFollowUpActivity")) {
  activity.needFollowUpActivity = jsonObj["IsNeedFollowUpActivity"];
}

if (jsonObj.containsKey("ParentActivityID")) {
  String activityId = jsonObj["ParentActivityID"];
  activityId = activityId != null && activityId.isNotEmpty ? activityId : "-1";
  Activity? activity1 = await ActivityDataHandlerBase.GetMasterActivityRecord(dbHandler, activityId);
  if (activity1 != null) {
    activity.parentActivityID = activity1.id;
  }
}

if (jsonObj.containsKey("ActivityAssignmentID")) {
  activity.activityAssignmentID = jsonObj["ActivityAssignmentID"];
}
if (jsonObj.containsKey("ExpectedCompletionDate")) {
  activity.expectedCompletionDate = jsonObj["ExpectedCompletionDate"];
}

if (jsonObj.containsKey("ProductInstallationDetailID")) {
  activity.productInstallationDetailID = jsonObj["ProductInstallationDetailID"];
}

/*if (jsonObj.containsKey("ProductInstallationDetailID")) {
  String productInstallationDetailId = jsonObj["ProductInstallationDetailID"];
  productInstallationDetailId = productInstallationDetailId != null && productInstallationDetailId.isNotEmpty ? productInstallationDetailId : "-1";
  ProductInstallationDetail productInstallationDetail = ProductInstallationDetailDataHandler.GetMasterProductInstallationDetailRecord(dbHandler, context, productInstallationDetailId);
  if (productInstallationDetail != null) {
    activity.productInstallationDetailID = productInstallationDetail.getId();
  }
}*/

if (jsonObj.containsKey("InvoiceID")) {
  activity.invoiceID = jsonObj["InvoiceID"];
}
if (jsonObj.containsKey("WorkflowProgressID")) {
  activity.workflowProgressID = jsonObj["WorkflowProgressID"];
}
if (jsonObj.containsKey("Tags")) {
  activity.tags = jsonObj["Tags"];
}
if (jsonObj.containsKey("FreeTextField1")) {
  activity.freeTextField1 = jsonObj["FreeTextField1"];
}
if (jsonObj.containsKey("FreeTextField2")) {
  activity.freeTextField2 = jsonObj["FreeTextField2"];
}
if (jsonObj.containsKey("FreeTextField3")) {
  activity.freeTextField3 = jsonObj["FreeTextField3"];
}
if (jsonObj.containsKey("IsApprovalRequired")) {
  activity.isApprovalRequired = Utility.getEmptyIfNull(jsonObj["IsApprovalRequired"]);
}
if (jsonObj.containsKey("IsApproved")) {
  activity.isApproved = jsonObj["IsApproved"];
}
if (jsonObj.containsKey("CompletedDate")) {
  activity.completedDate = jsonObj["CompletedDate"];
}
if (jsonObj.containsKey("Principal")) {
  activity.principalName = jsonObj["PrincipalName"];
}
if (jsonObj.containsKey("MarketingContactID")) {
  activity.marketingContactID = jsonObj["MarketingContactID"];
}
if (jsonObj.containsKey("WorkflowStageID")) {
  activity.workflowStageID = jsonObj["WorkflowStageID"];
}
if (jsonObj.containsKey("IsWorkflowStageUpdated")) {
  activity.isWorkflowStageUpdated = jsonObj["IsWorkflowStageUpdated"];
}
if (jsonObj.containsKey("LeadQualificationID")) {
  activity.leadQualificationID = jsonObj["LeadQualificationID"];
}
if (jsonObj.containsKey("ActivityCodeInternal")) {
  activity.activityCodeInternal = jsonObj["ActivityCodeInternal"];
}
if (jsonObj.containsKey("CreatedBy")) {
  activity.createdBy = jsonObj["CreatedBy"];
}
if (jsonObj.containsKey("CreatedOn")) {
  activity.createdOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedBy")) {
  activity.modifiedBy = jsonObj["ModifiedBy"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  activity.modifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("DeviceIdentifier")) {
  activity.deviceIdentifier = jsonObj["DeviceIdentifier"];
}
if (jsonObj.containsKey("ReferenceIdentifier")) {
  activity.referenceIdentifier = jsonObj["ReferenceIdentifier"];
}
if (jsonObj.containsKey("Location")) {
  activity.location = jsonObj["Location"];
}
if (jsonObj.containsKey("IsActive")) {
  activity.isActive = jsonObj["IsActive"];
}
if (jsonObj.containsKey("IsLocked")) {
  activity.isLocked = jsonObj["IsLocked"];
}
if (jsonObj.containsKey("Uid")) {
  activity.uid = jsonObj["Uid"];
}
if (jsonObj.containsKey("AppUserID")) {
  activity.appUserID = jsonObj["AppUserID"];
}
if (jsonObj.containsKey("AppUserGroupID")) {
  activity.appUserGroupID = jsonObj["AppUserGroupID"];
}
if (jsonObj.containsKey("IsArchived")) {
  activity.isArchived = jsonObj["IsArchived"];
}
if (jsonObj.containsKey("IsDeleted")) {
  activity.isDeleted = jsonObj["IsDeleted"];
}
if (jsonObj.containsKey("SuccessAlertMessage")) {
  activity.successAlertMessage = jsonObj["SuccessAlertMessage"];
}
if (jsonObj.containsKey("FailureAlertMessage")) {
  activity.failureAlertMessage = jsonObj["FailureAlertMessage"];
}
if (jsonObj.containsKey("ApprovalStatus")) {
  activity.approvalStatus = jsonObj["ApprovalStatus"];
}
if (jsonObj.containsKey("ApprovalDetails")) {
  activity.approvalDetails = jsonObj["ApprovalDetails"];
}

activity.isDirty = "false";
activity.isDeleted1 = "false";
activity.upSyncMessage = "";
activity.downSyncMessage = "";
if (jsonObj.containsKey("CreatedOn")) {
  activity.sCreatedOn = jsonObj["CreatedOn"];
}
if (jsonObj.containsKey("ModifiedOn")) {
  activity.sModifiedOn = jsonObj["ModifiedOn"];
}
if (jsonObj.containsKey("CreatedByUser")) {
  activity.createdByUser = jsonObj["CreatedByUser"];
}
if (jsonObj.containsKey("ModifiedByUser")) {
  activity.modifiedByUser = jsonObj["ModifiedByUser"];
}

activity.upSyncIndex = "0";
/*if (jsonObj.containsKey("AppUserID"))
  activity.ownerUserID = jsonObj["AppUserID"];*/
activity.ownerUserID = Globals.AppUserID.toString();


    // Continue with the remaining properties...

  } catch ( ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToActivity()", ex);
  }
  return activity;
}


Future<ActivityApproval> copyJsonDataToActivityApproval(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityApproval activityApproval,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityApprovalID')) {
      activityApproval.activityApprovalID =
          jsonObj['ActivityApprovalID'].toString();
    }
    if (jsonObj.containsKey('ActivityApprovalCode')) {
      activityApproval.activityApprovalCode =
          jsonObj['ActivityApprovalCode'].toString();
    }
    if (jsonObj.containsKey('ActivityApprovalTitle')) {
      activityApproval.activityApprovalTitle =
          jsonObj['ActivityApprovalTitle'].toString();
    }

    if (jsonObj.containsKey('ActivityApprovalTypeID')) {
      String activityApprovalTypeId =
          jsonObj['ActivityApprovalTypeID'].toString();
      activityApprovalTypeId =
          activityApprovalTypeId.isNotEmpty ? activityApprovalTypeId : '-1';
      ActivityApprovalType? activityApprovalType =
          await ActivityApprovalTypeDataHandlerBase.GetMasterActivityApprovalTypeRecord(
              dbHandler, activityApprovalTypeId);
      if (activityApprovalType != null) {
        activityApproval.activityApprovalTypeID = activityApprovalType.id;
      }
    }

    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId.isNotEmpty ? activityId : '-1';
      Activity ?activity = await ActivityDataHandlerBase.GetMasterActivityRecord(
          dbHandler, activityId);
      if (activity != null) {
        activityApproval.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey('RequestDate')) {
      activityApproval.requestDate = jsonObj['RequestDate'].toString();
    }
    if (jsonObj.containsKey('RequestDetail')) {
      activityApproval.requestDetail = jsonObj['RequestDetail'].toString();
    }
    if (jsonObj.containsKey('IsSubmitted')) {
      activityApproval.isSubmitted = jsonObj['IsSubmitted'].toString();
    }

    if (jsonObj.containsKey('ParentActivityApprovalID')) {
      String activityApprovalId =
          jsonObj['ParentActivityApprovalID'].toString();
      activityApprovalId =
          activityApprovalId.isNotEmpty ? activityApprovalId : '-1';
      ActivityApproval ?activityApproval1 =
          await ActivityApprovalDataHandlerBase.GetMasterActivityApprovalRecord(
              dbHandler, activityApprovalId);
      if (activityApproval1 != null) {
        activityApproval.parentActivityApprovalID = activityApproval1.id;
      }
    }

    if (jsonObj.containsKey('ApprovalStatus')) {
      activityApproval.approvalStatus = jsonObj['ApprovalStatus'].toString();
    }
    if (jsonObj.containsKey('ApprovalByAppUserID')) {
      activityApproval.approvalByAppUserID =
          jsonObj['ApprovalByAppUserID'].toString();
    }
    if (jsonObj.containsKey('ApprovalTime')) {
      activityApproval.approvalTime = jsonObj['ApprovalTime'].toString();
    }
    if (jsonObj.containsKey('ApproverRemarks')) {
      activityApproval.approverRemarks = jsonObj['ApproverRemarks'].toString();
    }
    if (jsonObj.containsKey('IsApprovalCompleted')) {
      activityApproval.isApprovalCompleted =
          jsonObj['IsApprovalCompleted'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityApproval.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityApproval.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityApproval.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityApproval.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      activityApproval.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityApproval.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Location')) {
      activityApproval.location = jsonObj['Location'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityApproval.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityApproval.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityApproval.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityApproval.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityApproval.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityApproval.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityApproval.isDirty = 'false';
    activityApproval.isDeleted1 = 'false';
    activityApproval.upSyncMessage = '';
    activityApproval.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityApproval.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityApproval.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityApproval.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityApproval.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityApproval.upSyncIndex = '0';
    activityApproval.ownerUserID = Globals.AppUserID.toString();

  } catch (e) {
    Globals.handleException( 'JSONDataCopier:CopyJsonDataToActivityApproval()', e);
  }
  return activityApproval;
}



Future<ActivityApprovalType> copyJsonDataToActivityApprovalType(
   context,
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityApprovalType activityApprovalType,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityApprovalTypeID')) {
      activityApprovalType.activityApprovalTypeID =
          jsonObj['ActivityApprovalTypeID'].toString();
    }
    if (jsonObj.containsKey('ActivityApprovalTypeCode')) {
      activityApprovalType.activityApprovalTypeCode =
          jsonObj['ActivityApprovalTypeCode'].toString();
    }
    if (jsonObj.containsKey('ActivityApprovalTypeName')) {
      activityApprovalType.activityApprovalTypeName =
          jsonObj['ActivityApprovalTypeName'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      activityApprovalType.description =
          jsonObj['Description'].toString();
    }

    if (jsonObj.containsKey('ActivityTypeID')) {
      String activityTypeId = jsonObj['ActivityTypeID'].toString();
      activityTypeId = activityTypeId.isNotEmpty ? activityTypeId : '-1';
      ActivityType activityType =
          await ActivityTypeDataHandlerBase.GetMasterActivityTypeRecord(
              dbHandler, activityTypeId);
      if (activityType != null) {
        activityApprovalType.activityTypeID = activityType.id;
      }
    }
    if (jsonObj.containsKey('InternalCode')) {
      activityApprovalType.internalCode =
          jsonObj['InternalCode'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityApprovalType.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityApprovalType.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityApprovalType.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityApprovalType.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityApprovalType.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityApprovalType.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityApprovalType.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityApprovalType.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityApprovalType.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityApprovalType.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityApprovalType.isDirty = 'false';
    activityApprovalType.isDeleted1 = 'false';
    activityApprovalType.upSyncMessage = '';
    activityApprovalType.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityApprovalType.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityApprovalType.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityApprovalType.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityApprovalType.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityApprovalType.upSyncIndex = '0';
    activityApprovalType.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
        context, 'JSONDataCopier:CopyJsonDataToActivityApprovalType()', e);
  }
  return activityApprovalType;
}



Future<ActivityBusinessunit> copyJsonDataToActivityBusinessUnit(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityBusinessunit activityBusinessUnit,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityBusinessUnitID')) {
      activityBusinessUnit.activityBusinessUnitID =
          jsonObj['ActivityBusinessUnitID'].toString();
    }
    if (jsonObj.containsKey('ActivityBusinessUnitCode')) {
      activityBusinessUnit.activityBusinessUnitCode =
          jsonObj['ActivityBusinessUnitCode'].toString();
    }

    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId.isNotEmpty ? activityId : '-1';
      Activity? activity = await ActivityDataHandlerBase.GetMasterActivityRecord(
          dbHandler, activityId);
      if (activity != null) {
        activityBusinessUnit.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey('BusinessUnitID')) {
      String businessUnitId = jsonObj['BusinessUnitID'].toString();
      businessUnitId = businessUnitId.isNotEmpty ? businessUnitId : '-1';
      BusinessUnit? businessUnit = await BusinessUnitDataHandlerBase
          .GetMasterBusinessUnitRecord(dbHandler, businessUnitId);
      if (businessUnit != null) {
        activityBusinessUnit.businessUnitID = businessUnit.id;
      }
    }

    if (jsonObj.containsKey('CreatedBy')) {
      activityBusinessUnit.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityBusinessUnit.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityBusinessUnit.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityBusinessUnit.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityBusinessUnit.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityBusinessUnit.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityBusinessUnit.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityBusinessUnit.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityBusinessUnit.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityBusinessUnit.isDeleted = jsonObj['IsDeleted'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityBusinessUnit.isArchived = jsonObj['IsArchived'].toString();
    }

    activityBusinessUnit.isDirty = 'false';
    activityBusinessUnit.isDeleted1 = 'false';
    activityBusinessUnit.upSyncMessage = '';
    activityBusinessUnit.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityBusinessUnit.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityBusinessUnit.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityBusinessUnit.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityBusinessUnit.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityBusinessUnit.upSyncIndex = '0';
    activityBusinessUnit.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToActivityBusinessUnit()',
      e,
    );
  }
  return activityBusinessUnit;
}

Future<ActivityMeasure> copyJsonDataToActivityMeasure(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityMeasure activityMeasure,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityMeasureID')) {
      activityMeasure.activityMeasureID =
          jsonObj['ActivityMeasureID'].toString();
    }
    if (jsonObj.containsKey('ActivityMeasureCode')) {
      activityMeasure.activityMeasureCode =
          jsonObj['ActivityMeasureCode'].toString();
    }
    if (jsonObj.containsKey('ActivityMeasureName')) {
      activityMeasure.activityMeasureName =
          jsonObj['ActivityMeasureName'].toString();
    }
    if (jsonObj.containsKey('InternalCode')) {
      activityMeasure.internalCode = jsonObj['InternalCode'].toString();
    }
    if (jsonObj.containsKey('IsDefault')) {
      activityMeasure.isDefault = jsonObj['IsDefault'].toString();
    }
    if (jsonObj.containsKey('SequentialOrder')) {
      activityMeasure.sequentialOrder =
          jsonObj['SequentialOrder'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityMeasure.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityMeasure.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityMeasure.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityMeasure.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityMeasure.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityMeasure.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityMeasure.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityMeasure.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityMeasure.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityMeasure.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityMeasure.isDirty = 'false';
    activityMeasure.isDeleted1 = 'false';
    activityMeasure.upSyncMessage = '';
    activityMeasure.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityMeasure.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityMeasure.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityMeasure.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityMeasure.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }

    activityMeasure.upSyncIndex = '0';
    activityMeasure.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityMeasure()',
      e,
    );
  }
  return activityMeasure;
}



Future<ActivityMedia> copyJsonDataToActivityMedia(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityMedia activityMedia,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityMediaID')) {
      activityMedia.activityMediaID =
          jsonObj['ActivityMediaID'].toString();
    }
    if (jsonObj.containsKey('ActivityMediaCode')) {
      activityMedia.activityMediaCode =
          jsonObj['ActivityMediaCode'].toString();
    }
    if (jsonObj.containsKey('ActivityMediaName')) {
      activityMedia.activityMediaName =
          jsonObj['ActivityMediaName'].toString();
    }

    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId != null && activityId.isNotEmpty
          ? activityId
          : '-1';
      Activity? activity =  await ActivityDataHandlerBase.GetMasterActivityRecord(
        dbHandler,
        activityId,
      );
      if (activity != null) {
        activityMedia.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey('ContentTypeID')) {
      String contentTypeId = jsonObj['ContentTypeID'].toString();
      contentTypeId = contentTypeId != null && contentTypeId.isNotEmpty
          ? contentTypeId
          : '-1';
      ContentType contentType = ContentTypeDataHandlerBase.GetMasterContentTypeRecord(
        dbHandler,
        context,
        contentTypeId,
      );
      if (contentType != null) {
        activityMedia.contentTypeID = contentType.getId();
      }
    }

    if (jsonObj.containsKey('MediaPath')) {
      activityMedia.mediaPath = jsonObj['MediaPath'].toString();
    }
    if (jsonObj.containsKey('MediaContent')) {
      activityMedia.mediaContent = jsonObj['MediaContent'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      activityMedia.description = jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('Tags')) {
      activityMedia.tags = jsonObj['Tags'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityMedia.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityMedia.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityMedia.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityMedia.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      activityMedia.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityMedia.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Location')) {
      activityMedia.location = jsonObj['Location'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityMedia.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityMedia.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityMedia.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityMedia.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityMedia.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityMedia.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityMedia.isDirty = 'false';
    activityMedia.isDeleted1 = 'false';
    activityMedia.upSyncMessage = '';
    activityMedia.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityMedia.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityMedia.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityMedia.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityMedia.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }

    activityMedia.upSyncIndex = '0';
    activityMedia.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityMedia()',
      e,
    );
  }
  return activityMedia;
}


Future<ActivityPermission> copyJsonDataToActivityPermission(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityPermission activityPermission,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityPermissionID')) {
      activityPermission.activityPermissionID =
          jsonObj['ActivityPermissionID'].toString();
    }
    if (jsonObj.containsKey('ActivityPermissionCode')) {
      activityPermission.activityPermissionCode =
          jsonObj['ActivityPermissionCode'].toString();
    }

    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId != null && activityId.isNotEmpty
          ? activityId
          : '-1';
      Activity activity = ActivityDataHandler.GetMasterActivityRecord(
        dbHandler,
        context,
        activityId,
      );
      if (activity != null) {
        activityPermission.activityID = activity.getId();
      }
    }

    if (jsonObj.containsKey('AppUserID')) {
      activityPermission.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('PermissionLevel')) {
      activityPermission.permissionLevel =
          jsonObj['PermissionLevel'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityPermission.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityPermission.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityPermission.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityPermission.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityPermission.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityPermission.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityPermission.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityPermission.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityPermission.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityPermission.isDirty = 'false';
    activityPermission.isDeleted1 = 'false';
    activityPermission.upSyncMessage = '';
    activityPermission.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityPermission.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityPermission.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityPermission.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityPermission.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityPermission.upSyncIndex = '0';
    activityPermission.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      context,
      'JSONDataCopier:CopyJsonDataToActivityPermission()',
      e,
    );
  }
  return activityPermission;
}



Future<ActivityPriority> copyJsonDataToActivityPriority(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityPriority activityPriority,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityPriorityID')) {
      activityPriority.activityPriorityID =
          jsonObj['ActivityPriorityID'].toString();
    }
    if (jsonObj.containsKey('ActivityPriorityCode')) {
      activityPriority.activityPriorityCode =
          jsonObj['ActivityPriorityCode'].toString();
    }
    if (jsonObj.containsKey('ActivityPriorityName')) {
      activityPriority.activityPriorityName =
          jsonObj['ActivityPriorityName'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      activityPriority.description = jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('IsDefault')) {
      activityPriority.isDefault = jsonObj['IsDefault'].toString();
    }
    if (jsonObj.containsKey('PriorityOrder')) {
      activityPriority.priorityOrder = jsonObj['PriorityOrder'].toString();
    }
    if (jsonObj.containsKey('AlertOnScheduleSlippage')) {
      activityPriority.alertOnScheduleSlippage =
          jsonObj['AlertOnScheduleSlippage'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityPriority.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityPriority.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityPriority.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityPriority.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityPriority.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityPriority.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityPriority.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityPriority.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityPriority.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityPriority.isDirty = 'false';
    activityPriority.isDeleted1 = 'false';
    activityPriority.upSyncMessage = '';
    activityPriority.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityPriority.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityPriority.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityPriority.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityPriority.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityPriority.upSyncIndex = '0';
    activityPriority.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityPriority()',
      e,
    );
  }
  return activityPriority;
}


Future<ActivityProduct> copyJsonDataToActivityProduct(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityProduct activityProduct,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityProductID')) {
      activityProduct.activityProductID =
          jsonObj['ActivityProductID'].toString();
    }
    if (jsonObj.containsKey('ActivityProductCode')) {
      activityProduct.activityProductCode =
          jsonObj['ActivityProductCode'].toString();
    }

    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId.isNotEmpty ? activityId : '-1';
      Activity? activity = await ActivityDataHandlerBase.GetMasterActivityRecord(
        dbHandler,
        activityId,
      );
      if (activity != null) {
        activityProduct.activityID = activity.getId();
      }
    }

    if (jsonObj.containsKey('ProductID')) {
      String productId = jsonObj['ProductID'].toString();
      productId = productId.isNotEmpty ? productId : '-1';
      Product product = await ProductDataHandlerBase.GetMasterProductRecord(
        dbHandler,
        context,
        productId,
      );
      if (product != null) {
        activityProduct.productID = product.getId();
      }
    }
    if (jsonObj.containsKey('Price')) {
      activityProduct.price = jsonObj['Price'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityProduct.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityProduct.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityProduct.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityProduct.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityProduct.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityProduct.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityProduct.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityProduct.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityProduct.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityProduct.isDeleted = jsonObj['IsDeleted'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityProduct.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }

    activityProduct.isDirty = 'false';
    activityProduct.isDeleted1 = 'false';
    activityProduct.upSyncMessage = '';
    activityProduct.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityProduct.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityProduct.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityProduct.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityProduct.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityProduct.upSyncIndex = '0';
    activityProduct.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      context,
      'JSONDataCopier:CopyJsonDataToActivityProduct()',
      e,
    );
  }
  return activityProduct;
}



Future<ActivityProductDetail> copyJsonDataToActivityProductDetail(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityProductDetail activityProductDetail,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityProductDetailID')) {
      activityProductDetail.activityProductDetailID =
          jsonObj['ActivityProductDetailID'].toString();
    }
    if (jsonObj.containsKey('ActivityProductDetailCode')) {
      activityProductDetail.activityProductDetailCode =
          jsonObj['ActivityProductDetailCode'].toString();
    }

    if (jsonObj.containsKey('ActivityProductID')) {
      String activityProductId = jsonObj['ActivityProductID'].toString();
      activityProductId =
          activityProductId.isNotEmpty ? activityProductId : '-1';
      ActivityProduct? activityProduct =
          await ActivityProductDataHandlerBase.GetMasterActivityProductRecord(
        dbHandler,
        activityProductId,
      );
      if (activityProduct != null) {
        activityProductDetail.activityProductID = activityProduct.getId();
      }
    }

    if (jsonObj.containsKey('Attribute')) {
      activityProductDetail.attribute =
          jsonObj['Attribute'].toString();
    }
    if (jsonObj.containsKey('Price')) {
      String bigValue = jsonObj['Price'].toString();
      String price = bigValue;
      if (bigValue.contains('E')) {
        BigInt bi = BigInt.parse(bigValue);
        price = bi.toInt().toString();
      }
      activityProductDetail.price = price;
    }
    if (jsonObj.containsKey('Quantity')) {
      activityProductDetail.quantity = jsonObj['Quantity'].toString();
    }
    if (jsonObj.containsKey('Amount')) {
      String bigValue = jsonObj['Amount'].toString();
      String amount = bigValue;
      if (bigValue.contains('E')) {
        BigInt bi = BigInt.parse(bigValue);
        amount = bi.toInt().toString();
      }
      activityProductDetail.amount = amount;
    }

    if (jsonObj.containsKey('SupplierAccountID')) {
      String accountId = jsonObj['SupplierAccountID'].toString();
      accountId = accountId.isNotEmpty ? accountId : '-1';
      Account? account =
          await AccountDataHandlerBase.GetMasterAccountRecord(
        dbHandler,
        accountId,
      );
      if (account != null) {
        activityProductDetail.supplierAccountID = account.id;
      }
    }

    if (jsonObj.containsKey('CreatedBy')) {
      activityProductDetail.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityProductDetail.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityProductDetail.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityProductDetail.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityProductDetail.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityProductDetail.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityProductDetail.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityProductDetail.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityProductDetail.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityProductDetail.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityProductDetail.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }

    activityProductDetail.isDirty = 'false';
    activityProductDetail.isDeleted1 = 'false';
    activityProductDetail.upSyncMessage = '';
    activityProductDetail.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityProductDetail.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityProductDetail.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityProductDetail.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityProductDetail.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityProductDetail.upSyncIndex = '0';
    activityProductDetail.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToActivityProductDetail()',
      e,
    );
  }
  return activityProductDetail;
}



Future<ActivityStatus> copyJsonDataToActivityStatus(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityStatus activityStatus,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityStatusID')) {
      activityStatus.activityStatusID =
          jsonObj['ActivityStatusID'].toString();
    }
    if (jsonObj.containsKey('ActivityStatusCode')) {
      activityStatus.activityStatusCode =
          jsonObj['ActivityStatusCode'].toString();
    }
    if (jsonObj.containsKey('ActivityStatusName')) {
      activityStatus.activityStatusName =
          jsonObj['ActivityStatusName'].toString();
    }
    if (jsonObj.containsKey('InternalCode')) {
      activityStatus.internalCode =
          jsonObj['InternalCode'].toString();
    }
    if (jsonObj.containsKey('DisplayInApp')) {
      activityStatus.displayInApp =
          jsonObj['DisplayInApp'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityStatus.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityStatus.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityStatus.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityStatus.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityStatus.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityStatus.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityStatus.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityStatus.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityStatus.isDeleted =
          jsonObj['IsDeleted'].toString();
    }

    activityStatus.isDirty = 'false';
    activityStatus.isDeleted1 = 'false';
    activityStatus.upSyncMessage = '';
    activityStatus.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityStatus.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityStatus.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityStatus.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityStatus.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityStatus.upSyncIndex = '0';
    activityStatus.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      context,
      'JSONDataCopier:CopyJsonDataToActivityStatus()',
      e,
    );
  }
  return activityStatus;
}



Future<ActivityTeam> copyJsonDataToActivityTeam(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityTeam activityTeam,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityTeamID')) {
      activityTeam.activityTeamID = jsonObj['ActivityTeamID'].toString();
    }
    if (jsonObj.containsKey('ActivityTeamCode')) {
      activityTeam.activityTeamCode = jsonObj['ActivityTeamCode'].toString();
    }
    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId.isNotEmpty ? activityId : '-1';
      Activity? activity = await ActivityDataHandlerBase.GetMasterActivityRecord(
        dbHandler,
        activityId,
      );
      if (activity != null) {
        activityTeam.activityID = activity.id;
      }
    }
    if (jsonObj.containsKey('ActivityTeamAppUserID')) {
      activityTeam.activityTeamAppUserID =
          jsonObj['ActivityTeamAppUserID'].toString();
    }
    if (jsonObj.containsKey('ActivityTeamAppUserName')) {
      activityTeam.appUserName =
          jsonObj['ActivityTeamAppUserName'].toString();
    }
    if (jsonObj.containsKey('Designation')) {
      activityTeam.Designation = jsonObj['Designation'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      activityTeam.description = jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityTeam.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityTeam.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityTeam.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTeam.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityTeam.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityTeam.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityTeam.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityTeam.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityTeam.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityTeam.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityTeam.isDirty = 'false';
    activityTeam.isDeleted1 = 'false';
    activityTeam.upSyncMessage = '';
    activityTeam.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityTeam.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTeam.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityTeam.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityTeam.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    activityTeam.upSyncIndex = '0';
    activityTeam.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToActivityTeam()',
      e,
    );
  }
  return activityTeam;
}


Future<ActivityTravel> copyJsonDataToActivityTravel(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityTravel activityTravel,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityTravelID')) {
      activityTravel.activityTravelID =
          jsonObj['ActivityTravelID'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelCode')) {
      activityTravel.activityTravelCode =
          jsonObj['ActivityTravelCode'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelTitle')) {
      activityTravel.activityTravelTitle =
          jsonObj['ActivityTravelTitle'].toString();
    }
    if (jsonObj.containsKey('ActivityID')) {
      String activityId = jsonObj['ActivityID'].toString();
      activityId = activityId.isNotEmpty ? activityId : '-1';
      Activity ?activity = await ActivityDataHandlerBase.GetMasterActivityRecord(
        dbHandler,
        activityId,
      );
      if (activity != null) {
        activityTravel.activityID = activity.id;
      }
    }
    if (jsonObj.containsKey('ActivityTravelDate')) {
      activityTravel.activityTravelDate =
          jsonObj['ActivityTravelDate'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelEndDate')) {
      activityTravel.activityTravelEndDate =
          jsonObj['ActivityTravelEndDate'].toString();
    }
    if (jsonObj.containsKey('TravelPurposeName')) {
      activityTravel.travelPurposeName =
          jsonObj['TravelPurposeName'].toString();
    }
    if (jsonObj.containsKey('StartLocation')) {
      activityTravel.startLocation = jsonObj['StartLocation'].toString();
    }
    if (jsonObj.containsKey('EndLocation')) {
      activityTravel.endLocation = jsonObj['EndLocation'].toString();
    }
    if (jsonObj.containsKey('StartLocationCoordinate')) {
      activityTravel.startLocationCoordinate =
          jsonObj['StartLocationCoordinate'].toString();
    }
    if (jsonObj.containsKey('EndLocationCoordinate')) {
      activityTravel.endLocationCoordinate =
          jsonObj['EndLocationCoordinate'].toString();
    }
    if (jsonObj.containsKey('ActualDistance')) {
      activityTravel.actualDistance =
          jsonObj['ActualDistance'].toString();
    }
    if (jsonObj.containsKey('DistanceTravelled')) {
      activityTravel.distanceTravelled =
          jsonObj['DistanceTravelled'].toString();
    }
    if (jsonObj.containsKey('ModeOfTravelID')) {
      String modeOfTravelId = jsonObj['ModeOfTravelID'].toString();
      modeOfTravelId = modeOfTravelId.isNotEmpty ? modeOfTravelId : '-1';
      ModeOfTravel ?modeOfTravel =
          await ModeOfTravelDataHandlerBase.GetMasterModeOfTravelRecord(
        dbHandler,
        modeOfTravelId,
      );
      if (modeOfTravel != null) {
        activityTravel.modeOfTravelID = modeOfTravel.getId();
      }
    }
    if (jsonObj.containsKey('TravelExpense')) {
      activityTravel.travelExpense = jsonObj['TravelExpense'].toString();
    }
    if (jsonObj.containsKey('ReasonForDeviation')) {
      activityTravel.reasonForDeviation =
          jsonObj['ReasonForDeviation'].toString();
    }
    if (jsonObj.containsKey('OtherExpense')) {
      activityTravel.otherExpense = jsonObj['OtherExpense'].toString();
    }
    if (jsonObj.containsKey('TotalExpense')) {
      activityTravel.totalExpense = jsonObj['TotalExpense'].toString();
    }
    if (jsonObj.containsKey('Tags')) {
      activityTravel.tags = jsonObj['Tags'].toString();
    }
    if (jsonObj.containsKey('IsSubmitted')) {
      activityTravel.isSubmitted = jsonObj['IsSubmitted'].toString();
    }
    if (jsonObj.containsKey('Remarks')) {
      activityTravel.remarks = jsonObj['Remarks'].toString();
    }
    if (jsonObj.containsKey('ApprovalStatus')) {
      activityTravel.approvalStatus = jsonObj['ApprovalStatus'].toString();
    }
    if (jsonObj.containsKey('ApprovedByAppUserName')) {
      activityTravel.approvedByAppUserName =
          jsonObj['ApprovedByAppUserName'].toString();
    }
    if (jsonObj.containsKey('ApprovedTime')) {
      activityTravel.approvedTime = jsonObj['ApprovedTime'].toString();
    }
    if (jsonObj.containsKey('ApproverRemarks')) {
      activityTravel.approverRemarks =
          jsonObj['ApproverRemarks'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityTravel.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravel.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityTravel.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravel.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      activityTravel.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityTravel.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Location')) {
      activityTravel.location = jsonObj['Location'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityTravel.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityTravel.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityTravel.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityTravel.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityTravel.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityTravel.isDeleted = jsonObj['IsDeleted'].toString();
    }

    activityTravel.isDirty = 'false';
    activityTravel.isDeleted1 = 'false';
    activityTravel.upSyncMessage = '';
    activityTravel.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravel.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravel.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityTravel.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityTravel.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityTravel.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID')) {
      activityTravel.ownerUserID = jsonObj['AppUserID'].toString();
    }*/
    activityTravel.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityTravel()',
      e,
    );
  }
  return activityTravel;
}


ActivityTravelExpense copyJsonDataToActivityTravelExpense(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityTravelExpense activityTravelExpense,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('ActivityTravelExpenseID')) {
      activityTravelExpense.activityTravelExpenseID =
          jsonObj['ActivityTravelExpenseID'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelExpenseCode')) {
      activityTravelExpense.activityTravelExpenseCode =
          jsonObj['ActivityTravelExpenseCode'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelExpenseTitle')) {
      activityTravelExpense.activityTravelExpenseTitle =
          jsonObj['ActivityTravelExpenseTitle'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelID')) {
      String activityTravelId =
          jsonObj['ActivityTravelID'].toString();
      activityTravelId =
          activityTravelId.isNotEmpty ? activityTravelId : '-1';
      ActivityTravel? activityTravel =await 
          ActivityTravelDataHandlerBase.GetMasterActivityTravelRecord(
        dbHandler,
        activityTravelId,
      );
      if (activityTravel != null) {
        activityTravelExpense.activityTravelID = activityTravel.getId();
      }
    }
    if (jsonObj.containsKey('ExpenseTypeID')) {
      String expenseTypeId =
          jsonObj['ExpenseTypeID'].toString();
      expenseTypeId =
          expenseTypeId.isNotEmpty ? expenseTypeId : '-1';
      ExpenseType expenseType =await 
          ExpenseTypeDataHandlerBase.GetMasterExpenseTypeRecord(
        dbHandler,
        expenseTypeId,
      );
      if (expenseType != null) {
        activityTravelExpense.expenseTypeID = expenseType.getId();
      }
    }
    if (jsonObj.containsKey('DistanceTravelled')) {
      activityTravelExpense.distanceTravelled =
          jsonObj['DistanceTravelled'].toString();
    }
    if (jsonObj.containsKey('ModeOfTravelID')) {
      String modeOfTravelId =
          jsonObj['ModeOfTravelID'].toString();
      modeOfTravelId =
          modeOfTravelId.isNotEmpty ? modeOfTravelId : '-1';
      ModeOfTravel? modeOfTravel =
      await    ModeOfTravelDataHandlerBase.GetMasterModeOfTravelRecord(
        dbHandler,
        modeOfTravelId,
      );
      if (modeOfTravel != null) {
        activityTravelExpense.modeOfTravelID = modeOfTravel.getId();
      }
    }
    if (jsonObj.containsKey('Amount')) {
      activityTravelExpense.amount =
          jsonObj['Amount'].toString();
    }
    if (jsonObj.containsKey('Remarks')) {
      activityTravelExpense.remarks =
          jsonObj['Remarks'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityTravelExpense.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelExpense.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityTravelExpense.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelExpense.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      activityTravelExpense.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityTravelExpense.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Location')) {
      activityTravelExpense.location =
          jsonObj['Location'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityTravelExpense.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityTravelExpense.uid =
          jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityTravelExpense.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityTravelExpense.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityTravelExpense.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityTravelExpense.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    activityTravelExpense.isDirty = 'false';
    activityTravelExpense.isDeleted1 = 'false';
    activityTravelExpense.upSyncMessage = '';
    activityTravelExpense.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelExpense.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelExpense.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityTravelExpense.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityTravelExpense.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityTravelExpense.upSyncIndex = '0';
    activityTravelExpense.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityTravelExpense()',
      e,
    );
  }
  return activityTravelExpense;
}

ActivityTravelMapping copyJsonDataToActivityTravelMapping(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityTravelMapping activityTravelMapping,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('ActivityTravelMappingID')) {
      activityTravelMapping.activityTravelMappingID =
          jsonObj['ActivityTravelMappingID'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelMappingCode')) {
      activityTravelMapping.activityTravelMappingCode =
          jsonObj['ActivityTravelMappingCode'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelID')) {
      String activityTravelId =
          jsonObj['ActivityTravelID'].toString();
      activityTravelId =
          activityTravelId.isNotEmpty ? activityTravelId : '-1';
      ActivityTravel? activityTravel =await 
          ActivityTravelDataHandlerBase.GetMasterActivityTravelRecord(
        dbHandler,
        activityTravelId,
      );
      if (activityTravel != null) {
        activityTravelMapping.activityTravelID = activityTravel.getId();
      }
    }
    if (jsonObj.containsKey('ActivityID')) {
      String activityId =
          jsonObj['ActivityID'].toString();
      activityId =
          activityId.isNotEmpty ? activityId : '-1';
      Activity activity =
          ActivityDataHandler.GetMasterActivityRecord(
        dbHandler,
        context,
        activityId,
      );
      if (activity != null) {
        activityTravelMapping.activityID = activity.getId();
      }
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityTravelMapping.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelMapping.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityTravelMapping.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelMapping.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityTravelMapping.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityTravelMapping.uid =
          jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityTravelMapping.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityTravelMapping.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityTravelMapping.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityTravelMapping.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    activityTravelMapping.isDirty = 'false';
    activityTravelMapping.isDeleted1 = 'false';
    activityTravelMapping.upSyncMessage = '';
    activityTravelMapping.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelMapping.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelMapping.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityTravelMapping.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityTravelMapping.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityTravelMapping.upSyncIndex = '0';
    activityTravelMapping.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityTravelMapping()',
      e,
    );
  }
  return activityTravelMapping;
}


ActivityTravelMedia copyJsonDataToActivityTravelMedia(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityTravelMedia activityTravelMedia,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('ActivityTravelMediaID')) {
      activityTravelMedia.activityTravelMediaID =
          jsonObj['ActivityTravelMediaID'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelMediaCode')) {
      activityTravelMedia.activityTravelMediaCode =
          jsonObj['ActivityTravelMediaCode'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelMediaName')) {
      activityTravelMedia.activityTravelMediaName =
          jsonObj['ActivityTravelMediaName'].toString();
    }
    if (jsonObj.containsKey('ActivityTravelID')) {
      String activityTravelId =
          jsonObj['ActivityTravelID'].toString();
      activityTravelId =
          activityTravelId.isNotEmpty ? activityTravelId : '-1';
      ActivityTravel ?activityTravel =await 
          ActivityTravelDataHandlerBase.GetMasterActivityTravelRecord(
        dbHandler,
        activityTravelId,
      );
      if (activityTravel != null) {
        activityTravelMedia.activityTravelID = activityTravel.id;
      }
    }
    if (jsonObj.containsKey('ContentTypeID')) {
      String contentTypeId =
          jsonObj['ContentTypeID'].toString();
      contentTypeId =
          contentTypeId.isNotEmpty ? contentTypeId : '-1';
      ContentType ?contentType =await 
          ContentTypeDataHandlerBase.GetMasterContentTypeRecord(
        dbHandler,
        context,
        contentTypeId,
      );
      if (contentType != null) {
        activityTravelMedia.contentTypeID = contentType.getId();
      }
    }
    if (jsonObj.containsKey('MediaPath')) {
      activityTravelMedia.mediaPath =
          jsonObj['MediaPath'].toString();
    }
    if (jsonObj.containsKey('MediaContent')) {
      activityTravelMedia.mediaContent =
          jsonObj['MediaContent'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      activityTravelMedia.description =
          jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('Tags')) {
      activityTravelMedia.tags =
          jsonObj['Tags'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityTravelMedia.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelMedia.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityTravelMedia.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelMedia.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      activityTravelMedia.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      activityTravelMedia.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityTravelMedia.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityTravelMedia.uid =
          jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityTravelMedia.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityTravelMedia.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityTravelMedia.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityTravelMedia.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    activityTravelMedia.isDirty = 'false';
    activityTravelMedia.isDeleted1 = 'false';
    activityTravelMedia.upSyncMessage = '';
    activityTravelMedia.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityTravelMedia.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityTravelMedia.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityTravelMedia.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityTravelMedia.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityTravelMedia.upSyncIndex = '0';
    activityTravelMedia.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityTravelMedia()',
      e,
    );
  }
  return activityTravelMedia;
}



Future<ActivityType> copyJsonDataToActivityType(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  ActivityType activityType,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('ActivityTypeID')) {
      activityType.activityTypeID =
          jsonObj['ActivityTypeID'].toString();
    }
    if (jsonObj.containsKey('ActivityTypeCode')) {
      activityType.activityTypeCode =
          jsonObj['ActivityTypeCode'].toString();
    }
    if (jsonObj.containsKey('ActivityTypeName')) {
      activityType.activityTypeName =
          jsonObj['ActivityTypeName'].toString();
    }
    if (jsonObj.containsKey('BusinessFeatureID')) {
      String businessFeatureId =
          jsonObj['BusinessFeatureID'].toString();
      businessFeatureId =
          businessFeatureId.isNotEmpty ? businessFeatureId : '-1';
      BusinessFeature? businessFeature =await 
          BusinessFeatureDataHandlerBase.GetMasterBusinessFeatureRecord(
        dbHandler,
        businessFeatureId,
      );
      if (businessFeature != null) {
        activityType.businessFeatureID = businessFeature.getId();
      }
    }
    if (jsonObj.containsKey('InternalCode')) {
      activityType.internalCode =
          jsonObj['InternalCode'].toString();
    }
    if (jsonObj.containsKey('SequentialOrder')) {
      activityType.sequentialOrder =
          jsonObj['SequentialOrder'].toString();
    }
    if (jsonObj.containsKey('IsEndDateRequired')) {
      activityType.isEndDateRequired =
          jsonObj['IsEndDateRequired'].toString();
    }
    if (jsonObj.containsKey('IsDurationRequired')) {
      activityType.isDurationRequired =
          jsonObj['IsDurationRequired'].toString();
    }
    if (jsonObj.containsKey('IsAccountMandatory')) {
      activityType.isAccountMandatory =
          jsonObj['IsAccountMandatory'].toString();
    }
    if (jsonObj.containsKey('IsOpportunityRequired')) {
      activityType.isOpportunityRequired =
          jsonObj['IsOpportunityRequired'].toString();
    }
    if (jsonObj.containsKey('IsOpportunityNameRequired')) {
      activityType.isOpportunityNameRequired =
          jsonObj['IsOpportunityNameRequired'].toString();
    }
    if (jsonObj.containsKey('IsApprovalRequiredOnCompletion')) {
      activityType.isApprovalRequiredOnCompletion =
          jsonObj['IsApprovalRequiredOnCompletion'].toString();
    }
    if (jsonObj.containsKey('AlertOnScheduleSlippage')) {
      activityType.alertOnScheduleSlippage =
          jsonObj['AlertOnScheduleSlippage'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      activityType.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      activityType.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityType.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      activityType.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      activityType.uid =
          jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      activityType.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      activityType.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      activityType.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      activityType.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      activityType.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    activityType.isDirty = 'false';
    activityType.isDeleted1 = 'false';
    activityType.upSyncMessage = '';
    activityType.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      activityType.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      activityType.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      activityType.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      activityType.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    activityType.upSyncIndex = '0';
    activityType.ownerUserID =
        Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToActivityType()',
      e,
    );
  }
  return activityType;
}


AddressType copyJsonDataToAddressType(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AddressType addressType,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AddressTypeID')) {
      addressType.addressTypeID = jsonObj['AddressTypeID'].toString();
    }
    if (jsonObj.containsKey('AddressTypeCode')) {
      addressType.addressTypeCode = jsonObj['AddressTypeCode'].toString();
    }
    if (jsonObj.containsKey('AddressTypeName')) {
      addressType.addressTypeName = jsonObj['AddressTypeName'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      addressType.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      addressType.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      addressType.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      addressType.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      addressType.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      addressType.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      addressType.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      addressType.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      addressType.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      addressType.isDeleted = jsonObj['IsDeleted'].toString();
    }
    addressType.isDirty = 'false';
    addressType.isDeleted1 = 'false';
    addressType.upSyncMessage = '';
    addressType.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      addressType.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      addressType.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      addressType.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      addressType.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    addressType.upSyncIndex = '0';
    addressType.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToAddressType()',
      e,
    );
  }
  return addressType;
}


Future<AppFeature> copyJsonDataToAppFeature(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppFeature appFeature,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey('AppFeatureID')) {
      appFeature.appFeatureID = jsonObj['AppFeatureID'].toString();
    }
    if (jsonObj.containsKey('AppFeatureCode')) {
      appFeature.appFeatureCode = jsonObj['AppFeatureCode'].toString();
    }
    if (jsonObj.containsKey('AppFeatureName')) {
      appFeature.appFeatureName = jsonObj['AppFeatureName'].toString();
    }
    if (jsonObj.containsKey('BusinessFeatureID')) {
      String businessFeatureId = jsonObj['BusinessFeatureID'].toString();
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty
          ? businessFeatureId
          : '-1';
      BusinessFeature? businessFeature =await
          BusinessFeatureDataHandlerBase.GetMasterBusinessFeatureRecord(
        dbHandler,
        businessFeatureId,
      );
      if (businessFeature != null) {
        appFeature.businessFeatureID = businessFeature.id;
      }
    }
    if (jsonObj.containsKey('AppFeatureGroupID')) {
      String appFeatureGroupId = jsonObj['AppFeatureGroupID'].toString();
      appFeatureGroupId = appFeatureGroupId != null && appFeatureGroupId.isNotEmpty
          ? appFeatureGroupId
          : '-1';
      AppFeatureGroup? appFeatureGroup =await
          AppFeatureGroupDataHandlerBase.GetMasterAppFeatureGroupRecord(
        dbHandler,
        context,
        appFeatureGroupId,
      );
      if (appFeatureGroup != null) {
        appFeature.appFeatureGroupID = appFeatureGroup.id;
      }
    }
    if (jsonObj.containsKey('Description')) {
      appFeature.description = jsonObj['Description'].toString();
    }
    if (jsonObj.containsKey('FormName')) {
      appFeature.formName = jsonObj['FormName'].toString();
    }
    if (jsonObj.containsKey('AppFeatureOrder')) {
      appFeature.appFeatureOrder = jsonObj['AppFeatureOrder'].toString();
    }
    if (jsonObj.containsKey('AppIcon')) {
      appFeature.appIcon = jsonObj['AppIcon'].toString();
    }
    if (jsonObj.containsKey('ConsoleIcon')) {
      appFeature.consoleIcon = jsonObj['ConsoleIcon'].toString();
    }
    if (jsonObj.containsKey('DescriptionText')) {
      appFeature.descriptionText = jsonObj['DescriptionText'].toString();
    }
    if (jsonObj.containsKey('DescriptionHtml')) {
      appFeature.descriptionHtml = jsonObj['DescriptionHtml'].toString();
    }
    if (jsonObj.containsKey('IsConsoleFeature')) {
      appFeature.isConsoleFeature = jsonObj['IsConsoleFeature'].toString();
    }
    if (jsonObj.containsKey('IsAppFeature')) {
      appFeature.isAppFeature = jsonObj['IsAppFeature'].toString();
    }
    if (jsonObj.containsKey('InternalCode')) {
      appFeature.internalCode = jsonObj['InternalCode'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appFeature.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appFeature.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appFeature.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeature.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      appFeature.deviceIdentifier = jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      appFeature.referenceIdentifier = jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      appFeature.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appFeature.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appFeature.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appFeature.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      appFeature.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appFeature.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appFeature.isDirty = 'false';
    appFeature.isDeleted1 = 'false';
    appFeature.upSyncMessage = '';
    appFeature.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appFeature.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeature.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appFeature.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appFeature.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appFeature.upSyncIndex = '0';
    appFeature.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      context,
      'JSONDataCopier:CopyJsonDataToAppFeature()',
      e,
    );
  }
  return appFeature;
}



AppFeatureField copyJsonDataToAppFeatureField(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppFeatureField appFeatureField,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppFeatureFieldID')) {
      appFeatureField.appFeatureFieldID =
          jsonObj['AppFeatureFieldID'].toString();
    }
    if (jsonObj.containsKey('AppFeatureFieldCode')) {
      appFeatureField.appFeatureFieldCode =
          jsonObj['AppFeatureFieldCode'].toString();
    }
    if (jsonObj.containsKey('AppFeatureFieldName')) {
      appFeatureField.appFeatureFieldName =
          jsonObj['AppFeatureFieldName'].toString();
    }
    if (jsonObj.containsKey('AppFeatureID')) {
      String appFeatureId = jsonObj['AppFeatureID'].toString();
      appFeatureId = appFeatureId != null && appFeatureId.isNotEmpty
          ? appFeatureId
          : '-1';
      AppFeature ?appFeature = await 
          AppFeatureDataHandlerBase.GetMasterAppFeatureRecord(
        dbHandler,
        appFeatureId,
      );
      if (appFeature != null) {
        appFeatureField.appFeatureID = appFeature.id;
      }
    }
    if (jsonObj.containsKey('DescriptionText')) {
      appFeatureField.descriptionText = jsonObj['DescriptionText'].toString();
    }
    if (jsonObj.containsKey('DescriptionHtml')) {
      appFeatureField.descriptionHtml = jsonObj['DescriptionHtml'].toString();
    }
    if (jsonObj.containsKey('AppFeatureFieldOrder')) {
      appFeatureField.appFeatureFieldOrder =
          jsonObj['AppFeatureFieldOrder'].toString();
    }
    if (jsonObj.containsKey('IsHidden')) {
      appFeatureField.isHidden = jsonObj['IsHidden'].toString();
    }
    if (jsonObj.containsKey('IsRequired')) {
      appFeatureField.isRequired = jsonObj['IsRequired'].toString();
    }
    if (jsonObj.containsKey('NewLabel')) {
      appFeatureField.newLabel = jsonObj['NewLabel'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appFeatureField.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appFeatureField.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appFeatureField.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeatureField.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      appFeatureField.deviceIdentifier =
          jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      appFeatureField.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      appFeatureField.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appFeatureField.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appFeatureField.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appFeatureField.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      appFeatureField.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appFeatureField.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appFeatureField.isDirty = 'false';
    appFeatureField.isDeleted1 = 'false';
    appFeatureField.upSyncMessage = '';
    appFeatureField.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appFeatureField.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeatureField.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appFeatureField.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appFeatureField.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appFeatureField.upSyncIndex = '0';
    if (jsonObj.containsKey('AppFeatureName')) {
      appFeatureField.appFeatureName = jsonObj['AppFeatureName'].toString();
    }
    if (jsonObj.containsKey('IsHiddenInFab')) {
      appFeatureField.isHiddenInFab = jsonObj['IsHiddenInFab'].toString();
    }
    appFeatureField.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToAppFeatureField()',
      e,
    );
  }
  return appFeatureField;
}


static AppFeatureGroup copyJsonDataToAppFeatureGroup(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppFeatureGroup appFeatureGroup,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppFeatureGroupID')) {
      appFeatureGroup.appFeatureGroupID =
          jsonObj['AppFeatureGroupID'].toString();
    }
    if (jsonObj.containsKey('AppFeatureGroupCode')) {
      appFeatureGroup.appFeatureGroupCode =
          jsonObj['AppFeatureGroupCode'].toString();
    }
    if (jsonObj.containsKey('AppFeatureGroupName')) {
      appFeatureGroup.appFeatureGroupName =
          jsonObj['AppFeatureGroupName'].toString();
    }
    if (jsonObj.containsKey('BusinessFeatureID')) {
      String businessFeatureId = jsonObj['BusinessFeatureID'].toString();
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty
          ? businessFeatureId
          : '-1';
      BusinessFeature businessFeature =await 
          BusinessFeatureDataHandlerBase.GetMasterBusinessFeatureRecord(
        dbHandler,
        businessFeatureId,
      );
      if (businessFeature != null) {
        appFeatureGroup.businessFeatureID = businessFeature.id;
      }
    }
    if (jsonObj.containsKey('AppFeatureGroupOrder')) {
      appFeatureGroup.appFeatureGroupOrder =
          jsonObj['AppFeatureGroupOrder'].toString();
    }
    if (jsonObj.containsKey('ParentAppFeatureGroupID')) {
      String appFeatureGroupId =
          jsonObj['ParentAppFeatureGroupID'].toString();
      appFeatureGroupId = appFeatureGroupId != null && appFeatureGroupId.isNotEmpty
          ? appFeatureGroupId
          : '-1';
      AppFeatureGroup appFeatureGroup1 =
          AppFeatureGroupDataHandlerBase.GetMasterAppFeatureGroupRecord(
        dbHandler,
        appFeatureGroupId,
      );
      if (appFeatureGroup1 != null) {
        appFeatureGroup.parentAppFeatureGroupID = appFeatureGroup1.id;
      }
    }
    if (jsonObj.containsKey('AppIcon')) {
      appFeatureGroup.appIcon = jsonObj['AppIcon'].toString();
    }
    if (jsonObj.containsKey('ConsoleIcon')) {
      appFeatureGroup.consoleIcon = jsonObj['ConsoleIcon'].toString();
    }
    if (jsonObj.containsKey('DescriptionText')) {
      appFeatureGroup.descriptionText = jsonObj['DescriptionText'].toString();
    }
    if (jsonObj.containsKey('DescriptionHtml')) {
      appFeatureGroup.descriptionHtml = jsonObj['DescriptionHtml'].toString();
    }
    if (jsonObj.containsKey('MenuPosition')) {
      appFeatureGroup.menuPosition = jsonObj['MenuPosition'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appFeatureGroup.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appFeatureGroup.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appFeatureGroup.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeatureGroup.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      appFeatureGroup.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appFeatureGroup.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appFeatureGroup.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appFeatureGroup.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appFeatureGroup.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appFeatureGroup.isDirty = 'false';
    appFeatureGroup.isDeleted1 = 'false';
    appFeatureGroup.upSyncMessage = '';
    appFeatureGroup.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appFeatureGroup.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appFeatureGroup.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appFeatureGroup.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appFeatureGroup.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appFeatureGroup.upSyncIndex = '0';
    appFeatureGroup.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToAppFeatureGroup()',
      e,
    );
  }
  return appFeatureGroup;
}


static AppLog copyJsonDataToAppLog(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppLog appLog,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppLogID')) {
      appLog.appLogID = jsonObj['AppLogID'].toString();
    }
    if (jsonObj.containsKey('AppLogCode')) {
      appLog.appLogCode = jsonObj['AppLogCode'].toString();
    }
    if (jsonObj.containsKey('AppLogDetail')) {
      appLog.appLogDetail = jsonObj['AppLogDetail'].toString();
    }
    if (jsonObj.containsKey('OperatingSystem')) {
      appLog.operatingSystem = jsonObj['OperatingSystem'].toString();
    }
    if (jsonObj.containsKey('OperatingSystemVersion')) {
      appLog.operatingSystemVersion =
          jsonObj['OperatingSystemVersion'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appLog.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appLog.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      appLog.deviceIdentifier = jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appLog.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appLog.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appLog.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      appLog.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appLog.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appLog.isDirty = 'false';
    appLog.isDeleted1 = 'false';
    appLog.upSyncMessage = '';
    appLog.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appLog.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appLog.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appLog.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appLog.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appLog.upSyncIndex = '0';
    appLog.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      'JSONDataCopier:CopyJsonDataToAppLog()',
      e,
    );
  }
  return appLog;
}


AppReport copyJsonDataToAppReport(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppReport appReport,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppReportID')) {
      appReport.appReportID = jsonObj['AppReportID'].toString();
    }
    if (jsonObj.containsKey('AppReportCode')) {
      appReport.appReportCode = jsonObj['AppReportCode'].toString();
    }
    if (jsonObj.containsKey('AppReportName')) {
      appReport.appReportName = jsonObj['AppReportName'].toString();
    }
    if (jsonObj.containsKey('AppReportPath')) {
      appReport.appReportPath = jsonObj['AppReportPath'].toString();
    }
    if (jsonObj.containsKey('AppReportType')) {
      appReport.appReportType = jsonObj['AppReportType'].toString();
    }
    if (jsonObj.containsKey('SequentialOrder')) {
      appReport.sequentialOrder = jsonObj['SequentialOrder'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appReport.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appReport.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appReport.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appReport.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      appReport.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appReport.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appReport.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appReport.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      appReport.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appReport.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appReport.isDirty = 'false';
    appReport.isDeleted1 = 'false';
    appReport.upSyncMessage = '';
    appReport.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appReport.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appReport.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appReport.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appReport.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appReport.upSyncIndex = '0';
    appReport.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToAppReport()',
      e,
    );
  }
  return appReport;
}



AppUsage copyJsonDataToAppUsage(
  DatabaseHandler dbHandler,
  Map<String, dynamic> jsonObj,
  AppUsage appUsage,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppUsageID')) {
      appUsage.appUsageID = jsonObj['AppUsageID'].toString();
    }
    if (jsonObj.containsKey('AppUsageCode')) {
      appUsage.appUsageCode = jsonObj['AppUsageCode'].toString();
    }
    if (jsonObj.containsKey('AppUsageName')) {
      appUsage.appUsageName = jsonObj['AppUsageName'].toString();
    }
    if (jsonObj.containsKey('UsageCount')) {
      appUsage.usageCount = jsonObj['UsageCount'].toString();
    }
    if (jsonObj.containsKey('OperatingSystem')) {
      appUsage.operatingSystem = jsonObj['OperatingSystem'].toString();
    }
    if (jsonObj.containsKey('OperatingSystemVersion')) {
      appUsage.operatingSystemVersion = jsonObj['OperatingSystemVersion'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appUsage.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appUsage.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appUsage.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appUsage.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      appUsage.deviceIdentifier = jsonObj['DeviceIdentifier'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      appUsage.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      appUsage.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appUsage.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appUsage.isDeleted = jsonObj['IsDeleted'].toString();
    }
    appUsage.isDirty = 'false';
    appUsage.isDeleted1 = 'false';
    appUsage.upSyncMessage = '';
    appUsage.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appUsage.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appUsage.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appUsage.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appUsage.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    appUsage.upSyncIndex = '0';
    appUsage.ownerUserID = Globals.AppUserID.toString();
  } catch (e) {
    Globals.handleException(
      
      'JSONDataCopier:CopyJsonDataToAppUsage()',
      e,
    );
  }
  return appUsage;
}
AppUser copyJsonDataToAppUser(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    AppUser appUser,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey('AppUserID')) {
      appUser.appUserID = jsonObj['AppUserID'];
    }
    if (jsonObj.containsKey('AppUserCode')) {
      appUser.appUserCode = jsonObj['AppUserCode'];
    }
    if (jsonObj.containsKey('AppUserName')) {
      appUser.appUserName = jsonObj['AppUserName'];
    }

    if (jsonObj.containsKey('AppUserTypeID')) {
      String appUserTypeId = jsonObj['AppUserTypeID'];
      appUserTypeId = appUserTypeId != null && appUserTypeId != ''
          ? appUserTypeId
          : '-1';
      AppUserType ?appUserType =await  AppUserTypeDataHandlerBase.getMasterAppUserTypeRecord(
        dbHandler,
        appUserTypeId,
      );
      if (appUserType != null) {
        appUser.appUserTypeID = appUserType.id;
      }
    }

    if (jsonObj.containsKey('Designation')) {
      appUser.designation = jsonObj['Designation'];
    }
    if (jsonObj.containsKey('MobileNumber')) {
      appUser.mobileNumber = jsonObj['MobileNumber'];
    }
    if (jsonObj.containsKey('Email')) appUser.email = jsonObj['Email'];
    if (jsonObj.containsKey('OfficialAddress')) {
      appUser.officialAddress = jsonObj['OfficialAddress'];
    }
    if (jsonObj.containsKey('EmployeeId')) {
      appUser.employeeId = jsonObj['EmployeeId'];
    }
    if (jsonObj.containsKey('LoginName')) {
      appUser.loginName = jsonObj['LoginName'];
    }
    if (jsonObj.containsKey('PassCode')) {
      appUser.passCode = jsonObj['PassCode'];
    }
    if (jsonObj.containsKey('ReportingToAppUserID1')) {
      appUser.reportingToAppUserID1 = jsonObj['ReportingToAppUserID1'];
    }
    if (jsonObj.containsKey('ReportingTo1Email')) {
      appUser.reportingTo1Email = jsonObj['ReportingTo1Email'];
    }
    if (jsonObj.containsKey('ReportingTo1Phone')) {
      appUser.reportingTo1Phone = jsonObj['ReportingTo1Phone'];
    }
    if (jsonObj.containsKey('ReportingTo1Designation')) {
      appUser.reportingTo1Designation = jsonObj['ReportingTo1Designation'];
    }
    if (jsonObj.containsKey('ReportingToAppUserID2')) {
      appUser.reportingToAppUserID2 = jsonObj['ReportingToAppUserID2'];
    }
    if (jsonObj.containsKey('ReportingTo2Email')) {
      appUser.reportingTo2Email = jsonObj['ReportingTo2Email'];
    }
    if (jsonObj.containsKey('ReportingTo2Phone')) {
      appUser.reportingTo2Phone = jsonObj['ReportingTo2Phone'];
    }
    if (jsonObj.containsKey('ReportingTo2Designation')) {
      appUser.reportingTo2Designation = jsonObj['ReportingTo2Designation'];
    }
    if (jsonObj.containsKey('ReportingToAppUserID3')) {
      appUser.reportingToAppUserID3 = jsonObj['ReportingToAppUserID3'];
    }
    if (jsonObj.containsKey('ReportingTo3Email')) {
      appUser.reportingTo3Email = jsonObj['ReportingTo3Email'];
    }
    if (jsonObj.containsKey('ReportingTo3Phone')) {
      appUser.reportingTo3Phone = jsonObj['ReportingTo3Phone'];
    }
    if (jsonObj.containsKey('ReportingTo3Designation')) {
      appUser.reportingTo3Designation = jsonObj['ReportingTo3Designation'];
    }
    if (jsonObj.containsKey('ProfilePicture')) {
      appUser.profilePicture = jsonObj['ProfilePicture'];
    }
    if (jsonObj.containsKey('ProfileCaption')) {
      appUser.profileCaption = jsonObj['ProfileCaption'];
    }
    if (jsonObj.containsKey('ProfileLocation')) {
      appUser.profileLocation = jsonObj['ProfileLocation'];
    }
    if (jsonObj.containsKey('CompanyLogo')) {
      appUser.companyLogo = jsonObj['CompanyLogo'];
    }
    if (jsonObj.containsKey('CompanyCaption')) {
      appUser.companyCaption = jsonObj['CompanyCaption'];
    }
    if (jsonObj.containsKey('UseCompanyLogo')) {
      appUser.useCompanyLogo = jsonObj['UseCompanyLogo'];
    }
    if (jsonObj.containsKey('TimeZoneCode')) {
      appUser.timeZoneCode = jsonObj['TimeZoneCode'];
    }
    if (jsonObj.containsKey('CurrecyCode')) {
      appUser.currecyCode = jsonObj['CurrecyCode'];
    }
    if (jsonObj.containsKey('CurrentLoginOn')) {
      appUser.currentLoginOn = jsonObj['CurrentLoginOn'];
    }
    if (jsonObj.containsKey('LastLoginOn')) {
      appUser.lastLoginOn = jsonObj['LastLoginOn'];
    }
    if (jsonObj.containsKey('AppLastLoginOn')) {
      appUser.appLastLoginOn = jsonObj['AppLastLoginOn'];
    }
    if (jsonObj.containsKey('PassCodeLastChangedOn')) {
      appUser.passCodeLastChangedOn = jsonObj['PassCodeLastChangedOn'];
    }
    if (jsonObj.containsKey('IsMailSent')) {
      appUser.isMailSent = jsonObj['IsMailSent'];
    }
    if (jsonObj.containsKey('AccountSort')) {
      appUser.accountSort = jsonObj['AccountSort'];
    }
    if (jsonObj.containsKey('ContactSort')) {
      appUser.contactSort = jsonObj['ContactSort'];
    }
    if (jsonObj.containsKey('ActivityPlannedSort')) {
      appUser.activityPlannedSort = jsonObj['ActivityPlannedSort'];
    }
    if (jsonObj.containsKey('ActivityInProcessSort')) {
      appUser.activityInProcessSort = jsonObj['ActivityInProcessSort'];
    }
    if (jsonObj.containsKey('ActivityCompletedSort')) {
      appUser.activityCompletedSort = jsonObj['ActivityCompletedSort'];
    }
    if (jsonObj.containsKey('ActivityOthersSort')) {
      appUser.activityOthersSort = jsonObj['ActivityOthersSort'];
    }
    if (jsonObj.containsKey('OpportunityOnGoingSort')) {
      appUser.opportunityOnGoingSort = jsonObj['OpportunityOnGoingSort'];
    }
    if (jsonObj.containsKey('OpportunityWonSort')) {
      appUser.opportunityWonSort = jsonObj['OpportunityWonSort'];
    }
    if (jsonObj.containsKey('OpportunityClosedSort')) {
      appUser.opportunityClosedSort = jsonObj['OpportunityClosedSort'];
    }
    if (jsonObj.containsKey('OpportunityDeliveredSort')) {
      appUser.opportunityDeliveredSort = jsonObj['OpportunityDeliveredSort'];
    }
    if (jsonObj.containsKey('NoteSort')) {
      appUser.noteSort = jsonObj['NoteSort'];
    }
    if (jsonObj.containsKey('AccountAddressSort')) {
      appUser.accountAddressSort = jsonObj['AccountAddressSort'];
    }
    if (jsonObj.containsKey('AccountBuyingProcessSort')) {
      appUser.accountBuyingProcessSort = jsonObj['AccountBuyingProcessSort'];
    }
    if (jsonObj.containsKey('AccountBusinessPlanSort')) {
      appUser.accountBusinessPlanSort = jsonObj['AccountBusinessPlanSort'];
    }
    if (jsonObj.containsKey('AccountCompetitionActivitySort')) {
      appUser.accountCompetitionActivitySort =
          jsonObj['AccountCompetitionActivitySort'];
    }
    if (jsonObj.containsKey('AccountMediaSort')) {
      appUser.accountMediaSort = jsonObj['AccountMediaSort'];
    }
    if (jsonObj.containsKey('ReporteeCount')) {
      appUser.reporteeCount = jsonObj['ReporteeCount'];
    }
    if (jsonObj.containsKey('UserToken')) {
      appUser.userToken = jsonObj['UserToken'];
    }
    if (jsonObj.containsKey('IsSystemDefined')) {
      appUser.isSystemDefined = jsonObj['IsSystemDefined'];
    }
    if (jsonObj.containsKey('Configuration')) {
      appUser.configuration = jsonObj['Configuration'];
    }
    if (jsonObj.containsKey('SystemConfiguration')) {
      appUser.systemConfiguration = jsonObj['SystemConfiguration'];
    }
    if (jsonObj.containsKey('IsWor')) {
      appUser.isWor = jsonObj['IsWor'];
    }
    if (jsonObj.containsKey('IsAppAllowed')) {
      appUser.isAppAllowed = jsonObj['IsAppAllowed'];
    }
    if (jsonObj.containsKey('CreatedBy')) {
      appUser.createdBy = jsonObj['CreatedBy'];
    }
    if (jsonObj.containsKey('CreatedOn')) {
      appUser.createdOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      appUser.modifiedBy = jsonObj['ModifiedBy'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appUser.modifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      appUser.deviceIdentifier = jsonObj['DeviceIdentifier'];
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      appUser.referenceIdentifier = jsonObj['ReferenceIdentifier'];
    }
    if (jsonObj.containsKey('IsActive')) {
      appUser.isActive = jsonObj['IsActive'];
    }
    if (jsonObj.containsKey('Uid')) {
      appUser.uid = jsonObj['Uid'];
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      appUser.appUserGroupID = jsonObj['AppUserGroupID'];
    }
    if (jsonObj.containsKey('IsArchived')) {
      appUser.isArchived = jsonObj['IsArchived'];
    }
    if (jsonObj.containsKey('IsDeleted')) {
      appUser.isDeleted = jsonObj['IsDeleted'];
    }

    appUser.isDirty = 'false';
    appUser.isDeleted1 = 'false';
    appUser.upSyncMessage = '';
    appUser.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      appUser.sCreatedOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      appUser.sModifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      appUser.createdByUser = jsonObj['CreatedByUser'];
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      appUser.modifiedByUser = jsonObj['ModifiedByUser'];
    }
    appUser.upSyncIndex = '0';
    appUser.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToAppUser()', ex);
  }
  return appUser;
}

Future<AppUserLocation> copyJsonDataToAppUserLocation(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserLocation appUserLocation,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserLocationID")) {
      appUserLocation.appUserLocationID = jsonObj["AppUserLocationID"];
    }
    if (jsonObj.containsKey("AppUserLocationCode")) {
      appUserLocation.appUserLocationCode = jsonObj["AppUserLocationCode"];
    }
    if (jsonObj.containsKey("AppUserLocationTitle")) {
      appUserLocation.appUserLocationTitle = jsonObj["AppUserLocationTitle"];
    }
    if (jsonObj.containsKey("AppUserLocationDate")) {
      appUserLocation.appUserLocationDate = jsonObj["AppUserLocationDate"];
    }
    if (jsonObj.containsKey("AppUserLocationCoordinates")) {
      appUserLocation.appUserLocationCoordinates =
          jsonObj["AppUserLocationCoordinates"];
    }
    if (jsonObj.containsKey("AppUserLocationAddress")) {
      appUserLocation.appUserLocationAddress =
          jsonObj["AppUserLocationAddress"];
    }
    if (jsonObj.containsKey("CheckSum")) {
      appUserLocation.checkSum = jsonObj["CheckSum"];
    }
    if (jsonObj.containsKey("LastLocationCoordinates")) {
      appUserLocation.lastLocationCoordinates =
          jsonObj["LastLocationCoordinates"];
    }
    if (jsonObj.containsKey("LastLocationAddress")) {
      appUserLocation.lastLocationAddress = jsonObj["LastLocationAddress"];
    }
    if (jsonObj.containsKey("LastLocationTime")) {
      appUserLocation.lastLocationTime = jsonObj["LastLocationTime"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserLocation.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserLocation.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserLocation.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserLocation.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      appUserLocation.deviceIdentifier = jsonObj["DeviceIdentifier"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      appUserLocation.referenceIdentifier =
          jsonObj["ReferenceIdentifier"];
    }
    if (jsonObj.containsKey("Location")) {
      appUserLocation.location = jsonObj["Location"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserLocation.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserLocation.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserLocation.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserLocation.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserLocation.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserLocation.isDeleted = jsonObj["IsDeleted"];
    }

    appUserLocation.isDirty = "false";
    appUserLocation.isDeleted1 = "false";
    appUserLocation.upSyncMessage = "";
    appUserLocation.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserLocation.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserLocation.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserLocation.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserLocation.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserLocation.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserLocation.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserLocation.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToAppUserLocation()", ex);
  }
  return appUserLocation;
}
Future<AppUserMessage> copyJsonDataToAppUserMessage(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserMessage appUserMessage,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserMessageID")) {
      appUserMessage.appUserMessageID = jsonObj["AppUserMessageID"];
    }
    if (jsonObj.containsKey("AppUserMessageCode")) {
      appUserMessage.appUserMessageCode = jsonObj["AppUserMessageCode"];
    }
    if (jsonObj.containsKey("AppUserMessageText")) {
      appUserMessage.appUserMessageText = jsonObj["AppUserMessageText"];
    }
    if (jsonObj.containsKey("ObjectType")) {
      appUserMessage.objectType = jsonObj["ObjectType"];
    }
    if (jsonObj.containsKey("ObjectID")) {
      appUserMessage.objectID = jsonObj["ObjectID"];
    }
    if (jsonObj.containsKey("IsAttachment")) {
      appUserMessage.isAttachment = jsonObj["IsAttachment"];
    }

    if (jsonObj.containsKey("ParentAppUserMessageID")) {
      String appUserMessageId = jsonObj["ParentAppUserMessageID"];
      appUserMessageId = appUserMessageId != null && appUserMessageId != "" ? appUserMessageId : "-1";
      AppUserMessage? appUserMessage1 =await 
          await AppUserMessageDataHandleBase.getMasterAppUserMessageRecord(
              dbHandler, appUserMessageId);
      if (appUserMessage1 != null) {
        appUserMessage.parentAppUserMessageID = appUserMessage1.id;
      }
    }

    if (jsonObj.containsKey("AppUserMessageTo")) {
      appUserMessage.appUserMessageTo = jsonObj["AppUserMessageTo"];
    }
    if (jsonObj.containsKey("AppUserMessageReadBy")) {
      appUserMessage.appUserMessageReadBy = jsonObj["AppUserMessageReadBy"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserMessage.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserMessage.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserMessage.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserMessage.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserMessage.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserMessage.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserMessage.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserMessage.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserMessage.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      appUserMessage.referenceIdentifier = jsonObj["ReferenceIdentifier"];
    }

    appUserMessage.isDirty = "false";
    appUserMessage.isDeleted1 = "false";
    appUserMessage.upSyncMessage = "";
    appUserMessage.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserMessage.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserMessage.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserMessage.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserMessage.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserMessage.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID")) {
      appUserMessage.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserMessage.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserMessage()",
      ex,
    );
  }
  return appUserMessage;
}

}





