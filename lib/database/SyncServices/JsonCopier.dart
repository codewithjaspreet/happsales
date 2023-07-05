import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountAddressDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountFormDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountSegmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityApprovalDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityApprovalTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityPriorityDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityTravelDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactAlignmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactMediaDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityApprovalDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityApprovalTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityPriorityDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityStageDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CreditRatingDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CurrencyDataHandlerBase.dart';
import 'package:happsales_crm/database/models/ActivityModels/ActivityBusinessUnit.dart';
import 'package:happsales_crm/database/models/OtherModels/AppUserTertitory.dart';
import 'package:happsales_crm/database/models/OtherModels/BusinessUnit.dart';
import '../Globals.dart';
import '../Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import '../Handlers/AccountHandlers/AccountFormDataHandler.dart';
import '../Handlers/AccountHandlers/AccountSegmentDataHandler.dart';
import '../Handlers/AccountHandlers/AccountTypeHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandlerBase.dart';
import '../Handlers/DatabaseHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityProductDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityProductDetailDataHandlerBase.dart';
import '../Handlers/OtherHandlers/AppFeatureDataHandlerBase.dart';
import '../Handlers/OtherHandlers/BusinessFeatureDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ContentTypeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CurrencyDataHandler.dart';
import '../Handlers/OtherHandlers/FormDataHandlerBase.dart';
import '../Handlers/OtherHandlers/HSSupportTicketDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ProductDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ProductDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ServiceInvoiceDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TagDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TagGroupDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TerritoryDataHandler.dart';
import '../Handlers/OtherHandlers/TerritoryDataHandlerBase.dart';
import '../Handlers/OtherHandlers/UnitDataHandlerBase.dart';
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
import '../models/AccountModels/AccountPermission.dart';
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
import '../models/ContactModels.dart/ContactAlignment.dart';
import '../models/ContactModels.dart/ContactCategory.dart';
import '../models/ContactModels.dart/ContactMedia.dart';
import '../models/ContactModels.dart/ContactTitle.dart';
import '../models/OpportunityModels/Opportunity.dart';
import '../models/OpportunityModels/OpportunityApproval.dart';
import '../models/OpportunityModels/OpportunityApprovalType.dart';
import '../models/OpportunityModels/OpportunityBusinessUnit.dart';
import '../models/OpportunityModels/OpportunityContact.dart';
import '../models/OpportunityModels/OpportunityFulfillmentStatus.dart';
import '../models/OpportunityModels/OpportunityMeasure.dart';
import '../models/OpportunityModels/OpportunityMedia.dart';
import '../models/OpportunityModels/OpportunityName.dart';
import '../models/OpportunityModels/OpportunityPermission.dart';
import '../models/OpportunityModels/OpportunityPriority.dart';
import '../models/OpportunityModels/OpportunityProduct.dart';
import '../models/OpportunityModels/OpportunityProductDetail.dart';
import '../models/OpportunityModels/OpportunityProductDetailAttribute.dart';
import '../models/OpportunityModels/OpportunityStage.dart';
import '../models/OpportunityModels/OpportunityStatus.dart';
import '../models/OpportunityModels/OpportunityTeam.dart';
import '../models/OpportunityModels/OpportunityType.dart';
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
import '../models/OtherModels/AppUserProduct.dart';
import '../models/OtherModels/AppUserRemark.dart';
import '../models/OtherModels/AppUserRole.dart';
import '../models/OtherModels/AppUserTeam.dart';
import '../models/OtherModels/AppUserTeamMember.dart';
import '../models/OtherModels/AppUserType.dart';
import '../models/OtherModels/Attribute.dart';
import '../models/OtherModels/AttributeValue.dart';
import '../models/OtherModels/BusinessEmail.dart';
import '../models/OtherModels/BusinessFeature.dart';
import '../models/OtherModels/ChatMessage.dart';
import '../models/OtherModels/ChatUserAndGroup.dart';
import '../models/OtherModels/ChatUserGroupMember.dart';
import '../models/OtherModels/Competitor.dart';
import '../models/OtherModels/ContentType.dart';
import '../models/OtherModels/Country.dart';
import '../models/OtherModels/CreditRating.dart';
import '../models/OtherModels/Currency.dart';
// base entity;



import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import '../models/OtherModels/CustomerMeeting.dart';
import '../models/OtherModels/Department.dart';
import '../models/OtherModels/Designation.dart';
import '../models/OtherModels/EmailManualTemplate.dart';
import '../models/OtherModels/ExpenseType.dart';
import '../models/OtherModels/FieldAttendance.dart';
import '../models/OtherModels/FinancialInstitution.dart';
import '../models/OtherModels/FinancialYear.dart';
import '../models/OtherModels/Form.dart';
import '../models/OtherModels/FormCell.dart';
import '../models/OtherModels/FormCellElement.dart';
import '../models/OtherModels/FormCellElementBase.dart';
import '../models/OtherModels/FormSection.dart';
import '../models/OtherModels/HSSupportTicket.dart';
import '../models/OtherModels/HSSupportTicketMedia.dart';
import '../models/OtherModels/Industry..dart';
import '../models/OtherModels/LeadSource.dart';
import '../models/OtherModels/Location.dart';
import '../models/OtherModels/ModeOfTravel.dart';
import '../models/OtherModels/Note.dart';
import '../models/OtherModels/NoteMedia.dart';
import '../models/OtherModels/NotePermission.dart';
import '../models/OtherModels/Notification.dart';
import '../models/OtherModels/NotificationAssignment.dart';
import '../models/OtherModels/PerformanceSummary.dart';
import '../models/OtherModels/PhoneType.dart';
import '../models/OtherModels/Product.dart';
import '../models/OtherModels/ProductAuxiliary.dart';
import '../models/OtherModels/ProductCategory.dart';
import '../models/OtherModels/ProductInstallation.dart';
import '../models/OtherModels/ProductInstallationDetail.dart';
import '../models/OtherModels/ProductMedia.dart';
import '../models/OtherModels/Reimbursement.dart';
import '../models/OtherModels/ReimbursementDetail.dart';
import '../models/OtherModels/ReimbursementType.dart';
import '../models/OtherModels/Reminder.dart';
import '../models/OtherModels/Resource.dart';
import '../models/OtherModels/ServiceInvoice.dart';
import '../models/OtherModels/ServiceInvoiceDetail.dart';
import '../models/OtherModels/Tag.dart';
import '../models/OtherModels/TagGroup.dart';
import '../models/OtherModels/Territory.dart';
import '../models/OtherModels/TimeZone.dart';
import '../models/OtherModels/TravelPurpose.dart';
import '../models/OtherModels/Unit.dart';
import '../models/OtherModels/UserRole.dart';
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
        Account? account1 = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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

      account.isDirty = "false";
      account.isDeleted1 = "true";
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
        Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
            dbHandler, accountId);
        if (account != null) {
          accountAddress.accountID = account.id;
        }
      }

      if (jsonObj.containsKey("ContactID")) {
        String contactId = jsonObj["ContactID"];
        contactId =
            contactId != null && contactId.isNotEmpty ? contactId : "-1";
        Contact? contact = await ContactHandlerDataBase.GetMasterContactRecord(
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
        Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
        Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
        Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
            await BusinessUnitDataHandlerBaseBase.GetMasterBusinessUnitRecord(
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
      Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
      Account? account = await  AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
      Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord( dbHandler, accountId);
      if (account != null) {
        accountCompetitionActivity.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";

      Opportunity? opportunity = await OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
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
      Account? account = await  AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
      Activity? activity = await  ActivityDataHandlerBaseBase.GetMasterActivityRecord( dbHandler, activityId);
      if (activity != null) {
        accountForm.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";
      Opportunity? opportunity = await  OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
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
          .getMasterFormCellElementRecord(dbHandler,  formCellElementId);
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
      Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        accountMedia.accountID = account.id;
      }
    }

    if (jsonObj.containsKey('ContentTypeID')) {
      String contentTypeId = jsonObj['ContentTypeID'].toString();
      contentTypeId =
          (contentTypeId != null && contentTypeId != '') ? contentTypeId : '-1';
      ContentType contentType = await ContentTypeDataHandlerBaseBase
          .getMasterContentTypeRecord(dbHandler,  contentTypeId);
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
      Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
         'JSONDataCopier:CopyJsonDataToAccountSegment()', ex);
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
        
        territoryId,
      );
      if (territory != null) {
        accountTerritory.territoryID = territory.id;
      }
    }

    if (jsonObj.containsKey('AccountID')) {
      String accountId = jsonObj['AccountID'].toString();
      accountId = accountId.isNotEmpty ? accountId : '-1';
      Account account = AccountDataHandlerBase.getMasterAccountRecord(
        dbHandler,
        
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
         'JSONDataCopier:CopyJsonDataToAccountTerritory()', ex);
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


static Future<Activity> copyJsonDataToActivity( DatabaseHandler dbHandler, dynamic jsonObj, Activity activity, bool isForNew) async{
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
      ActivityType? activityType = await ActivityTypeDataHandlerBase.GetMasterActivityTypeRecord(dbHandler,  activityTypeId);
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
      Account? account =await  AccountDataHandlerBaseBase.GetMasterAccountRecord(dbHandler, accountId);
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
  Opportunity? opportunity = await OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
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
  Activity? activity1 = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(dbHandler, activityId);
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
  ProductInstallationDetail productInstallationDetail = ProductInstallationDetailDataHandler.GetMasterProductInstallationDetailRecord(dbHandler,  productInstallationDetailId);
  if (productInstallationDetail != null) {
    activity.productInstallationDetailID = productInstallationDetail.id;
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
      Activity ?activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
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
      ActivityApproval? activityApproval1 =
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
         'JSONDataCopier:CopyJsonDataToActivityApprovalType()', e);
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
      Activity? activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
          dbHandler, activityId);
      if (activity != null) {
        activityBusinessUnit.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey('BusinessUnitID')) {
      String businessUnitId = jsonObj['BusinessUnitID'].toString();
      businessUnitId = businessUnitId.isNotEmpty ? businessUnitId : '-1';
      BusinessUnit? businessUnit = await BusinessUnitDataHandlerBaseBase
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
      Activity? activity =  await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
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
      ContentType contentType = ContentTypeDataHandlerBaseBaseBase.GetMasterContentTypeRecord(
        dbHandler,
        
        contentTypeId,
      );
      if (contentType != null) {
        activityMedia.contentTypeID = contentType.id;
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
      Activity ?activity =await  ActivityDataHandlerBaseBase.GetMasterActivityRecord(
        dbHandler,
        
        activityId,
      );
      if (activity != null) {
        activityPermission.activityID = activity.id;
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
      Activity? activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
        dbHandler,
        activityId,
      );
      if (activity != null) {
        activityProduct.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey('ProductID')) {
      String productId = jsonObj['ProductID'].toString();
      productId = productId.isNotEmpty ? productId : '-1';
      Product product = await ProductDataHandlerBase.GetMasterProductRecord(
        dbHandler,
        
        productId,
      );
      if (product != null) {
        activityProduct.productID = product.id;
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
        activityProductDetail.activityProductID = activityProduct.id;
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
          await AccountDataHandlerBaseBase.GetMasterAccountRecord(
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
      Activity? activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
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
      Activity ?activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(
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
        activityTravel.modeOfTravelID = modeOfTravel.id;
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
        activityTravelExpense.activityTravelID = activityTravel.id;
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
        activityTravelExpense.expenseTypeID = expenseType.id;
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
        activityTravelExpense.modeOfTravelID = modeOfTravel.id;
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
        activityTravelMapping.activityTravelID = activityTravel.id;
      }
    }
    if (jsonObj.containsKey('ActivityID')) {
      String activityId =
          jsonObj['ActivityID'].toString();
      activityId =
          activityId.isNotEmpty ? activityId : '-1';
      Activity activity =
          ActivityDataHandlerBase.GetMasterActivityRecord(
        dbHandler,
        
        activityId,
      );
      if (activity != null) {
        activityTravelMapping.activityID = activity.id;
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
          ContentTypeDataHandlerBaseBaseBase.GetMasterContentTypeRecord(
        dbHandler,
        
        contentTypeId,
      );
      if (contentType != null) {
        activityTravelMedia.contentTypeID = contentType.id;
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
        activityType.businessFeatureID = businessFeature.id;
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

Future<AppUserProduct> copyJsonDataToAppUserProduct(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserProduct appUserProduct,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserProductID")) {
      appUserProduct.appUserProductID = jsonObj["AppUserProductID"];
    }
    if (jsonObj.containsKey("AppUserProductCode")) {
      appUserProduct.appUserProductCode = jsonObj["AppUserProductCode"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserProduct.appUserID = jsonObj["AppUserID"];
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"];
      productId = productId != null && productId != "" ? productId : "-1";
      Product product = await ProductDataHandlerBase.getMasterProductRecord(
        dbHandler,
        productId,
      );
      if (product != null) {
        appUserProduct.productID = product.id;
      }
    }

    if (jsonObj.containsKey("CreatedBy")) {
      appUserProduct.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserProduct.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserProduct.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserProduct.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserProduct.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserProduct.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserProduct.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserProduct.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserProduct.isDeleted = jsonObj["IsDeleted"];
    }

    appUserProduct.isDirty = "false";
    appUserProduct.isDeleted1 = "false";
    appUserProduct.upSyncMessage = "";
    appUserProduct.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserProduct.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserProduct.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserProduct.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserProduct.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserProduct.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID")) {
      appUserProduct.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserProduct.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserProduct()",
      ex,
    );
  }
  return appUserProduct;
}

Future<AppUserRemark> copyJsonDataToAppUserRemark(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserRemark appUserRemark,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserRemarkID")) {
      appUserRemark.appUserRemarkID = jsonObj["AppUserRemarkID"];
    }
    if (jsonObj.containsKey("AppUserRemarkCode")) {
      appUserRemark.appUserRemarkCode = jsonObj["AppUserRemarkCode"];
    }
    if (jsonObj.containsKey("AppUserRemarkDetails")) {
      appUserRemark.appUserRemarkDetails = jsonObj["AppUserRemarkDetails"];
    }
    if (jsonObj.containsKey("AppUserRemarkObject")) {
      appUserRemark.appUserRemarkObject = jsonObj["AppUserRemarkObject"];
    }
    if (jsonObj.containsKey("AppUserRemarkObjectID")) {
      appUserRemark.appUserRemarkObjectID = jsonObj["AppUserRemarkObjectID"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserRemark.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserRemark.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserRemark.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserRemark.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      appUserRemark.deviceIdentifier = jsonObj["DeviceIdentifier"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      appUserRemark.referenceIdentifier = jsonObj["ReferenceIdentifier"];
    }
    if (jsonObj.containsKey("Location")) {
      appUserRemark.location = jsonObj["Location"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserRemark.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserRemark.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserRemark.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserRemark.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserRemark.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserRemark.isDeleted = jsonObj["IsDeleted"];
    }

    appUserRemark.isDirty = "false";
    appUserRemark.isDeleted1 = "false";
    appUserRemark.upSyncMessage = "";
    appUserRemark.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserRemark.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserRemark.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserRemark.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserRemark.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserRemark.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserRemark.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserRemark.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserRemark()",
      ex,
    );
  }
  return appUserRemark;
}
Future<AppUserRole> copyJsonDataToAppUserRole(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserRole appUserRole,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserRoleID")) {
      appUserRole.appUserRoleID = jsonObj["AppUserRoleID"];
    }
    if (jsonObj.containsKey("AppUserRoleCode")) {
      appUserRole.appUserRoleCode = jsonObj["AppUserRoleCode"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserRole.appUserID = jsonObj["AppUserID"];
    }

    if (jsonObj.containsKey("UserRoleID")) {
      String userRoleId = jsonObj["UserRoleID"];
      userRoleId = userRoleId != null && userRoleId.isNotEmpty ? userRoleId : "-1";
      UserRole userRole = await UserRoleDataHandlerBase.getMasterUserRoleRecord(
        dbHandler,
    
        userRoleId,
      );
      if (userRole != null) {
        appUserRole.userRoleID = userRole.id;
      }
    }

    if (jsonObj.containsKey("CreatedBy")) {
      appUserRole.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserRole.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserRole.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserRole.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserRole.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserRole.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserRole.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserRole.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserRole.isDeleted = jsonObj["IsDeleted"];
    }

    appUserRole.isDirty = "false";
    appUserRole.isDeleted1 = "false";
    appUserRole.upSyncMessage = "";
    appUserRole.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserRole.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserRole.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserRole.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserRole.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserRole.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserRole.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserRole.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserRole()",
      ex,
    );
  }
  return appUserRole;
}

Future<AppUserTeam> copyJsonDataToAppUserTeam(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserTeam appUserTeam,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserTeamID")) {
      appUserTeam.appUserTeamID = jsonObj["AppUserTeamID"];
    }
    if (jsonObj.containsKey("AppUserTeamCode")) {
      appUserTeam.appUserTeamCode = jsonObj["AppUserTeamCode"];
    }
    if (jsonObj.containsKey("AppUserTeamName")) {
      appUserTeam.appUserTeamName = jsonObj["AppUserTeamName"];
    }
    if (jsonObj.containsKey("AppUserTeamDescription")) {
      appUserTeam.appUserTeamDescription = jsonObj["AppUserTeamDescription"];
    }
    if (jsonObj.containsKey("TeamLeadAppUserID")) {
      appUserTeam.teamLeadAppUserID = jsonObj["TeamLeadAppUserID"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserTeam.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTeam.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserTeam.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTeam.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserTeam.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserTeam.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserTeam.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserTeam.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserTeam.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserTeam.isDeleted = jsonObj["IsDeleted"];
    }

    appUserTeam.isDirty = "false";
    appUserTeam.isDeleted1 = "false";
    appUserTeam.upSyncMessage = "";
    appUserTeam.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTeam.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTeam.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserTeam.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserTeam.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserTeam.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserTeam.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserTeam.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserTeam()",
      ex,
    );
  }
  return appUserTeam;
}

Future<AppUserTeamMember> copyJsonDataToAppUserTeamMember(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserTeamMember appUserTeamMember,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserTeamMemberID")) {
      appUserTeamMember.appUserTeamMemberID = jsonObj["AppUserTeamMemberID"];
    }
    if (jsonObj.containsKey("AppUserTeamMemberCode")) {
      appUserTeamMember.appUserTeamMemberCode = jsonObj["AppUserTeamMemberCode"];
    }
    if (jsonObj.containsKey("AppUserTeamID")) {
      String appUserTeamId = jsonObj["AppUserTeamID"];
      appUserTeamId = appUserTeamId != null && appUserTeamId != "" ? appUserTeamId : "-1";
      AppUserTeam appUserTeam = await AppUserTeamDataHandlerBase.getMasterAppUserTeamRecord(dbHandler, appUserTeamId);
      if (appUserTeam != null) {
        appUserTeamMember.appUserTeamID = appUserTeam.id;
      }
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserTeamMember.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserTeamMember.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTeamMember.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserTeamMember.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTeamMember.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserTeamMember.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserTeamMember.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserTeamMember.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserTeamMember.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserTeamMember.isDeleted = jsonObj["IsDeleted"];
    }

    appUserTeamMember.isDirty = "false";
    appUserTeamMember.isDeleted1 = "false";
    appUserTeamMember.upSyncMessage = "";
    appUserTeamMember.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTeamMember.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTeamMember.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserTeamMember.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserTeamMember.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserTeamMember.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserTeamMember.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserTeamMember.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserTeamMember()",
      ex,
    );
  }
  return appUserTeamMember;
}
Future<AppUserTertitory> copyJsonDataToAppUserTerritory(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    AppUserTertitory appUserTerritory,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("AppUserTerritoryID")) {
      appUserTerritory.appUserTerritoryID = jsonObj["AppUserTerritoryID"];
    }
    if (jsonObj.containsKey("AppUserTerritoryCode")) {
      appUserTerritory.appUserTerritoryCode = jsonObj["AppUserTerritoryCode"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserTerritory.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("TerritoryID")) {
      String territoryId = jsonObj["TerritoryID"];
      territoryId = territoryId != null && territoryId != "" ? territoryId : "-1";
      Territory territory = await TerritoryDataHandlerBase.getMasterTerritoryRecord(dbHandler, territoryId);
      if (territory != null) {
        appUserTerritory.territoryID = territory.id;
      }
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserTerritory.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTerritory.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserTerritory.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTerritory.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserTerritory.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserTerritory.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserTerritory.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      appUserTerritory.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserTerritory.isDeleted = jsonObj["IsDeleted"];
    }

    appUserTerritory.isDirty = "false";
    appUserTerritory.isDeleted1 = "false";
    appUserTerritory.upSyncMessage = "";
    appUserTerritory.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserTerritory.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserTerritory.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserTerritory.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserTerritory.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserTerritory.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserTerritory.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserTerritory.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserTerritory()",
      ex,
    );
  }
  return appUserTerritory;
}

AppUserType copyJsonDataToAppUserType(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  AppUserType appUserType,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("AppUserTypeID")) {
      appUserType.appUserTypeID = jsonObj["AppUserTypeID"];
    }
    if (jsonObj.containsKey("AppUserTypeCode")) {
      appUserType.appUserTypeCode = jsonObj["AppUserTypeCode"];
    }
    if (jsonObj.containsKey("AppUserTypeName")) {
      appUserType.appUserTypeName = jsonObj["AppUserTypeName"];
    }
    if (jsonObj.containsKey("IsExternalUser")) {
      appUserType.isExternalUser = jsonObj["IsExternalUser"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      appUserType.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      appUserType.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      appUserType.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserType.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      appUserType.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      appUserType.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      appUserType.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      appUserType.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      appUserType.isDeleted = jsonObj["IsDeleted"];
    }

    appUserType.isDirty = "false";
    appUserType.isDeleted1 = "false";
    appUserType.upSyncMessage = "";
    appUserType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      appUserType.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      appUserType.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      appUserType.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      appUserType.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    appUserType.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      appUserType.ownerUserID = jsonObj["AppUserID"];
    }*/
    appUserType.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToAppUserType()",
      ex,
    );
  }
  return appUserType;
}

Attribute copyJsonDataToAttribute(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  Attribute attribute,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("AttributeID")) {
      attribute.attributeID = jsonObj["AttributeID"];
    }
    if (jsonObj.containsKey("AttributeCode")) {
      attribute.attributeCode = jsonObj["AttributeCode"];
    }
    if (jsonObj.containsKey("AttributeName")) {
      attribute.attributeName = jsonObj["AttributeName"];
    }
    if (jsonObj.containsKey("Description")) {
      attribute.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("ApplyToAllProducts")) {
      attribute.applyToAllProducts = jsonObj["ApplyToAllProducts"];
    }

    if (jsonObj.containsKey("ParentAttributeID")) {
      String attributeId = jsonObj["ParentAttributeID"];
      attributeId = attributeId != null && attributeId.isNotEmpty ? attributeId : "-1";
      Attribute? attribute1 =await 
          AttributeDataHandlerBase.getMasterAttributeRecord(dbHandler, attributeId);
      if (attribute1 != null) {
        attribute.parentAttributeID = attribute1.id;
      }
    }

    if (jsonObj.containsKey("IsSelfReferencing")) {
      attribute.isSelfReferencing = jsonObj["IsSelfReferencing"];
    }
    if (jsonObj.containsKey("SequentialOrder")) {
      attribute.sequentialOrder = jsonObj["SequentialOrder"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      attribute.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      attribute.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      attribute.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      attribute.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      attribute.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      attribute.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      attribute.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      attribute.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      attribute.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      attribute.isDeleted = jsonObj["IsDeleted"];
    }

    attribute.isDirty = "false";
    attribute.isDeleted1 = "false";
    attribute.upSyncMessage = "";
    attribute.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      attribute.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      attribute.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      attribute.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      attribute.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    attribute.upSyncIndex = "0";
    attribute.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException("JSONDataCopier:CopyJsonDataToAttribute()", ex);
  }
  return attribute;
}
AttributeValue copyJsonDataToAttributeValue(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  AttributeValue attributeValue,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("AttributeValueID")) {
      attributeValue.attributeValueID = jsonObj["AttributeValueID"];
    }
    if (jsonObj.containsKey("AttributeValueCode")) {
      attributeValue.attributeValueCode = jsonObj["AttributeValueCode"];
    }
    if (jsonObj.containsKey("AttributeValueName")) {
      attributeValue.attributeValueName = jsonObj["AttributeValueName"];
    }

    if (jsonObj.containsKey("AttributeID")) {
      String attributeId = jsonObj["AttributeID"];
      attributeId = attributeId != null && attributeId.isNotEmpty ? attributeId : "-1";
      Attribute? attribute = AttributeDataHandlerBase.getMasterAttributeRecord(
        dbHandler,
        attributeId,
      );
      if (attribute != null) {
        attributeValue.attributeID = attribute.id;
      }
    }

    if (jsonObj.containsKey("Description")) {
      attributeValue.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("Multiplier")) {
      attributeValue.multiplier = jsonObj["Multiplier"];
    }

    if (jsonObj.containsKey("ParentAttributeValueID")) {
      String attributeValueId = jsonObj["ParentAttributeValueID"];
      attributeValueId = attributeValueId != null && attributeValueId.isNotEmpty ? attributeValueId : "-1";
      AttributeValue attributeValue1 = AttributeValueDataHandler.getMasterAttributeValueRecord(
        dbHandler,
        
        attributeValueId,
      );
      if (attributeValue1 != null) {
        attributeValue.parentAttributeValueID = attributeValue1.id;
      }
    }

    if (jsonObj.containsKey("CreatedOn")) {
      attributeValue.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      attributeValue.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      attributeValue.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      attributeValue.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      attributeValue.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      attributeValue.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      attributeValue.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      attributeValue.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      attributeValue.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      attributeValue.isDeleted = jsonObj["IsDeleted"];
    }

    attributeValue.isDirty = "false";
    attributeValue.isDeleted1 = "false";
    attributeValue.upSyncMessage = "";
    attributeValue.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      attributeValue.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      attributeValue.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      attributeValue.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      attributeValue.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    attributeValue.upSyncIndex = "0";
    attributeValue.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToAttributeValue()", ex);
  }
  return attributeValue;
}

BusinessEmail copyJsonDataToBusinessEmail(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  BusinessEmail businessEmail,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("BusinessEmailID")) {
      businessEmail.businessEmailID = jsonObj["BusinessEmailID"];
    }
    if (jsonObj.containsKey("BusinessEmailCode")) {
      businessEmail.businessEmailCode = jsonObj["BusinessEmailCode"];
    }
    if (jsonObj.containsKey("BusinessEmailAddress")) {
      businessEmail.businessEmailAddress = jsonObj["BusinessEmailAddress"];
    }
    if (jsonObj.containsKey("Purpose")) {
      businessEmail.purpose = jsonObj["Purpose"];
    }
    if (jsonObj.containsKey("Remarks")) {
      businessEmail.remarks = jsonObj["Remarks"];
    }
    if (jsonObj.containsKey("IsApproved")) {
      businessEmail.isApproved = jsonObj["IsApproved"];
    }
    if (jsonObj.containsKey("HSRemarks")) {
      businessEmail.hsRemarks = jsonObj["HSRemarks"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      businessEmail.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      businessEmail.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessEmail.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      businessEmail.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      businessEmail.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      businessEmail.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      businessEmail.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      businessEmail.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      businessEmail.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      businessEmail.isDeleted = jsonObj["IsDeleted"];
    }

    businessEmail.isDirty = "false";
    businessEmail.isDeleted1 = "false";
    businessEmail.upSyncMessage = "";
    businessEmail.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      businessEmail.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessEmail.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      businessEmail.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      businessEmail.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    businessEmail.upSyncIndex = "0";
    businessEmail.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToBusinessEmail()", ex);
  }
  return businessEmail;
}

BusinessFeature copyJsonDataToBusinessFeature(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  BusinessFeature businessFeature,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("BusinessFeatureID")) {
      businessFeature.businessFeatureID = jsonObj["BusinessFeatureID"];
    }
    if (jsonObj.containsKey("BusinessFeatureCode")) {
      businessFeature.businessFeatureCode = jsonObj["BusinessFeatureCode"];
    }
    if (jsonObj.containsKey("BusinessFeatureName")) {
      businessFeature.businessFeatureName = jsonObj["BusinessFeatureName"];
    }
    if (jsonObj.containsKey("AppIcon")) {
      businessFeature.appIcon = jsonObj["AppIcon"];
    }
    if (jsonObj.containsKey("ConsoleIcon")) {
      businessFeature.consoleIcon = jsonObj["ConsoleIcon"];
    }
    if (jsonObj.containsKey("DescriptionText")) {
      businessFeature.descriptionText = jsonObj["DescriptionText"];
    }
    if (jsonObj.containsKey("DescriptionHtml")) {
      businessFeature.descriptionHtml = jsonObj["DescriptionHtml"];
    }
    if (jsonObj.containsKey("InternalCode")) {
      businessFeature.internalCode = jsonObj["InternalCode"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      businessFeature.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      businessFeature.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessFeature.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      businessFeature.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      businessFeature.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      businessFeature.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      businessFeature.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      businessFeature.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      businessFeature.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      businessFeature.isDeleted = jsonObj["IsDeleted"];
    }

    businessFeature.isDirty = "false";
    businessFeature.isDeleted1 = "false";
    businessFeature.upSyncMessage = "";
    businessFeature.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      businessFeature.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessFeature.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      businessFeature.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      businessFeature.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    businessFeature.upSyncIndex = "0";
    businessFeature.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToBusinessFeature()", ex);
  }
  return businessFeature;
}

BusinessUnit copyJsonDataToBusinessUnit(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  BusinessUnit businessUnit,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("BusinessUnitID")) {
      businessUnit.businessUnitID = jsonObj["BusinessUnitID"];
    }
    if (jsonObj.containsKey("BusinessUnitCode")) {
      businessUnit.businessUnitCode = jsonObj["BusinessUnitCode"];
    }
    if (jsonObj.containsKey("BusinessUnitName")) {
      businessUnit.businessUnitName = jsonObj["BusinessUnitName"];
    }
    if (jsonObj.containsKey("Description")) {
      businessUnit.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("HeadOfBusinessUnitAppUserID")) {
      businessUnit.headOfBusinessUnitAppUserID = jsonObj["HeadOfBusinessUnitAppUserID"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      businessUnit.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      businessUnit.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessUnit.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      businessUnit.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      businessUnit.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      businessUnit.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("Uid")) {
      businessUnit.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      businessUnit.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      businessUnit.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      businessUnit.referenceIdentifier = jsonObj["ReferenceIdentifier"];
    }

    businessUnit.isDirty = "false";
    businessUnit.isDeleted1 = "false";
    businessUnit.upSyncMessage = "";
    businessUnit.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      businessUnit.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      businessUnit.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      businessUnit.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      businessUnit.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    businessUnit.upSyncIndex = "0";
    businessUnit.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToBusinessUnit()", ex);
  }
  return businessUnit;
}



ChatMessage copyJsonDataToChatMessage(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  ChatMessage chatMessage,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("ChatMessageID")) {
      chatMessage.chatMessageID = jsonObj["ChatMessageID"];
    }
    if (jsonObj.containsKey("ChatMessageCode")) {
      chatMessage.chatMessageCode = jsonObj["ChatMessageCode"];
    }
    if (jsonObj.containsKey("ChatMessageContent")) {
      chatMessage.chatMessageContent = jsonObj["ChatMessageContent"];
    }
    if (jsonObj.containsKey("ContentType")) {
      chatMessage.contentType = jsonObj["ContentType"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupID")) {
      chatMessage.chatUserAndGroupID = jsonObj["ChatUserAndGroupID"];
    }
    if (jsonObj.containsKey("ToChatUserAndGroupID")) {
      chatMessage.toChatUserAndGroupID = jsonObj["ToChatUserAndGroupID"];
    }
    if (jsonObj.containsKey("LocalMediaPath")) {
      chatMessage.localMediaPath = jsonObj["LocalMediaPath"];
    }
    if (jsonObj.containsKey("IsUploaded")) {
      chatMessage.isUploaded = jsonObj["IsUploaded"];
    }
    if (jsonObj.containsKey("MediaPath")) {
      chatMessage.mediaPath = jsonObj["MediaPath"];
    }
    if (jsonObj.containsKey("IsRead")) {
      chatMessage.isRead = jsonObj["IsRead"];
    }
    if (jsonObj.containsKey("ReadStatus")) {
      chatMessage.readStatus = jsonObj["ReadStatus"];
    }
    if (jsonObj.containsKey("ObjectName")) {
      chatMessage.objectName = jsonObj["ObjectName"];
    }
    if (jsonObj.containsKey("ObjectID")) {
      chatMessage.objectID = jsonObj["ObjectID"];
    }
    if (jsonObj.containsKey("ObjectCode")) {
      chatMessage.objectCode = jsonObj["ObjectCode"];
    }
    if (jsonObj.containsKey("ObjectAction")) {
      chatMessage.objectAction = jsonObj["ObjectAction"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      chatMessage.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      chatMessage.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatMessage.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      chatMessage.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      chatMessage.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      chatMessage.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      chatMessage.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      chatMessage.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      chatMessage.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      chatMessage.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("AppUserName")) {
      chatMessage.appUserName = jsonObj["AppUserName"];
    }
    if (jsonObj.containsKey("ToAppUserID")) {
      chatMessage.toAppUserID = jsonObj["ToAppUserID"];
    }
    if (jsonObj.containsKey("ToChatUserAndGroupUid")) {
      chatMessage.toChatUserAndGroupUid = jsonObj["ToChatUserAndGroupUid"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupName")) {
      chatMessage.chatUserAndGroupName = jsonObj["ChatUserAndGroupName"];
    }
    if (jsonObj.containsKey("ToChatUserAndGroupName")) {
      chatMessage.toChatUserAndGroupName = jsonObj["ToChatUserAndGroupName"];
    }

    chatMessage.isDirty = "false";
    chatMessage.isDeleted1 = "false";
    chatMessage.upSyncMessage = "";
    chatMessage.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      chatMessage.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatMessage.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      chatMessage.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      chatMessage.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    chatMessage.upSyncIndex = "0";
    chatMessage.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToChatMessage()", ex);
  }
  return chatMessage;
}



ChatUserAndGroup copyJsonDataToChatUserAndGroup(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  ChatUserAndGroup chatUserAndGroup,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("ChatUserAndGroupID")) {
      chatUserAndGroup.chatUserAndGroupID = jsonObj["ChatUserAndGroupID"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupCode")) {
      chatUserAndGroup.chatUserAndGroupCode = jsonObj["ChatUserAndGroupCode"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupName")) {
      chatUserAndGroup.chatUserAndGroupName = jsonObj["ChatUserAndGroupName"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupLogo")) {
      chatUserAndGroup.chatUserAndGroupLogo = jsonObj["ChatUserAndGroupLogo"];
    }
    if (jsonObj.containsKey("ChatUserAndGroupDescription")) {
      chatUserAndGroup.chatUserAndGroupDescription =
          jsonObj["ChatUserAndGroupDescription"];
    }
    if (jsonObj.containsKey("PhoneNumber")) {
      chatUserAndGroup.phoneNumber = jsonObj["PhoneNumber"];
    }
    if (jsonObj.containsKey("Email")) {
      chatUserAndGroup.email = jsonObj["Email"];
    }
    if (jsonObj.containsKey("TargetAppUserID")) {
      chatUserAndGroup.targetAppUserID = jsonObj["TargetAppUserID"];
    }
    if (jsonObj.containsKey("IsGroup")) {
      chatUserAndGroup.isGroup = jsonObj["IsGroup"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      chatUserAndGroup.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      chatUserAndGroup.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      chatUserAndGroup.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatUserAndGroup.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      chatUserAndGroup.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      chatUserAndGroup.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      chatUserAndGroup.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      chatUserAndGroup.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      chatUserAndGroup.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      chatUserAndGroup.isArchived = jsonObj["IsArchived"];
    }

    chatUserAndGroup.isDirty = "false";
    chatUserAndGroup.isDeleted1 = "false";
    chatUserAndGroup.upSyncMessage = "";
    chatUserAndGroup.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      chatUserAndGroup.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatUserAndGroup.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      chatUserAndGroup.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      chatUserAndGroup.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    chatUserAndGroup.upSyncIndex = "0";
    chatUserAndGroup.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToChatUserAndGroup()", ex);
  }
  return chatUserAndGroup;
}

ChatUserGroupMember copyJsonDataToChatUserGroupMember(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  ChatUserGroupMember chatUserGroupMember,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("ChatUserGroupMemberID")) {
      chatUserGroupMember.chatUserGroupMemberID =
          jsonObj["ChatUserGroupMemberID"];
    }
    if (jsonObj.containsKey("ChatUserGroupMemberCode")) {
      chatUserGroupMember.chatUserGroupMemberCode =
          jsonObj["ChatUserGroupMemberCode"];
    }

    if (jsonObj.containsKey("ChatUserAndGroupID")) {
      String chatUserAndGroupId = jsonObj["ChatUserAndGroupID"];
      chatUserAndGroupId = chatUserAndGroupId != null && chatUserAndGroupId.isNotEmpty
          ? chatUserAndGroupId
          : "-1";
      ChatUserAndGroup chatUserAndGroup =
          ChatUserAndGroupDataHandlerBase.getMasterChatUserAndGroupRecord(
              dbHandler, chatUserAndGroupId);
      if (chatUserAndGroup != null) {
        chatUserGroupMember.chatUserAndGroupID = chatUserAndGroup.id;
      }
    }

    if (jsonObj.containsKey("TargetAppUserID")) {
      chatUserGroupMember.targetAppUserID = jsonObj["TargetAppUserID"];
    }
    if (jsonObj.containsKey("MemberName")) {
      chatUserGroupMember.memberName = jsonObj["MemberName"];
    }
    if (jsonObj.containsKey("MemberDescription")) {
      chatUserGroupMember.memberDescription =
          jsonObj["MemberDescription"];
    }
    if (jsonObj.containsKey("PhoneNumber")) {
      chatUserGroupMember.phoneNumber = jsonObj["PhoneNumber"];
    }
    if (jsonObj.containsKey("Email")) {
      chatUserGroupMember.email = jsonObj["Email"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      chatUserGroupMember.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      chatUserGroupMember.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      chatUserGroupMember.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatUserGroupMember.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("Uid")) {
      chatUserGroupMember.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      chatUserGroupMember.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      chatUserGroupMember.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      chatUserGroupMember.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsActive")) {
      chatUserGroupMember.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      chatUserGroupMember.isDeleted = jsonObj["IsDeleted"];
    }

    chatUserGroupMember.isDirty = "false";
    chatUserGroupMember.isDeleted1 = "false";
    chatUserGroupMember.upSyncMessage = "";
    chatUserGroupMember.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      chatUserGroupMember.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      chatUserGroupMember.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      chatUserGroupMember.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      chatUserGroupMember.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    chatUserGroupMember.upSyncIndex = "0";
    chatUserGroupMember.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToChatUserGroupMember()", ex);
  }
  return chatUserGroupMember;
}


Competitor copyJsonDataToCompetitor(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  Competitor competitor,
  bool isForNew,
) {
  try {
    if (jsonObj.containsKey("CompetitorID")) {
      competitor.competitorID = jsonObj["CompetitorID"];
    }
    if (jsonObj.containsKey("CompetitorCode")) {
      competitor.competitorCode = jsonObj["CompetitorCode"];
    }
    if (jsonObj.containsKey("CompetitorName")) {
      competitor.competitorName = jsonObj["CompetitorName"];
    }
    if (jsonObj.containsKey("Description")) {
      competitor.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      competitor.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      competitor.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      competitor.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      competitor.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      competitor.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      competitor.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      competitor.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      competitor.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      competitor.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      competitor.isDeleted = jsonObj["IsDeleted"];
    }

    competitor.isDirty = "false";
    competitor.isDeleted1 = "false";
    competitor.upSyncMessage = "";
    competitor.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      competitor.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      competitor.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      competitor.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      competitor.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    competitor.upSyncIndex = "0";
    competitor.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToCompetitor()", ex);
  }
  return competitor;
}


Future<Contact> copyJsonDataToContact(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  Contact contact,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("ContactID")) {
      contact.contactID = jsonObj["ContactID"];
    }
    if (jsonObj.containsKey("ContactCode")) {
      contact.contactCode = jsonObj["ContactCode"];
    }
    if (jsonObj.containsKey("Title")) {
      contact.title = jsonObj["Title"];
    }
    if (jsonObj.containsKey("FirstName")) {
      contact.firstName = jsonObj["FirstName"];
    }
    if (jsonObj.containsKey("MiddleName")) {
      contact.middleName = jsonObj["MiddleName"];
    }
    if (jsonObj.containsKey("LastName")) {
      contact.lastName = jsonObj["LastName"];
    }
    if (jsonObj.containsKey("ContactName")) {
      contact.contactName = jsonObj["ContactName"];
    }
    if (jsonObj.containsKey("ContactIdentifier")) {
      contact.contactIdentifier = jsonObj["ContactIdentifier"];
    }
    if (jsonObj.containsKey("AccountName")) {
      contact.accountName = jsonObj["AccountName"];
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"];
      accountId = accountId != null && accountId != "" ? accountId : "-1";
      Account? account =await 
          AccountDataHandlerBaseBase.GetMasterAccountRecord(dbHandler, accountId);
      if (account != null) {
        contact.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactCategoryID")) {
      String contactCategoryId = jsonObj["ContactCategoryID"];
      contactCategoryId =
          contactCategoryId != null && contactCategoryId != "" ? contactCategoryId : "-1";
      ContactCategory ?contactCategory =await 
          ContactCategoryDataHandlerBase.GetMasterContactCategoryRecord(dbHandler, contactCategoryId);
      if (contactCategory != null) {
        contact.contactCategoryID = contactCategory.id;
      }
    }

    if (jsonObj.containsKey("DepartmentName")) {
      contact.departmentName = jsonObj["DepartmentName"];
    }
    if (jsonObj.containsKey("Designation")) {
      contact.designation = jsonObj["Designation"];
    }
    if (jsonObj.containsKey("RolesAndResponsibilities")) {
      contact.rolesAndResponsibilities = jsonObj["RolesAndResponsibilities"];
    }
    if (jsonObj.containsKey("ReportingManager")) {
      contact.reportingManager = jsonObj["ReportingManager"];
    }

    if (jsonObj.containsKey("ReportingContactID")) {
      String contactId = jsonObj["ReportingContactID"];
      contactId = contactId != null && contactId != "" ? contactId : "-1";
      Contact? contact1 =await 
          ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
      if (contact1 != null) {
        contact.reportingContactID = contact1.id;
      }
    }

    if (jsonObj.containsKey("MobileNumber")) {
      contact.mobileNumber = jsonObj["MobileNumber"];
    }
    if (jsonObj.containsKey("AlternateMobileNumber")) {
      contact.alternateMobileNumber = jsonObj["AlternateMobileNumber"];
    }
    if (jsonObj.containsKey("WorkPhone")) {
      contact.workPhone = jsonObj["WorkPhone"];
    }
    if (jsonObj.containsKey("ResidencePhone")) {
      contact.residencePhone = jsonObj["ResidencePhone"];
    }
    if (jsonObj.containsKey("Email")) {
      contact.email = jsonObj["Email"];
    }
    if (jsonObj.containsKey("AlternateEmail")) {
      contact.alternateEmail = jsonObj["AlternateEmail"];
    }
    if (jsonObj.containsKey("AddressLine1")) {
      contact.addressLine1 = jsonObj["AddressLine1"];
    }
    if (jsonObj.containsKey("AddressLine2")) {
      contact.addressLine2 = jsonObj["AddressLine2"];
    }
    if (jsonObj.containsKey("AddressLine3")) {
      contact.addressLine3 = jsonObj["AddressLine3"];
    }
    if (jsonObj.containsKey("City")) {
      contact.city = jsonObj["City"];
    }
    if (jsonObj.containsKey("State")) {
      contact.state = jsonObj["State"];
    }
    if (jsonObj.containsKey("Country")) {
      contact.country = jsonObj["Country"];
    }
    if (jsonObj.containsKey("PIN")) {
      contact.pin = jsonObj["PIN"];
    }
    if (jsonObj.containsKey("GPSCoordinates")) {
      contact.gpsCoordinates = jsonObj["GPSCoordinates"];
    }
    if (jsonObj.containsKey("LinkedIn")) {
      contact.linkedIn = jsonObj["LinkedIn"];
    }
    if (jsonObj.containsKey("PastAccounts")) {
      contact.pastAccounts = jsonObj["PastAccounts"];
    }
    if (jsonObj.containsKey("PastDesignations")) {
      contact.pastDesignations = jsonObj["PastDesignations"];
    }
    if (jsonObj.containsKey("DateOfBirth")) {
      contact.dateOfBirth = jsonObj["DateOfBirth"];
    }
    if (jsonObj.containsKey("RemindBirthday")) {
      contact.remindBirthday = jsonObj["RemindBirthday"];
    }

    if (jsonObj.containsKey("ContactAlignmentID")) {
      String contactAlignmentId = jsonObj["ContactAlignmentID"];
      contactAlignmentId =
          contactAlignmentId != null && contactAlignmentId != "" ? contactAlignmentId : "-1";
      ContactAlignment? contactAlignment = await  ContactAlignmentDataHandlerBase.GetMasterContactAlignmentRecord(
          dbHandler, contactAlignmentId);
      if (contactAlignment != null) {
        contact.contactAlignmentID = contactAlignment.id;
      }
    }
    if (jsonObj.containsKey("ContactCodeInternal")) {
      contact.contactCodeInternal = jsonObj["ContactCodeInternal"];
    }
    if (jsonObj.containsKey("Remarks")) {
      contact.remarks = jsonObj["Remarks"];
    }
    if (jsonObj.containsKey("ReferenceHistory")) {
      contact.referenceHistory = jsonObj["ReferenceHistory"];
    }
    if (jsonObj.containsKey("IsPrimaryContact")) {
      contact.isPrimaryContact = jsonObj["IsPrimaryContact"];
    }
    if (jsonObj.containsKey("Tags")) {
      contact.tags = jsonObj["Tags"];
    }
    if (jsonObj.containsKey("FreeTextField1")) {
      contact.freeTextField1 = jsonObj["FreeTextField1"];
    }
    if (jsonObj.containsKey("FreeTextField2")) {
      contact.freeTextField2 = jsonObj["FreeTextField2"];
    }
    if (jsonObj.containsKey("FreeTextField3")) {
      contact.freeTextField3 = jsonObj["FreeTextField3"];
    }
    if (jsonObj.containsKey("CompanyName")) {
      contact.companyName = jsonObj["CompanyName"];
    }
    if (jsonObj.containsKey("TaxPayerIdentificationNumber")) {
      contact.taxPayerIdentificationNumber = jsonObj["TaxPayerIdentificationNumber"];
    }
    if (jsonObj.containsKey("SocialSecurityNumber")) {
      contact.socialSecurityNumber = jsonObj["SocialSecurityNumber"];
    }
    if (jsonObj.containsKey("PassportNumber")) {
      contact.passportNumber = jsonObj["PassportNumber"];
    }
    if (jsonObj.containsKey("DrivingLicenseNumber")) {
      contact.drivingLicenseNumber = jsonObj["DrivingLicenseNumber"];
    }
    if (jsonObj.containsKey("VoterIDCardNumber")) {
      contact.voterIDCardNumber = jsonObj["VoterIDCardNumber"];
    }
    if (jsonObj.containsKey("MarketingContactID")) {
      contact.marketingContactID = jsonObj["MarketingContactID"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      contact.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      contact.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      contact.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      contact.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      contact.deviceIdentifier = jsonObj["DeviceIdentifier"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      contact.referenceIdentifier = jsonObj["ReferenceIdentifier"];
    }
    if (jsonObj.containsKey("IsActive")) {
      contact.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      contact.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      contact.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AssignedByAppUserID")) {
      contact.assignedByAppUserID = jsonObj["AssignedByAppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      contact.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      contact.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      contact.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("LeadQualificationID")) {
      contact.leadQualificationID = jsonObj["LeadQualificationID"];
    }

    contact.isDirty = "false";
    contact.isDeleted1 = "false";
    contact.upSyncMessage = "";
    contact.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      contact.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      contact.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      contact.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      contact.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    contact.upSyncIndex = "0";
    contact.ownerUserID = Globals.AppUserID.toString();

  } catch ( ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContact()", ex);
  }
  return contact;
}


static Future<ContactAlignment> copyJsonDataToContactAlignment( DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ContactAlignment contactAlignment, bool isForNew) async {
  try {
    contactAlignment.contactAlignmentID = jsonObj["ContactAlignmentID"] as String;
    contactAlignment.contactAlignmentCode = jsonObj["ContactAlignmentCode"] as String;
    contactAlignment.contactAlignmentName = jsonObj["ContactAlignmentName"] as String;
    contactAlignment.indicatorColor = jsonObj["IndicatorColor"] as String;
    contactAlignment.createdOn = jsonObj["CreatedOn"] as String;
    contactAlignment.createdBy = jsonObj["CreatedBy"] as String;
    contactAlignment.modifiedOn = jsonObj["ModifiedOn"] as String;
    contactAlignment.modifiedBy = jsonObj["ModifiedBy"] as String;
    contactAlignment.isActive = jsonObj["IsActive"] as String;
    contactAlignment.uid = jsonObj["Uid"] as String;
    contactAlignment.appUserID = jsonObj["AppUserID"] as String;
    contactAlignment.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    contactAlignment.isArchived = jsonObj["IsArchived"] as String;
    contactAlignment.isDeleted = jsonObj["IsDeleted"] as String;

    contactAlignment.isDirty = "false";
    contactAlignment.isDeleted1 = "false";
    contactAlignment.upSyncMessage = "";
    contactAlignment.downSyncMessage = "";
    contactAlignment.sCreatedOn = jsonObj["CreatedOn"] as String;
    contactAlignment.sModifiedOn = jsonObj["ModifiedOn"] as String;
    contactAlignment.createdByUser = jsonObj["CreatedByUser"] as String;
    contactAlignment.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    contactAlignment.upSyncIndex = "0";
    contactAlignment.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContactAlignment()", ex);
  }
  return contactAlignment;
}

ContactCategory copyJsonDataToContactCategory( DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ContactCategory contactCategory, bool isForNew) {
  try {
    contactCategory.contactCategoryID = jsonObj["ContactCategoryID"] as String;
    contactCategory.contactCategoryCode = jsonObj["ContactCategoryCode"] as String;
    contactCategory.contactCategoryName = jsonObj["ContactCategoryName"] as String;
    contactCategory.createdOn = jsonObj["CreatedOn"] as String;
    contactCategory.createdBy = jsonObj["CreatedBy"] as String;
    contactCategory.modifiedOn = jsonObj["ModifiedOn"] as String;
    contactCategory.modifiedBy = jsonObj["ModifiedBy"] as String;
    contactCategory.isActive = jsonObj["IsActive"] as String;
    contactCategory.uid = jsonObj["Uid"] as String;
    contactCategory.appUserID = jsonObj["AppUserID"] as String;
    contactCategory.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    contactCategory.isArchived = jsonObj["IsArchived"] as String;
    contactCategory.isDeleted = jsonObj["IsDeleted"] as String;

    contactCategory.isDirty = "false";
    contactCategory.isDeleted1 = "false";
    contactCategory.upSyncMessage = "";
    contactCategory.downSyncMessage = "";
    contactCategory.sCreatedOn = jsonObj["CreatedOn"] as String;
    contactCategory.sModifiedOn = jsonObj["ModifiedOn"] as String;
    contactCategory.createdByUser = jsonObj["CreatedByUser"] as String;
    contactCategory.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    contactCategory.upSyncIndex = "0";
    contactCategory.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContactCategory()", ex);
  }
  return contactCategory;
}

Future<ContactMedia> copyJsonDataToContactMedia(, DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ContactMedia contactMedia, bool isForNew) async {
  try {
    contactMedia.contactMediaID = jsonObj["ContactMediaID"] as String;
    contactMedia.contactMediaCode = jsonObj["ContactMediaCode"] as String;
    contactMedia.contactMediaName = jsonObj["ContactMediaName"] as String;

    if (jsonObj.containsKey("ContactID")) {
      String contactId = jsonObj["ContactID"] as String;
      contactId = contactId != null && contactId.isNotEmpty ? contactId : "-1";
      Contact? contact =await  ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
      if (contact != null) {
        contactMedia.contactID = contact.id;
      }
    }

    if (jsonObj.containsKey("ContentTypeID")) {
      String contentTypeId = jsonObj["ContentTypeID"] as String;
      contentTypeId = contentTypeId != null && contentTypeId.isNotEmpty ? contentTypeId : "-1";
      ContentType contentType = ContentTypeDataHandlerBaseBaseBase.getMasterContentTypeRecord(dbHandler, contentTypeId);
      if (contentType != null) {
        contactMedia.contentTypeID = contentType.id;
      }
    }

    contactMedia.mediaPath = jsonObj["MediaPath"] as String;
    contactMedia.mediaContent = jsonObj["MediaContent"] as String;
    contactMedia.description = jsonObj["Description"] as String;
    contactMedia.tags = jsonObj["Tags"] as String;
    contactMedia.createdBy = jsonObj["CreatedBy"] as String;
    contactMedia.createdOn = jsonObj["CreatedOn"] as String;
    contactMedia.modifiedBy = jsonObj["ModifiedBy"] as String;
    contactMedia.modifiedOn = jsonObj["ModifiedOn"] as String;
    contactMedia.deviceIdentifier = jsonObj["DeviceIdentifier"] as String;
    contactMedia.referenceIdentifier = jsonObj["ReferenceIdentifier"] as String;
    contactMedia.isActive = jsonObj["IsActive"] as String;
    contactMedia.uid = jsonObj["Uid"] as String;
    contactMedia.appUserID = jsonObj["AppUserID"] as String;
    contactMedia.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    contactMedia.isArchived = jsonObj["IsArchived"] as String;
    contactMedia.isDeleted = jsonObj["IsDeleted"] as String;

    contactMedia.isDirty = "false";
    contactMedia.isDeleted1 = "false";
    contactMedia.upSyncMessage = "";
    contactMedia.downSyncMessage = "";
    contactMedia.sCreatedOn = jsonObj["CreatedOn"] as String;
    contactMedia.sModifiedOn = jsonObj["ModifiedOn"] as String;
    contactMedia.createdByUser = jsonObj["CreatedByUser"] as String;
    contactMedia.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    contactMedia.upSyncIndex = "0";
    contactMedia.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContactMedia()", ex);
  }
  return contactMedia;
}

ContactTitle copyJsonDataToContactTitle(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ContactTitle contactTitle, bool isForNew) {
  try {
    contactTitle.contactTitleID = jsonObj["ContactTitleID"] as String;
    contactTitle.contactTitleCode = jsonObj["ContactTitleCode"] as String;
    contactTitle.contactTitleName = jsonObj["ContactTitleName"] as String;
    contactTitle.createdOn = jsonObj["CreatedOn"] as String;
    contactTitle.createdBy = jsonObj["CreatedBy"] as String;
    contactTitle.modifiedOn = jsonObj["ModifiedOn"] as String;
    contactTitle.modifiedBy = jsonObj["ModifiedBy"] as String;
    contactTitle.isActive = jsonObj["IsActive"] as String;
    contactTitle.uid = jsonObj["Uid"] as String;
    contactTitle.appUserID = jsonObj["AppUserID"] as String;
    contactTitle.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    contactTitle.isArchived = jsonObj["IsArchived"] as String;
    contactTitle.isDeleted = jsonObj["IsDeleted"] as String;

    contactTitle.isDirty = "false";
    contactTitle.isDeleted1 = "false";
    contactTitle.upSyncMessage = "";
    contactTitle.downSyncMessage = "";
    contactTitle.sCreatedOn = jsonObj["CreatedOn"] as String;
    contactTitle.sModifiedOn = jsonObj["ModifiedOn"] as String;
    contactTitle.createdByUser = jsonObj["CreatedByUser"] as String;
    contactTitle.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    contactTitle.upSyncIndex = "0";
    contactTitle.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContactTitle()", ex);
  }
  return contactTitle;
}

ContentType copyJsonDataToContentType(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ContentType contentType, bool isForNew) {
  try {
    contentType.contentTypeID = jsonObj["ContentTypeID"] as String;
    contentType.contentTypeCode = jsonObj["ContentTypeCode"] as String;
    contentType.contentTypeName = jsonObj["ContentTypeName"] as String;
    contentType.createdOn = jsonObj["CreatedOn"] as String;
    contentType.createdBy = jsonObj["CreatedBy"] as String;
    contentType.modifiedOn = jsonObj["ModifiedOn"] as String;
    contentType.modifiedBy = jsonObj["ModifiedBy"] as String;
    contentType.isActive = jsonObj["IsActive"] as String;
    contentType.uid = jsonObj["Uid"] as String;
    contentType.appUserID = jsonObj["AppUserID"] as String;
    contentType.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    contentType.isArchived = jsonObj["IsArchived"] as String;
    contentType.isDeleted = jsonObj["IsDeleted"] as String;

    contentType.isDirty = "false";
    contentType.isDeleted1 = "false";
    contentType.upSyncMessage = "";
    contentType.downSyncMessage = "";
    contentType.sCreatedOn = jsonObj["CreatedOn"] as String;
    contentType.sModifiedOn = jsonObj["ModifiedOn"] as String;
    contentType.createdByUser = jsonObj["CreatedByUser"] as String;
    contentType.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    contentType.upSyncIndex = "0";
    contentType.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToContentType()", ex);
  }
  return contentType;
}

Country copyJsonDataToCountry(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Country country, bool isForNew) {
  try {
    country.countryID = jsonObj["CountryID"] as String;
    country.countryCode = jsonObj["CountryCode"] as String;
    country.countryName = jsonObj["CountryName"] as String;
    country.createdOn = jsonObj["CreatedOn"] as String;
    country.createdBy = jsonObj["CreatedBy"] as String;
    country.modifiedOn = jsonObj["ModifiedOn"] as String;
    country.modifiedBy = jsonObj["ModifiedBy"] as String;
    country.isActive = jsonObj["IsActive"] as String;
    country.uid = jsonObj["Uid"] as String;
    country.appUserID = jsonObj["AppUserID"] as String;
    country.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    country.isArchived = jsonObj["IsArchived"] as String;
    country.isDeleted = jsonObj["IsDeleted"] as String;

    country.isDirty = "false";
    country.isDeleted1 = "false";
    country.upSyncMessage = "";
    country.downSyncMessage = "";
    country.sCreatedOn = jsonObj["CreatedOn"] as String;
    country.sModifiedOn = jsonObj["ModifiedOn"] as String;
    country.createdByUser = jsonObj["CreatedByUser"] as String;
    country.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    country.upSyncIndex = "0";
    country.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToCountry()", ex);
  }
  return country;
}
CreditRating copyJsonDataToCreditRating(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, CreditRating creditRating, bool isForNew) {
  try {
    creditRating.creditRatingID = jsonObj["CreditRatingID"] as String;
    creditRating.creditRatingCode = jsonObj["CreditRatingCode"] as String;
    creditRating.creditRatingName = jsonObj["CreditRatingName"] as String;
    creditRating.creditRatingDescription = jsonObj["CreditRatingDescription"] as String;
    creditRating.createdOn = jsonObj["CreatedOn"] as String;
    creditRating.createdBy = jsonObj["CreatedBy"] as String;
    creditRating.modifiedOn = jsonObj["ModifiedOn"] as String;
    creditRating.modifiedBy = jsonObj["ModifiedBy"] as String;
    creditRating.isActive = jsonObj["IsActive"] as String;
    creditRating.uid = jsonObj["Uid"] as String;
    creditRating.appUserID = jsonObj["AppUserID"] as String;
    creditRating.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    creditRating.isArchived = jsonObj["IsArchived"] as String;
    creditRating.isDeleted = jsonObj["IsDeleted"] as String;

    creditRating.isDirty = "false";
    creditRating.isDeleted1 = "false";
    creditRating.upSyncMessage = "";
    creditRating.downSyncMessage = "";
    creditRating.sCreatedOn = jsonObj["CreatedOn"] as String;
    creditRating.sModifiedOn = jsonObj["ModifiedOn"] as String;
    creditRating.createdByUser = jsonObj["CreatedByUser"] as String;
    creditRating.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    creditRating.upSyncIndex = "0";
    creditRating.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToCreditRating()", ex);
  }
  return creditRating;
}
Future<Currency> copyJsonDataToCurrency(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Currency currency, bool isForNew) async {
  try {
    currency.currencyID = jsonObj["CurrencyID"] as String;
    currency.currencyCode = jsonObj["CurrencyCode"] as String;
    currency.currencyName = jsonObj["CurrencyName"] as String;

    if (jsonObj.containsKey("CountryID")) {
      String countryId = jsonObj["CountryID"] as String;
      countryId = countryId != null && countryId.isNotEmpty ? countryId : "-1";
      Country country = await  CountryDataHandler.getMasterCountryRecord(dbHandler, countryId);
      if (country != null) {
        currency.countryID = country.id;
      }
    }

    currency.standardCurrencyCode = jsonObj["StandardCurrencyCode"] as String;
    currency.currencySymbol = jsonObj["CurrencySymbol"] as String;
    currency.exchangeRate = jsonObj["ExchangeRate"] as String;
    currency.isDefaultCurrency = jsonObj["IsDefaultCurrency"] as String;
    currency.createdOn = jsonObj["CreatedOn"] as String;
    currency.createdBy = jsonObj["CreatedBy"] as String;
    currency.modifiedOn = jsonObj["ModifiedOn"] as String;
    currency.modifiedBy = jsonObj["ModifiedBy"] as String;
    currency.isActive = jsonObj["IsActive"] as String;
    currency.uid = jsonObj["Uid"] as String;
    currency.appUserID = jsonObj["AppUserID"] as String;
    currency.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    currency.isArchived = jsonObj["IsArchived"] as String;
    currency.isDeleted = jsonObj["IsDeleted"] as String;

    currency.isDirty = "false";
    currency.isDeleted1 = "false";
    currency.upSyncMessage = "";
    currency.downSyncMessage = "";
    currency.sCreatedOn = jsonObj["CreatedOn"] as String;
    currency.sModifiedOn = jsonObj["ModifiedOn"] as String;
    currency.createdByUser = jsonObj["CreatedByUser"] as String;
    currency.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    currency.upSyncIndex = "0";
    currency.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToCurrency()", ex);
  }
  return currency;
}

Future<CustomerMeeting> copyJsonDataToCustomerMeeting( DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, CustomerMeeting customerMeeting, bool isForNew) async {
  try {
    customerMeeting.customerMeetingID = jsonObj["CustomerMeetingID"] as String;
    customerMeeting.customerMeetingCode = jsonObj["CustomerMeetingCode"] as String;
    customerMeeting.customerMeetingTitle = jsonObj["CustomerMeetingTitle"] as String;

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"] as String;
      activityId = activityId != null && activityId.isNotEmpty ? activityId : "-1";
      Activity? activity = await ActivityDataHandlerBaseBase.GetMasterActivityRecord(dbHandler, activityId);
      if (activity != null) {
        customerMeeting.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"] as String;
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account?account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(dbHandler, accountId);
      if (account != null) {
        customerMeeting.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactID")) {
      String contactId = jsonObj["ContactID"] as String;
      contactId = contactId != null && contactId.isNotEmpty ? contactId : "-1";
      Contact ?contact = await ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
      if (contact != null) {
        customerMeeting.contactID = contact.id;
      }
    }

    customerMeeting.customerMeetingDate = jsonObj["CustomerMeetingDate"] as String;
    customerMeeting.punchInTime = jsonObj["PunchInTime"] as String;
    customerMeeting.punchOutTime = jsonObj["PunchOutTime"] as String;
    customerMeeting.punchInLocation = jsonObj["PunchInLocation"] as String;
    customerMeeting.punchOutLocation = jsonObj["PunchOutLocation"] as String;
    customerMeeting.remarks = jsonObj["Remarks"] as String;
    customerMeeting.createdBy = jsonObj["CreatedBy"] as String;
    customerMeeting.createdOn = jsonObj["CreatedOn"] as String;
    customerMeeting.modifiedBy = jsonObj["ModifiedBy"] as String;
    customerMeeting.modifiedOn = jsonObj["ModifiedOn"] as String;
    customerMeeting.deviceIdentifier = jsonObj["DeviceIdentifier"] as String;
    customerMeeting.referenceIdentifier = jsonObj["ReferenceIdentifier"] as String;
    customerMeeting.isActive = jsonObj["IsActive"] as String;
    customerMeeting.uid = jsonObj["Uid"] as String;
    customerMeeting.appUserID = jsonObj["AppUserID"] as String;
    customerMeeting.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    customerMeeting.isArchived = jsonObj["IsArchived"] as String;
    customerMeeting.isDeleted = jsonObj["IsDeleted"] as String;

    customerMeeting.isDirty = "false";
    customerMeeting.isDeleted1 = "false";
    customerMeeting.upSyncMessage = "";
    customerMeeting.downSyncMessage = "";
    customerMeeting.sCreatedOn = jsonObj["CreatedOn"] as String;
    customerMeeting.sModifiedOn = jsonObj["ModifiedOn"] as String;
    customerMeeting.createdByUser = jsonObj["CreatedByUser"] as String;
    customerMeeting.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    customerMeeting.upSyncIndex = "0";
    customerMeeting.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToCustomerMeeting()", ex);
  }
  return customerMeeting;
}
Department copyJsonDataToDepartment(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Department department, bool isForNew) {
  try {
    department.departmentID = jsonObj["DepartmentID"] as String;
    department.departmentCode = jsonObj["DepartmentCode"] as String;
    department.departmentName = jsonObj["DepartmentName"] as String;
    department.createdOn = jsonObj["CreatedOn"] as String;
    department.createdBy = jsonObj["CreatedBy"] as String;
    department.modifiedOn = jsonObj["ModifiedOn"] as String;
    department.modifiedBy = jsonObj["ModifiedBy"] as String;
    department.isActive = jsonObj["IsActive"] as String;
    department.uid = jsonObj["Uid"] as String;
    department.appUserID = jsonObj["AppUserID"] as String;
    department.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    department.isArchived = jsonObj["IsArchived"] as String;
    department.isDeleted = jsonObj["IsDeleted"] as String;

    department.isDirty = "false";
    department.isDeleted1 = "false";
    department.upSyncMessage = "";
    department.downSyncMessage = "";
    department.sCreatedOn = jsonObj["CreatedOn"] as String;
    department.sModifiedOn = jsonObj["ModifiedOn"] as String;
    department.createdByUser = jsonObj["CreatedByUser"] as String;
    department.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    department.upSyncIndex = "0";
    department.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToDepartment()", ex);
  }
  return department;
}

Designation copyJsonDataToDesignation(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Designation designation, bool isForNew) {
  try {
    designation.designationID = jsonObj["DesignationID"] as String;
    designation.designationCode = jsonObj["DesignationCode"] as String;
    designation.designationName = jsonObj["DesignationName"] as String;
    designation.createdOn = jsonObj["CreatedOn"] as String;
    designation.createdBy = jsonObj["CreatedBy"] as String;
    designation.modifiedOn = jsonObj["ModifiedOn"] as String;
    designation.modifiedBy = jsonObj["ModifiedBy"] as String;
    designation.isActive = jsonObj["IsActive"] as String;
    designation.uid = jsonObj["Uid"] as String;
    designation.appUserID = jsonObj["AppUserID"] as String;
    designation.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    designation.isArchived = jsonObj["IsArchived"] as String;
    designation.isDeleted = jsonObj["IsDeleted"] as String;

    designation.isDirty = "false";
    designation.isDeleted1 = "false";
    designation.upSyncMessage = "";
    designation.downSyncMessage = "";
    designation.sCreatedOn = jsonObj["CreatedOn"] as String;
    designation.sModifiedOn = jsonObj["ModifiedOn"] as String;
    designation.createdByUser = jsonObj["CreatedByUser"] as String;
    designation.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    designation.upSyncIndex = "0";
    designation.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToDesignation()", ex);
  }
  return designation;
}

EmailManualTemplate copyJsonDataToEmailManualTemplate(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, EmailManualTemplate emailManualTemplate, bool isForNew) {
  try {
    emailManualTemplate.emailManualTemplateID = jsonObj["EmailManualTemplateID"] as String;
    emailManualTemplate.emailManualTemplateCode = jsonObj["EmailManualTemplateCode"] as String;
    emailManualTemplate.emailManualTemplateName = jsonObj["EmailManualTemplateName"] as String;
    emailManualTemplate.emailTemplateType = jsonObj["EmailTemplateType"] as String;
    emailManualTemplate.subject = jsonObj["Subject"] as String;
    emailManualTemplate.mailBody = jsonObj["MailBody"] as String;
    emailManualTemplate.fromEmail = jsonObj["FromEmail"] as String;
    emailManualTemplate.toEmail = jsonObj["ToEmail"] as String;
    emailManualTemplate.ccEmail = jsonObj["CcEmail"] as String;
    emailManualTemplate.emailType = jsonObj["EMailType"] as String;
    emailManualTemplate.isSystemDefined = jsonObj["IsSystemDefined"] as String;
    emailManualTemplate.createdOn = jsonObj["CreatedOn"] as String;
    emailManualTemplate.createdBy = jsonObj["CreatedBy"] as String;
    emailManualTemplate.modifiedOn = jsonObj["ModifiedOn"] as String;
    emailManualTemplate.modifiedBy = jsonObj["ModifiedBy"] as String;
    emailManualTemplate.isActive = jsonObj["IsActive"] as String;
    emailManualTemplate.uid = jsonObj["Uid"] as String;
    emailManualTemplate.appUserID = jsonObj["AppUserID"] as String;
    emailManualTemplate.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    emailManualTemplate.isDeleted = jsonObj["IsDeleted"] as String;

    emailManualTemplate.isDirty = "false";
    emailManualTemplate.isDeleted1 = "false";
    emailManualTemplate.upSyncMessage = "";
    emailManualTemplate.downSyncMessage = "";
    emailManualTemplate.sCreatedOn = jsonObj["CreatedOn"] as String;
    emailManualTemplate.sModifiedOn = jsonObj["ModifiedOn"] as String;
    emailManualTemplate.createdByUser = jsonObj["CreatedByUser"] as String;
    emailManualTemplate.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    emailManualTemplate.upSyncIndex = "0";
    emailManualTemplate.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToEmailManualTemplate()", ex);
  }
  return emailManualTemplate;
}

FieldAttendance copyJsonDataToFieldAttendance(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, FieldAttendance fieldAttendance, bool isForNew) {
  try {
    fieldAttendance.fieldAttendanceID = jsonObj["FieldAttendanceID"] as String;
    fieldAttendance.fieldAttendanceCode = jsonObj["FieldAttendanceCode"] as String;
    fieldAttendance.fieldAttendanceTitle = jsonObj["FieldAttendanceTitle"] as String;
    fieldAttendance.fieldAttendanceDate = jsonObj["FieldAttendanceDate"] as String;
    if (isForNew) {
      fieldAttendance.punchInTime = jsonObj["PunchInTime"] as String;
      fieldAttendance.punchOutTime = jsonObj["PunchOutTime"] as String;
      fieldAttendance.punchInLocation = jsonObj["PunchInLocation"] as String;
      fieldAttendance.userSpecifiedPunchInLocation = jsonObj["UserSpecifiedPunchInLocation"] as String;
      fieldAttendance.punchOutLocation = jsonObj["PunchOutLocation"] as String;
      fieldAttendance.userSpecifiedPunchOutLocation = jsonObj["UserSpecifiedPunchOutLocation"] as String;
    }
    fieldAttendance.remarks = jsonObj["Remarks"] as String;
    fieldAttendance.createdBy = jsonObj["CreatedBy"] as String;
    fieldAttendance.createdOn = jsonObj["CreatedOn"] as String;
    fieldAttendance.modifiedBy = jsonObj["ModifiedBy"] as String;
    fieldAttendance.modifiedOn = jsonObj["ModifiedOn"] as String;
    fieldAttendance.deviceIdentifier = jsonObj["DeviceIdentifier"] as String;
    fieldAttendance.referenceIdentifier = jsonObj["ReferenceIdentifier"] as String;
    fieldAttendance.isActive = jsonObj["IsActive"] as String;
    fieldAttendance.uid = jsonObj["Uid"] as String;
    fieldAttendance.appUserID = jsonObj["AppUserID"] as String;
    fieldAttendance.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    fieldAttendance.isArchived = jsonObj["IsArchived"] as String;
    fieldAttendance.isDeleted = jsonObj["IsDeleted"] as String;

    fieldAttendance.isDirty = "false";
    fieldAttendance.isDeleted1 = "false";
    fieldAttendance.upSyncMessage = "";
    fieldAttendance.downSyncMessage = "";
    fieldAttendance.sCreatedOn = jsonObj["CreatedOn"] as String;
    fieldAttendance.sModifiedOn = jsonObj["ModifiedOn"] as String;
    fieldAttendance.createdByUser = jsonObj["CreatedByUser"] as String;
    fieldAttendance.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    fieldAttendance.upSyncIndex = "0";
    fieldAttendance.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFieldAttendance()", ex);
  }
  return fieldAttendance;
}

ExpenseType copyJsonDataToExpenseType(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ExpenseType expenseType, bool isForNew) {
  try {
    expenseType.expenseTypeID = jsonObj["ExpenseTypeID"] as String;
    expenseType.expenseTypeCode = jsonObj["ExpenseTypeCode"] as String;
    expenseType.expenseTypeName = jsonObj["ExpenseTypeName"] as String;
    expenseType.isTravelRequired = jsonObj["IsTravelRequired"] as String;
    expenseType.calculateDistanceTravelled = jsonObj["CalculateDistanceTravelled"] as String;
    expenseType.createdOn = jsonObj["CreatedOn"] as String;
    expenseType.createdBy = jsonObj["CreatedBy"] as String;
    expenseType.modifiedOn = jsonObj["ModifiedOn"] as String;
    expenseType.modifiedBy = jsonObj["ModifiedBy"] as String;
    expenseType.isActive = jsonObj["IsActive"] as String;
    expenseType.uid = jsonObj["Uid"] as String;
    expenseType.appUserID = jsonObj["AppUserID"] as String;
    expenseType.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    expenseType.isArchived = jsonObj["IsArchived"] as String;
    expenseType.isDeleted = jsonObj["IsDeleted"] as String;

    expenseType.isDirty = "false";
    expenseType.isDeleted1 = "false";
    expenseType.upSyncMessage = "";
    expenseType.downSyncMessage = "";
    expenseType.sCreatedOn = jsonObj["CreatedOn"] as String;
    expenseType.sModifiedOn = jsonObj["ModifiedOn"] as String;
    expenseType.createdByUser = jsonObj["CreatedByUser"] as String;
    expenseType.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    expenseType.upSyncIndex = "0";
    expenseType.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToExpenseType()", ex);
  }
  return expenseType;
}

FinancialInstitution copyJsonDataToFinancialInstitution(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, FinancialInstitution financialInstitution, bool isForNew) {
  try {
    financialInstitution.financialInstitutionID = jsonObj["FinancialInstitutionID"] as String;
    financialInstitution.financialInstitutionCode = jsonObj["FinancialInstitutionCode"] as String;
    financialInstitution.financialInstitutionName = jsonObj["FinancialInstitutionName"] as String;
    financialInstitution.description = jsonObj["Description"] as String;
    financialInstitution.createdOn = jsonObj["CreatedOn"] as String;
    financialInstitution.createdBy = jsonObj["CreatedBy"] as String;
    financialInstitution.modifiedOn = jsonObj["ModifiedOn"] as String;
    financialInstitution.modifiedBy = jsonObj["ModifiedBy"] as String;
    financialInstitution.isActive = jsonObj["IsActive"] as String;
    financialInstitution.uid = jsonObj["Uid"] as String;
    financialInstitution.appUserID = jsonObj["AppUserID"] as String;
    financialInstitution.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    financialInstitution.isArchived = jsonObj["IsArchived"] as String;
    financialInstitution.isDeleted = jsonObj["IsDeleted"] as String;

    financialInstitution.isDirty = "false";
    financialInstitution.isDeleted1 = "false";
    financialInstitution.upSyncMessage = "";
    financialInstitution.downSyncMessage = "";
    financialInstitution.sCreatedOn = jsonObj["CreatedOn"] as String;
    financialInstitution.sModifiedOn = jsonObj["ModifiedOn"] as String;
    financialInstitution.createdByUser = jsonObj["CreatedByUser"] as String;
    financialInstitution.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    financialInstitution.upSyncIndex = "0";
    financialInstitution.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFinancialInstitution()", ex);
  }
  return financialInstitution;
}
FinancialYear copyJsonDataToFinancialYear(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, FinancialYear financialYear, bool isForNew) {
  try {
    financialYear.financialYearID = jsonObj["FinancialYearID"] as String;
    financialYear.financialYearCode = jsonObj["FinancialYearCode"] as String;
    financialYear.financialYearName = jsonObj["FinancialYearName"] as String;
    financialYear.actualFinancialYear = jsonObj["ActualFinancialYear"] as String;
    financialYear.financialYearStartDate = jsonObj["FinancialYearStartDate"] as String;
    financialYear.financialYearEndDate = jsonObj["FinancialYearEndDate"] as String;
    financialYear.createdBy = jsonObj["CreatedBy"] as String;
    financialYear.createdOn = jsonObj["CreatedOn"] as String;
    financialYear.modifiedBy = jsonObj["ModifiedBy"] as String;
    financialYear.modifiedOn = jsonObj["ModifiedOn"] as String;
    financialYear.isActive = jsonObj["IsActive"] as String;
    financialYear.uid = jsonObj["Uid"] as String;
    financialYear.appUserID = jsonObj["AppUserID"] as String;
    financialYear.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    financialYear.isArchived = jsonObj["IsArchived"] as String;
    financialYear.isDeleted = jsonObj["IsDeleted"] as String;

    financialYear.isDirty = "false";
    financialYear.isDeleted1 = "false";
    financialYear.upSyncMessage = "";
    financialYear.downSyncMessage = "";
    financialYear.sCreatedOn = jsonObj["CreatedOn"] as String;
    financialYear.sModifiedOn = jsonObj["ModifiedOn"] as String;
    financialYear.createdByUser = jsonObj["CreatedByUser"] as String;
    financialYear.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    financialYear.upSyncIndex = "0";
    financialYear.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFinancialYear()", ex);
  }
  return financialYear;
}

static Future<Form> copyJsonDataToForm(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Form form, bool isForNew) async {
  try {
    form.formID = jsonObj["FormID"] as String;
    form.formCode = jsonObj["FormCode"] as String;
    form.formName = jsonObj["FormName"] as String;

    if (jsonObj.containsKey("BusinessFeatureID")) {
      String businessFeatureId = jsonObj["BusinessFeatureID"] as String;
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty ? businessFeatureId : "-1";
      BusinessFeature? businessFeature = await BusinessFeatureDataHandler.getMasterBusinessFeatureRecord(dbHandler,  businessFeatureId);
      if (businessFeature != null) {
        form.businessFeatureID = businessFeature.id;
      }
    }

    form.formType = jsonObj["FormType"] as String;
    form.linkTo = jsonObj["LinkTo"] as String;
    form.forStatus = jsonObj["ForStatus"] as String;
    form.sortOrder = jsonObj["SortOrder"] as String;
    form.isMandatory = jsonObj["IsMandatory"] as String;
    form.displayInApp = jsonObj["DisplayInApp"] as String;
    form.pdfSize = jsonObj["PDFSize"] as String;
    form.dataScriptWeb = jsonObj["DataScriptWeb"] as String;
    form.dataScriptApp = jsonObj["DataScriptApp"] as String;

    if (jsonObj.containsKey("ParentFormID")) {
      String formId = jsonObj["ParentFormID"] as String;
      formId = formId != null && formId.isNotEmpty ? formId : "-1";
      Form? form1 = await FormDataHandlerBase.GetMasterFormRecord(dbHandler, formId);
      if (form1 != null) {
        form.parentFormID = form1.id;
      }
    }

    if (jsonObj.containsKey("EmailManualTemplateID")) {
      String emailManualTemplateId = jsonObj["EmailManualTemplateID"] as String;
      emailManualTemplateId = emailManualTemplateId != null && emailManualTemplateId.isNotEmpty ? emailManualTemplateId : "-1";
      EmailManualTemplate? emailManualTemplate = await EmailManualTemplateDataHandler.getMasterEmailManualTemplateRecord(dbHandler,  emailManualTemplateId);
      if (emailManualTemplate != null) {
        form.emailManualTemplateID = emailManualTemplate.id;
      }
    }

    form.emailAutomatedTemplateID = jsonObj["EmailAutomatedTemplateID"] as String;
    form.createdOn = jsonObj["CreatedOn"] as String;
    form.createdBy = jsonObj["CreatedBy"] as String;
    form.modifiedOn = jsonObj["ModifiedOn"] as String;
    form.modifiedBy = jsonObj["ModifiedBy"] as String;
    form.isActive = jsonObj["IsActive"] as String;
    form.uid = jsonObj["Uid"] as String;
    form.appUserID = jsonObj["AppUserID"] as String;
    form.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    form.isArchived = jsonObj["IsArchived"] as String;
    form.isDeleted = jsonObj["IsDeleted"] as String;

    form.isDirty = "false";
    form.isDeleted1 = "false";
    form.upSyncMessage = "";
    form.downSyncMessage = "";
    form.sCreatedOn = jsonObj["CreatedOn"] as String;
    form.sModifiedOn = jsonObj["ModifiedOn"] as String;
    form.createdByUser = jsonObj["CreatedByUser"] as String;
    form.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    form.upSyncIndex = "0";
    form.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToForm()", ex);
  }
  return form;
}

FormCell copyJsonDataToFormCell(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, FormCell formCell, bool isForNew) {
  try {
    formCell.formCellID = jsonObj["FormCellID"] as String;
    formCell.formCellCode = jsonObj["FormCellCode"] as String;
    formCell.formCellName = jsonObj["FormCellName"] as String;

    if (jsonObj.containsKey("FormSectionID")) {
      String formSectionId = jsonObj["FormSectionID"] as String;
      formSectionId = formSectionId != null && formSectionId.isNotEmpty ? formSectionId : "-1";
      FormSection formSection = FormSectionDataHandler.getMasterFormSectionRecord(dbHandler, formSectionId);
      if (formSection != null) {
        formCell.formSectionID = formSection.id;
      }
    }

    formCell.rowIndex = jsonObj["RowIndex"] as String;
    formCell.columnIndex = jsonObj["ColumnIndex"] as String;
    formCell.rowSpan = jsonObj["RowSpan"] as String;
    formCell.columnSpan = jsonObj["ColumnSpan"] as String;
    formCell.alignment = jsonObj["Alignment"] as String;
    formCell.verticalAlignment = jsonObj["VerticalAlignment"] as String;
    formCell.createdOn = jsonObj["CreatedOn"] as String;
    formCell.createdBy = jsonObj["CreatedBy"] as String;
    formCell.modifiedOn = jsonObj["ModifiedOn"] as String;
    formCell.modifiedBy = jsonObj["ModifiedBy"] as String;
    formCell.isActive = jsonObj["IsActive"] as String;
    formCell.uid = jsonObj["Uid"] as String;
    formCell.referenceIdentifier = jsonObj["ReferenceIdentifier"] as String;
    formCell.appUserID = jsonObj["AppUserID"] as String;
    formCell.appUserGroupID = jsonObj["AppUserGroupID"] as String;
    formCell.isArchived = jsonObj["IsArchived"] as String;
    formCell.isDeleted = jsonObj["IsDeleted"] as String;

    formCell.isDirty = "false";
    formCell.isDeleted1 = "false";
    formCell.upSyncMessage = "";
    formCell.downSyncMessage = "";
    formCell.sCreatedOn = jsonObj["CreatedOn"] as String;
    formCell.sModifiedOn = jsonObj["ModifiedOn"] as String;
    formCell.createdByUser = jsonObj["CreatedByUser"] as String;
    formCell.modifiedByUser = jsonObj["ModifiedByUser"] as String;
    formCell.upSyncIndex = "0";
    formCell.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFormCell()", );
  }
  return formCell;
}

Future<FormCellElement> copyJsonDataToFormCellElement(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    FormCellElement formCellElement,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("FormCellElementID")) {
      formCellElement.formCellElementID = jsonObj["FormCellElementID"];
    }
    if (jsonObj.containsKey("FormCellElementCode")) {
      formCellElement.formCellElementCode = jsonObj["FormCellElementCode"];
    }
    if (jsonObj.containsKey("FormCellElementName")) {
      formCellElement.formCellElementName = jsonObj["FormCellElementName"];
    }

    if (jsonObj.containsKey("FormCellID")) {
      String formCellId = jsonObj["FormCellID"];
      formCellId = formCellId != null && formCellId != "" ? formCellId : "-1";
      FormCell formCell =
          await FormCellDataHandler.getMasterFormCellRecord(dbHandler, formCellId);
      if (formCell != null) {
        formCellElement.formCellID = formCell.id;
      }
    }

    if (jsonObj.containsKey("ControlName")) {
      formCellElement.controlName = jsonObj["ControlName"];
    }
    if (jsonObj.containsKey("ControlType")) {
      formCellElement.controlType = jsonObj["ControlType"];
    }
    if (jsonObj.containsKey("ControlLabel")) {
      formCellElement.controlLabel = jsonObj["ControlLabel"];
    }
    if (jsonObj.containsKey("ShowControlLabelIn")) {
      formCellElement.showControlLabelIn = jsonObj["ShowControlLabelIn"];
    }
    if (jsonObj.containsKey("CheckBoxLabelPosition")) {
      formCellElement.checkBoxLabelPosition = jsonObj["CheckBoxLabelPosition"];
    }
    if (jsonObj.containsKey("ControlValues")) {
      formCellElement.controlValues = jsonObj["ControlValues"];
    }
    if (jsonObj.containsKey("DefaultValue")) {
      formCellElement.defaultValue = jsonObj["DefaultValue"];
    }
    if (jsonObj.containsKey("Height")) {
      formCellElement.height = jsonObj["Height"];
    }
    if (jsonObj.containsKey("Width")) {
      formCellElement.width = jsonObj["Width"];
    }
    if (jsonObj.containsKey("IsRequired")) {
      formCellElement.isRequired = jsonObj["IsRequired"];
    }
    if (jsonObj.containsKey("IsPlaceHolder")) {
      formCellElement.isPlaceHolder = jsonObj["IsPlaceHolder"];
    }
    if (jsonObj.containsKey("PlaceHolderWidth")) {
      formCellElement.placeHolderWidth = jsonObj["PlaceHolderWidth"];
    }
    if (jsonObj.containsKey("DisplayInApp")) {
      formCellElement.displayInApp = jsonObj["DisplayInApp"];
    }
    if (jsonObj.containsKey("DisplayInReport")) {
      formCellElement.displayInReport = jsonObj["DisplayInReport"];
    }
    if (jsonObj.containsKey("HorizontalAlignment")) {
      formCellElement.horizontalAlignment = jsonObj["HorizontalAlignment"];
    }
    if (jsonObj.containsKey("VerticalAlignment")) {
      formCellElement.verticalAlignment = jsonObj["VerticalAlignment"];
    }
    if (jsonObj.containsKey("FontSize")) {
      formCellElement.fontSize = jsonObj["FontSize"];
    }
    if (jsonObj.containsKey("FontWeight")) {
      formCellElement.fontWeight = jsonObj["FontWeight"];
    }
    if (jsonObj.containsKey("ForeColor")) {
      formCellElement.foreColor = jsonObj["ForeColor"];
    }
    if (jsonObj.containsKey("BackgroundColor")) {
      formCellElement.backgroundColor = jsonObj["BackgroundColor"];
    }
    if (jsonObj.containsKey("SequentialOrder")) {
      formCellElement.sequentialOrder = jsonObj["SequentialOrder"];
    }
    if (jsonObj.containsKey("StartOnNewLine")) {
      formCellElement.startOnNewLine = jsonObj["StartOnNewLine"];
    }
    if (jsonObj.containsKey("LineBreakAfter")) {
      formCellElement.lineBreakAfter = jsonObj["LineBreakAfter"];
    }
    if (jsonObj.containsKey("PaddingLeft")) {
      formCellElement.paddingLeft = jsonObj["PaddingLeft"];
    }
    if (jsonObj.containsKey("PaddingRight")) {
      formCellElement.paddingRight = jsonObj["PaddingRight"];
    }
    if (jsonObj.containsKey("NeedAutoNumber")) {
      formCellElement.needAutoNumber = jsonObj["NeedAutoNumber"];
    }
    if (jsonObj.containsKey("AutoNumberPrefix")) {
      formCellElement.autoNumberPrefix = jsonObj["AutoNumberPrefix"];
    }
    if (jsonObj.containsKey("AutoNumber")) {
      formCellElement.autoNumber = jsonObj["AutoNumber"];
    }
    if (jsonObj.containsKey("IsDisabled")) {
      formCellElement.isDisabled = jsonObj["IsDisabled"];
    }

    if (jsonObj.containsKey("AttributeID")) {
      String attributeId = jsonObj["AttributeID"];
      attributeId = attributeId != null && attributeId != "" ? attributeId : "-1";
      Attribute attribute =
          await AttributeDataHandler.getMasterAttributeRecord(dbHandler, attributeId);
      if (attribute != null) {
        formCellElement.attributeID = attribute.id;
      }
    }

    if (jsonObj.containsKey("CanTriggerEvent")) {
      formCellElement.canTriggerEvent = jsonObj["CanTriggerEvent"];
    }
    if (jsonObj.containsKey("DataScriptApp1")) {
      formCellElement.dataScriptApp1 = jsonObj["DataScriptApp1"];
    }
    if (jsonObj.containsKey("DataScriptApp2")) {
      formCellElement.dataScriptApp2 = jsonObj["DataScriptApp2"];
    }
    if (jsonObj.containsKey("DataScriptWeb1")) {
      formCellElement.dataScriptWeb1 = jsonObj["DataScriptWeb1"];
    }
    if (jsonObj.containsKey("DataScriptWeb2")) {
      formCellElement.dataScriptWeb2 = jsonObj["DataScriptWeb2"];
    }
    if (jsonObj.containsKey("EventClassName")) {
      formCellElement.eventClassName = jsonObj["EventClassName"];
    }
    if (jsonObj.containsKey("IsTotalValue")) {
      formCellElement.isTotalValue = jsonObj["IsTotalValue"];
    }
    if (jsonObj.containsKey("SignatureType")) {
      formCellElement.signatureType = jsonObj["SignatureType"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      formCellElement.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      formCellElement.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      formCellElement.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      formCellElement.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      formCellElement.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      formCellElement.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      formCellElement.referenceIdentifier = jsonObj["ReferenceIdentifier"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      formCellElement.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      formCellElement.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      formCellElement.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      formCellElement.isDeleted = jsonObj["IsDeleted"];
    }

    formCellElement.isDirty = "false";
    formCellElement.isDeleted1 = "false";
    formCellElement.upSyncMessage = "";
    formCellElement.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      formCellElement.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      formCellElement.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      formCellElement.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      formCellElement.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    formCellElement.upSyncIndex = "0";
    formCellElement.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFormCellElement()", ex);
  }
  return formCellElement;
}

Future<FormSection> copyJsonDataToFormSection(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, FormSection formSection, bool isForNew) async {
  try {
    if (jsonObj.containsKey("FormSectionID")) {
      formSection.formSectionID = jsonObj["FormSectionID"].toString();
    }
    if (jsonObj.containsKey("FormSectionCode")) {
      formSection.formSectionCode = jsonObj["FormSectionCode"].toString();
    }
    if (jsonObj.containsKey("FormSectionName")) {
      formSection.formSectionName = jsonObj["FormSectionName"].toString();
    }

    if (jsonObj.containsKey("FormID")) {
      String formId = jsonObj["FormID"].toString();
      formId = (formId != null && formId.isNotEmpty) ? formId : "-1";
      Form? form = await  FormDataHandlerBase.GetMasterFormRecord(dbHandler, formId);
      if (form != null) {
        formSection.formID = form.id;
      }
    }

    if (jsonObj.containsKey("NumberOfRows")) {
      formSection.numberOfRows = jsonObj["NumberOfRows"].toString();
    }
    if (jsonObj.containsKey("NumberOfColumns")) {
      formSection.numberOfColumns = jsonObj["NumberOfColumns"].toString();
    }
    if (jsonObj.containsKey("ColumnWidths")) {
      formSection.columnWidths = jsonObj["ColumnWidths"].toString();
    }
    if (jsonObj.containsKey("SectionStyle")) {
      formSection.sectionStyle = jsonObj["SectionStyle"].toString();
    }
    if (jsonObj.containsKey("ShowHeaderIn")) {
      formSection.showHeaderIn = jsonObj["ShowHeaderIn"].toString();
    }
    if (jsonObj.containsKey("SectionType")) {
      formSection.sectionType = jsonObj["SectionType"].toString();
    }
    if (jsonObj.containsKey("SectionOrder")) {
      formSection.sectionOrder = jsonObj["SectionOrder"].toString();
    }
    if (jsonObj.containsKey("BackgroundColor")) {
      formSection.backgroundColor = jsonObj["BackgroundColor"].toString();
    }
    if (jsonObj.containsKey("DisplayInApp")) {
      formSection.displayInApp = jsonObj["DisplayInApp"].toString();
    }
    if (jsonObj.containsKey("DisplayInReport")) {
      formSection.displayInReport = jsonObj["DisplayInReport"].toString();
    }
    if (jsonObj.containsKey("IsRepeatable")) {
      formSection.isRepeatable = jsonObj["IsRepeatable"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      formSection.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      formSection.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      formSection.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      formSection.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      formSection.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      formSection.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      formSection.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      formSection.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      formSection.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      formSection.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      formSection.isDeleted = jsonObj["IsDeleted"].toString();
    }

    formSection.isDirty = "false";
    formSection.isDeleted1 = "false";
    formSection.upSyncMessage = "";
    formSection.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      formSection.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      formSection.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      formSection.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      formSection.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    formSection.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID"))
      formSection.ownerUserID = jsonObj["AppUserID"].toString();*/
    formSection.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToFormSection()", ex);
  }
  return formSection;
}


Industry copyJsonDataToIndustry(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Industry industry, bool isForNew) {
  try {
    if (jsonObj.containsKey("IndustryID")) {
      industry.industryID = jsonObj["IndustryID"].toString();
    }
    if (jsonObj.containsKey("IndustryCode")) {
      industry.industryCode = jsonObj["IndustryCode"].toString();
    }
    if (jsonObj.containsKey("IndustryName")) {
      industry.industryName = jsonObj["IndustryName"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      industry.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      industry.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      industry.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      industry.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      industry.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      industry.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      industry.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      industry.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      industry.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      industry.isDeleted = jsonObj["IsDeleted"].toString();
    }

    industry.isDirty = "false";
    industry.isDeleted1 = "false";
    industry.upSyncMessage = "";
    industry.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      industry.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      industry.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      industry.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      industry.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    industry.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID"))
      industry.ownerUserID = jsonObj["AppUserID"].toString();*/
    industry.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToIndustry()", ex);
  }
  return industry;
}

LeadSource copyJsonDataToLeadSource(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, LeadSource leadSource, bool isForNew) {
  try {
    if (jsonObj.containsKey("LeadSourceID")) {
      leadSource.leadSourceID = jsonObj["LeadSourceID"].toString();
    }
    if (jsonObj.containsKey("LeadSourceCode")) {
      leadSource.leadSourceCode = jsonObj["LeadSourceCode"].toString();
    }
    if (jsonObj.containsKey("LeadSourceName")) {
      leadSource.leadSourceName = jsonObj["LeadSourceName"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      leadSource.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      leadSource.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      leadSource.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      leadSource.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      leadSource.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      leadSource.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      leadSource.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      leadSource.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      leadSource.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      leadSource.isDeleted = jsonObj["IsDeleted"].toString();
    }

    leadSource.isDirty = "false";
    leadSource.isDeleted1 = "false";
    leadSource.upSyncMessage = "";
    leadSource.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      leadSource.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      leadSource.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      leadSource.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      leadSource.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    leadSource.upSyncIndex = "0";
    leadSource.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToLeadSource()", ex);
  }
  return leadSource;
}

Location copyJsonDataToLocation(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Location location, bool isForNew) {
  try {
    if (jsonObj.containsKey("LocationID")) {
      location.locationID = jsonObj["LocationID"].toString();
    }
    if (jsonObj.containsKey("LocationName")) {
      location.locationName = jsonObj["LocationName"].toString();
    }
    if (jsonObj.containsKey("City")) {
      location.city = jsonObj["City"].toString();
    }
    if (jsonObj.containsKey("District")) {
      location.district = jsonObj["District"].toString();
    }
    if (jsonObj.containsKey("Taluk")) {
      location.taluk = jsonObj["Taluk"].toString();
    }
    if (jsonObj.containsKey("State")) {
      location.state = jsonObj["State"].toString();
    }
    if (jsonObj.containsKey("PINCode")) {
      location.pinCode = jsonObj["PINCode"].toString();
    }
    if (jsonObj.containsKey("Country")) {
      location.country = jsonObj["Country"].toString();
    }
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToLocation()", ex);
  }
  return location;
}

ModeOfTravel copyJsonDataToModeOfTravel(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, ModeOfTravel modeOfTravel, bool isForNew) {
  try {
    if (jsonObj.containsKey("ModeOfTravelID")) {
      modeOfTravel.modeOfTravelID = jsonObj["ModeOfTravelID"].toString();
    }
    if (jsonObj.containsKey("ModeOfTravelCode")) {
      modeOfTravel.modeOfTravelCode = jsonObj["ModeOfTravelCode"].toString();
    }
    if (jsonObj.containsKey("ModeOfTravelName")) {
      modeOfTravel.modeOfTravelName = jsonObj["ModeOfTravelName"].toString();
    }
    if (jsonObj.containsKey("RatePerKilometer")) {
      modeOfTravel.ratePerKilometer = jsonObj["RatePerKilometer"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      modeOfTravel.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      modeOfTravel.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      modeOfTravel.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      modeOfTravel.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      modeOfTravel.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      modeOfTravel.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      modeOfTravel.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      modeOfTravel.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      modeOfTravel.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      modeOfTravel.isDeleted = jsonObj["IsDeleted"].toString();
    }

    modeOfTravel.isDirty = "false";
    modeOfTravel.isDeleted1 = "false";
    modeOfTravel.upSyncMessage = "";
    modeOfTravel.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      modeOfTravel.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      modeOfTravel.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      modeOfTravel.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      modeOfTravel.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    modeOfTravel.upSyncIndex = "0";
    modeOfTravel.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToModeOfTravel()", ex);
  }
  return modeOfTravel;
}

Future<Note> copyJsonDataToNote(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Note note, bool isForNew) async {
  try {
    if (jsonObj.containsKey("NoteID")) {
      note.noteID = jsonObj["NoteID"].toString();
    }
    if (jsonObj.containsKey("NoteCode")) {
      note.noteCode = jsonObj["NoteCode"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = (accountId != null && accountId.isNotEmpty) ? accountId : "-1";
      Account? account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(dbHandler, accountId);
      if (account != null) {
        note.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactID")) {
      String contactId = jsonObj["ContactID"].toString();
      contactId = (contactId != null && contactId.isNotEmpty) ? contactId : "-1";
      Contact? contact = await  ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
      if (contact != null) {
        note.contactID = contact.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId = (opportunityId != null && opportunityId.isNotEmpty) ? opportunityId : "-1";
      Opportunity? opportunity =await OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
      if (opportunity != null) {
        note.opportunityID = opportunity.id;
      }
    }

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"].toString();
      activityId = (activityId != null && activityId.isNotEmpty) ? activityId : "-1";
      Activity? activity =await ActivityDataHandlerBaseBase.GetMasterActivityRecord(dbHandler, activityId);
      if (activity != null) {
        note.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("OpportunityStageID")) {
      String opportunityStageId = jsonObj["OpportunityStageID"].toString();
      opportunityStageId = (opportunityStageId != null && opportunityStageId.isNotEmpty) ? opportunityStageId : "-1";
      OpportunityStage ?opportunityStage = await  OpportunityStageDataHandlerBase.GetMasterOpportunityStageRecord(dbHandler, opportunityStageId);
      if (opportunityStage != null) {
        note.opportunityStageID = opportunityStage.id;
      }
    }

    if (jsonObj.containsKey("IsPersonal")) {
      note.isPersonal = jsonObj["IsPersonal"].toString();
    }
    if (jsonObj.containsKey("NoteTitle")) {
      note.noteTitle = jsonObj["NoteTitle"].toString();
    }
    if (jsonObj.containsKey("NoteDate")) {
      note.noteDate = jsonObj["NoteDate"].toString();
    }
    if (jsonObj.containsKey("NoteContent")) {
      note.noteContent = jsonObj["NoteContent"].toString();
    }
    if (jsonObj.containsKey("Tags")) {
      note.tags = jsonObj["Tags"].toString();
    }
    if (jsonObj.containsKey("FreeTextField1")) {
      note.freeTextField1 = jsonObj["FreeTextField1"].toString();
    }
    if (jsonObj.containsKey("FreeTextField2")) {
      note.freeTextField2 = jsonObj["FreeTextField2"].toString();
    }
    if (jsonObj.containsKey("FreeTextField3")) {
      note.freeTextField3 = jsonObj["FreeTextField3"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      note.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      note.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      note.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      note.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      note.deviceIdentifier = jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      note.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      note.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      note.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      note.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      note.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      note.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      note.isDeleted = jsonObj["IsDeleted"].toString();
    }
    note.isDirty = "false";
    note.isDeleted1 = "false";
    note.upSyncMessage = "";
    note.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      note.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      note.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      note.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      note.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    note.upSyncIndex = "0";
    note.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToNote()", ex);
  }
  return note;
}
NoteMedia copyJsonDataToNoteMedia(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, NoteMedia noteMedia, bool isForNew) {
  try {
    if (jsonObj.containsKey("NoteMediaID")) {
      noteMedia.noteMediaID = jsonObj["NoteMediaID"].toString();
    }
    if (jsonObj.containsKey("NoteMediaCode")) {
      noteMedia.noteMediaCode = jsonObj["NoteMediaCode"].toString();
    }
    if (jsonObj.containsKey("NoteMediaName")) {
      noteMedia.noteMediaName = jsonObj["NoteMediaName"].toString();
    }

    if (jsonObj.containsKey("NoteID")) {
      String noteId = jsonObj["NoteID"].toString();
      noteId = (noteId != null && noteId.isNotEmpty) ? noteId : "-1";
      Note note = NoteDataHandler.getMasterNoteRecord(dbHandler,  noteId);
      if (note != null) {
        noteMedia.noteID = note.id;
      }
    }

    if (jsonObj.containsKey("ContentTypeID")) {
      String contentTypeId = jsonObj["ContentTypeID"].toString();
      contentTypeId = (contentTypeId != null && contentTypeId.isNotEmpty) ? contentTypeId : "-1";
      ContentType contentType = ContentTypeDataHandlerBaseBase.getMasterContentTypeRecord(dbHandler,  contentTypeId);
      if (contentType != null) {
        noteMedia.contentTypeId = contentType.id;
      }
    }

    if (jsonObj.containsKey("MediaPath")) {
      noteMedia.mediaPath = jsonObj["MediaPath"].toString();
    }
    if (jsonObj.containsKey("MediaContent")) {
      noteMedia.mediaContent = jsonObj["MediaContent"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      noteMedia.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("Tags")) {
      noteMedia.tags = jsonObj["Tags"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      noteMedia.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      noteMedia.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      noteMedia.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      noteMedia.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      noteMedia.deviceIdentifier = jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      noteMedia.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      noteMedia.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      noteMedia.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      noteMedia.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      noteMedia.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      noteMedia.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      noteMedia.isDeleted = jsonObj["IsDeleted"].toString();
    }

    noteMedia.isDirty = "false";
    noteMedia.isDeleted1 = "false";
    noteMedia.upSyncMessage = "";
    noteMedia.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      noteMedia.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      noteMedia.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      noteMedia.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      noteMedia.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    noteMedia.upSyncIndex = "0";
    noteMedia.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToNoteMedia()", ex);
  }
  return noteMedia;
}

NotePermission copyJsonDataToNotePermission(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, NotePermission notePermission, bool isForNew) {
  try {
    if (jsonObj.containsKey("NotePermissionID")) {
      notePermission.notePermissionID = jsonObj["NotePermissionID"].toString();
    }
    if (jsonObj.containsKey("NotePermissionCode")) {
      notePermission.notePermissionCode = jsonObj["NotePermissionCode"].toString();
    }

    if (jsonObj.containsKey("NoteID")) {
      String noteId = jsonObj["NoteID"].toString();
      noteId = (noteId != null && noteId.isNotEmpty) ? noteId : "-1";
      Note note = NoteDataHandler.getMasterNoteRecord(dbHandler,  noteId);
      if (note != null) {
        notePermission.noteID = note.id;
      }
    }

    if (jsonObj.containsKey("AppUserID")) {
      notePermission.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("PermissionLevel")) {
      notePermission.permissionLevel = jsonObj["PermissionLevel"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      notePermission.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      notePermission.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notePermission.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      notePermission.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      notePermission.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      notePermission.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      notePermission.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      notePermission.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      notePermission.isDeleted = jsonObj["IsDeleted"].toString();
    }

    notePermission.isDirty = "false";
    notePermission.isDeleted1 = "false";
    notePermission.upSyncMessage = "";
    notePermission.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      notePermission.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notePermission.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      notePermission.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      notePermission.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    notePermission.upSyncIndex = "0";
    /*if (jsonObj.has("AppUserID"))
        notePermission.setOwnerUserID(jsonObj.optString("AppUserID"));*/
    notePermission.ownerUserID = Globals.appUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToNotePermission()", ex);
  }
  return notePermission;
}

Notification copyJsonDataToNotification(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, Notification notification, bool isForNew) {
  try {
    if (jsonObj.containsKey("NotificationID")) {
      notification.notificationID = jsonObj["NotificationID"].toString();
    }
    if (jsonObj.containsKey("NotificationCode")) {
      notification.notificationCode = jsonObj["NotificationCode"].toString();
    }
    if (jsonObj.containsKey("NotificationTitle")) {
      notification.notificationTitle = jsonObj["NotificationTitle"].toString();
    }
    if (jsonObj.containsKey("NotificationDetails")) {
      notification.notificationDetails = jsonObj["NotificationDetails"].toString();
    }
    if (jsonObj.containsKey("NotificationDate")) {
      notification.notificationDate = jsonObj["NotificationDate"].toString();
    }
    if (jsonObj.containsKey("SendToAll")) {
      notification.sendToAll = jsonObj["SendToAll"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      notification.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      notification.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      notification.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notification.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      notification.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      notification.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      notification.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      notification.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      notification.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      notification.isDeleted = jsonObj["IsDeleted"].toString();
    }

    notification.isDirty = "false";
    notification.isDeleted1 = "false";
    notification.upSyncMessage = "";
    notification.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      notification.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notification.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      notification.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      notification.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    notification.upSyncIndex = "0";
    /*if (jsonObj.has("AppUserID"))
        notification.setOwnerUserID(jsonObj.optString("AppUserID"));*/
    notification.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToNotification()", ex);
  }
  return notification;
}

NotificationAssignment copyJsonDataToNotificationAssignment(  DatabaseHandler dbHandler, Map<String, dynamic> jsonObj, NotificationAssignment notificationAssignment, bool isForNew) {
  try {
    if (jsonObj.containsKey("NotificationAssignmentID")) {
      notificationAssignment.notificationAssignmentID = jsonObj["NotificationAssignmentID"].toString();
    }
    if (jsonObj.containsKey("NotificationAssignmentCode")) {
      notificationAssignment.notificationAssignmentCode = jsonObj["NotificationAssignmentCode"].toString();
    }
    if (jsonObj.containsKey("NotificationAssignmentTitle")) {
      notificationAssignment.notificationAssignmentTitle = jsonObj["NotificationAssignmentTitle"].toString();
    }

    if (jsonObj.containsKey("NotificationID")) {
      String notificationId = jsonObj["NotificationID"].toString();
      notificationId = (notificationId != null && notificationId.isNotEmpty) ? notificationId : "-1";
      Notification notification = NotificationDataHandler.getMasterNotificationRecord(dbHandler,  notificationId);
      if (notification != null) {
        notificationAssignment.notificationID = notification.id;
      }
    }

    if (jsonObj.containsKey("AppUserID")) {
      notificationAssignment.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      notificationAssignment.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      notificationAssignment.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      notificationAssignment.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notificationAssignment.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      notificationAssignment.deviceIdentifier = jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      notificationAssignment.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("Location")) {
      notificationAssignment.location = jsonObj["Location"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      notificationAssignment.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      notificationAssignment.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      notificationAssignment.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      notificationAssignment.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      notificationAssignment.isDeleted = jsonObj["IsDeleted"].toString();
    }

    notificationAssignment.isDirty = "false";
    notificationAssignment.isDeleted1 = "false";
    notificationAssignment.upSyncMessage = "";
    notificationAssignment.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      notificationAssignment.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      notificationAssignment.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      notificationAssignment.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      notificationAssignment.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    notificationAssignment.upSyncIndex = "0";
    /*if (jsonObj.has("AppUserID"))
        notificationAssignment.setOwnerUserID(jsonObj.optString("AppUserID"));*/
    notificationAssignment.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToNotificationAssignment()", ex);
  }
  return notificationAssignment;
}

Future<Opportunity> copyJsonDataToOpportunity(
  DatabaseHandler dbHandler,
  dynamic jsonObj,
  Opportunity opportunity,
  bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("OpportunityID")) {
      opportunity.opportunityID = jsonObj["OpportunityID"].toString();
    }
    if (jsonObj.containsKey("OpportunityCode")) {
      opportunity.opportunityCode = jsonObj["OpportunityCode"].toString();
    }
    if (jsonObj.containsKey("OpportunityName")) {
      opportunity.opportunityName = jsonObj["OpportunityName"].toString();
    }
    if (jsonObj.containsKey("AssignmentDetails")) {
      opportunity.assignmentDetails =
          Utility.getEmptyIfNull(jsonObj["AssignmentDetails"].toString());
    }
    if (jsonObj.containsKey("OpportunityDetail")) {
      opportunity.opportunityDetail =
          jsonObj["OpportunityDetail"].toString();
    }
    if (jsonObj.containsKey("LeadSource")) {
      opportunity.leadSource = jsonObj["LeadSource"].toString();
    }

    if (jsonObj.containsKey("OpportunityTypeID")) {
      String opportunityTypeId = jsonObj["OpportunityTypeID"].toString();
      opportunityTypeId = opportunityTypeId.isNotEmpty ? opportunityTypeId : "-1";
      OpportunityType? opportunityType =
          await OpportunityTypeDataHandlerBase.GetMasterOpportunityTypeRecord(
              dbHandler, opportunityTypeId);
      if (opportunityType != null) {
        opportunity.opportunityTypeID = opportunityType.id;
      }
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId.isNotEmpty ? accountId : "-1";
      Account ?account = await AccountDataHandlerBaseBase.GetMasterAccountRecord(
          dbHandler, accountId);
      if (account != null) {
        opportunity.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ContactID")) {
  String contactId = jsonObj["ContactID"].toString();
  contactId = contactId.isNotEmpty ? contactId : "-1";
  Contact? contact = await ContactHandlerDataBase.GetMasterContactRecord(
      dbHandler, contactId);
  if (contact != null) {
    opportunity.contactID = contact.id;
  }
}

if (jsonObj.containsKey("OpportunityMeasure")) {
  opportunity.opportunityMeasure = jsonObj["OpportunityMeasure"].toString();
}

String bigValue = jsonObj["OpportunityValue"].toString();
String opportunityValue = bigValue;
if (bigValue.contains("E")) {
  BigInt bi = BigInt.parse(bigValue);
  opportunityValue = bi.toInt().toString();
}
opportunity.opportunityValue = opportunityValue;

if (jsonObj.containsKey("CurrencyID")) {
  String currencyId = jsonObj["CurrencyID"].toString();
  currencyId = currencyId.isNotEmpty ? currencyId : "-1";
  Currency? currency = await CurrencyDataHandlerBase.GetMasterCurrencyRecord(
      dbHandler, currencyId);
  if (currency != null) {
    opportunity.currencyID = currency.id;
  }
}

bigValue = jsonObj["GrossProfit"].toString();
String grossProfit = bigValue;
if (grossProfit.contains("E")) {
  BigInt bi = BigInt.parse(bigValue);
  grossProfit = bi.toInt().toString();
}
opportunity.grossProfit = grossProfit;

if (jsonObj.containsKey("DealRegistrationNumber")) {
  opportunity.dealRegistrationNumber =
      jsonObj["DealRegistrationNumber"].toString();
}
if (jsonObj.containsKey("ClosureDate")) {
  opportunity.closureDate = jsonObj["ClosureDate"].toString();
}
if (jsonObj.containsKey("Probability")) {
  opportunity.probability = jsonObj["Probability"].toString();
}

if (jsonObj.containsKey("OpportunityPriorityID")) {
  String opportunityPriorityId = jsonObj["OpportunityPriorityID"].toString();
  opportunityPriorityId =
      opportunityPriorityId.isNotEmpty ? opportunityPriorityId : "-1";
  OpportunityPriority ?opportunityPriority =
      await OpportunityPriorityDataHandlerBase.GetMasterOpportunityPriorityRecord(
          dbHandler, opportunityPriorityId);
  if (opportunityPriority != null) {
    opportunity.opportunityPriorityID = opportunityPriority.id;
  }
}
if (jsonObj.containsKey("OpportunityStageID")) {
  String opportunityStageId = jsonObj["OpportunityStageID"].toString();
  opportunityStageId =
      opportunityStageId.isNotEmpty ? opportunityStageId : "-1";
  OpportunityStage opportunityStage =
      await OpportunityStageDataHandler.GetMasterOpportunityStageRecord(
          dbHandler,  opportunityStageId);
  if (opportunityStage != null) {
    opportunity.opportunityStageID = opportunityStage.id;
  }
}

if (jsonObj.containsKey("OpportunityStatusID")) {
  String opportunityStatusId = jsonObj["OpportunityStatusID"].toString();
  opportunityStatusId =
      opportunityStatusId.isNotEmpty ? opportunityStatusId : "-1";
  OpportunityStatus opportunityStatus =
      await OpportunityStatusDataHandler.GetMasterOpportunityStatusRecord(
          dbHandler,  opportunityStatusId);
  if (opportunityStatus != null) {
    opportunity.opportunityStatusID = opportunityStatus.id;
  }
}

if (jsonObj.containsKey("ActualOpportunityValue")) {
  opportunity.actualOpportunityValue =
      jsonObj["ActualOpportunityValue"].toString();
}

if (jsonObj.containsKey("LostToCompetitor")) {
  opportunity.lostToCompetitor = jsonObj["LostToCompetitor"].toString();
}
if (jsonObj.containsKey("ReasonForOpportunityStatus")) {
  opportunity.reasonForOpportunityStatus =
      jsonObj["ReasonForOpportunityStatus"].toString();
}

if (jsonObj.containsKey("PlannedDeliveryDate")) {
  opportunity.plannedDeliveryDate =
      jsonObj["PlannedDeliveryDate"].toString();
}
if (jsonObj.containsKey("ActualDeliveryDate")) {
  opportunity.actualDeliveryDate =
      jsonObj["ActualDeliveryDate"].toString();
}
if (jsonObj.containsKey("CurrentActionOwner")) {
  opportunity.currentActionOwner =
      jsonObj["CurrentActionOwner"].toString();
}
if (jsonObj.containsKey("CustomerCallID")) {
  opportunity.customerCallID = jsonObj["CustomerCallID"].toString();
}
if (jsonObj.containsKey("CustomerSatisfactionID")) {
  opportunity.customerSatisfactionID =
      jsonObj["CustomerSatisfactionID"].toString();
}
if (jsonObj.containsKey("ReferenceIdentifier")) {
  opportunity.referenceIdentifier =
      jsonObj["ReferenceIdentifier"].toString();
}

if (jsonObj.containsKey("OpportunityIdentifier")) {
  opportunity.opportunityIdentifier =
      jsonObj["OpportunityIdentifier"].toString();
}
if (jsonObj.containsKey("PurchaseOrderNumber")) {
  opportunity.purchaseOrderNumber =
      jsonObj["PurchaseOrderNumber"].toString();
}
if (jsonObj.containsKey("QuotationNumber")) {
  opportunity.quotationNumber = jsonObj["QuotationNumber"].toString();
}
if (jsonObj.containsKey("IsFinanceRequired")) {
  opportunity.isFinanceRequired = jsonObj["IsFinanceRequired"].toString();
}
if (jsonObj.containsKey("FinanceBy")) {
  opportunity.financeBy = jsonObj["FinanceBy"].toString();
}
if (jsonObj.containsKey("FinanceRemarks")) {
  opportunity.financeRemarks = jsonObj["FinanceRemarks"].toString();
}
if (jsonObj.containsKey("IsApprovalRequired")) {
  opportunity.isApprovalRequired =
      jsonObj["IsApprovalRequired"].toString();
}

if (jsonObj.containsKey("ParentOpportunityID")) {
  String opportunityId = jsonObj["ParentOpportunityID"].toString();
  opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";
  Opportunity? opportunity1 = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(
      dbHandler,  opportunityId);
  if (opportunity1 != null) {
    opportunity.parentOpportunityID = opportunity1.id;
  }
}

if (jsonObj.containsKey("IsRecurringOpportunity")) {
  opportunity.isRecurringOpportunity =
      jsonObj["IsRecurringOpportunity"].toString();
}
if (jsonObj.containsKey("RecurrenceIntervalInDays")) {
  opportunity.recurrenceIntervalInDays =
      jsonObj["RecurrenceIntervalInDays"].toString();
}
if (jsonObj.containsKey("RecurrenceCount")) {
  opportunity.recurrenceCount = jsonObj["RecurrenceCount"].toString();
}

if (jsonObj.containsKey("RecurringOpportunityID")) {
  String opportunityId = jsonObj["RecurringOpportunityID"].toString();
  opportunityId = opportunityId.isNotEmpty ? opportunityId : "-1";
  Opportunity? opportunity2 = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(
      dbHandler,  opportunityId);
  if (opportunity2 != null) {
    opportunity.recurringOpportunityID = opportunity2.id;
  }
}

if (jsonObj.containsKey("DateGeneratedForRecurring")) {
  opportunity.dateGeneratedForRecurring =
      jsonObj["DateGeneratedForRecurring"].toString();
}
if (jsonObj.containsKey("OpportunityAssignmentID")) {
  opportunity.opportunityAssignmentID =
      jsonObj["OpportunityAssignmentID"].toString();
}

if (jsonObj.containsKey("SupplierAccountID")) {
  String accountId = jsonObj["SupplierAccountID"].toString();
  accountId = accountId.isNotEmpty ? accountId : "-1";
  Account ?account1 = await AccountDataHandlerBase.GetMasterAccountRecord(
      dbHandler,  accountId);
  if (account1 != null) {
    opportunity.supplierAccountID = account1.id;
  }
}

if (jsonObj.containsKey("OpportunityCodeInternal")) {
  opportunity.opportunityCodeInternal =
      jsonObj["OpportunityCodeInternal"].toString();
}

if (jsonObj.containsKey("Tags")) {
  opportunity.tags = jsonObj["Tags"].toString();
}
if (jsonObj.containsKey("FreeTextField1")) {
  opportunity.freeTextField1 = jsonObj["FreeTextField1"].toString();
}
if (jsonObj.containsKey("FreeTextField2")) {
  opportunity.freeTextField2 = jsonObj["FreeTextField2"].toString();
}
if (jsonObj.containsKey("FreeTextField3")) {
  opportunity.freeTextField3 = jsonObj["FreeTextField3"].toString();
}
if (jsonObj.containsKey("IsAssigned")) {
  opportunity.isAssigned = jsonObj["IsAssigned"].toString();
}
if (jsonObj.containsKey("AssignedDate")) {
  opportunity.assignedDate = jsonObj["AssignedDate"].toString();
}
if (jsonObj.containsKey("AssignedByAppUserID")) {
  opportunity.assignedByAppUserID =
      jsonObj["AssignedByAppUserID"].toString();
}
if (jsonObj.containsKey("AssignmentRemarks")) {
  opportunity.assignmentRemarks =
      jsonObj["AssignmentRemarks"].toString();
}
if (jsonObj.containsKey("OpportunityFulfillmentStatus")) {
  opportunity.opportunityFulfillmentStatus =
      jsonObj["OpportunityFulfillmentStatus"].toString();
}
if (jsonObj.containsKey("IsOpportunityFulfilled")) {
  opportunity.isOpportunityFulfilled =
      jsonObj["IsOpportunityFulfilled"].toString();
}
if (jsonObj.containsKey("CreatedBy")) {
  opportunity.createdBy = jsonObj["CreatedBy"].toString();
}
if (jsonObj.containsKey("CreatedOn")) {
  opportunity.createdOn = jsonObj["CreatedOn"].toString();
}
if (jsonObj.containsKey("ModifiedBy")) {
  opportunity.modifiedBy = jsonObj["ModifiedBy"].toString();
}
if (jsonObj.containsKey("ModifiedOn")) {
  opportunity.modifiedOn = jsonObj["ModifiedOn"].toString();
}
if (jsonObj.containsKey("IsWonAlerted")) {
  opportunity.isWonAlerted = jsonObj["IsWonAlerted"].toString();
}
if (jsonObj.containsKey("IsNewAlerted")) {
  opportunity.isNewAlerted = jsonObj["IsNewAlerted"].toString();
}
if (jsonObj.containsKey("IsActive")) {
  opportunity.isActive = jsonObj["IsActive"].toString();
}
if (jsonObj.containsKey("IsLocked")) {
  opportunity.isLocked = jsonObj["IsLocked"].toString();
}
if (jsonObj.containsKey("IsApproved")) {
  opportunity.isApproved = jsonObj["IsApproved"].toString();
}
if (jsonObj.containsKey("Uid")) {
  opportunity.uid = jsonObj["Uid"].toString();
}
if (jsonObj.containsKey("AppUserID")) {
  opportunity.appUserID = jsonObj["AppUserID"].toString();
}
if (jsonObj.containsKey("AppUserGroupID")) {
  opportunity.appUserGroupID = jsonObj["AppUserGroupID"].toString();
}
if (jsonObj.containsKey("IsArchived")) {
  opportunity.isArchived = jsonObj["IsArchived"].toString();
}
if (jsonObj.containsKey("IsDeleted")) {
  opportunity.isDeleted = jsonObj["IsDeleted"].toString();
}
if (jsonObj.containsKey("LeadQualificationID")) {
  opportunity.leadQualificationID =
      jsonObj["LeadQualificationID"].toString();
}
if (jsonObj.containsKey("WorkFlowDetails")) {
  opportunity.workFlowDetails =
      Utility.getEmptyIfNull(jsonObj["WorkFlowDetails"].toString());
}
if (jsonObj.containsKey("RequestedDeliveryDate")) {
  opportunity.requestedDeliveryDate =
      jsonObj["RequestedDeliveryDate"].toString();
}
if (jsonObj.containsKey("PlannedDeliveryDate")) {
  opportunity.plannedDeliveryDate =
      jsonObj["PlannedDeliveryDate"].toString();
}
if (jsonObj.containsKey("ActualDeliveryDate")) {
  opportunity.actualDeliveryDate =
      jsonObj["ActualDeliveryDate"].toString();
}
opportunity.isDirty = "false";
opportunity.isDeleted1 = "false";
opportunity.upSyncMessage = "";
opportunity.downSyncMessage = "";
if (jsonObj.containsKey("CreatedOn")) {
  opportunity.sCreatedOn = jsonObj["CreatedOn"].toString();
}
if (jsonObj.containsKey("ModifiedOn")) {
  opportunity.sModifiedOn = jsonObj["ModifiedOn"].toString();
}
if (jsonObj.containsKey("CreatedByUser")) {
  opportunity.createdByUser = jsonObj["CreatedByUser"].toString();
}
if (jsonObj.containsKey("ModifiedByUser")) {
  opportunity.modifiedByUser = jsonObj["ModifiedByUser"].toString();
}
opportunity.upSyncIndex = "0";
/*if (jsonObj.has("AppUserID"))
  opportunity.ownerUserID = jsonObj.optString("AppUserID");*/
opportunity.ownerUserID = Globals.AppUserID.toString();




  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToOpportunity()", ex);
  }
  return opportunity;
}


Future<OpportunityApproval> copyJsonDataToOpportunityApproval(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityApproval opportunityApproval,
    bool isForNew,
  ) async {
    try {
      if (jsonObj.containsKey("OpportunityApprovalID")) {
        opportunityApproval.opportunityApprovalID = jsonObj["OpportunityApprovalID"];
      }
      if (jsonObj.containsKey("OpportunityApprovalCode")) {
        opportunityApproval.opportunityApprovalCode = jsonObj["OpportunityApprovalCode"];
      }
      if (jsonObj.containsKey("OpportunityApprovalTitle")) {
        opportunityApproval.opportunityApprovalTitle = jsonObj["OpportunityApprovalTitle"];
      }

      if (jsonObj.containsKey("OpportunityApprovalTypeID")) {
        String opportunityApprovalTypeId = jsonObj["OpportunityApprovalTypeID"];
        opportunityApprovalTypeId = opportunityApprovalTypeId != null && opportunityApprovalTypeId != "" ? opportunityApprovalTypeId : "-1";
        OpportunityApprovalType ?opportunityApprovalType = await  OpportunityApprovalTypeDataHandlerBase.GetMasterOpportunityApprovalTypeRecord(dbHandler, opportunityApprovalTypeId);
        if (opportunityApprovalType != null) {
          opportunityApproval.opportunityApprovalTypeID = opportunityApprovalType.id;
        }
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
        Opportunity? opportunity = await  OpportunityDataHandlerBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
        if (opportunity != null) {
          opportunityApproval.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("RequestDate")) {
        opportunityApproval.requestDate = jsonObj["RequestDate"];
      }
      if (jsonObj.containsKey("RequestDetail")) {
        opportunityApproval.requestDetail = jsonObj["RequestDetail"];
      }
      if (jsonObj.containsKey("IsSubmitted")) {
        opportunityApproval.isSubmitted = jsonObj["IsSubmitted"];
      }

      if (jsonObj.containsKey("ParentOpportunityApprovalID")) {
        String opportunityApprovalId = jsonObj["ParentOpportunityApprovalID"];
        opportunityApprovalId = opportunityApprovalId != null && opportunityApprovalId != "" ? opportunityApprovalId : "-1";
        OpportunityApproval? opportunityApproval1 = await OpportunityApprovalDataHandlerBase.GetMasterOpportunityApprovalRecord(dbHandler, opportunityApprovalId);
        if (opportunityApproval1 != null) {
          opportunityApproval.parentOpportunityApprovalID = opportunityApproval1.id;
        }
      }

      if (jsonObj.containsKey("ApprovalStatus")) {
        opportunityApproval.approvalStatus = jsonObj["ApprovalStatus"];
      }
      if (jsonObj.containsKey("ApprovalByAppUserID")) {
        opportunityApproval.approvalByAppUserID = jsonObj["ApprovalByAppUserID"];
      }
      if (jsonObj.containsKey("ApprovalTime")) {
        opportunityApproval.approvalTime = jsonObj["ApprovalTime"];
      }
      if (jsonObj.containsKey("ApproverRemarks")) {
        opportunityApproval.approverRemarks = jsonObj["ApproverRemarks"];
      }
      if (jsonObj.containsKey("IsApprovalCompleted")) {
        opportunityApproval.isApprovalCompleted = jsonObj["IsApprovalCompleted"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityApproval.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityApproval.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityApproval.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityApproval.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("DeviceIdentifier")) {
        opportunityApproval.deviceIdentifier = jsonObj["DeviceIdentifier"];
      }
      if (jsonObj.containsKey("ReferenceIdentifier")) {
        opportunityApproval.referenceIdentifier = jsonObj["ReferenceIdentifier"];
      }
      if (jsonObj.containsKey("Location")) {
        opportunityApproval.location = jsonObj["Location"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityApproval.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityApproval.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityApproval.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityApproval.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityApproval.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityApproval.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityApproval.isDirty = "false";
      opportunityApproval.isDeleted1 = "false";
      opportunityApproval.upSyncMessage = "";
      opportunityApproval.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityApproval.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityApproval.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityApproval.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityApproval.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityApproval.upSyncIndex = "0";
      opportunityApproval.ownerUserID = Globals.appUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityApproval()", ex);
    }
    return opportunityApproval;
  }
OpportunityApprovalType copyJsonDataToOpportunityApprovalType(
     
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityApprovalType opportunityApprovalType,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityApprovalTypeID")) {
        opportunityApprovalType.opportunityApprovalTypeID = jsonObj["OpportunityApprovalTypeID"];
      }
      if (jsonObj.containsKey("OpportunityApprovalTypeCode")) {
        opportunityApprovalType.opportunityApprovalTypeCode = jsonObj["OpportunityApprovalTypeCode"];
      }
      if (jsonObj.containsKey("OpportunityApprovalTypeName")) {
        opportunityApprovalType.opportunityApprovalTypeName = jsonObj["OpportunityApprovalTypeName"];
      }
      if (jsonObj.containsKey("Description")) {
        opportunityApprovalType.description = jsonObj["Description"];
      }

      if (jsonObj.containsKey("OpportunityTypeID")) {
        String opportunityTypeId = jsonObj["OpportunityTypeID"];
        opportunityTypeId = opportunityTypeId != null && opportunityTypeId != "" ? opportunityTypeId : "-1";
        OpportunityType opportunityType = OpportunityTypeDataHandlerBase.getMasterOpportunityTypeRecord(dbHandler,  opportunityTypeId);
        if (opportunityType != null) {
          opportunityApprovalType.opportunityTypeID = opportunityType.id;
        }
      }

      if (jsonObj.containsKey("InternalCode")) {
        opportunityApprovalType.internalCode = jsonObj["InternalCode"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityApprovalType.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityApprovalType.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityApprovalType.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityApprovalType.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityApprovalType.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityApprovalType.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityApprovalType.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityApprovalType.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityApprovalType.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityApprovalType.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityApprovalType.isDirty = "false";
      opportunityApprovalType.isDeleted1 = "false";
      opportunityApprovalType.upSyncMessage = "";
      opportunityApprovalType.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityApprovalType.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityApprovalType.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityApprovalType.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityApprovalType.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityApprovalType.upSyncIndex = "0";
      opportunityApprovalType.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityApprovalType()", ex);
    }
    return opportunityApprovalType;
  }

Future<OpportunityBusinessUnit> copyJsonDataToOpportunityBusinessUnit(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityBusinessUnit opportunityBusinessUnit,
    bool isForNew,
  ) async {
    try {
      if (jsonObj.containsKey("OpportunityBusinessUnitID")) {
        opportunityBusinessUnit.opportunityBusinessUnitID = jsonObj["OpportunityBusinessUnitID"];
      }
      if (jsonObj.containsKey("OpportunityBusinessUnitCode")) {
        opportunityBusinessUnit.opportunityBusinessUnitCode = jsonObj["OpportunityBusinessUnitCode"];
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
        Opportunity? opportunity = await  OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandle, opportunityId);
        if (opportunity != null) {
          opportunityBusinessUnit.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("BusinessUnitID")) {
        String businessUnitId = jsonObj["BusinessUnitID"];
        businessUnitId = businessUnitId != null && businessUnitId != "" ? businessUnitId : "-1";
        BusinessUnit? businessUnit =await  BusinessUnitDataHandlerBaseBase.GetMasterBusinessUnitRecord(dbHandler, businessUnitId);
        if (businessUnit != null) {
          opportunityBusinessUnit.businessUnitID = businessUnit.id;
        }
      }

      if (jsonObj.containsKey("CreatedBy")) {
        opportunityBusinessUnit.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityBusinessUnit.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityBusinessUnit.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityBusinessUnit.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityBusinessUnit.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityBusinessUnit.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityBusinessUnit.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityBusinessUnit.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("ReferenceIdentifier")) {
        opportunityBusinessUnit.referenceIdentifier = jsonObj["ReferenceIdentifier"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityBusinessUnit.isDeleted = jsonObj["IsDeleted"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityBusinessUnit.isArchived = jsonObj["IsArchived"];
      }

      opportunityBusinessUnit.isDirty = "false";
      opportunityBusinessUnit.isDeleted1 = "false";
      opportunityBusinessUnit.upSyncMessage = "";
      opportunityBusinessUnit.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityBusinessUnit.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityBusinessUnit.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityBusinessUnit.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityBusinessUnit.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityBusinessUnit.upSyncIndex = "0";
      opportunityBusinessUnit.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityBusinessUnit()", ex);
    }
    return opportunityBusinessUnit;
  }

  Future<OpportunityContact> copyJsonDataToOpportunityContact(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityContact opportunityContact,
    bool isForNew,
  ) async {
    try {
      if (jsonObj.containsKey("OpportunityContactID")) {
        opportunityContact.opportunityContactID = jsonObj["OpportunityContactID"];
      }
      if (jsonObj.containsKey("OpportunityContactCode")) {
        opportunityContact.opportunityContactCode = jsonObj["OpportunityContactCode"];
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
        Opportunity? opportunity = await  OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
        if (opportunity != null) {
          opportunityContact.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("ContactID")) {
        String contactId = jsonObj["ContactID"];
        contactId = contactId != null && contactId != "" ? contactId : "-1";
        Contact? contact =await  ContactHandlerDataBase.GetMasterContactRecord(dbHandler, contactId);
        if (contact != null) {
          opportunityContact.contactID = contact.id;
        }
      }

      if (jsonObj.containsKey("ContactName")) {
        opportunityContact.contactName = jsonObj["ContactName"];
      }
      if (jsonObj.containsKey("Description")) {
        opportunityContact.description = jsonObj["Description"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityContact.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityContact.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityContact.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityContact.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityContact.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityContact.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityContact.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityContact.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityContact.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityContact.isDeleted = jsonObj["IsDeleted"];
      }
      if (jsonObj.containsKey("ReferenceIdentifier")) {
        opportunityContact.referenceIdentifier = jsonObj["ReferenceIdentifier"];
      }

      opportunityContact.isDirty = "false";
      opportunityContact.isDeleted1 = "false";
      opportunityContact.upSyncMessage = "";
      opportunityContact.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityContact.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityContact.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityContact.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityContact.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityContact.upSyncIndex = "0";
      opportunityContact.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityContact()", ex);
    }
    return opportunityContact;
  }
Future<OpportunityFulfillmentStatus> copyJsonDataToOpportunityFulfillmentStatus(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityFulfillmentStatus opportunityFulfillmentStatus,
    bool isForNew,
  ) async {
    try {
      if (jsonObj.containsKey("OpportunityFulfillmentStatusID")) {
        opportunityFulfillmentStatus.opportunityFulfillmentStatusID = jsonObj["OpportunityFulfillmentStatusID"];
      }
      if (jsonObj.containsKey("OpportunityFulfillmentStatusCode")) {
        opportunityFulfillmentStatus.opportunityFulfillmentStatusCode = jsonObj["OpportunityFulfillmentStatusCode"];
      }
      if (jsonObj.containsKey("OpportunityFulfillmentStatusName")) {
        opportunityFulfillmentStatus.opportunityFulfillmentStatusName = jsonObj["OpportunityFulfillmentStatusName"];
      }
      if (jsonObj.containsKey("SequentialOrder")) {
        opportunityFulfillmentStatus.sequentialOrder = jsonObj["SequentialOrder"];
      }
      if (jsonObj.containsKey("Indicator")) {
        opportunityFulfillmentStatus.indicator = jsonObj["Indicator"];
      }
      if (jsonObj.containsKey("InternalCode")) {
        opportunityFulfillmentStatus.internalCode = jsonObj["InternalCode"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityFulfillmentStatus.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityFulfillmentStatus.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityFulfillmentStatus.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityFulfillmentStatus.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityFulfillmentStatus.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityFulfillmentStatus.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityFulfillmentStatus.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityFulfillmentStatus.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityFulfillmentStatus.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityFulfillmentStatus.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityFulfillmentStatus.isDirty = "false";
      opportunityFulfillmentStatus.isDeleted1 = "false";
      opportunityFulfillmentStatus.upSyncMessage = "";
      opportunityFulfillmentStatus.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityFulfillmentStatus.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityFulfillmentStatus.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityFulfillmentStatus.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityFulfillmentStatus.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityFulfillmentStatus.upSyncIndex = "0";
      /*if (jsonObj.containsKey("AppUserID"))
          opportunityFulfillmentStatus.ownerUserID = jsonObj["AppUserID"];*/
      opportunityFulfillmentStatus.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityFulfillmentStatus()", ex);
    }
    return opportunityFulfillmentStatus;
  }

OpportunityMeasure copyJsonDataToOpportunityMeasure(
     
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityMeasure opportunityMeasure,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityMeasureID")) {
        opportunityMeasure.opportunityMeasureID = jsonObj["OpportunityMeasureID"];
      }
      if (jsonObj.containsKey("OpportunityMeasureCode")) {
        opportunityMeasure.opportunityMeasureCode = jsonObj["OpportunityMeasureCode"];
      }
      if (jsonObj.containsKey("OpportunityMeasureName")) {
        opportunityMeasure.opportunityMeasureName = jsonObj["OpportunityMeasureName"];
      }
      if (jsonObj.containsKey("InternalCode")) {
        opportunityMeasure.internalCode = jsonObj["InternalCode"];
      }
      if (jsonObj.containsKey("IsDefault")) {
        opportunityMeasure.isDefault = jsonObj["IsDefault"];
      }
      if (jsonObj.containsKey("SequentialOrder")) {
        opportunityMeasure.sequentialOrder = jsonObj["SequentialOrder"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityMeasure.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityMeasure.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityMeasure.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityMeasure.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityMeasure.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityMeasure.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityMeasure.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityMeasure.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityMeasure.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityMeasure.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityMeasure.isDirty = "false";
      opportunityMeasure.isDeleted1 = "false";
      opportunityMeasure.upSyncMessage = "";
      opportunityMeasure.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityMeasure.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityMeasure.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityMeasure.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityMeasure.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityMeasure.upSyncIndex = "0";
      opportunityMeasure.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityMeasure()", ex);
    }
    return opportunityMeasure;
  }
Future<OpportunityMedia> copyJsonDataToOpportunityMedia(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityMedia opportunityMedia,
    bool isForNew,
  ) async {
    try {
      if (jsonObj.containsKey("OpportunityMediaID")) {
        opportunityMedia.opportunityMediaID = jsonObj["OpportunityMediaID"];
      }
      if (jsonObj.containsKey("OpportunityMediaCode")) {
        opportunityMedia.opportunityMediaCode = jsonObj["OpportunityMediaCode"];
      }
      if (jsonObj.containsKey("OpportunityMediaName")) {
        opportunityMedia.opportunityMediaName = jsonObj["OpportunityMediaName"];
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
        Opportunity ?opportunity =  await OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
        if (opportunity != null) {
          opportunityMedia.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("ContentTypeID")) {
        String contentTypeId = jsonObj["ContentTypeID"];
        contentTypeId = contentTypeId != null && contentTypeId != "" ? contentTypeId : "-1";
        ContentType contentType = ContentTypeDataHandlerBaseBase.getMasterContentTypeRecord(dbHandler,  contentTypeId);
        if (contentType != null) {
          opportunityMedia.contentTypeID = contentType.id;
        }
      }

      if (jsonObj.containsKey("MediaPath")) {
        opportunityMedia.mediaPath = jsonObj["MediaPath"];
      }
      if (jsonObj.containsKey("MediaContent")) {
        opportunityMedia.mediaContent = jsonObj["MediaContent"];
      }
      if (jsonObj.containsKey("Description")) {
        opportunityMedia.description = jsonObj["Description"];
      }
      if (jsonObj.containsKey("Tags")) {
        opportunityMedia.tags = jsonObj["Tags"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityMedia.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityMedia.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityMedia.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityMedia.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityMedia.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityMedia.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityMedia.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityMedia.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityMedia.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityMedia.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityMedia.isDirty = "false";
      opportunityMedia.isDeleted1 = "false";
      opportunityMedia.upSyncMessage = "";
      opportunityMedia.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityMedia.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityMedia.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityMedia.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityMedia.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityMedia.upSyncIndex = "0";
      opportunityMedia.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityMedia()", ex);
    }
    return opportunityMedia;
  }


OpportunityName copyJsonDataToOpportunityName(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityName opportunityName,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityNameID")) {
        opportunityName.opportunityNameID = jsonObj["OpportunityNameID"];
      }
      if (jsonObj.containsKey("OpportunityNameCode")) {
        opportunityName.opportunityNameCode = jsonObj["OpportunityNameCode"];
      }
      if (jsonObj.containsKey("OpportunityNameEntry")) {
        opportunityName.opportunityNameEntry = jsonObj["OpportunityNameEntry"];
      }
      if (jsonObj.containsKey("Description")) {
        opportunityName.description = jsonObj["Description"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityName.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityName.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityName.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityName.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityName.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityName.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityName.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityName.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("ReferenceIdentifier")) {
        opportunityName.referenceIdentifier = jsonObj["ReferenceIdentifier"];
      }

      opportunityName.isDirty = "false";
      opportunityName.isDeleted1 = "false";
      opportunityName.upSyncMessage = "";
      opportunityName.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityName.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityName.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityName.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityName.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityName.upSyncIndex = "0";
      opportunityName.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityName()", ex);
    }
    return opportunityName;
  }

  OpportunityPermission copyJsonDataToOpportunityPermission(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityPermission opportunityPermission,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityPermissionID")) {
        opportunityPermission.opportunityPermissionID = jsonObj["OpportunityPermissionID"];
      }
      if (jsonObj.containsKey("OpportunityPermissionCode")) {
        opportunityPermission.opportunityPermissionCode = jsonObj["OpportunityPermissionCode"];
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId.isNotEmpty ? opportunityId : "-1";
        Opportunity? opportunity = await  OpportunityApprovalDataHandlerBase.GetMasterOpportunityApprovalRecord(dbHandler, opportunityId);
        if (opportunity != null) {
          opportunityPermission.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("AppUserID")) {
        opportunityPermission.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("PermissionLevel")) {
        opportunityPermission.permissionLevel = jsonObj["PermissionLevel"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityPermission.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityPermission.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityPermission.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityPermission.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityPermission.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityPermission.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityPermission.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityPermission.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityPermission.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityPermission.isDirty = "false";
      opportunityPermission.isDeleted1 = "false";
      opportunityPermission.upSyncMessage = "";
      opportunityPermission.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityPermission.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityPermission.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityPermission.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityPermission.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityPermission.upSyncIndex = "0";
      opportunityPermission.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityPermission()", ex);
    }
    return opportunityPermission;
  }

  OpportunityPriority copyJsonDataToOpportunityPriority(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityPriority opportunityPriority,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityPriorityID")) {
        opportunityPriority.opportunityPriorityID = jsonObj["OpportunityPriorityID"];
      }
      if (jsonObj.containsKey("OpportunityPriorityCode")) {
        opportunityPriority.opportunityPriorityCode = jsonObj["OpportunityPriorityCode"];
      }
      if (jsonObj.containsKey("OpportunityPriorityName")) {
        opportunityPriority.opportunityPriorityName = jsonObj["OpportunityPriorityName"];
      }
      if (jsonObj.containsKey("Description")) {
        opportunityPriority.description = jsonObj["Description"];
      }
      if (jsonObj.containsKey("IsDefault")) {
        opportunityPriority.isDefault = jsonObj["IsDefault"];
      }
      if (jsonObj.containsKey("PriorityOrder")) {
        opportunityPriority.priorityOrder = jsonObj["PriorityOrder"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityPriority.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("CreatedBy")) {
        opportunityPriority.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityPriority.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityPriority.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityPriority.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityPriority.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityPriority.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityPriority.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityPriority.isDeleted = jsonObj["IsDeleted"];
      }

      opportunityPriority.isDirty = "false";
      opportunityPriority.isDeleted1 = "false";
      opportunityPriority.upSyncMessage = "";
      opportunityPriority.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityPriority.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityPriority.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityPriority.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityPriority.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityPriority.upSyncIndex = "0";
      opportunityPriority.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityPriority()", ex);
    }
    return opportunityPriority;
  }


OpportunityProduct copyJsonDataToOpportunityProduct(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityProduct opportunityProduct,
    bool isForNew,
  ) {
    try {
      if (jsonObj.containsKey("OpportunityProductID")) {
        opportunityProduct.opportunityProductID = jsonObj["OpportunityProductID"];
      }
      if (jsonObj.containsKey("OpportunityProductCode")) {
        opportunityProduct.opportunityProductCode = jsonObj["OpportunityProductCode"];
      }

      if (jsonObj.containsKey("OpportunityID")) {
        String opportunityId = jsonObj["OpportunityID"];
        opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
        Opportunity ?opportunity =  await OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
        if (opportunity != null) {
          opportunityProduct.opportunityID = opportunity.id;
        }
      }

      if (jsonObj.containsKey("ProductID")) {
        String productId = jsonObj["ProductID"];
        productId = productId != null && productId != "" ? productId : "-1";
        Product product = ProductDataHandlerBase.getMasterProductRecord(dbHandler, productId);
        if (product != null) {
          opportunityProduct.productID = product.id;
        }
      }

   if (jsonObj.containsKey("Price")) {
  String bigValue = jsonObj["Price"];
  String price = bigValue;
  if (bigValue.contains("E")) {
    BigInt bi = BigInt.parse(bigValue);
    price = bi.toUnsigned(64).toString();
  }
  opportunityProduct.price =(price);
}

      if (jsonObj.containsKey("CreatedBy")) {
        opportunityProduct.createdBy = jsonObj["CreatedBy"];
      }
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityProduct.createdOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedBy")) {
        opportunityProduct.modifiedBy = jsonObj["ModifiedBy"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityProduct.modifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("IsActive")) {
        opportunityProduct.isActive = jsonObj["IsActive"];
      }
      if (jsonObj.containsKey("Uid")) {
        opportunityProduct.uid = jsonObj["Uid"];
      }
      if (jsonObj.containsKey("AppUserID")) {
        opportunityProduct.appUserID = jsonObj["AppUserID"];
      }
      if (jsonObj.containsKey("AppUserGroupID")) {
        opportunityProduct.appUserGroupID = jsonObj["AppUserGroupID"];
      }
      if (jsonObj.containsKey("IsArchived")) {
        opportunityProduct.isArchived = jsonObj["IsArchived"];
      }
      if (jsonObj.containsKey("IsDeleted")) {
        opportunityProduct.isDeleted = jsonObj["IsDeleted"];
      }
      if (jsonObj.containsKey("ReferenceIdentifier")) {
        opportunityProduct.referenceIdentifier = jsonObj["ReferenceIdentifier"];
      }

      opportunityProduct.isDirty = "false";
      opportunityProduct.isDeleted1 = "false";
      opportunityProduct.upSyncMessage = "";
      opportunityProduct.downSyncMessage = "";
      if (jsonObj.containsKey("CreatedOn")) {
        opportunityProduct.sCreatedOn = jsonObj["CreatedOn"];
      }
      if (jsonObj.containsKey("ModifiedOn")) {
        opportunityProduct.sModifiedOn = jsonObj["ModifiedOn"];
      }
      if (jsonObj.containsKey("CreatedByUser")) {
        opportunityProduct.createdByUser = jsonObj["CreatedByUser"];
      }
      if (jsonObj.containsKey("ModifiedByUser")) {
        opportunityProduct.modifiedByUser = jsonObj["ModifiedByUser"];
      }
      opportunityProduct.upSyncIndex = "0";
      opportunityProduct.ownerUserID = Globals.AppUserID.toString();
    } catch (ex) {
      Globals.handleException( "JSONDataCopier:CopyJsonDataToOpportunityProduct()", ex);
    }
    return opportunityProduct;
  }
OpportunityProductDetail copyJsonDataToOpportunityProductDetail(
     
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityProductDetail opportunityProductDetail,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("OpportunityProductDetailID")) {
      opportunityProductDetail.opportunityProductDetailID =
          jsonObj["OpportunityProductDetailID"];
    }
    if (jsonObj.containsKey("OpportunityProductDetailCode")) {
      opportunityProductDetail.opportunityProductDetailCode =
          jsonObj["OpportunityProductDetailCode"];
    }

    if (jsonObj.containsKey("OpportunityProductID")) {
      String opportunityProductId =
          jsonObj["OpportunityProductID"].toString();
      opportunityProductId = opportunityProductId.isNotEmpty
          ? opportunityProductId
          : "-1";
      OpportunityProduct? opportunityProduct =await
          OpportunityProductDataHandlerBase.GetMasterOpportunityProductRecord(
        dbHandler,
        
        opportunityProductId,
      );
      if (opportunityProduct != null) {
        opportunityProductDetail.opportunityProductID = opportunityProduct.id;
      }
    }

    if (jsonObj.containsKey("Attribute")) {
      opportunityProductDetail.attribute = jsonObj["Attribute"];
    }

    if (jsonObj.containsKey("Price")) {
      String bigValue = jsonObj["Price"];
      String price = bigValue;
      if (bigValue.contains("E")) {
        BigInt bi = BigInt.parse(bigValue);
        price = bi.toInt().toString();
      }
      opportunityProductDetail.price = price;
    }
    
    if (jsonObj.containsKey("Quantity")) {
      opportunityProductDetail.quantity = jsonObj["Quantity"];
    }

    String bigValue = jsonObj["Amount"];
    String amount = bigValue;
    if (bigValue.contains("E")) {
      BigInt bi = BigInt.parse(bigValue);
      amount = bi.toInt().toString();
    }
    opportunityProductDetail.amount = amount;

    if (jsonObj.containsKey("Remarks")) {
      opportunityProductDetail.remarks = jsonObj["Remarks"];
    }

    if (jsonObj.containsKey("SupplierAccountID")) {
      String accountId = jsonObj["SupplierAccountID"].toString();
      accountId = accountId.isNotEmpty ? accountId : "-1";
      Account account = AccountDataHandlerBase.getMasterAccountRecord(
        dbHandler,
        
        accountId,
      );
      if (account != null) {
        opportunityProductDetail.supplierAccountID = account.id;
      }
    }

    if (jsonObj.containsKey("CreatedBy")) {
      opportunityProductDetail.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityProductDetail.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityProductDetail.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityProductDetail.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityProductDetail.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityProductDetail.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityProductDetail.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityProductDetail.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityProductDetail.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityProductDetail.isDeleted = jsonObj["IsDeleted"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      opportunityProductDetail.referenceIdentifier =
          jsonObj["ReferenceIdentifier"];
    }

    opportunityProductDetail.isDirty = "false";
    opportunityProductDetail.isDeleted1 = "false";
    opportunityProductDetail.upSyncMessage = "";
    opportunityProductDetail.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityProductDetail.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityProductDetail.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityProductDetail.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityProductDetail.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityProductDetail.upSyncIndex = "0";
    opportunityProductDetail.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException(
      
      "JSONDataCopier:CopyJsonDataToOpportunityProductDetail()",
      ex,
    );
  }
  return opportunityProductDetail;
}
Future<OpportunityProductDetailAttribute> copyJsonDataToOpportunityProductDetailAttribute(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityProductDetailAttribute opportunityProductDetailAttribute,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("OpportunityProductDetailAttributeID")) {
      opportunityProductDetailAttribute.opportunityProductDetailAttributeID =
          jsonObj["OpportunityProductDetailAttributeID"];
    }
    if (jsonObj.containsKey("OpportunityProductDetailAttributeCode")) {
      opportunityProductDetailAttribute.opportunityProductDetailAttributeCode =
          jsonObj["OpportunityProductDetailAttributeCode"];
    }

    if (jsonObj.containsKey("OpportunityProductDetailID")) {
      String opportunityProductDetailId =
          jsonObj["OpportunityProductDetailID"].toString();
      opportunityProductDetailId = opportunityProductDetailId.isNotEmpty
          ? opportunityProductDetailId
          : "-1";
      OpportunityProductDetail? opportunityProductDetail =await
          OpportunityProductDetailDataHandlerBase.GetMasterOpportunityProductDetailRecord(
        dbHandler,
        opportunityProductDetailId,
      );
      if (opportunityProductDetail != null) {
        opportunityProductDetailAttribute.opportunityProductDetailID =
            opportunityProductDetail.id;
      }
    }

    if (jsonObj.containsKey("AttributeID")) {
      String attributeId = jsonObj["AttributeID"].toString();
      attributeId = attributeId.isNotEmpty ? attributeId : "-1";
      Attribute attribute = AttributeDataHandler.getMasterAttributeRecord(
        dbHandler,
        
        attributeId,
      );
      if (attribute != null) {
        opportunityProductDetailAttribute.attributeID = attribute.id;
      }
    }

    if (jsonObj.containsKey("AttributeValueID")) {
      String attributeValueId = jsonObj["AttributeValueID"].toString();
      attributeValueId = attributeValueId.isNotEmpty ? attributeValueId : "-1";
      AttributeValue attributeValue =
          AttributeValueDataHandler.getMasterAttributeValueRecord(
        dbHandler,
        attributeValueId,
      );
      if (attributeValue != null) {
        opportunityProductDetailAttribute.attributeValueID =
            attributeValue.id;
      }
    }

    if (jsonObj.containsKey("AttributeValue")) {
      opportunityProductDetailAttribute.attributeValue =
          jsonObj["AttributeValue"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityProductDetailAttribute.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityProductDetailAttribute.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityProductDetailAttribute.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityProductDetailAttribute.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityProductDetailAttribute.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityProductDetailAttribute.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      opportunityProductDetailAttribute.referenceIdentifier =
          jsonObj["ReferenceIdentifier"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityProductDetailAttribute.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityProductDetailAttribute.appUserGroupID =
          jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityProductDetailAttribute.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityProductDetailAttribute.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityProductDetailAttribute.isDirty = "false";
    opportunityProductDetailAttribute.isDeleted1 = "false";
    opportunityProductDetailAttribute.upSyncMessage = "";
    opportunityProductDetailAttribute.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityProductDetailAttribute.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityProductDetailAttribute.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityProductDetailAttribute.createdByUser =
          jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityProductDetailAttribute.modifiedByUser =
          jsonObj["ModifiedByUser"];
    }
    opportunityProductDetailAttribute.upSyncIndex = "0";
    opportunityProductDetailAttribute.ownerUserID =
        Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      
      "JSONDataCopier:CopyJsonDataToOpportunityProductDetailAttribute()",
      ex,
    );
  }
  return opportunityProductDetailAttribute;
}

Future<OpportunityStage> copyJsonDataToOpportunityStage(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityStage opportunityStage,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("OpportunityStageID")) {
      opportunityStage.opportunityStageID = jsonObj["OpportunityStageID"];
    }
    if (jsonObj.containsKey("OpportunityStageCode")) {
      opportunityStage.opportunityStageCode =
          jsonObj["OpportunityStageCode"];
    }
    if (jsonObj.containsKey("OpportunityStageName")) {
      opportunityStage.opportunityStageName =
          jsonObj["OpportunityStageName"];
    }
    if (jsonObj.containsKey("Description")) {
      opportunityStage.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("SequentialOrder")) {
      opportunityStage.sequentialOrder = jsonObj["SequentialOrder"];
    }
    if (jsonObj.containsKey("IsPipeline")) {
      opportunityStage.isPipeline = jsonObj["IsPipeline"];
    }
    if (jsonObj.containsKey("Probability")) {
      opportunityStage.probability = jsonObj["Probability"];
    }
    if (jsonObj.containsKey("Indicator")) {
      opportunityStage.indicator = jsonObj["Indicator"];
    }
    if (jsonObj.containsKey("StagnantAlertDays")) {
      opportunityStage.stagnantAlertDays = jsonObj["StagnantAlertDays"];
    }
    if (jsonObj.containsKey("WorkflowStageID")) {
      opportunityStage.workflowStageID = jsonObj["WorkflowStageID"];
    }
    if (jsonObj.containsKey("WorkflowStageName")) {
      opportunityStage.workflowStageName = jsonObj["WorkflowStageName"];
    }
    if (jsonObj.containsKey("AlertMessage")) {
      opportunityStage.alertMessage = jsonObj["AlertMessage"];
    }
    if (jsonObj.containsKey("OpportunityStageType")) {
      opportunityStage.opportunityStageType =
          jsonObj["OpportunityStageType"];
    }
    if (jsonObj.containsKey("ActionOnSelection")) {
      opportunityStage.actionOnSelection =
          jsonObj["ActionOnSelection"];
    }
    if (jsonObj.containsKey("InternalCode")) {
      opportunityStage.internalCode = jsonObj["InternalCode"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStage.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityStage.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStage.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityStage.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityStage.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityStage.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityStage.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityStage.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityStage.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityStage.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityStage.isDirty = "false";
    opportunityStage.isDeleted1 = "false";
    opportunityStage.upSyncMessage = "";
    opportunityStage.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStage.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStage.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityStage.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityStage.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityStage.upSyncIndex = "0";
    opportunityStage.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      
      "JSONDataCopier:CopyJsonDataToOpportunityStage()",
      ex,
    );
  }
  return opportunityStage;
}


OpportunityStageType copyJsonDataToOpportunityStageType(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityStageType opportunityStageType,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("OpportunityStageTypeID")) {
      opportunityStageType.opportunityStageTypeID =
          jsonObj["OpportunityStageTypeID"];
    }
    if (jsonObj.containsKey("OpportunityStageTypeCode")) {
      opportunityStageType.opportunityStageTypeCode =
          jsonObj["OpportunityStageTypeCode"];
    }
    if (jsonObj.containsKey("OpportunityStageID")) {
      opportunityStageType.opportunityStageID =
          jsonObj["OpportunityStageID"];
    }
    if (jsonObj.containsKey("OpportunityTypeID")) {
      opportunityStageType.opportunityTypeID =
          jsonObj["OpportunityTypeID"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityStageType.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStageType.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityStageType.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStageType.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityStageType.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityStageType.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityStageType.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityStageType.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityStageType.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityStageType.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityStageType.isDirty = "false";
    opportunityStageType.isDeleted1 = "false";
    opportunityStageType.upSyncMessage = "";
    opportunityStageType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStageType.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStageType.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityStageType.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityStageType.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityStageType.upSyncIndex = "0";
    opportunityStageType.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToOpportunityStageType()",
      ex,
    );
  }
  return opportunityStageType;
}

OpportunityStatus copyJsonDataToOpportunityStatus(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityStatus opportunityStatus,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("OpportunityStatusID")) {
      opportunityStatus.opportunityStatusID =
          jsonObj["OpportunityStatusID"];
    }
    if (jsonObj.containsKey("OpportunityStatusCode")) {
      opportunityStatus.opportunityStatusCode =
          jsonObj["OpportunityStatusCode"];
    }
    if (jsonObj.containsKey("OpportunityStatusName")) {
      opportunityStatus.opportunityStatusName =
          jsonObj["OpportunityStatusName"];
    }
    if (jsonObj.containsKey("SequentialOrder")) {
      opportunityStatus.sequentialOrder = jsonObj["SequentialOrder"];
    }
    if (jsonObj.containsKey("Probability")) {
      opportunityStatus.probability = jsonObj["Probability"];
    }
    if (jsonObj.containsKey("Indicator")) {
      opportunityStatus.indicator = jsonObj["Indicator"];
    }
    if (jsonObj.containsKey("InternalCode")) {
      opportunityStatus.internalCode = jsonObj["InternalCode"];
    }
    if (jsonObj.containsKey("WorkflowStageID")) {
      opportunityStatus.workflowStageID = jsonObj["WorkflowStageID"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStatus.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityStatus.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStatus.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityStatus.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityStatus.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityStatus.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityStatus.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityStatus.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityStatus.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityStatus.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityStatus.isDirty = "false";
    opportunityStatus.isDeleted1 = "false";
    opportunityStatus.upSyncMessage = "";
    opportunityStatus.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityStatus.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityStatus.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityStatus.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityStatus.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityStatus.upSyncIndex = "0";
    opportunityStatus.ownerUserID = Globals.appUserID.toString();
  } catch (ex) {
    Globals.handleException(
      
      "JSONDataCopier:CopyJsonDataToOpportunityStatus()",
      ex,
    );
  }
  return opportunityStatus;
}
Future<OpportunityTeam> copyJsonDataToOpportunityTeam(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityTeam opportunityTeam,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("OpportunityTeamID")) {
      opportunityTeam.opportunityTeamID = jsonObj["OpportunityTeamID"];
    }
    if (jsonObj.containsKey("OpportunityTeamCode")) {
      opportunityTeam.opportunityTeamCode = jsonObj["OpportunityTeamCode"];
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"];
      opportunityId = opportunityId != null && opportunityId != "" ? opportunityId : "-1";
      Opportunity? opportunity =await 
          OpportunityDataHandlerBaseBase.GetMasterOpportunityRecord(dbHandler, opportunityId);
      if (opportunity != null) {
        opportunityTeam.opportunityID = opportunity.id;
      }
    }

    if (jsonObj.containsKey("OpportunityTeamAppUserID")) {
      opportunityTeam.opportunityTeamAppUserID =
          jsonObj["OpportunityTeamAppUserID"];
    }
    if (jsonObj.containsKey("OpportunityTeamAppUserName")) {
      opportunityTeam.appUserName = jsonObj["OpportunityTeamAppUserName"];
    }
    if (jsonObj.containsKey("Designation")) {
      opportunityTeam.designation = jsonObj["Designation"];
    }
    if (jsonObj.containsKey("Description")) {
      opportunityTeam.description = jsonObj["Description"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityTeam.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityTeam.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityTeam.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityTeam.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityTeam.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityTeam.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityTeam.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityTeam.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityTeam.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityTeam.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityTeam.isDirty = "false";
    opportunityTeam.isDeleted1 = "false";
    opportunityTeam.upSyncMessage = "";
    opportunityTeam.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityTeam.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityTeam.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityTeam.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityTeam.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityTeam.upSyncIndex = "0";
    opportunityTeam.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToOpportunityTeam()",
      ex,
    );
  }
  return opportunityTeam;
}

OpportunityType copyJsonDataToOpportunityType(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    OpportunityType opportunityType,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("OpportunityTypeID")) {
      opportunityType.opportunityTypeID = jsonObj["OpportunityTypeID"];
    }
    if (jsonObj.containsKey("OpportunityTypeCode")) {
      opportunityType.opportunityTypeCode = jsonObj["OpportunityTypeCode"];
    }
    if (jsonObj.containsKey("OpportunityTypeName")) {
      opportunityType.opportunityTypeName = jsonObj["OpportunityTypeName"];
    }
    if (jsonObj.containsKey("InternalCode")) {
      opportunityType.internalCode = jsonObj["InternalCode"];
    }
    if (jsonObj.containsKey("IsDefault")) {
      opportunityType.isDefault = jsonObj["IsDefault"];
    }
    if (jsonObj.containsKey("SequentialOrder")) {
      opportunityType.sequentialOrder = jsonObj["SequentialOrder"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityType.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      opportunityType.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityType.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      opportunityType.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("Uid")) {
      opportunityType.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      opportunityType.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      opportunityType.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      opportunityType.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsActive")) {
      opportunityType.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      opportunityType.isDeleted = jsonObj["IsDeleted"];
    }

    opportunityType.isDirty = "false";
    opportunityType.isDeleted1 = "false";
    opportunityType.upSyncMessage = "";
    opportunityType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      opportunityType.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      opportunityType.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      opportunityType.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      opportunityType.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    opportunityType.upSyncIndex = "0";
    opportunityType.ownerUserID = Globals.appUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToOpportunityType()",
      ex,
    );
  }
  return opportunityType;
}

PhoneType copyJsonDataToPhoneType(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    PhoneType phoneType,
    bool isForNew,
) {
  try {
    if (jsonObj.containsKey("PhoneTypeID")) {
      phoneType.phoneTypeID = jsonObj["PhoneTypeID"];
    }
    if (jsonObj.containsKey("PhoneTypeCode")) {
      phoneType.phoneTypeCode = jsonObj["PhoneTypeCode"];
    }
    if (jsonObj.containsKey("PhoneTypeName")) {
      phoneType.phoneTypeName = jsonObj["PhoneTypeName"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      phoneType.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      phoneType.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      phoneType.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      phoneType.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("IsActive")) {
      phoneType.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("Uid")) {
      phoneType.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      phoneType.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      phoneType.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      phoneType.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      phoneType.isDeleted = jsonObj["IsDeleted"];
    }

    phoneType.isDirty = "false";
    phoneType.isDeleted1 = "false";
    phoneType.upSyncMessage = "";
    phoneType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      phoneType.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      phoneType.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      phoneType.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      phoneType.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    phoneType.upSyncIndex = "0";
    phoneType.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      
      "JSONDataCopier:CopyJsonDataToPhoneType()",
      ex,
    );
  }
  return phoneType;
}

Future<PerformanceSummary> copyJsonDataToPerformanceSummary(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    PerformanceSummary performanceSummary,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("PerformanceSummaryID")) {
      performanceSummary.performanceSummaryID = jsonObj["PerformanceSummaryID"];
    }
    if (jsonObj.containsKey("PerformanceSummaryCode")) {
      performanceSummary.performanceSummaryCode = jsonObj["PerformanceSummaryCode"];
    }
    if (jsonObj.containsKey("PerformanceSummaryName")) {
      performanceSummary.performanceSummaryName = jsonObj["PerformanceSummaryName"];
    }

    if (jsonObj.containsKey("BusinessFeatureID")) {
      String businessFeatureId = jsonObj["BusinessFeatureID"];
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty ? businessFeatureId : "-1";
      BusinessFeature businessFeature = BusinessFeatureDataHandler.getMasterBusinessFeatureRecord(dbHandler,  businessFeatureId);
      if (businessFeature != null) {
        performanceSummary.businessFeatureID = businessFeature.id;
      }
    }

    if (jsonObj.containsKey("PerformanceType")) {
      performanceSummary.performanceType = jsonObj["PerformanceType"];
    }

    if (jsonObj.containsKey("ActivityTypeID")) {
      String activityTypeId = jsonObj["ActivityTypeID"];
      activityTypeId = activityTypeId != null && activityTypeId.isNotEmpty ? activityTypeId : "-1";
      ActivityType activityType = ActivityTypeDataHandler.getMasterActivityTypeRecord(dbHandler,  activityTypeId);
      if (activityType != null) {
        performanceSummary.activityTypeID = activityType.id;
      }
    }

    if (jsonObj.containsKey("FinancialYearID")) {
      String financialYearId = jsonObj["FinancialYearID"];
      financialYearId = financialYearId != null && financialYearId.isNotEmpty ? financialYearId : "-1";
      FinancialYear financialYear = FinancialYearDataHandler.getMasterFinancialYearRecord(dbHandler,  financialYearId);
      if (financialYear != null) {
        performanceSummary.financialYearID = financialYear.id;
      }
    }

    if (jsonObj.containsKey("PeriodName")) {
      performanceSummary.periodName = jsonObj["PeriodName"];
    }
    if (jsonObj.containsKey("StartDate")) {
      performanceSummary.startDate = jsonObj["StartDate"];
    }
    if (jsonObj.containsKey("EndDate")) {
      performanceSummary.endDate = jsonObj["EndDate"];
    }
    if (jsonObj.containsKey("Target")) {
      performanceSummary.target = jsonObj["Target"];
    }
    if (jsonObj.containsKey("Achievement")) {
      performanceSummary.achievement = jsonObj["Achievement"];
    }
    if (jsonObj.containsKey("CreatedOn")) {
      performanceSummary.createdOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("CreatedBy")) {
      performanceSummary.createdBy = jsonObj["CreatedBy"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      performanceSummary.modifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      performanceSummary.modifiedBy = jsonObj["ModifiedBy"];
    }
    if (jsonObj.containsKey("Uid")) {
      performanceSummary.uid = jsonObj["Uid"];
    }
    if (jsonObj.containsKey("AppUserID")) {
      performanceSummary.appUserID = jsonObj["AppUserID"];
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      performanceSummary.appUserGroupID = jsonObj["AppUserGroupID"];
    }
    if (jsonObj.containsKey("IsArchived")) {
      performanceSummary.isArchived = jsonObj["IsArchived"];
    }
    if (jsonObj.containsKey("IsActive")) {
      performanceSummary.isActive = jsonObj["IsActive"];
    }
    if (jsonObj.containsKey("IsDeleted")) {
      performanceSummary.isDeleted = jsonObj["IsDeleted"];
    }

    performanceSummary.isDirty = "false";
    performanceSummary.isDeleted1 = "false";
    performanceSummary.upSyncMessage = "";
    performanceSummary.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      performanceSummary.sCreatedOn = jsonObj["CreatedOn"];
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      performanceSummary.sModifiedOn = jsonObj["ModifiedOn"];
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      performanceSummary.createdByUser = jsonObj["CreatedByUser"];
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      performanceSummary.modifiedByUser = jsonObj["ModifiedByUser"];
    }
    performanceSummary.upSyncIndex = "0";
    performanceSummary.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
      "JSONDataCopier:CopyJsonDataToPerformanceSummary()",
      ex,
    );
  }
  return performanceSummary;
}


Future<Product> copyJsonDataToProduct(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Product product,
    bool isForNew,
) async {
  try {
    if (jsonObj.containsKey("ProductID")) {
      product.productID = jsonObj["ProductID"].toString();
    }
    if (jsonObj.containsKey("ProductCode")) {
      product.productCode = jsonObj["ProductCode"].toString();
    }
    if (jsonObj.containsKey("ProductName")) {
      product.productName = jsonObj["ProductName"].toString();
    }
    if (jsonObj.containsKey("ProductDescription")) {
      product.productDescription = jsonObj["ProductDescription"].toString();
    }
    if (jsonObj.containsKey("Manufacturer")) {
      product.manufacturer = jsonObj["Manufacturer"].toString();
    }
    if (jsonObj.containsKey("HSNCode")) {
      product.hsnCode = jsonObj["HSNCode"].toString();
    }
    if (jsonObj.containsKey("MRP")) {
      product.mrp = jsonObj["MRP"].toString();
    }
    if (jsonObj.containsKey("Price")) {
      product.price = jsonObj["Price"].toString();
    }

    String bigValue = jsonObj["PriceForSales"].toString();
    String priceForSales = bigValue;
    if (bigValue.indexOf("E") > -1) {
      BigInt bi = BigInt.parse(bigValue);
      priceForSales = bi.toInt().toString();
    }
    product.priceForSales = priceForSales;

    if (jsonObj.containsKey("MinimumSalesPrice")) {
      product.minimumSalesPrice = jsonObj["MinimumSalesPrice"].toString();
    }
    if (jsonObj.containsKey("MaximumSalesPrice")) {
      product.maximumSalesPrice = jsonObj["MaximumSalesPrice"].toString();
    }

    if (jsonObj.containsKey("CurrentStock")) {
      product.currentStock = jsonObj["CurrentStock"].toString();
    }

    if (jsonObj.containsKey("UnitID")) {
      String unitId = jsonObj["UnitID"].toString();
      unitId = unitId.isNotEmpty ? unitId : "-1";
      Unit unit = await UnitDataHandlerBase.getMasterUnitRecord(dbHandler,  unitId);
      if (unit != null) {
        product.unitID = unit.id;
      }
    }

    if (jsonObj.containsKey("IsAttributeBased")) {
      product.isAttributeBased = jsonObj["IsAttributeBased"].toString();
    }
    if (jsonObj.containsKey("CGSTPercentage")) {
      product.cgstPercentage = jsonObj["CGSTPercentage"].toString();
    }
    if (jsonObj.containsKey("SGSTPercentage")) {
      product.sgstPercentage = jsonObj["SGSTPercentage"].toString();
    }
    if (jsonObj.containsKey("GSTPercentage")) {
      product.gstPercentage = jsonObj["GSTPercentage"].toString();
    }
    if (jsonObj.containsKey("IsPriceIncludesTax")) {
      product.isPriceIncludesTax = jsonObj["IsPriceIncludesTax"].toString();
    }

    if (jsonObj.containsKey("ProductCategoryID")) {
      String productCategoryId = jsonObj["ProductCategoryID"].toString();
      productCategoryId = productCategoryId.isNotEmpty ? productCategoryId : "-1";
      ProductCategory productCategory = await ProductCategoryDataHandler.getMasterProductCategoryRecord(
          dbHandler,  productCategoryId);
      if (productCategory != null) {
        product.productCategoryID = productCategory.id;
      }
    }

    if (jsonObj.containsKey("LifeTimeInHours")) {
      product.lifeTimeInHours = jsonObj["LifeTimeInHours"].toString();
    }

    if (jsonObj.containsKey("ParentProductID")) {
      String productId = jsonObj["ParentProductID"].toString();
      productId = productId.isNotEmpty ? productId : "-1";
      Product product1 = await ProductDataHandlerBase.getMasterProductRecord(dbHandler,  productId);
      if (product1 != null) {
        product.parentProductID = product1.id;
      }
    }

    if (jsonObj.containsKey("ProductThumbnailImagePath")) {
      product.productThumbnailImagePath = jsonObj["ProductThumbnailImagePath"].toString();
    }
    if (jsonObj.containsKey("ProductImagePath")) {
      product.productImagePath = jsonObj["ProductImagePath"].toString();
    }
    if (jsonObj.containsKey("ProductBrochurePath")) {
      product.productBrochurePath = jsonObj["ProductBrochurePath"].toString();
    }
    if (jsonObj.containsKey("ProductAttributes")) {
      product.productAttributes = jsonObj["ProductAttributes"].toString();
    }
    if (jsonObj.containsKey("ProductCategoryHierarchy")) {
      product.productCategoryHierarchy = jsonObj["ProductCategoryHierarchy"].toString();
    }
    if (jsonObj.containsKey("IsSaleable")) {
      product.isSaleable = jsonObj["IsSaleable"].toString();
    }
    if (jsonObj.containsKey("FeatureOptions")) {
      product.featureOptions = jsonObj["FeatureOptions"].toString();
    }
    if (jsonObj.containsKey("ProductCodeInternal")) {
      product.productCodeInternal = jsonObj["ProductCodeInternal"].toString();
    }
    if (jsonObj.containsKey("Tags")) {
      product.tags = jsonObj["Tags"].toString();
    }
    if (jsonObj.containsKey("Remarks")) {
      product.remarks = jsonObj["Remarks"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      product.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      product.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      product.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      product.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      product.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      product.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      product.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      product.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      product.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      product.isDeleted = jsonObj["IsDeleted"].toString();
    }

    product.isDirty = "false";
    product.isDeleted1 = "false";
    product.upSyncMessage = "";
    product.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      product.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      product.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      product.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      product.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    product.upSyncIndex = "0";
    product.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToProduct()", ex);
  }
  return product;
}


Future<ProductAuxiliary> copyJsonDataToProductAuxiliary(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ProductAuxiliary productAuxiliary,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('ProductAuxiliaryID')) {
      productAuxiliary.productAuxiliaryID =
          jsonObj['ProductAuxiliaryID'].toString();
    }
    if (jsonObj.containsKey('ProductAuxiliaryCode')) {
      productAuxiliary.productAuxiliaryCode =
          jsonObj['ProductAuxiliaryCode'].toString();
    }

    if (jsonObj.containsKey('ProductID')) {
      String productId = jsonObj['ProductID'].toString();
      productId = (productId != null && productId != '') ? productId : '-1';
      Product product = await ProductDataHandlerBase.getMasterProductRecord(
          dbHandler,  productId);
      if (product != null) {
        productAuxiliary.productID = product.id;
      }
    }

    if (jsonObj.containsKey('AuxiliaryProductID')) {
      String productId = jsonObj['AuxiliaryProductID'].toString();
      productId = (productId != null && productId != '') ? productId : '-1';
      Product product1 = await ProductDataHandlerBase.getMasterProductRecord(
          dbHandler,  productId);
      if (product1 != null) {
        productAuxiliary.auxiliaryProductID = product1.id;
      }
    }

    if (jsonObj.containsKey('Quantity')) {
      productAuxiliary.quantity = jsonObj['Quantity'].toString();
    }
    if (jsonObj.containsKey('Price')) {
      productAuxiliary.price = jsonObj['Price'].toString();
    }
    if (jsonObj.containsKey('IsPriceIncludesTax')) {
      productAuxiliary.isPriceIncludesTax =
          jsonObj['IsPriceIncludesTax'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      productAuxiliary.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      productAuxiliary.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      productAuxiliary.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productAuxiliary.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      productAuxiliary.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      productAuxiliary.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      productAuxiliary.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      productAuxiliary.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('SequentialOrder')) {
      productAuxiliary.sequentialOrder = jsonObj['SequentialOrder'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      productAuxiliary.isDeleted = jsonObj['IsDeleted'].toString();
    }

    productAuxiliary.isDirty = 'false';
    productAuxiliary.isDeleted1 = 'false';
    productAuxiliary.upSyncMessage = '';
    productAuxiliary.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      productAuxiliary.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productAuxiliary.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      productAuxiliary.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      productAuxiliary.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    productAuxiliary.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID'))
      productAuxiliary.ownerUserID = jsonObj['AppUserID'].toString();*/
    productAuxiliary.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( 'JSONDataCopier:CopyJsonDataToProductAuxiliary()', ex);
  }
  return productAuxiliary;
}

Future<ProductCategory> copyJsonDataToProductCategory(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ProductCategory productCategory,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('ProductCategoryID')) {
      productCategory.productCategoryID =
          jsonObj['ProductCategoryID'].toString();
    }
    if (jsonObj.containsKey('ProductCategoryCode')) {
      productCategory.productCategoryCode =
          jsonObj['ProductCategoryCode'].toString();
    }
    if (jsonObj.containsKey('ProductCategoryName')) {
      productCategory.productCategoryName =
          jsonObj['ProductCategoryName'].toString();
    }
    if (jsonObj.containsKey('Description')) {
      productCategory.description = jsonObj['Description'].toString();
    }

    if (jsonObj.containsKey('ParentProductCategoryID')) {
      String productCategoryId =
          jsonObj['ParentProductCategoryID'].toString();
      productCategoryId =
          (productCategoryId != null && productCategoryId != '')
              ? productCategoryId
              : '-1';
      ProductCategory productCategory1 = await ProductCategoryDataHandler
          .getMasterProductCategoryRecord(dbHandler,  productCategoryId);
      if (productCategory1 != null) {
        productCategory.parentProductCategoryID = productCategory1.id;
      }
    }

    if (jsonObj.containsKey('CreatedOn')) {
      productCategory.createdOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      productCategory.createdBy = jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productCategory.modifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      productCategory.modifiedBy = jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      productCategory.isActive = jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      productCategory.uid = jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      productCategory.appUserID = jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      productCategory.appUserGroupID = jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      productCategory.isArchived = jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      productCategory.isDeleted = jsonObj['IsDeleted'].toString();
    }

    productCategory.isDirty = 'false';
    productCategory.isDeleted1 = 'false';
    productCategory.upSyncMessage = '';
    productCategory.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      productCategory.sCreatedOn = jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productCategory.sModifiedOn = jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      productCategory.createdByUser = jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      productCategory.modifiedByUser = jsonObj['ModifiedByUser'].toString();
    }
    productCategory.upSyncIndex = '0';
    /*if (jsonObj.containsKey('AppUserID'))
      productCategory.ownerUserID = jsonObj['AppUserID'].toString();*/
    productCategory.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToProductCategory()', ex);
  }
  return productCategory;
}
Future<ProductInstallation> copyJsonDataToProductInstallation(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ProductInstallation productInstallation,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('ProductInstallationID')) {
      productInstallation.productInstallationID =
          jsonObj['ProductInstallationID'].toString();
    }
    if (jsonObj.containsKey('ProductInstallationCode')) {
      productInstallation.productInstallationCode =
          jsonObj['ProductInstallationCode'].toString();
    }
    if (jsonObj.containsKey('InstallationIdentifier')) {
      productInstallation.installationIdentifier =
          jsonObj['InstallationIdentifier'].toString();
    }

    if (jsonObj.containsKey('AccountID')) {
      String accountId = jsonObj['AccountID'].toString();
      accountId =
          (accountId != null && accountId != '') ? accountId : '-1';
      Account account = await AccountDataHandlerBase.getMasterAccountRecord(
          dbHandler,  accountId);
      if (account != null) {
        productInstallation.accountID = account.id;
      }
    }

    if (jsonObj.containsKey('ContactID')) {
      String contactId = jsonObj['ContactID'].toString();
      contactId =
          (contactId != null && contactId != '') ? contactId : '-1';
      Contact contact = await ContactDataHandler.getMasterContactRecord(
          dbHandler,  contactId);
      if (contact != null) {
        productInstallation.contactID = contact.id;
      }
    }

    if (jsonObj.containsKey('ProductID')) {
      String productId = jsonObj['ProductID'].toString();
      productId =
          (productId != null && productId != '') ? productId : '-1';
      Product product = await ProductDataHandlerBase.getMasterProductRecord(
          dbHandler,  productId);
      if (product != null) {
        productInstallation.productID = product.id;
      }
    }

    if (jsonObj.containsKey('SerialNumber')) {
      productInstallation.serialNumber =
          jsonObj['SerialNumber'].toString();
    }
    if (jsonObj.containsKey('PartNumber')) {
      productInstallation.partNumber =
          jsonObj['PartNumber'].toString();
    }
    if (jsonObj.containsKey('Model')) {
      productInstallation.model =
          jsonObj['Model'].toString();
    }
    if (jsonObj.containsKey('DateOfManufacture')) {
      productInstallation.dateOfManufacture =
          jsonObj['DateOfManufacture'].toString();
    }
    if (jsonObj.containsKey('LocationUnit')) {
      productInstallation.locationUnit =
          jsonObj['LocationUnit'].toString();
    }
    if (jsonObj.containsKey('LocationAddress')) {
      productInstallation.locationAddress =
          jsonObj['LocationAddress'].toString();
    }
    if (jsonObj.containsKey('DateOfCommissioning')) {
      productInstallation.dateOfCommissioning =
          jsonObj['DateOfCommissioning'].toString();
    }
    if (jsonObj.containsKey('ApplicationOfProduct')) {
      productInstallation.applicationOfProduct =
          jsonObj['ApplicationOfProduct'].toString();
    }
    if (jsonObj.containsKey('WarrantyEndDate')) {
      productInstallation.warrantyEndDate =
          jsonObj['WarrantyEndDate'].toString();
    }
    if (jsonObj.containsKey('UsageHoursPerWeek')) {
      productInstallation.usageHoursPerWeek =
          jsonObj['UsageHoursPerWeek'].toString();
    }
    if (jsonObj.containsKey('CreatedOn')) {
      productInstallation.createdOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedBy')) {
      productInstallation.createdBy =
          jsonObj['CreatedBy'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productInstallation.modifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      productInstallation.modifiedBy =
          jsonObj['ModifiedBy'].toString();
    }
    if (jsonObj.containsKey('IsActive')) {
      productInstallation.isActive =
          jsonObj['IsActive'].toString();
    }
    if (jsonObj.containsKey('Uid')) {
      productInstallation.uid =
          jsonObj['Uid'].toString();
    }
    if (jsonObj.containsKey('AppUserID')) {
      productInstallation.appUserID =
          jsonObj['AppUserID'].toString();
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      productInstallation.appUserGroupID =
          jsonObj['AppUserGroupID'].toString();
    }
    if (jsonObj.containsKey('IsArchived')) {
      productInstallation.isArchived =
          jsonObj['IsArchived'].toString();
    }
    if (jsonObj.containsKey('IsDeleted')) {
      productInstallation.isDeleted =
          jsonObj['IsDeleted'].toString();
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      productInstallation.referenceIdentifier =
          jsonObj['ReferenceIdentifier'].toString();
    }

    productInstallation.isDirty = 'false';
    productInstallation.isDeleted1 = 'false';
    productInstallation.upSyncMessage = '';
    productInstallation.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      productInstallation.sCreatedOn =
          jsonObj['CreatedOn'].toString();
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      productInstallation.sModifiedOn =
          jsonObj['ModifiedOn'].toString();
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      productInstallation.createdByUser =
          jsonObj['CreatedByUser'].toString();
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      productInstallation.modifiedByUser =
          jsonObj['ModifiedByUser'].toString();
    }
    productInstallation.upSyncIndex = '0';
    /* if (jsonObj.has("AppUserID"))
        productInstallation.setOwnerUserID(jsonObj.optString("AppUserID"));*/
    productInstallation.ownerUserID =
        Globals.appUserID.toString();

  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToProductInstallation()', ex);
  }
  return productInstallation;
}

ProductInstallationDetail copyJsonDataToProductInstallationDetail(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ProductInstallationDetail productInstallationDetail,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("ProductInstallationDetailID")) {
      productInstallationDetail.productInstallationDetailID = jsonObj["ProductInstallationDetailID"].toString();
    }
    if (jsonObj.containsKey("ProductInstallationDetailCode")) {
      productInstallationDetail.productInstallationDetailCode = jsonObj["ProductInstallationDetailCode"].toString();
    }

    if (jsonObj.containsKey("ProductInstallationID")) {
      String productInstallationId = jsonObj["ProductInstallationID"].toString();
      productInstallationId = productInstallationId.isNotEmpty ? productInstallationId : "-1";
      ProductInstallation productInstallation = ProductInstallationDataHandler.getMasterProductInstallationRecord(
          dbHandler,  productInstallationId);
      if (productInstallation != null) {
        productInstallationDetail.productInstallationID = productInstallation.id;
      }
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"].toString();
      productId = productId.isNotEmpty ? productId : "-1";
      Product product = ProductDataHandlerBase.getMasterProductRecord(dbHandler,  productId);
      if (product != null) {
        productInstallationDetail.productID = product.id;
      }
    }

    if (jsonObj.containsKey("SerialNumber")) {
      productInstallationDetail.serialNumber = jsonObj["SerialNumber"].toString();
    }
    if (jsonObj.containsKey("PartNumber")) {
      productInstallationDetail.partNumber = jsonObj["PartNumber"].toString();
    }
    if (jsonObj.containsKey("Model")) {
      productInstallationDetail.model = jsonObj["Model"].toString();
    }
    if (jsonObj.containsKey("DateOfManufacture")) {
      productInstallationDetail.dateOfManufacture = jsonObj["DateOfManufacture"].toString();
    }
    if (jsonObj.containsKey("ApplicationOfProduct")) {
      productInstallationDetail.applicationOfProduct = jsonObj["ApplicationOfProduct"].toString();
    }
    if (jsonObj.containsKey("DateOfCommissioning")) {
      productInstallationDetail.dateOfCommissioning = jsonObj["DateOfCommissioning"].toString();
    }
    if (jsonObj.containsKey("LifeTimeInHours")) {
      productInstallationDetail.lifeTimeInHours = jsonObj["LifeTimeInHours"].toString();
    }
    if (jsonObj.containsKey("UsageHoursPerWeek")) {
      productInstallationDetail.usageHoursPerWeek = jsonObj["UsageHoursPerWeek"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      productInstallationDetail.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      productInstallationDetail.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      productInstallationDetail.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      productInstallationDetail.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      productInstallationDetail.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      productInstallationDetail.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      productInstallationDetail.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      productInstallationDetail.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      productInstallationDetail.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      productInstallationDetail.isDeleted = jsonObj["IsDeleted"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      productInstallationDetail.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }

    productInstallationDetail.isDirty = "false";
    productInstallationDetail.isDeleted1 = "false";
    productInstallationDetail.upSyncMessage = "";
    productInstallationDetail.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      productInstallationDetail.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      productInstallationDetail.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      productInstallationDetail.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      productInstallationDetail.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    productInstallationDetail.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      productInstallationDetail.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    productInstallationDetail.ownerUserID = Globals.appUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToProductInstallationDetail()", ex);
  }
  return productInstallationDetail;
}

ProductMedia copyJsonDataToProductMedia(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ProductMedia productMedia,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("ProductMediaID")) {
      productMedia.productMediaID = jsonObj["ProductMediaID"].toString();
    }
    if (jsonObj.containsKey("ProductMediaCode")) {
      productMedia.productMediaCode = jsonObj["ProductMediaCode"].toString();
    }
    if (jsonObj.containsKey("ProductMediaName")) {
      productMedia.productMediaName = jsonObj["ProductMediaName"].toString();
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"].toString();
      productId = productId.isNotEmpty ? productId : "-1";
      Product product = ProductDataHandlerBase.getMasterProductRecord(dbHandler,  productId);
      if (product != null) {
        productMedia.productID = product.id;
      }
    }

    if (jsonObj.containsKey("ContentTypeID")) {
      String contentTypeId = jsonObj["ContentTypeID"].toString();
      contentTypeId = contentTypeId.isNotEmpty ? contentTypeId : "-1";
      ContentType contentType = ContentTypeDataHandlerBaseBase.getMasterContentTypeRecord(dbHandler,  contentTypeId);
      if (contentType != null) {
        productMedia.contentTypeID = contentType.id;
      }
    }

    if (jsonObj.containsKey("MediaPath")) {
      productMedia.mediaPath = jsonObj["MediaPath"].toString();
    }
    if (jsonObj.containsKey("MediaContent")) {
      productMedia.mediaContent = jsonObj["MediaContent"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      productMedia.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("Tags")) {
      productMedia.tags = jsonObj["Tags"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      productMedia.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      productMedia.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      productMedia.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      productMedia.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      productMedia.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      productMedia.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      productMedia.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      productMedia.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      productMedia.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      productMedia.isDeleted = jsonObj["IsDeleted"].toString();
    }

    productMedia.isDirty = "false";
    productMedia.isDeleted1 = "false";
    productMedia.upSyncMessage = "";
    productMedia.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      productMedia.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      productMedia.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      productMedia.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      productMedia.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    productMedia.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID")) {
      productMedia.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    productMedia.ownerUserID = Globals.appUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToProductMedia()", ex);
  }
  return productMedia;
}
Reimbursement copyJsonDataToReimbursement(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Reimbursement reimbursement,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("ReimbursementID")) {
      reimbursement.reimbursementID = jsonObj["ReimbursementID"].toString();
    }
    if (jsonObj.containsKey("ReimbursementCode")) {
      reimbursement.reimbursementCode = jsonObj["ReimbursementCode"].toString();
    }
    if (jsonObj.containsKey("ReimbursementTitle")) {
      reimbursement.reimbursementTitle = jsonObj["ReimbursementTitle"].toString();
    }
    if (jsonObj.containsKey("ReimbursementDate")) {
      reimbursement.reimbursementDate = jsonObj["ReimbursementDate"].toString();
    }
    if (jsonObj.containsKey("VoucherNumber")) {
      reimbursement.voucherNumber = jsonObj["VoucherNumber"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      reimbursement.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("Amount")) {
      reimbursement.amount = jsonObj["Amount"].toString();
    }
    if (jsonObj.containsKey("IsPaid")) {
      reimbursement.isPaid = jsonObj["IsPaid"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursement.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      reimbursement.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursement.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      reimbursement.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      reimbursement.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      reimbursement.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      reimbursement.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      reimbursement.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      reimbursement.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      reimbursement.isDeleted = jsonObj["IsDeleted"].toString();
    }

    reimbursement.isDirty = "false";
    reimbursement.isDeleted1 = "false";
    reimbursement.upSyncMessage = "";
    reimbursement.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursement.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursement.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      reimbursement.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      reimbursement.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    reimbursement.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      reimbursement.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    reimbursement.ownerUserID = Globals.appUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToReimbursement()", ex);
  }
  return reimbursement;
}

Future<ReimbursementDetail> copyJsonDataToReimbursementDetail(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ReimbursementDetail reimbursementDetail,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("ReimbursementDetailID")) {
      reimbursementDetail.reimbursementDetailID =
          jsonObj["ReimbursementDetailID"].toString();
    }
    if (jsonObj.containsKey("ReimbursementDetailCode")) {
      reimbursementDetail.reimbursementDetailCode =
          jsonObj["ReimbursementDetailCode"].toString();
    }
    if (jsonObj.containsKey("ReimbursementDetailTitle")) {
      reimbursementDetail.reimbursementDetailTitle =
          jsonObj["ReimbursementDetailTitle"].toString();
    }
    if (jsonObj.containsKey("BillNumber")) {
      reimbursementDetail.billNumber = jsonObj["BillNumber"].toString();
    }
    if (jsonObj.containsKey("BillDate")) {
      reimbursementDetail.billDate = jsonObj["BillDate"].toString();
    }
    if (jsonObj.containsKey("Amount")) {
      reimbursementDetail.amount = jsonObj["Amount"].toString();
    }

    if (jsonObj.containsKey("ReimbursementID")) {
      String reimbursementId = jsonObj["ReimbursementID"].toString();
      reimbursementId =
          reimbursementId != null && reimbursementId.isNotEmpty ? reimbursementId : "-1";
      Reimbursement reimbursement = ReimbursementDataHandler.getMasterReimbursementRecord(
          dbHandler,  reimbursementId);
      if (reimbursement != null) {
        reimbursementDetail.reimbursementID = reimbursement.id;
      }
    }

    if (jsonObj.containsKey("ReimbursementTypeID")) {
      String reimbursementTypeId = jsonObj["ReimbursementTypeID"].toString();
      reimbursementTypeId = reimbursementTypeId != null && reimbursementTypeId.isNotEmpty
          ? reimbursementTypeId
          : "-1";
      ReimbursementType reimbursementType = ReimbursementTypeDataHandler
          .getMasterReimbursementTypeRecord(dbHandler,  reimbursementTypeId);
      if (reimbursementType != null) {
        reimbursementDetail.reimbursementTypeID = reimbursementType.id;
      }
    }

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"].toString();
      activityId =
          activityId != null && activityId.isNotEmpty ? activityId : "-1";
      Activity activity =
          ActivityDataHandlerBase.getMasterActivityRecord(dbHandler,  activityId);
      if (activity != null) {
        reimbursementDetail.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("ActivityTravelID")) {
      String activityTravelId = jsonObj["ActivityTravelID"].toString();
      activityTravelId = activityTravelId != null && activityTravelId.isNotEmpty
          ? activityTravelId
          : "-1";
      ActivityTravel activityTravel = ActivityTravelDataHandler
          .getMasterActivityTravelRecord(dbHandler,  activityTravelId);
      if (activityTravel != null) {
        reimbursementDetail.activityTravelID = activityTravel.id;
      }
    }

    if (jsonObj.containsKey("Description")) {
      reimbursementDetail.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("DocumentPath")) {
      reimbursementDetail.documentPath = jsonObj["DocumentPath"].toString();
    }
    if (jsonObj.containsKey("DocumentContent")) {
      reimbursementDetail.documentContent = jsonObj["DocumentContent"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursementDetail.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      reimbursementDetail.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursementDetail.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      reimbursementDetail.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      reimbursementDetail.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      reimbursementDetail.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      reimbursementDetail.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      reimbursementDetail.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      reimbursementDetail.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      reimbursementDetail.isDeleted = jsonObj["IsDeleted"].toString();
    }

    reimbursementDetail.isDirty = "false";
    reimbursementDetail.isDeleted1 = "false";
    reimbursementDetail.upSyncMessage = "";
    reimbursementDetail.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursementDetail.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursementDetail.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      reimbursementDetail.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      reimbursementDetail.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    reimbursementDetail.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      reimbursementDetail.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    reimbursementDetail.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToReimbursementDetail()", ex);
  }
  return reimbursementDetail;
}

Future<ReimbursementType> copyJsonDataToReimbursementType(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ReimbursementType reimbursementType,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("ReimbursementTypeID")) {
      reimbursementType.reimbursementTypeID =
          jsonObj["ReimbursementTypeID"].toString();
    }
    if (jsonObj.containsKey("ReimbursementTypeCode")) {
      reimbursementType.reimbursementTypeCode =
          jsonObj["ReimbursementTypeCode"].toString();
    }
    if (jsonObj.containsKey("ReimbursementTypeName")) {
      reimbursementType.reimbursementTypeName =
          jsonObj["ReimbursementTypeName"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursementType.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      reimbursementType.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursementType.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      reimbursementType.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      reimbursementType.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      reimbursementType.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      reimbursementType.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      reimbursementType.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      reimbursementType.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      reimbursementType.isDeleted = jsonObj["IsDeleted"].toString();
    }

    reimbursementType.isDirty = "false";
    reimbursementType.isDeleted1 = "false";
    reimbursementType.upSyncMessage = "";
    reimbursementType.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      reimbursementType.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reimbursementType.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      reimbursementType.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      reimbursementType.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    reimbursementType.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      reimbursementType.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    reimbursementType.ownerUserID = Globals.AppUserID.toString();

  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToReimbursementType()", ex);
  }
  return reimbursementType;
}

Future<Reminder> copyJsonDataToReminder(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Reminder reminder,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("ReminderID")) {
      reminder.reminderID = jsonObj["ReminderID"].toString();
    }
    if (jsonObj.containsKey("ReminderCode")) {
      reminder.reminderCode = jsonObj["ReminderCode"].toString();
    }
    if (jsonObj.containsKey("ReminderTitle")) {
      reminder.reminderTitle = jsonObj["ReminderTitle"].toString();
    }
    if (jsonObj.containsKey("ReminderDescription")) {
      reminder.reminderDescription =
          jsonObj["ReminderDescription"].toString();
    }
    if (jsonObj.containsKey("ReminderDate")) {
      reminder.reminderDate = jsonObj["ReminderDate"].toString();
    }
    if (jsonObj.containsKey("ReminderTime")) {
      reminder.reminderTime = jsonObj["ReminderTime"].toString();
    }
    if (jsonObj.containsKey("ReminderRepeat")) {
      reminder.reminderRepeat = jsonObj["ReminderRepeat"].toString();
    }
    if (jsonObj.containsKey("RepeatNumber")) {
      reminder.repeatNumber = jsonObj["RepeatNumber"].toString();
    }
    if (jsonObj.containsKey("RepeatType")) {
      reminder.repeatType = jsonObj["RepeatType"].toString();
    }
    if (jsonObj.containsKey("Active")) {
      reminder.active = jsonObj["Active"].toString();
    }

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"].toString();
      activityId = activityId != null && activityId.isNotEmpty ? activityId : "-1";
      Activity? activity = await  ActivityDataHandlerBase.GetMasterActivityRecord(
          dbHandler,  activityId);
      if (activity != null) {
        reminder.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("OpportunityID")) {
      String opportunityId = jsonObj["OpportunityID"].toString();
      opportunityId =
          opportunityId != null && opportunityId.isNotEmpty ? opportunityId : "-1";
      Opportunity? opportunity = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(
          dbHandler,  opportunityId);
      if (opportunity != null) {
        reminder.opportunityID = opportunity.id;
      }
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account? account = await AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler,  accountId);
      if (account != null) {
        reminder.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("IsSetBySystem")) {
      reminder.isSetBySystem = jsonObj["IsSetBySystem"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      reminder.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      reminder.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      reminder.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reminder.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      reminder.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      reminder.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      reminder.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      reminder.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      reminder.isDeleted = jsonObj["IsDeleted"].toString();
    }

    reminder.isDirty = "false";
    reminder.isDeleted1 = "false";
    reminder.upSyncMessage = "";
    reminder.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      reminder.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      reminder.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      reminder.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      reminder.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    reminder.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      reminder.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    reminder.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToReminder()", ex);
  }
  return reminder;
}

Resource copyJsonDataToResource(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Resource resource,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("ResourceID")) {
      resource.resourceID = jsonObj["ResourceID"].toString();
    }
    if (jsonObj.containsKey("ResourceCode")) {
      resource.resourceCode = jsonObj["ResourceCode"].toString();
    }
    if (jsonObj.containsKey("ResourceName")) {
      resource.resourceName = jsonObj["ResourceName"].toString();
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"].toString();
      productId = productId != null && productId.isNotEmpty ? productId : "-1";
      Product? product =  await ProductDataHandlerBase.GetMasterProductRecord(
          dbHandler,  productId);
      if (product != null) {
        resource.productID = product.id;
      }
    }

    if (jsonObj.containsKey("ContentTypeID")) {
      String contentTypeId = jsonObj["ContentTypeID"].toString();
      contentTypeId =
          contentTypeId != null && contentTypeId.isNotEmpty ? contentTypeId : "-1";
      ContentType? contentType =await ContentTypeDataHandlerBaseBase.GetMasterContentTypeRecord(
          dbHandler,  contentTypeId);
      if (contentType != null) {
        resource.contentTypeID = contentType.id;
      }
    }

    if (jsonObj.containsKey("ResourcePath")) {
      resource.resourcePath = jsonObj["ResourcePath"].toString();
    }
    if (jsonObj.containsKey("ResourceContent")) {
      resource.resourceContent = jsonObj["ResourceContent"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      resource.description = jsonObj["Description"].toString();
    }
    if (jsonObj.containsKey("ResourceCategoryName")) {
      resource.resourceCategoryName = jsonObj["ResourceCategoryName"].toString();
    }
    if (jsonObj.containsKey("IsSharable")) {
      resource.isSharable = jsonObj["IsSharable"].toString();
    }
    if (jsonObj.containsKey("ValidUpTo")) {
      resource.validUpTo = jsonObj["ValidUpTo"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      resource.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      resource.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      resource.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      resource.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      resource.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      resource.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      resource.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      resource.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      resource.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      resource.isDeleted = jsonObj["IsDeleted"].toString();
    }

    resource.isDirty = "false";
    resource.isDeleted1 = "false";
    resource.upSyncMessage = "";
    resource.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      resource.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      resource.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      resource.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      resource.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    resource.upSyncIndex = "0";
    /* if (jsonObj.containsKey("AppUserID")) {
      resource.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    resource.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToResource()", ex);
  }
  return resource;
}
Future<ServiceInvoice> copyJsonDataToServiceInvoice(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ServiceInvoice serviceInvoice,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("ServiceInvoiceID")) {
      serviceInvoice.serviceInvoiceID = jsonObj["ServiceInvoiceID"].toString();
    }
    if (jsonObj.containsKey("ServiceInvoiceCode")) {
      serviceInvoice.serviceInvoiceCode = jsonObj["ServiceInvoiceCode"].toString();
    }
    if (jsonObj.containsKey("ServiceInvoiceTitle")) {
      serviceInvoice.serviceInvoiceTitle = jsonObj["ServiceInvoiceTitle"].toString();
    }
    if (jsonObj.containsKey("ServiceInvoiceDate")) {
      serviceInvoice.serviceInvoiceDate = jsonObj["ServiceInvoiceDate"].toString();
    }

    if (jsonObj.containsKey("AccountID")) {
      String accountId = jsonObj["AccountID"].toString();
      accountId = accountId != null && accountId.isNotEmpty ? accountId : "-1";
      Account? account = await  AccountDataHandlerBase.GetMasterAccountRecord(
          dbHandler,  accountId);
      if (account != null) {
        serviceInvoice.accountID = account.id;
      }
    }

    if (jsonObj.containsKey("ActivityID")) {
      String activityId = jsonObj["ActivityID"].toString();
      activityId = activityId != null && activityId.isNotEmpty ? activityId : "-1";
      Activity? activity = await  ActivityDataHandlerBase.GetMasterActivityRecord(
          dbHandler,  activityId);
      if (activity != null) {
        serviceInvoice.activityID = activity.id;
      }
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"].toString();
      productId = productId != null && productId.isNotEmpty ? productId : "-1";
      Product? product = await ProductDataHandlerBase.GetMasterProductRecord(
          dbHandler,  productId);
      if (product != null) {
        serviceInvoice.productID = product.id;
      }
    }

    if (jsonObj.containsKey("BarCode")) {
      serviceInvoice.barCode = jsonObj["BarCode"].toString();
    }
    if (jsonObj.containsKey("IsInWarranty")) {
      serviceInvoice.isInWarranty = jsonObj["IsInWarranty"].toString();
    }
    if (jsonObj.containsKey("ProductPartsPrice")) {
      serviceInvoice.productPartsPrice = jsonObj["ProductPartsPrice"].toString();
    }
    if (jsonObj.containsKey("ServiceCharge")) {
      serviceInvoice.serviceCharge = jsonObj["ServiceCharge"].toString();
    }
    if (jsonObj.containsKey("Tax")) {
      serviceInvoice.tax = jsonObj["Tax"].toString();
    }
    if (jsonObj.containsKey("TotalAmount")) {
      serviceInvoice.totalAmount = jsonObj["TotalAmount"].toString();
    }
    if (jsonObj.containsKey("AmountPaid")) {
      serviceInvoice.amountPaid = jsonObj["AmountPaid"].toString();
    }

    if (jsonObj.containsKey("CurrencyID")) {
      String currencyId = jsonObj["CurrencyID"].toString();
      currencyId = currencyId != null && currencyId.isNotEmpty ? currencyId : "-1";
      Currency ?currency = await  CurrencyDataHandlerBase.GetMasterCurrencyRecord(
          dbHandler, currencyId);
      if (currency != null) {
        serviceInvoice.currencyID = currency.id;
      }
    }

    if (jsonObj.containsKey("PaymentDate")) {
      serviceInvoice.paymentDate = jsonObj["PaymentDate"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      serviceInvoice.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      serviceInvoice.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      serviceInvoice.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      serviceInvoice.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      serviceInvoice.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      serviceInvoice.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      serviceInvoice.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      serviceInvoice.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      serviceInvoice.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      serviceInvoice.isDeleted = jsonObj["IsDeleted"].toString();
    }

    serviceInvoice.isDirty = "false";
    serviceInvoice.isDeleted1 = "false";
    serviceInvoice.upSyncMessage = "";
    serviceInvoice.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      serviceInvoice.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      serviceInvoice.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      serviceInvoice.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      serviceInvoice.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    serviceInvoice.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      serviceInvoice.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    serviceInvoice.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToServiceInvoice()", ex);
  }
  return serviceInvoice;
}

Future<ServiceInvoiceDetail> copyJsonDataToServiceInvoiceDetail(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    ServiceInvoiceDetail serviceInvoiceDetail,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("ServiceInvoiceDetailID")) {
      serviceInvoiceDetail.serviceInvoiceDetailID = jsonObj["ServiceInvoiceDetailID"].toString();
    }
    if (jsonObj.containsKey("ServiceInvoiceDetailCode")) {
      serviceInvoiceDetail.serviceInvoiceDetailCode = jsonObj["ServiceInvoiceDetailCode"].toString();
    }
    if (jsonObj.containsKey("ProductPartBarCode")) {
      serviceInvoiceDetail.productPartBarCode = jsonObj["ProductPartBarCode"].toString();
    }

    if (jsonObj.containsKey("ServiceInvoiceID")) {
      String serviceInvoiceId = jsonObj["ServiceInvoiceID"].toString();
      serviceInvoiceId = serviceInvoiceId != null && serviceInvoiceId.isNotEmpty ? serviceInvoiceId : "-1";
      ServiceInvoice? serviceInvoice = await ServiceInvoiceDataHandlerBase.GetMasterServiceInvoiceRecord(
          dbHandler,  serviceInvoiceId);
      if (serviceInvoice != null) {
        serviceInvoiceDetail.serviceInvoiceID = serviceInvoice.id;
      }
    }

    if (jsonObj.containsKey("ProductID")) {
      String productId = jsonObj["ProductID"].toString();
      productId = productId != null && productId.isNotEmpty ? productId : "-1";
      Product? product = await ProductDataHandlerBase.GetMasterProductRecord(
          dbHandler,  productId);
      if (product != null) {
        serviceInvoiceDetail.productID = product.id;
      }
    }

    if (jsonObj.containsKey("Quantity")) {
      serviceInvoiceDetail.quantity = jsonObj["Quantity"].toString();
    }
    if (jsonObj.containsKey("Rate")) {
      serviceInvoiceDetail.rate = jsonObj["Rate"].toString();
    }
    if (jsonObj.containsKey("Price")) {
      serviceInvoiceDetail.price = jsonObj["Price"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      serviceInvoiceDetail.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      serviceInvoiceDetail.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      serviceInvoiceDetail.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      serviceInvoiceDetail.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      serviceInvoiceDetail.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      serviceInvoiceDetail.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      serviceInvoiceDetail.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      serviceInvoiceDetail.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      serviceInvoiceDetail.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      serviceInvoiceDetail.isDeleted = jsonObj["IsDeleted"].toString();
    }

    serviceInvoiceDetail.isDirty = "false";
    serviceInvoiceDetail.isDeleted1 = "false";
    serviceInvoiceDetail.upSyncMessage = "";
    serviceInvoiceDetail.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      serviceInvoiceDetail.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      serviceInvoiceDetail.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      serviceInvoiceDetail.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      serviceInvoiceDetail.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    serviceInvoiceDetail.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      serviceInvoiceDetail.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    serviceInvoiceDetail.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToServiceInvoiceDetail()", ex);
  }
  return serviceInvoiceDetail;
}


Future<Tag> copyJsonDataToTag(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Tag tag,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("TagID")) {
      tag.tagID = jsonObj["TagID"].toString();
    }
    if (jsonObj.containsKey("TagCode")) {
      tag.tagCode = jsonObj["TagCode"].toString();
    }
    if (jsonObj.containsKey("TagName")) {
      tag.tagName = jsonObj["TagName"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      tag.description = jsonObj["Description"].toString();
    }

    if (jsonObj.containsKey("ParentTagID")) {
      String tagId = jsonObj["ParentTagID"].toString();
      tagId = tagId != null && tagId.isNotEmpty ? tagId : "-1";
      Tag? tag1 =  await TagDataHandlerBase.GetMasterTagRecord(dbHandler,  tagId);
      if (tag1 != null) {
        tag.parentTagID = tag1.id;
      }
    }

    if (jsonObj.containsKey("TagGroupID")) {
      String tagGroupId = jsonObj["TagGroupID"].toString();
      tagGroupId = tagGroupId != null && tagGroupId.isNotEmpty ? tagGroupId : "-1";
      TagGroup? tagGroup = await TagGroupDataHandlerBase.GetMasterTagGroupRecord(dbHandler,  tagGroupId);
      if (tagGroup != null) {
        tag.tagGroupID = tagGroup.id;
      }
    }

    if (jsonObj.containsKey("SortOrder")) {
      tag.sortOrder = jsonObj["SortOrder"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      tag.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      tag.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      tag.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      tag.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("DeviceIdentifier")) {
      tag.deviceIdentifier = jsonObj["DeviceIdentifier"].toString();
    }
    if (jsonObj.containsKey("ReferenceIdentifier")) {
      tag.referenceIdentifier = jsonObj["ReferenceIdentifier"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      tag.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      tag.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      tag.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      tag.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      tag.isDeleted = jsonObj["IsDeleted"].toString();
    }

    tag.isDirty = "false";
    tag.isDeleted1 = "false";
    tag.upSyncMessage = "";
    tag.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      tag.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      tag.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      tag.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      tag.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    tag.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      tag.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    tag.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToTag()", ex);
  }
  return tag;
}

Future<TagGroup> copyJsonDataToTagGroup(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    TagGroup tagGroup,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("TagGroupID")) {
      tagGroup.tagGroupID = jsonObj["TagGroupID"].toString();
    }
    if (jsonObj.containsKey("TagGroupCode")) {
      tagGroup.tagGroupCode = jsonObj["TagGroupCode"].toString();
    }
    if (jsonObj.containsKey("TagGroupName")) {
      tagGroup.tagGroupName = jsonObj["TagGroupName"].toString();
    }

    if (jsonObj.containsKey("BusinessFeatureID")) {
      String businessFeatureId = jsonObj["BusinessFeatureID"].toString();
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty ? businessFeatureId : "-1";
      BusinessFeature ?businessFeature = await BusinessFeatureDataHandlerBase.GetMasterBusinessFeatureRecord(dbHandler,  businessFeatureId);
      if (businessFeature != null) {
        tagGroup.businessFeatureID = businessFeature.id;
      }
    }

    if (jsonObj.containsKey("LinkTo")) {
      tagGroup.linkTo = jsonObj["LinkTo"].toString();
    }
    if (jsonObj.containsKey("SortOrder")) {
      tagGroup.sortOrder = jsonObj["SortOrder"].toString();
    }
    if (jsonObj.containsKey("DisplayInApp")) {
      tagGroup.displayInApp = jsonObj["DisplayInApp"].toString();
    }
    if (jsonObj.containsKey("PositionIndex")) {
      tagGroup.positionIndex = jsonObj["PositionIndex"].toString();
    }
    if (jsonObj.containsKey("AllowNewValues")) {
      tagGroup.allowNewValues = jsonObj["AllowNewValues"].toString();
    }
    if (jsonObj.containsKey("UseInBusinessTarget")) {
      tagGroup.useInBusinessTarget = jsonObj["UseInBusinessTarget"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      tagGroup.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      tagGroup.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      tagGroup.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      tagGroup.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      tagGroup.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      tagGroup.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      tagGroup.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      tagGroup.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      tagGroup.isDeleted = jsonObj["IsDeleted"].toString();
    }

    tagGroup.isDirty = "false";
    tagGroup.isDeleted1 = "false";
    tagGroup.upSyncMessage = "";
    tagGroup.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      tagGroup.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      tagGroup.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      tagGroup.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      tagGroup.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    tagGroup.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      tagGroup.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    tagGroup.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToTagGroup()", ex);
  }
  return tagGroup;
}

Future<Territory> copyJsonDataToTerritory(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    Territory territory,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("TerritoryID")) {
      territory.territoryID = jsonObj["TerritoryID"].toString();
    }
    if (jsonObj.containsKey("TerritoryCode")) {
      territory.territoryCode = jsonObj["TerritoryCode"].toString();
    }
    if (jsonObj.containsKey("TerritoryName")) {
      territory.territoryName = jsonObj["TerritoryName"].toString();
    }
    if (jsonObj.containsKey("Description")) {
      territory.description = jsonObj["Description"].toString();
    }

    if (jsonObj.containsKey("ParentTerritoryID")) {
      String territoryId = jsonObj["ParentTerritoryID"].toString();
      territoryId = territoryId != null && territoryId.isNotEmpty ? territoryId : "-1";
      Territory? territory1 = await TerritoryDataHandlerBase.GetMasterTerritoryRecord(dbHandler,  territoryId);
      if (territory1 != null) {
        territory.parentTerritoryID = territory1.id;
      }
    }

    if (jsonObj.containsKey("CreatedOn")) {
      territory.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      territory.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      territory.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      territory.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      territory.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      territory.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      territory.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      territory.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      territory.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      territory.isDeleted = jsonObj["IsDeleted"].toString();
    }

    territory.isDirty = "false";
    territory.isDeleted1 = "false";
    territory.upSyncMessage = "";
    territory.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      territory.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      territory.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      territory.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      territory.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    territory.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      territory.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    territory.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToTerritory()", ex);
  }
  return territory;
}


TimeZone copyJsonDataToTimeZone(
     
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    TimeZone timeZone,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("TimeZoneID")) {
      timeZone.timeZoneID = jsonObj["TimeZoneID"].toString();
    }
    if (jsonObj.containsKey("TimeZoneCode")) {
      timeZone.timeZoneCode = jsonObj["TimeZoneCode"].toString();
    }
    if (jsonObj.containsKey("TimeZoneName")) {
      timeZone.timeZoneName = jsonObj["TimeZoneName"].toString();
    }
    if (jsonObj.containsKey("GMTOffSet")) {
      timeZone.gmtOffSet = jsonObj["GMTOffSet"].toString();
    }
    if (jsonObj.containsKey("GMTOffSetInMinutes")) {
      timeZone.gmtOffSetInMinutes = jsonObj["GMTOffSetInMinutes"].toString();
    }
    if (jsonObj.containsKey("ServerRelativeOffSet")) {
      timeZone.serverRelativeOffSet = jsonObj["ServerRelativeOffSet"].toString();
    }
    if (jsonObj.containsKey("DSTCorrection")) {
      timeZone.dstCorrection = jsonObj["DSTCorrection"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      timeZone.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      timeZone.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      timeZone.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      timeZone.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      timeZone.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      timeZone.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      timeZone.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      timeZone.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      timeZone.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      timeZone.isDeleted = jsonObj["IsDeleted"].toString();
    }

    timeZone.isDirty = "false";
    timeZone.isDeleted1 = "false";
    timeZone.upSyncMessage = "";
    timeZone.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      timeZone.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      timeZone.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      timeZone.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      timeZone.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    timeZone.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      timeZone.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    timeZone.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException( "JSONDataCopier:CopyJsonDataToTimeZone()", ex);
  }
  return timeZone;
}

Future<TravelPurpose> copyJsonDataToTravelPurpose(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    TravelPurpose travelPurpose,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey("TravelPurposeID")) {
      travelPurpose.travelPurposeID = jsonObj["TravelPurposeID"].toString();
    }
    if (jsonObj.containsKey("TravelPurposeCode")) {
      travelPurpose.travelPurposeCode = jsonObj["TravelPurposeCode"].toString();
    }
    if (jsonObj.containsKey("TravelPurposeName")) {
      travelPurpose.travelPurposeName = jsonObj["TravelPurposeName"].toString();
    }
    if (jsonObj.containsKey("TravelPurposeDescription")) {
      travelPurpose.travelPurposeDescription =
          jsonObj["TravelPurposeDescription"].toString();
    }

    if (jsonObj.containsKey("BusinessFeatureID")) {
      String businessFeatureId = jsonObj["BusinessFeatureID"].toString();
      businessFeatureId = businessFeatureId != null && businessFeatureId.isNotEmpty
          ? businessFeatureId
          : "-1";
      BusinessFeature ?businessFeature =await  BusinessFeatureDataHandlerBase
          .GetMasterBusinessFeatureRecord(dbHandler,  businessFeatureId);
      if (businessFeature != null) {
        travelPurpose.businessFeatureID = businessFeature.id;
      }
    }

    if (jsonObj.containsKey("CreatedOn")) {
      travelPurpose.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      travelPurpose.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      travelPurpose.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      travelPurpose.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      travelPurpose.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      travelPurpose.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      travelPurpose.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      travelPurpose.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      travelPurpose.isDeleted = jsonObj["IsDeleted"].toString();
    }

    travelPurpose.isDirty = "false";
    travelPurpose.isDeleted1 = "false";
    travelPurpose.upSyncMessage = "";
    travelPurpose.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      travelPurpose.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      travelPurpose.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      travelPurpose.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      travelPurpose.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    travelPurpose.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      travelPurpose.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    travelPurpose.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToTravelPurpose()", ex);
  }
  return travelPurpose;
}

UserRole copyJsonDataToUserRole(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    UserRole userRole,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("UserRoleID")) {
      userRole.userRoleID = jsonObj["UserRoleID"].toString();
    }
    if (jsonObj.containsKey("UserRoleCode")) {
      userRole.userRoleCode = jsonObj["UserRoleCode"].toString();
    }
    if (jsonObj.containsKey("UserRoleName")) {
      userRole.userRoleName = jsonObj["UserRoleName"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      userRole.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      userRole.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      userRole.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      userRole.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      userRole.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("IsSystemDefined")) {
      userRole.isSystemDefined = jsonObj["IsSystemDefined"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      userRole.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      userRole.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      userRole.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsArchived")) {
      userRole.isArchived = jsonObj["IsArchived"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      userRole.isDeleted = jsonObj["IsDeleted"].toString();
    }

    userRole.isDirty = "false";
    userRole.isDeleted1 = "false";
    userRole.upSyncMessage = "";
    userRole.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      userRole.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      userRole.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      userRole.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      userRole.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    userRole.upSyncIndex = "0";
    /*if (jsonObj.containsKey("AppUserID")) {
      userRole.ownerUserID = jsonObj["AppUserID"].toString();
    }*/
    userRole.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToUserRole()", ex);
  }
  return userRole;
}
HSSupportTicket copyJsonDataToHSSupportTicket(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    HSSupportTicket hSSupportTicket,
    bool isForNew) {
  try {
    if (jsonObj.containsKey("HSSupportTicketID")) {
      hSSupportTicket.hSSupportTicketID =
          jsonObj["HSSupportTicketID"].toString();
    }
    if (jsonObj.containsKey("HSSupportTicketCode")) {
      hSSupportTicket.hSSupportTicketCode =
          jsonObj["HSSupportTicketCode"].toString();
    }
    if (jsonObj.containsKey("HSSupportTicketTitle")) {
      hSSupportTicket.hSSupportTicketTitle =
          jsonObj["HSSupportTicketTitle"].toString();
    }
    if (jsonObj.containsKey("HSSupportTicketType")) {
      hSSupportTicket.hSSupportTicketType =
          jsonObj["HSSupportTicketType"].toString();
    }
    if (jsonObj.containsKey("HSSupportTicketDetail")) {
      hSSupportTicket.hSSupportTicketDetail =
          jsonObj["HSSupportTicketDetail"].toString();
    }
    if (jsonObj.containsKey("CreatedBy")) {
      hSSupportTicket.createdBy = jsonObj["CreatedBy"].toString();
    }
    if (jsonObj.containsKey("CreatedOn")) {
      hSSupportTicket.createdOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedBy")) {
      hSSupportTicket.modifiedBy = jsonObj["ModifiedBy"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      hSSupportTicket.modifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("ParentHSSupportTicketID")) {
      hSSupportTicket.parentHSSupportTicketID =
          jsonObj["ParentHSSupportTicketID"].toString();
    }
    if (jsonObj.containsKey("AssignedToHSUserID")) {
      hSSupportTicket.assignedToHSUserID =
          jsonObj["AssignedToHSUserID"].toString();
    }
    if (jsonObj.containsKey("TicketStatus")) {
      hSSupportTicket.ticketStatus = jsonObj["TicketStatus"].toString();
    }
    if (jsonObj.containsKey("Resolution")) {
      hSSupportTicket.resolution = jsonObj["Resolution"].toString();
    }
    if (jsonObj.containsKey("ResolutionTime")) {
      hSSupportTicket.resolutionTime = jsonObj["ResolutionTime"].toString();
    }
    if (jsonObj.containsKey("IsActive")) {
      hSSupportTicket.isActive = jsonObj["IsActive"].toString();
    }
    if (jsonObj.containsKey("Uid")) {
      hSSupportTicket.uid = jsonObj["Uid"].toString();
    }
    if (jsonObj.containsKey("AppUserID")) {
      hSSupportTicket.appUserID = jsonObj["AppUserID"].toString();
    }
    if (jsonObj.containsKey("AppUserGroupID")) {
      hSSupportTicket.appUserGroupID = jsonObj["AppUserGroupID"].toString();
    }
    if (jsonObj.containsKey("IsDeleted")) {
      hSSupportTicket.isDeleted = jsonObj["IsDeleted"].toString();
    }

    hSSupportTicket.isDirty = "false";
    hSSupportTicket.isDeleted1 = "false";
    hSSupportTicket.upSyncMessage = "";
    hSSupportTicket.downSyncMessage = "";
    if (jsonObj.containsKey("CreatedOn")) {
      hSSupportTicket.sCreatedOn = jsonObj["CreatedOn"].toString();
    }
    if (jsonObj.containsKey("ModifiedOn")) {
      hSSupportTicket.sModifiedOn = jsonObj["ModifiedOn"].toString();
    }
    if (jsonObj.containsKey("CreatedByUser")) {
      hSSupportTicket.createdByUser = jsonObj["CreatedByUser"].toString();
    }
    if (jsonObj.containsKey("ModifiedByUser")) {
      hSSupportTicket.modifiedByUser = jsonObj["ModifiedByUser"].toString();
    }
    hSSupportTicket.upSyncIndex = "0";
    hSSupportTicket.ownerUserID = Globals.AppUserID.toString();
  } catch (ex) {
    Globals.handleException(
         "JSONDataCopier:CopyJsonDataToHSSupportTicket()", ex);
  }
  return hSSupportTicket;
}
Future<HSSupportTicketMedia> copyJsonDataToHSSupportTicketMedia(
    DatabaseHandler dbHandler,
    Map<String, dynamic> jsonObj,
    HSSupportTicketMedia hSSupportTicketMedia,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('HSSupportTicketMediaID')) {
      hSSupportTicketMedia.hSSupportTicketMediaID =
          jsonObj['HSSupportTicketMediaID'];
    }
    if (jsonObj.containsKey('HSSupportTicketMediaCode')) {
      hSSupportTicketMedia.hSSupportTicketMediaCode =
          jsonObj['HSSupportTicketMediaCode'];
    }
    if (jsonObj.containsKey('HSSupportTicketMediaName')) {
      hSSupportTicketMedia.hSSupportTicketMediaName =
          jsonObj['HSSupportTicketMediaName'];
    }

    if (jsonObj.containsKey('HSSupportTicketID')) {
      String hSSupportTicketId = jsonObj['HSSupportTicketID'];
      hSSupportTicketId = hSSupportTicketId != null && hSSupportTicketId != ''
          ? hSSupportTicketId
          : '-1';
      HSSupportTicket? hSSupportTicket =await
          HSSupportTicketDataHandlerBase.GetMasterHSSupportTicketRecord(
              dbHandler, hSSupportTicketId);
      if (hSSupportTicket != null) {
        hSSupportTicketMedia.hSSupportTicketID = hSSupportTicket.id;
      }
    }

    if (jsonObj.containsKey('ContentTypeID')) {
      String contentTypeId = jsonObj['ContentTypeID'];
      contentTypeId = contentTypeId != null && contentTypeId != ''
          ? contentTypeId
          : '-1';
      ContentType? contentType =await
          ContentTypeDataHandlerBase.GetMasterContentTypeRecord(
              dbHandler, contentTypeId);
      if (contentType != null) {
        hSSupportTicketMedia.contentTypeID = contentType.id;
      }
    }

    if (jsonObj.containsKey('MediaPath')) {
      hSSupportTicketMedia.mediaPath = jsonObj['MediaPath'];
    }
    if (jsonObj.containsKey('MediaContent')) {
      hSSupportTicketMedia.mediaContent = jsonObj['MediaContent'];
    }
    if (jsonObj.containsKey('Description')) {
      hSSupportTicketMedia.description = jsonObj['Description'];
    }
    if (jsonObj.containsKey('Tags')) {
      hSSupportTicketMedia.tags = jsonObj['Tags'];
    }
    if (jsonObj.containsKey('CreatedBy')) {
      hSSupportTicketMedia.createdBy = jsonObj['CreatedBy'];
    }
    if (jsonObj.containsKey('CreatedOn')) {
      hSSupportTicketMedia.createdOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      hSSupportTicketMedia.modifiedBy = jsonObj['ModifiedBy'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      hSSupportTicketMedia.modifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('DeviceIdentifier')) {
      hSSupportTicketMedia.deviceIdentifier = jsonObj['DeviceIdentifier'];
    }
    if (jsonObj.containsKey('ReferenceIdentifier')) {
      hSSupportTicketMedia.referenceIdentifier =
          jsonObj['ReferenceIdentifier'];
    }
    if (jsonObj.containsKey('IsActive')) {
      hSSupportTicketMedia.isActive = jsonObj['IsActive'];
    }
    if (jsonObj.containsKey('Uid')) {
      hSSupportTicketMedia.uid = jsonObj['Uid'];
    }
    if (jsonObj.containsKey('AppUserID')) {
      hSSupportTicketMedia.appUserID = jsonObj['AppUserID'];
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      hSSupportTicketMedia.appUserGroupID = jsonObj['AppUserGroupID'];
    }
    if (jsonObj.containsKey('IsArchived')) {
      hSSupportTicketMedia.isArchived = jsonObj['IsArchived'];
    }
    if (jsonObj.containsKey('IsDeleted')) {
      hSSupportTicketMedia.isDeleted = jsonObj['IsDeleted'];
    }

    hSSupportTicketMedia.isDirty = 'false';
    hSSupportTicketMedia.isDeleted1 = 'false';
    hSSupportTicketMedia.upSyncMessage = '';
    hSSupportTicketMedia.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      hSSupportTicketMedia.sCreatedOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      hSSupportTicketMedia.sModifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      hSSupportTicketMedia.createdByUser = jsonObj['CreatedByUser'];
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      hSSupportTicketMedia.modifiedByUser = jsonObj['ModifiedByUser'];
    }
    hSSupportTicketMedia.upSyncIndex = '0';
    hSSupportTicketMedia.ownerUserID = '${Globals.AppUserID}';

  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToHSSupportTicketMedia()', ex);
  }
  return hSSupportTicketMedia;
}

Future<AccountPermission> copyJsonDataToAccountPermission(
    DatabaseHandler dbHandler ,
    dynamic jsonObj,
    AccountPermission accountPermission,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('AccountPermissionID')) {
      accountPermission.accountPermissionID =
          jsonObj['AccountPermissionID'];
    }
    if (jsonObj.containsKey('AccountPermissionCode')) {
      accountPermission.assignmentPermissionTypeCode =
          jsonObj['AccountPermissionCode'];
    }
    if (jsonObj.containsKey('AccountID')) {
      accountPermission.accountID = jsonObj['AccountID'];
    }

    if (jsonObj.containsKey('AppUserID')) {
      accountPermission.appUserID = jsonObj['AppUserID'];
    }

    if (jsonObj.containsKey('AssignmentPermissionTypeID')) {
      accountPermission.assignmentPermissionTypeID =
          jsonObj['AssignmentPermissionTypeID'];
    }
    if (jsonObj.containsKey('IsDenied')) {
      accountPermission.isDenied = jsonObj['IsDenied'];
    }

    if (jsonObj.containsKey('CreatedBy')) {
      accountPermission.createdBy = jsonObj['CreatedBy'];
    }
    if (jsonObj.containsKey('CreatedOn')) {
      accountPermission.createdOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      accountPermission.modifiedBy = jsonObj['ModifiedBy'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountPermission.modifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('IsActive')) {
      accountPermission.isActive = jsonObj['IsActive'];
    }
    if (jsonObj.containsKey('Uid')) {
      accountPermission.uid = jsonObj['Uid'];
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      accountPermission.appUserGroupID = jsonObj['AppUserGroupID'];
    }
    if (jsonObj.containsKey('IsArchived')) {
      accountPermission.isArchived = jsonObj['IsArchived'];
    }
    if (jsonObj.containsKey('IsDeleted')) {
      accountPermission.isDeleted = jsonObj['IsDeleted'];
    }
    if (jsonObj.containsKey('AccountName')) {
      accountPermission.accountName = jsonObj['AccountName'];
    }
    if (jsonObj.containsKey('AppUserName')) {
      accountPermission.appUserName = jsonObj['AppUserName'];
    }

    accountPermission.isDirty = 'false';
    accountPermission.isDeleted1 = 'false';
    accountPermission.upSyncMessage = '';
    accountPermission.downSyncMessage = '';

    if (jsonObj.containsKey('CreatedOn')) {
      accountPermission.sCreatedOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      accountPermission.sModifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      accountPermission.createdByUser = jsonObj['CreatedByUser'];
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      accountPermission.modifiedByUser = jsonObj['ModifiedByUser'];
    }
    accountPermission.upSyncIndex = '0';

    accountPermission.ownerUserID = '${Globals.AppUserID}';

  } catch (ex) {
    Globals.handleException(
         'JSONDataCopier:CopyJsonDataToAccountPermission()', ex);
  }
  return accountPermission;
}

Future<Unit> copyJsonDataToUnit(
    DatabaseHandler dbHandler,
    dynamic jsonObj,
    Unit unit,
    bool isForNew) async {
  try {
    if (jsonObj.containsKey('UnitID')) {
      unit.unitID = jsonObj['UnitID'];
    }
    if (jsonObj.containsKey('UnitCode')) {
      unit.unitCode = jsonObj['UnitCode'];
    }
    if (jsonObj.containsKey('UnitName')) {
      unit.unitName = jsonObj['UnitName'];
    }
    if (jsonObj.containsKey('ShortForm')) {
      unit.shortForm = jsonObj['ShortForm'];
    }
    if (jsonObj.containsKey('NumberSystemBase')) {
      unit.numberSystemBase = jsonObj['NumberSystemBase'];
    }

    if (jsonObj.containsKey('ParentUnitID')) {
      String unitId = jsonObj['ParentUnitID'];
      unitId = unitId != null && unitId.isNotEmpty ? unitId : '-1';
      Unit? unit1 =  await UnitDataHandlerBase.GetMasterUnitRecord(dbHandler, unitId);
      if (unit1 != null) {
        unit.parentUnitID = unit1.id;
      }
    }

    if (jsonObj.containsKey('ConversionFactor')) {
      unit.conversionFactor = jsonObj['ConversionFactor'];
    }
    if (jsonObj.containsKey('CreatedOn')) {
      unit.createdOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('CreatedBy')) {
      unit.createdBy = jsonObj['CreatedBy'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      unit.modifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('ModifiedBy')) {
      unit.modifiedBy = jsonObj['ModifiedBy'];
    }
    if (jsonObj.containsKey('IsActive')) {
      unit.isActive = jsonObj['IsActive'];
    }
    if (jsonObj.containsKey('Uid')) {
      unit.uid = jsonObj['Uid'];
    }
    if (jsonObj.containsKey('AppUserID')) {
      unit.appUserID = jsonObj['AppUserID'];
    }
    if (jsonObj.containsKey('AppUserGroupID')) {
      unit.appUserGroupID = jsonObj['AppUserGroupID'];
    }
    if (jsonObj.containsKey('IsArchived')) {
      unit.isArchived = jsonObj['IsArchived'];
    }
    if (jsonObj.containsKey('IsDeleted')) {
      unit.isDeleted = jsonObj['IsDeleted'];
    }

    unit.isDirty = 'false';
    unit.isDeleted1 = 'false';
    unit.upSyncMessage = '';
    unit.downSyncMessage = '';
    if (jsonObj.containsKey('CreatedOn')) {
      unit.sCreatedOn = jsonObj['CreatedOn'];
    }
    if (jsonObj.containsKey('ModifiedOn')) {
      unit.sModifiedOn = jsonObj['ModifiedOn'];
    }
    if (jsonObj.containsKey('CreatedByUser')) {
      unit.createdByUser = jsonObj['CreatedByUser'];
    }
    if (jsonObj.containsKey('ModifiedByUser')) {
      unit.modifiedByUser = jsonObj['ModifiedByUser'];
    }
    unit.upSyncIndex = '0';
    unit.ownerUserID = '${Globals.AppUserID}';
  } catch (ex) {
    Globals.handleException( 'JSONDataCopier:CopyJsonDataToUnit()', ex);
  }
  return unit;
}

}






