import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:happsales_crm/database/AppTables/ColumnsBase.dart';
import 'package:happsales_crm/database/AppTables/TablesBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountBusinessUnitHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountFormValueDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountPhoneDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityTravelMappingDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactAlignmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityMediaDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityProductDetailDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityStageDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/ChatMessageDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CountryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OtherHandlers/CustomerMeetingDataHandlerBase.dart';
import 'package:happsales_crm/database/models/ActivityModels/ActivityBusinessUnit.dart';
import 'package:logger/logger.dart';

import '../../models/contact_title.dart';
import '../Handlers/AccountHandlers/AccountAddressDataHandlerBase.dart';
import '../Handlers/AccountHandlers/AccountBuyingProcessDataHandlerBase.dart';
import '../Handlers/AccountHandlers/AccountMappingDataHandler.dart';
import '../Handlers/AccountHandlers/AccountMappingDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityMediaDataHandler.dart';
import '../Handlers/ActivityHandlers/ActivityTravelExpenseDataHandlerBase.dart';
import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import '../Handlers/ContactHandlers/ContactHandlerDataBase.dart';
import '../Handlers/ContactHandlers/ContactHandlerDataBaseBase.dart';
import '../Handlers/ContactHandlers/ContactMediaDataHandler.dart';
import '../Handlers/ContactHandlers/ContactMediaDataHandlerBase.dart';
import '../Handlers/ContactHandlers/ContactTitleDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityApprovalDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityApprovalTypeDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityBusinessUnitDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityContactHandlerDataBaseBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityFulfillmentStatusDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityMeasureDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityMediaDataHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityNameDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityPermissionDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityProductDetailAttributeDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityStageTypeDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityTeamDataHandlerBase.dart';
import '../Handlers/OtherHandlers/AppUserLocationDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ChatUserAndGroupDataHandler.dart';
import '../Handlers/OtherHandlers/ChatUserAndGroupDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ChatUserGroupMemberDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CompetitorDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ContentTypeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CreditRatingDataHandlerBase.dart';
import '../Handlers/OtherHandlers/CurrencyDataHandlerBaseBase.dart';
import '../Handlers/OtherHandlers/DesignationDataHandlerBase.dart';
import '../Handlers/OtherHandlers/EmailManualTemplateDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ExpenseTypeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FieldAttendanceDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FinancialInstitutionDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FinancialYearDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FormCellDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FormCellElementDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FormDataHandlerBase.dart';
import '../Handlers/OtherHandlers/FormSectionDataHandlerBase.dart';
import '../Handlers/OtherHandlers/HSSupportTicketDataHandlerBase.dart';
import '../Handlers/OtherHandlers/HSSupportTicketMediaDataHandlerBase.dart';
import '../Handlers/OtherHandlers/IndustryDataHandlerBase.dart';
import '../Handlers/OtherHandlers/LeadSourceDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ModeOfTravelDataHandlerBase.dart';
import '../Handlers/OtherHandlers/NoteDataHandlerBase.dart';
import '../Handlers/OtherHandlers/NoteMediaDataHandler.dart';
import '../Handlers/OtherHandlers/NoteMediaDataHandlerBase.dart';
import '../Handlers/OtherHandlers/NotePermissionDataHandlerBase.dart';
import '../Handlers/OtherHandlers/NotificationAssignmentDataHandlerBase.dart';
import '../Handlers/OtherHandlers/NotificationDataHandlerBase.dart';
import '../Handlers/OtherHandlers/PerformanceSummaryDataHandlerBase.dart';
import '../Handlers/OtherHandlers/PhoneTypeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ProductCategoryDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ProductDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ReimbursementTypeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ReminderDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ResourceDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ServiceInvoiceDataHandlerBase.dart';
import '../Handlers/OtherHandlers/ServiceInvoiceDetailDataHandlerBase.dart';
import '../Handlers/OtherHandlers/SyncDataHandler.dart';
import '../Handlers/OtherHandlers/TagDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TagGroupDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TerritoryDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TimeZoneDataHandlerBase.dart';
import '../Handlers/OtherHandlers/TravelPurposeDataHandlerBase.dart';
import '../Handlers/OtherHandlers/UnitDataHandlerBase.dart';
import '../models/AccountModels/AccountCategory.dart';
import '../models/AccountModels/AccountSegment.dart';
import '../models/AccountModels/AccountStatus.dart';
import '../models/ActivityModels/ActivityApprovalType.dart';
import '../models/ActivityModels/ActivityMeasure.dart';
import '../models/ContactModels.dart/ContactAlignment.dart';
import '../models/ContactModels.dart/ContactCategory.dart';
import '../models/OpportunityModels/OpportunityApprovalType.dart';
import '../models/OpportunityModels/OpportunityFulfillmentStatus.dart';
import '../models/OpportunityModels/OpportunityMeasure.dart';
import '../models/OpportunityModels/OpportunityName.dart';
import '../models/OpportunityModels/OpportunityProductDetailAttribute.dart';
import '../models/OpportunityModels/OpportunityStatus.dart';
import '../models/OpportunityModels/OpportunityType.dart';
import '../models/OtherModels/AppFeatureField.dart';
import '../models/OtherModels/AppFeatureGroup.dart';
import '../models/OtherModels/AppLog.dart';
import '../models/OtherModels/AppReport.dart';
import '../models/OtherModels/AppSyncItem.dart';
import '../models/OtherModels/AppUser.dart';
import '../models/OtherModels/AppUserTeam.dart';
import '../models/OtherModels/AppUserTeamMember.dart';
import '../models/OtherModels/AttributeValue.dart';
import '../models/OtherModels/BusinessEmail.dart';
import '../models/OtherModels/BusinessFeature.dart';
import '../models/OtherModels/BusinessUnit.dart';
import '../models/OtherModels/ChatUserAndGroup.dart';
import '../models/OtherModels/ChatUserGroupMember.dart';
import '../models/OtherModels/Competitor.dart';
import '../models/OtherModels/ContentType.dart';
import '../models/OtherModels/Country.dart';
import '../models/OtherModels/CreditRating.dart';
import '../models/OtherModels/Currency.dart';
import '../models/OtherModels/Designation.dart';
import '../models/OtherModels/EmailManualTemplate.dart';
import '../models/OtherModels/ExpenseType.dart';
import '../models/OtherModels/FinancialInstitution.dart';
import '../models/OtherModels/FinancialYear.dart';
import '../models/OtherModels/Form.dart';
import '../models/OtherModels/FormCell.dart';
import '../models/OtherModels/FormCellElement.dart';
import '../models/OtherModels/FormSection.dart';
import '../models/OtherModels/Industry..dart';
import '../models/OtherModels/LeadSource.dart';
import '../models/OtherModels/ModeOfTravel.dart';
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
import '../models/OtherModels/ReimbursementType.dart';
import '../models/OtherModels/Reminder.dart';

import '../AppConstants.dart';
import '../Globals.dart';
import '../Handlers/AccountHandlers/AccountDataHandler.dart';
import '../Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandler.dart';
import '../Handlers/ActivityHandlers/ActivityProductDataHandler.dart';
import '../Handlers/ActivityHandlers/ActivityProductDetailDataHandler.dart';
import '../Handlers/DataBaseHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityProductDataHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityProductDetailDataHandler.dart';
import '../models/AccountModels/Account.dart';
import '../models/AccountModels/AccountAddress.dart';
import '../models/AccountModels/AccountBusinessPlan.dart';
import '../models/AccountModels/AccountBusinessUnit.dart';
import '../models/AccountModels/AccountBuyingProcess.dart';
import '../models/AccountModels/AccountCategoryMapping.dart';
import '../models/AccountModels/AccountCompetitionActivity.dart';
import '../models/AccountModels/AccountForm.dart';
import '../models/AccountModels/AccountFormValue.dart';
import '../models/AccountModels/AccountMedia.dart';
import '../models/AccountModels/AccountPhone.dart';
import '../models/ActivityModels/Activity.dart';
import '../models/ActivityModels/ActivityApproval.dart';
import '../models/ActivityModels/ActivityMedia.dart';
import '../models/ActivityModels/ActivityPermission.dart';
import '../models/ActivityModels/ActivityProduct.dart';
import '../models/ActivityModels/ActivityProductDetail.dart';
import '../models/ActivityModels/ActivityTeam.dart';
import '../models/ActivityModels/ActivityTravel.dart';
import '../models/ActivityModels/ActivityTravelExpense.dart';
import '../models/ActivityModels/ActivityTravelMapping.dart';
import '../models/ActivityModels/ActivityTravelMedia.dart';
import '../models/ContactModels.dart/Contact.dart';
import '../models/ContactModels.dart/ContactMedia.dart';
import '../models/OpportunityModels/Opportunity.dart';
import '../models/OpportunityModels/OpportunityApproval.dart';
import '../models/OpportunityModels/OpportunityBusinessUnit.dart';
import '../models/OpportunityModels/OpportunityContact.dart';
import '../models/OpportunityModels/OpportunityMedia.dart';
import '../models/OpportunityModels/OpportunityPermission.dart';
import '../models/OpportunityModels/OpportunityProduct.dart';
import '../models/OpportunityModels/OpportunityProductDetail.dart';
import '../models/OpportunityModels/OpportunityTeam.dart';
import '../models/OtherModels/AppUserLocation.dart';
import '../models/OtherModels/AppUserMessage.dart';
import '../models/OtherModels/AppUserRemark.dart';
import '../models/OtherModels/ChatMessage.dart';
import '../models/OtherModels/CustomerMeeting.dart';
import '../models/OtherModels/FieldAttendance.dart';
import '../models/OtherModels/HSSupportTicket.dart';
import '../models/OtherModels/HSSupportTicketMedia.dart';
import '../models/OtherModels/Note.dart';
import '../models/OtherModels/NoteMedia.dart';
import '../models/OtherModels/NotePermission.dart';
import '../models/OtherModels/Reimbursement.dart';
import '../models/OtherModels/ReimbursementDetail.dart';
import '../models/OtherModels/Resource.dart';
import '../models/OtherModels/ServiceInvoice.dart';
import '../models/OtherModels/ServiceInvoiceDetail.dart';
import '../models/OtherModels/TagGroup.dart';
import '../models/OtherModels/Territory.dart';
import '../models/OtherModels/TimeZone.dart';
import '../models/OtherModels/TravelPurpose.dart';
import '../models/OtherModels/Unit.dart';
import 'JsonCopier.dart';
import 'Utility.dart';

import 'package:http/http.dart' as http;

class SyncService{

    // Handler handler;

     static int DEFAULT_SYNC_INTERVAL = (5 * 1000) ;
     static final String LOG_TAG = "HS_SYNC";
     static  DatabaseHandler dbHandler = DatabaseHandler();

     static var logger = Logger();

    //  static Context ;
     bool isRunning = false;
     bool doDoubleCheck = true;
     static String currentdownload = "";
     static List upSyncList = [];
     static List upSyncListApplog = [];
     static int totalRecordsToupSync = 0;

     static int AccountsPageCurrent = 0;
     static int AccountAddressesPageCurrent = 0;
     static int AccountBusinessPlansPageCurrent = 0;
     static int AccountBusinessUnitsPageCurrent = 0;
     static int AccountBuyingProcessesPageCurrent = 0;
     static int AccountCategoriesPageCurrent = 0;
     static int AccountCategoryMappingsPageCurrent = 0;
     static int AccountCompetitionActivitiesPageCurrent = 0;
     static int AccountFormsPageCurrent = 0;
     static int AccountFormValuesPageCurrent = 0;
     static int AccountMediaPageCurrent = 0;
     static int AccountPhonesPageCurrent = 0;
     static int AccountSegmentsPageCurrent = 0;
     static int AccountStatusesPageCurrent = 0;
     static int AccountTerritoriesPageCurrent = 0;
     static int AccountTypesPageCurrent = 0;
     static int ActivitiesPageCurrent = 0;
     static int ActivityApprovalsPageCurrent = 0;
     static int ActivityApprovalTypesPageCurrent = 0;
     static int ActivityBusinessUnitsPageCurrent = 0;
     static int ActivityMeasuresPageCurrent = 0;
     static int ActivityMediaPageCurrent = 0;
     static int ActivityPermissionsPageCurrent = 0;
     static int ActivityPrioritiesPageCurrent = 0;
     static int ActivityProductsPageCurrent = 0;
     static int ActivityProductDetailsPageCurrent = 0;
     static int ActivityStatusesPageCurrent = 0;
     static int ActivityTeamsPageCurrent = 0;
     static int ActivityTravelsPageCurrent = 0;
     static int ActivityTravelExpensesPageCurrent = 0;
     static int ActivityTravelMappingsPageCurrent = 0;
     static int ActivityTravelMediaPageCurrent = 0;
     static int ActivityTypesPageCurrent = 0;
     static int AddressTypesPageCurrent = 0;
     static int AppFeaturesPageCurrent = 0;
     static int AppFeatureFieldsPageCurrent = 0;
     static int AppFeatureGroupsPageCurrent = 0;
     static int AppReportsPageCurrent = 0;
     static int AppUsersPageCurrent = 0;
     static int AppUserLocationsPageCurrent = 0;
     static int AppUserMessagesPageCurrent = 0;
     static int AppUserProductsPageCurrent = 0;
     static int AppUserRemarksPageCurrent = 0;
     static int AppUserTeamsPageCurrent = 0;
     static int AppUserTeamMembersPageCurrent = 0;
     static int AppUserTerritoriesPageCurrent = 0;
     static int AppUserTypesPageCurrent = 0;
     static int AttributesPageCurrent = 0;
     static int AttributeValuesPageCurrent = 0;
     static int BusinessEmailsPageCurrent = 0;
     static int BusinessFeaturesPageCurrent = 0;
     static int BusinessUnitsPageCurrent = 0;
     static int ChatMessagesPageCurrent = 0;
     static int ChatUserAndGroupsPageCurrent = 0;
     static int ChatUserGroupMembersPageCurrent = 0;
     static int CompetitorsPageCurrent = 0;
     static int ContactsPageCurrent = 0;
     static int ContactAlignmentsPageCurrent = 0;
     static int ContactCategoriesPageCurrent = 0;
     static int ContactMediaPageCurrent = 0;
     static int ContactTitlesPageCurrent = 0;
     static int ContentTypesPageCurrent = 0;
     static int CountriesPageCurrent = 0;
     static int CreditRatingsPageCurrent = 0;
     static int CurrenciesPageCurrent = 0;
     static int CustomerMeetingsPageCurrent = 0;
     static int DepartmentsPageCurrent = 0;
     static int DesignationsPageCurrent = 0;
     static int EmailManualTemplatesPageCurrent = 0;
     static int ExpenseTypesPageCurrent = 0;
     static int FieldAttendancesPageCurrent = 0;
     static int FinancialInstitutionsPageCurrent = 0;
     static int FinancialYearsPageCurrent = 0;
     static int FormsPageCurrent = 0;
     static int FormCellsPageCurrent = 0;
     static int FormCellElementsPageCurrent = 0;
     static int FormSectionsPageCurrent = 0;
     static int HSSupportTicketsPageCurrent = 0;
     static int HSSupportTicketMediaPageCurrent = 0;
     static int IndustriesPageCurrent = 0;
     static int LeadSourcesPageCurrent = 0;
     static int ModeOfTravelsPageCurrent = 0;
     static int NotesPageCurrent = 0;
     static int NoteMediaPageCurrent = 0;
     static int NotePermissionsPageCurrent = 0;
     static int NotificationsPageCurrent = 0;
     static int NotificationAssignmentsPageCurrent = 0;
     static int OpportunitiesPageCurrent = 0;
     static int OpportunityApprovalsPageCurrent = 0;
     static int OpportunityApprovalTypesPageCurrent = 0;
     static int OpportunityBusinessUnitsPageCurrent = 0;
     static int OpportunityContactsPageCurrent = 0;
     static int OpportunityMeasuresPageCurrent = 0;
     static int OpportunityFulfillmentStatusesPageCurrent = 0;
     static int OpportunityMediaPageCurrent = 0;
     static int OpportunityNamesPageCurrent = 0;
     static int OpportunityPermissionsPageCurrent = 0;
     static int OpportunityPrioritiesPageCurrent = 0;
     static int OpportunityProductsPageCurrent = 0;
     static int OpportunityProductDetailsPageCurrent = 0;
     static int OpportunityProductDetailAttributesPageCurrent = 0;
     static int OpportunityStagesPageCurrent = 0;
     static int OpportunityStageTypesPageCurrent = 0;
     static int OpportunityStatusesPageCurrent = 0;
     static int OpportunityTeamsPageCurrent = 0;
     static int OpportunityTypesPageCurrent = 0;
     static int PerformanceSummariesPageCurrent = 0;
     static int PhoneTypesPageCurrent = 0;
     static int ProductsPageCurrent = 0;
     static int ProductAuxiliariesPageCurrent = 0;
     static int ProductCategoriesPageCurrent = 0;
     static int ProductInstallationsPageCurrent = 0;
     static int ProductInstallationDetailsPageCurrent = 0;
     static int ProductMediaPageCurrent = 0;
     static int ReimbursementsPageCurrent = 0;
     static int ReimbursementDetailsPageCurrent = 0;
     static int ReimbursementTypesPageCurrent = 0;
     static int RemindersPageCurrent = 0;
     static int ResourcesPageCurrent = 0;
     static int ServiceInvoicesPageCurrent = 0;
     static int ServiceInvoiceDetailsPageCurrent = 0;
     static int TagsPageCurrent = 0;
     static int TagGroupsPageCurrent = 0;
     static int TerritoriesPageCurrent = 0;
     static int TimeZonesPageCurrent = 0;
     static int TravelPurposesPageCurrent = 0;
     static int UnitsPageCurrent = 0;

     static bool isFirstdownloadCompleted = false;
     static int syncCount = 0;

     static final int MY_DEFAULT_TIMEOUT = 15000;


      void runSyncOperations() {
        const syncInterval = Duration(milliseconds: DEFAULT_SYNC_INTERVAL); // Adjust the sync interval as needed

        Timer.periodic(syncInterval, (timer) async{
          if (await Utility.isNetworkConnected() &&
              !isRunning &&
              Globals.USER_TOKEN.isNotEmpty &&
              Globals.AppUserID > 0 &&
              Globals.AppUserGroupID > 0) {
            isRunning = true;

            runUpSync();

            runDownSync();

            // runAppLogUpSync();

            isRunning = false;
          }
        });
      }

      Future<void> runUpSync() async {
        try {

            totalRecordsToupSync = 0;

            //Account
  List<Account> newOrModifiedAccountList = await AccountDataHandlerBase.GetAccountUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedAccountList.length > 0) {

  logger.d("New Or Modified Accounts - ${newOrModifiedAccountList.length}");
  
  // Logger.d("New Or Modified Accounts - ${newOrModifiedAccountList.length}");
  totalRecordsToupSync += newOrModifiedAccountList.length;
}

for (Account account in newOrModifiedAccountList) {
  try {
    if (!upSyncList.contains("Account-${account.id}")) {
      upSyncList.add("Account-${account.id}");
      upSyncAccount(account);
    }
  } catch (e) {
    //  handling code goes here
  }
  return; // Assuming this is intended to exit the loop after the first iteration
}


            //AccountCategoryMapping
           List<AccountCategoryMapping> newOrModifiedAccountCategoryMappingList = await AccountCategoryMappingDataHandlerBase.GetAccountCategoryMappingUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedAccountCategoryMappingList.length > 0) {
  logger.d(LOG_TAG, "New Or Modified AccountCategoryMappings - ${newOrModifiedAccountCategoryMappingList.length}");
  totalRecordsToupSync += newOrModifiedAccountCategoryMappingList.length;
}

for (AccountCategoryMapping accountCategoryMapping in newOrModifiedAccountCategoryMappingList) {
  try {
    if (!upSyncList.contains("AccountCategoryMapping-${accountCategoryMapping.id}")) {
      upSyncList.add("AccountCategoryMapping-${accountCategoryMapping.id}");
      upSyncAccountCategoryMapping(accountCategoryMapping);
    }
  } catch (e) {
  }
  return;
}


            //Contact
          List<Contact> newOrModifiedContactList =  await ContactHandlerDataBase.GetContactUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedContactList.length > 0) {
  logger.d("New Or Modified Contacts - ${newOrModifiedContactList.length}");
  totalRecordsToupSync += newOrModifiedContactList.length;
}

for (Contact contact in newOrModifiedContactList) {
  try {
    if (!upSyncList.contains("Contact-${contact.id}")) {
      upSyncList.add("Contact-${contact.id}");
      upSyncContact(contact);
    }
  } catch (e) {
  }
  return;
}

// Activity
List<Activity> newOrModifiedActivityList = await  ActivityDataHandlerBase.GetActivityUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedActivityList.length > 0) {
  logger.d("New Or Modified Activities - ${newOrModifiedActivityList.length}");
  totalRecordsToupSync += newOrModifiedActivityList.length;
}

for (Activity activity in newOrModifiedActivityList) {
  try {
    if (!upSyncList.contains("Activity-${activity.id}")) {
      upSyncList.add("Activity-${activity.id}");
      upSyncActivity(activity);
    }
  } catch (e) {
  }
  return;
}

// Opportunity
List<Opportunity> newOrModifiedOpportunityList = await OpportunityDataHandlerBase.GetOpportunityUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedOpportunityList.length > 0) {
  Logger.d("New Or Modified Opportunities - ${newOrModifiedOpportunityList.length}");
  totalRecordsToupSync += newOrModifiedOpportunityList.length;
}

for (Opportunity opportunity in newOrModifiedOpportunityList) {
  try {
    if (!upSyncList.contains("Opportunity-${opportunity.id}")) {
      upSyncList.add("Opportunity-${opportunity.id}");
      upSyncOpportunity(opportunity);
    }
  } catch (e) {
  }
  return;
}



            //ActivityProduct
            List<String> newOrModifiedActivityIdList = await ActivityProductDataHandler.GetActivityProductUpSyncRecordsActivityIds(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityIdList.length > 0) {
                  Logger.d("New Or Modified ActivityProducts - ${newOrModifiedActivityIdList.length}");
                totalRecordsToupSync += newOrModifiedActivityIdList.length;
            }
            for (String activityId in  newOrModifiedActivityIdList) {
                try {

                    String masterActivityId =  await ActivityDataHandlerBase.GetServerId(dbHandler,  activityId);

                    if (masterActivityId != ("") && !upSyncList.contains("ActivityProduct-" + masterActivityId)) {

                        List<ActivityProduct> activityProductListOriginal = await ActivityProductDataHandler.GetActivityProductupSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailListOriginal = await ActivityProductDetailDataHandler.GetActivityProductDetailupSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        List<ActivityProduct> activityProductList = await  ActivityProductDataHandler.GetActivityProductupSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailList = await ActivityProductDetailDataHandler.GetActivityProductDetailupSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        //String serverActivityId = ActivityDataHandler.GetServerId(dbHandler,  activityId);

                        for (ActivityProduct activityProduct in activityProductList) {
                            activityProduct.activityID = (masterActivityId);
                            activityProduct.productID = await (ProductDataHandlerBase.GetServerId(dbHandler,  activityProduct.productID! ));
                        }

                        for (ActivityProductDetail activityProductDetail in activityProductDetailList) {
                            activityProductDetail.activityProductID = ("-1");
                            activityProductDetail.supplierAccountID =  await (AccountDataHandlerBase.GetServerId(dbHandler,  activityProductDetail.supplierAccountID! ));
                        }

                        upSyncList.add("ActivityProduct-" + masterActivityId);
                        upSyncActivityProduct(masterActivityId, activityProductListOriginal, activityProductDetailListOriginal, activityProductList, activityProductDetailList);
                    }

                } catch ( e) {
                }
                return;
            }

            //OpportunityProduct
            List<String> newOrModifiedOpportunityIdList =await  OpportunityProductDataHandlerBase.GetOpportunityProductupSyncRecordsOpportunityIds(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityIdList.length > 0) {
                Logger.d("New Or Modified OpportunityProducts - " + newOrModifiedOpportunityIdList.length.toString());
                totalRecordsToupSync += newOrModifiedOpportunityIdList.length;
            }
            for (String opportunityId in  newOrModifiedOpportunityIdList) {
                try {

                    String masterOpportunityId = await  OpportunityDataHandlerBase.GetServerId(dbHandler,  opportunityId);

                    if (masterOpportunityId !=("") && !upSyncList.contains("OpportunityProduct-" + masterOpportunityId)) {

                        List<OpportunityProduct> opportunityProductListOriginal = await OpportunityProductDataHandlerBase.GetOpportunityProductupSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailListOriginal = await OpportunityProductDetailDataHandler.GetOpportunityProductDetailupSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        List<OpportunityProduct> opportunityProductList = await OpportunityProductDataHandlerBase.GetOpportunityProductupSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailList =await  OpportunityProductDataHandlerBase.GetOpportunityProductDetailupSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        //String serverOpportunityId = OpportunityDataHandler.GetServerId(dbHandler,  opportunityId);

                        for (OpportunityProduct opportunityProduct in  opportunityProductList) {
                            opportunityProduct.opportunityID = (masterOpportunityId);
                            opportunityProduct.productID = await (ProductDataHandlerBase.GetServerId(dbHandler,  opportunityProduct.getProductID!));
                        }

                        for (OpportunityProductDetail opportunityProductDetail in opportunityProductDetailList) {
                            opportunityProductDetail.opportunityProductID = ("-1");
                            opportunityProductDetail.supplierAccountID = await (AccountDataHandlerBase.GetServerId(dbHandler,  opportunityProductDetail.supplierAccountID!));
                        }

                        upSyncList.add("OpportunityProduct-" + masterOpportunityId);
                        upSyncOpportunityProduct(masterOpportunityId, opportunityProductListOriginal, opportunityProductDetailListOriginal, opportunityProductList, opportunityProductDetailList);
                    }
                } catch ( e) {
                }
                return;
            }

           /* //OpportunityProductDetailAttribute
            List<OpportunityProductDetailAttribute> newOrModifiedOpportunityProductDetailAttributeList = OpportunityProductDetailAttributeDataHandler.GetOpportunityProductDetailAttributeupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            Log.d(LOG_TAG, "New Or Modified OpportunityProductDetailAttributes - " + String.valueOf(newOrModifiedOpportunityProductDetailAttributeList.length));
            for (OpportunityProductDetailAttribute opportunityProductDetailAttribute in newOrModifiedOpportunityProductDetailAttributeList) {
                try {
                    if(!upSyncList.contains("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.id)) {
                        upSyncList.add("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.id);
                        upSyncOpportunityProductDetailAttribute(opportunityProductDetailAttribute);
                    }
                } catch ( e) {
                }
                return;
            }*/

            //CustomerMeeting
            List<CustomerMeeting> newOrModifiedCustomerMeetingList =await CustomerMeetingDataHandlerBase.GetCustomerMeetingupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedCustomerMeetingList.length > 0) {
                Logger.d("New Or Modified CustomerMeetings - " + newOrModifiedCustomerMeetingList.length.toString());
                totalRecordsToupSync += newOrModifiedCustomerMeetingList.length;
            }
            for (CustomerMeeting customerMeeting in newOrModifiedCustomerMeetingList) {
                try {
                    if (!upSyncList.contains("CustomerMeeting-" + customerMeeting.id!)) {
                        upSyncList.add("CustomerMeeting-" + customerMeeting.id!);
                        upSyncCustomerMeeting(customerMeeting);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityContact
            List<OpportunityContact> newOrModifiedOpportunityContactList = await OpportunityContactHandlerDataBaseBase.GetOpportunityContactupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityContactList.length > 0) {
                logger.d(LOG_TAG, "New Or Modified OpportunityContacts - " +  newOrModifiedOpportunityContactList.length.toString());
                totalRecordsToupSync += newOrModifiedOpportunityContactList.length;
            }
            for (OpportunityContact opportunityContact in newOrModifiedOpportunityContactList) {
                try {
                    if (!upSyncList.contains("OpportunityContact-" + opportunityContact.id!)) {
                        upSyncList.add("OpportunityContact-" + opportunityContact.id!);
                        upSyncOpportunityContact(opportunityContact);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountAddress
            List<AccountAddress> newOrModifiedAccountAddressList = await  AccountAddressDataHandlerBase.GetAccountAddressupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountAddressList.length > 0) {
                Logger.d("New Or Modified AccountAddresses - " + newOrModifiedAccountAddressList.length.toString());
                totalRecordsToupSync += newOrModifiedAccountAddressList.length;
            }
            for (AccountAddress accountAddress in newOrModifiedAccountAddressList) {
                try {
                    if (!upSyncList.contains("AccountAddress-" + accountAddress.id!)) {
                        upSyncList.add("AccountAddress-" + accountAddress.id!);
                        upSyncAccountAddress(accountAddress);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountPhone
            List<AccountPhone> newOrModifiedAccountPhoneList = await  AccountPhoneDataHandlerBase.GetAccountPhoneupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountPhoneList.length > 0) {
                Logger.d("New Or Modified AccountPhones - " + newOrModifiedAccountPhoneList.length.toString());
                totalRecordsToupSync += newOrModifiedAccountPhoneList.length;
            }
            for (AccountPhone accountPhone in newOrModifiedAccountPhoneList) {
                try {
                    if (!upSyncList.contains("AccountPhone-" + accountPhone.id!)) {
                        upSyncList.add("AccountPhone-" + accountPhone.id!);
                        upSyncAccountPhone(accountPhone);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountBuyingProcess
            List<AccountBuyingProcess> newOrModifiedAccountBuyingProcessList =  AccountBuyingProcessDataHandlerBase.GetAccountBuyingProcessRecord(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBuyingProcessList.length > 0) {
                Logger.d("New Or Modified AccountBuyingProcesses - " + String.valueOf(newOrModifiedAccountBuyingProcessList.length));
                totalRecordsToupSync += newOrModifiedAccountBuyingProcessList.length;
            }
            for (AccountBuyingProcess accountBuyingProcess in newOrModifiedAccountBuyingProcessList) {
                try {
                    if (!upSyncList.contains("AccountBuyingProcess-" + accountBuyingProcess.id!)) {
                        upSyncList.add("AccountBuyingProcess-" + accountBuyingProcess.id!);
                        upSyncAccountBuyingProcess(accountBuyingProcess);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountBusinessPlan
            List<AccountBusinessPlan> newOrModifiedAccountBusinessPlanList = AccountBusinessPlanDataHandler.GetAccountBusinessPlanupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessPlanList.length > 0) {
                Logger.d("New Or Modified AccountBusinessPlans - " + String.valueOf(newOrModifiedAccountBusinessPlanList.length));
                totalRecordsToupSync += newOrModifiedAccountBusinessPlanList.length;
            }
            for (AccountBusinessPlan accountBusinessPlan in newOrModifiedAccountBusinessPlanList) {
                try {
                    if (!upSyncList.contains("AccountBusinessPlan-" + accountBusinessPlan.id)) {
                        upSyncList.add("AccountBusinessPlan-" + accountBusinessPlan.id);
                        upSyncAccountBusinessPlan(accountBusinessPlan);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountCompetitionActivity
            List<AccountCompetitionActivity> newOrModifiedAccountCompetitionActivityList = AccountCompetitionActivityDataHandler.GetAccountCompetitionActivityupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountCompetitionActivityList.length > 0) {
                Logger.d("New Or Modified AccountCompetitionActivities - " + String.valueOf(newOrModifiedAccountCompetitionActivityList.length));
                totalRecordsToupSync += newOrModifiedAccountCompetitionActivityList.length;
            }
            for (AccountCompetitionActivity accountCompetitionActivity in newOrModifiedAccountCompetitionActivityList) {
                try {
                    if (!upSyncList.contains("AccountCompetitionActivity-" + accountCompetitionActivity.id)) {
                        upSyncList.add("AccountCompetitionActivity-" + accountCompetitionActivity.id);
                        upSyncAccountCompetitionActivity(accountCompetitionActivity);
                    }
                } catch ( e) {
                }
                return;
            }

            //Note
            List<Note> newOrModifiedNoteList = NoteDataHandler.GetNoteupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteList.length > 0) {
                Logger.d("New Or Modified Notes - " + String.valueOf(newOrModifiedNoteList.length));
                totalRecordsToupSync += newOrModifiedNoteList.length;
            }
            for (Note note in newOrModifiedNoteList) {
                try {
                    if (!upSyncList.contains("Note-" + note.id)) {
                        upSyncList.add("Note-" + note.id);
                        upSyncNote(note);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravel
            List<ActivityTravel> newOrModifiedActivityTravelList = ActivityTravelDataHandler.GetActivityTravelupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelList.length > 0) {
                Logger.d("New Or Modified ActivityTravels - " + String.valueOf(newOrModifiedActivityTravelList.length));
                totalRecordsToupSync += newOrModifiedActivityTravelList.length;
            }
            for (ActivityTravel activityTravel in newOrModifiedActivityTravelList) {
                try {
                    if (!upSyncList.contains("ActivityTravel-" + activityTravel.id)) {
                        upSyncList.add("ActivityTravel-" + activityTravel.id);
                        upSyncActivityTravel(activityTravel);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountMedia
            List<AccountMedia> newOrModifiedAccountMediaList = AccountMediaDataHandler.GetAccountMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaList.length > 0) {
                Logger.d("New Or Modified AccountMedia - " + String.valueOf(newOrModifiedAccountMediaList.length));
                totalRecordsToupSync += newOrModifiedAccountMediaList.length;
            }
            for (AccountMedia accountMedia in newOrModifiedAccountMediaList) {
                try {
                    if (!upSyncList.contains("AccountMedia-" + accountMedia.id)) {
                        upSyncList.add("AccountMedia-" + accountMedia.id);
                        upSyncAccountMedia(accountMedia);
                    }
                } catch ( e) {
                }
                return;
            }


            //ContactMedia
            List<ContactMedia> newOrModifiedContactMediaList = ContactMediaDataHandler.GetContactMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaList.length > 0) {
                Logger.d("New Or Modified ContactMedia - " + String.valueOf(newOrModifiedContactMediaList.length));
                totalRecordsToupSync += newOrModifiedContactMediaList.length;
            }
            for (ContactMedia contactMedia in newOrModifiedContactMediaList) {
                try {
                    if (!upSyncList.contains("ContactMedia-" + contactMedia.id)) {
                        upSyncList.add("ContactMedia-" + contactMedia.id);
                        upSyncContactMedia(contactMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityMedia
            List<OpportunityMedia> newOrModifiedOpportunityMediaList = OpportunityMediaDataHandler.GetOpportunityMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaList.length > 0) {
                Logger.d("New Or Modified OpportunityMedia - " + String.valueOf(newOrModifiedOpportunityMediaList.length));
                totalRecordsToupSync += newOrModifiedOpportunityMediaList.length;
            }
            for (OpportunityMedia opportunityMedia in newOrModifiedOpportunityMediaList) {
                try {
                    if (!upSyncList.contains("OpportunityMedia-" + opportunityMedia.id)) {
                        upSyncList.add("OpportunityMedia-" + opportunityMedia.id);
                        upSyncOpportunityMedia(opportunityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityMedia
            List<ActivityMedia> newOrModifiedActivityMediaList = ActivityMediaDataHandler.GetActivityMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaList.length > 0) {
                Logger.d("New Or Modified ActivityMedia - " + String.valueOf(newOrModifiedActivityMediaList.length));
                totalRecordsToupSync += newOrModifiedActivityMediaList.length;
            }
            for (ActivityMedia activityMedia in newOrModifiedActivityMediaList) {
                try {
                    if (!upSyncList.contains("ActivityMedia-" + activityMedia.id)) {
                        upSyncList.add("ActivityMedia-" + activityMedia.id);
                        upSyncActivityMedia(activityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //NoteMedia
            List<NoteMedia> newOrModifiedNoteMediaList = NoteMediaDataHandler.GetNoteMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaList.length > 0) {
                Logger.d("New Or Modified NoteMedia - " + String.valueOf(newOrModifiedNoteMediaList.length));
                totalRecordsToupSync += newOrModifiedNoteMediaList.length;
            }
            for (NoteMedia noteMedia in newOrModifiedNoteMediaList) {
                try {
                    if (!upSyncList.contains("NoteMedia-" + noteMedia.id)) {
                        upSyncList.add("NoteMedia-" + noteMedia.id);
                        upSyncNoteMedia(noteMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelMedia
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaList = ActivityTravelMediaDataHandler.GetActivityTravelMediaupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaList.length > 0) {
                Logger.d("New Or Modified ActivityTravelMedia - " + String.valueOf(newOrModifiedActivityTravelMediaList.length));
                totalRecordsToupSync += newOrModifiedActivityTravelMediaList.length;
            }
            for (ActivityTravelMedia activityMedia in newOrModifiedActivityTravelMediaList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMedia-" + activityMedia.id)) {
                        upSyncList.add("ActivityTravelMedia-" + activityMedia.id);
                        upSyncActivityTravelMedia(activityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelExpense
            List<ActivityTravelExpense> newOrModifiedActivityTravelExpenseList = await ActivityTravelExpenseDataHandlerBase.GetActivityTravelExpenseUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelExpenseList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelExpenses - " + String.valueOf(newOrModifiedActivityTravelExpenseList.length));
                totalRecordsToupSync += newOrModifiedActivityTravelExpenseList.length;
            }
            for (ActivityTravelExpense activityTravelExpense in newOrModifiedActivityTravelExpenseList) {
                try {
                    if (!upSyncList.contains("ActivityTravelExpense-" + activityTravelExpense.id)) {
                        upSyncList.add("ActivityTravelExpense-" + activityTravelExpense.id);
                        upSyncActivityTravelExpense(activityTravelExpense);
                    }
                } catch ( e) {
                }
                return;
            }

            //FieldAttendance
            List<FieldAttendance> newOrModifiedFieldAttendanceList = FieldAttendanceDataHandlerBase.GetFieldAttendanceupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedFieldAttendanceList.length > 0) {
                Logger.d("New Or Modified FieldAttendances - " + String.valueOf(newOrModifiedFieldAttendanceList.length));
                totalRecordsToupSync += newOrModifiedFieldAttendanceList.length;
            }
            for (FieldAttendance fieldAttendance in newOrModifiedFieldAttendanceList) {
                try {
                    if (!upSyncList.contains("FieldAttendance-" + fieldAttendance.id)) {
                        upSyncList.add("FieldAttendance-" + fieldAttendance.id);
                        //Get Address for PunchIn Location
                        if (!Globals.isNullOrEmpty(fieldAttendance.getPunchInLocation())) {
                            JSONObject obj = new JSONObject(fieldAttendance.getPunchInLocation());
                            if (Globals.isNullOrEmpty(obj.getString("address"))) {
                                if (!Globals.isNullOrEmpty(Globals.GetLocationAddress( Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude"))))) {
                                    AddressEntry addressEntry = new AddressEntry(obj.getString("timeId"), GetLocationAddress( Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude"))), Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude")));
                                    Gson gson = new Gson();
                                    String addressString = gson.toJson(addressEntry);
                                    fieldAttendance.setPunchInLocation(addressString);
                                    fieldAttendance.setIsDirty("true");
                                    long rid = FieldAttendanceDataHandler.UpdateFieldAttendanceRecord(dbHandler,  fieldAttendance.id, fieldAttendance);
                                    //Log.d("Missed-PunchIn", "Sucessfully Updated");
                                }

                            }
                        }

                        //Get Address for punchOut Location
                        if (!Globals.isNullOrEmpty(fieldAttendance.getPunchOutLocation())) {
                            JSONObject jsonObjectPunchOut = new JSONObject(fieldAttendance.getPunchOutLocation());
                            if (Globals.isNullOrEmpty(jsonObjectPunchOut.getString("address"))) {
                                if (!Globals.isNullOrEmpty(Globals.GetLocationAddress( Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude"))))) {
                                    AddressEntry addressEntry = new AddressEntry(jsonObjectPunchOut.getString("timeId"), GetLocationAddress( Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude"))), Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude")));
                                    Gson gson = new Gson();
                                    String addressString = gson.toJson(addressEntry);
                                    fieldAttendance.setPunchOutLocation(addressString);
                                    fieldAttendance.setIsDirty("true");
                                    fieldAttendance.setModifiedBy(Globals.AppUserLoginName);
                                    fieldAttendance.setModifiedOn(Globals.GetDateTimeNowDBFormat());
                                    long rid = FieldAttendanceDataHandler.UpdateFieldAttendanceRecord(dbHandler,  fieldAttendance.id, fieldAttendance);
                                    //Log.d("Missed-PunchOut", "Sucessfully Updated");
                                }
                            }
                        }

                        upSyncFieldAttendance(fieldAttendance);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserRemark
            List<AppUserRemark> newOrModifiedAppUserRemarkList = AppUserRemarkDataHandlerBase.GetAppUserRemarkupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserRemarkList.length > 0) {
                Logger.d("New Or Modified AppUserRemarks - " + String.valueOf(newOrModifiedAppUserRemarkList.length));
                totalRecordsToupSync += newOrModifiedAppUserRemarkList.length;
            }
            for (AppUserRemark appUserRemark in newOrModifiedAppUserRemarkList) {
                try {
                    if (!upSyncList.contains("AppUserRemark-" + appUserRemark.id)) {
                        upSyncList.add("AppUserRemark-" + appUserRemark.id);
                        upSyncAppUserRemark(appUserRemark);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountForm
            List<AccountForm> newOrModifiedAccountFormList = AccountFormDataHandlerBase.GetAccountFormupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountFormList.length > 0) {
                Logger.d("New Or Modified AccountForms - " + String.valueOf(newOrModifiedAccountFormList.length));
                totalRecordsToupSync += newOrModifiedAccountFormList.length;
            }
            for (AccountForm accountForm in newOrModifiedAccountFormList) {
                try {
                    if (!upSyncList.contains("AccountForm-" + accountForm.id)) {
                        upSyncList.add("AccountForm-" + accountForm.id);
                        upSyncAccountForm(accountForm);
                    }
                } catch ( e) {
                }
                return;
            }


            //AccountFormValue
            List<AccountForm> newOrModifiedAccountFormListForValuesupSync = AccountFormDataHandlerBase.GetMasterAccountFormRecordsForValuesupSync(dbHandler, );
            if (newOrModifiedAccountFormListForValuesupSync.length > 0) {
                Logger.d("New Or Modified AccountFormValues - " + String.valueOf(newOrModifiedAccountFormListForValuesupSync.length));
                totalRecordsToupSync += newOrModifiedAccountFormListForValuesupSync.length;
            }
            for (AccountForm accountForm in newOrModifiedAccountFormListForValuesupSync) {
                try {
                    if (!upSyncList.contains("AccountFormValue-" + accountForm.id)) {
                        upSyncList.add("AccountFormValue-" + accountForm.id);
                        List<AccountFormValue> accountFormValuesOriginal = AccountFormValueDataHandler.GetAccountFormValueupSyncRecordsByAccountFormId(dbHandler,  accountForm.id);
                        List<AccountFormValue> accountFormValues = AccountFormValueDataHandler.GetAccountFormValueupSyncRecordsByAccountFormId(dbHandler,  accountForm.id);
                        for (AccountFormValue accountFormValue in accountFormValues) {
                            accountFormValue.setAccountFormID(AccountFormDataHandler.GetServerId(dbHandler,  accountFormValue.getAccountFormID()));
                            accountFormValue.setFormCellElementID(FormCellElementDataHandler.GetServerId(dbHandler,  accountFormValue.getFormCellElementID()));
                        }
                        upSyncAccountFormValue(accountForm.id, accountFormValuesOriginal, accountFormValues);
                    }
                } catch ( e) {
                }
                return;
            }

            //Reimbursement
            List<Reimbursement> newOrModifiedReimbursementList = ReimbursementDataHandlerBase.GetReimbursementupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementList.length > 0) {
                Logger.d("New Or Modified Reimbursements - " + String.valueOf(newOrModifiedReimbursementList.length));
                totalRecordsToupSync += newOrModifiedReimbursementList.length;
            }
            for (Reimbursement reimbursement in newOrModifiedReimbursementList) {
                try {
                    if (!upSyncList.contains("Reimbursement-" + reimbursement.id)) {
                        upSyncList.add("Reimbursement-" + reimbursement.id);
                        upSyncReimbursement(reimbursement);
                    }
                } catch ( e) {
                }
                return;
            }

            //ReimbursementDetail
            List<ReimbursementDetail> newOrModifiedReimbursementDetailList = ReimbursementDetailDataHandlerBase.GetReimbursementDetailupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementDetailList.length > 0) {
                Logger.d("New Or Modified ReimbursementDetails - " + String.valueOf(newOrModifiedReimbursementDetailList.length));
                totalRecordsToupSync += newOrModifiedReimbursementDetailList.length;
            }
            for (ReimbursementDetail reimbursementDetail in newOrModifiedReimbursementDetailList) {
                try {
                    if (!upSyncList.contains("ReimbursementDetail-" + reimbursementDetail.id)) {
                        upSyncList.add("ReimbursementDetail-" + reimbursementDetail.id);
                        upSyncReimbursementDetail(reimbursementDetail);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityPermission
            List<ActivityPermission> newOrModifiedActivityPermissionList = ActivityPermissionDataHandlerBase.GetActivityPermissionupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityPermissionList.length > 0) {
                Logger.d("New Or Modified ActivityPermissions - " + String.valueOf(newOrModifiedActivityPermissionList.length));
                totalRecordsToupSync += newOrModifiedActivityPermissionList.length;
            }
            for (ActivityPermission activityPermission in newOrModifiedActivityPermissionList) {
                try {
                    if (!upSyncList.contains("ActivityPermission-" + activityPermission.id)) {
                        upSyncList.add("ActivityPermission-" + activityPermission.id);
                        upSyncActivityPermission(activityPermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //NotePermission
            List<NotePermission> newOrModifiedNotePermissionList = NotePermissionDataHandlerBase.GetNotePermissionupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNotePermissionList.length > 0) {
                Logger.d("New Or Modified NotePermissions - " + String.valueOf(newOrModifiedNotePermissionList.length));
                totalRecordsToupSync += newOrModifiedNotePermissionList.length;
            }
            for (NotePermission notePermission in newOrModifiedNotePermissionList) {
                try {
                    if (!upSyncList.contains("NotePermission-" + notePermission.id)) {
                        upSyncList.add("NotePermission-" + notePermission.id);
                        upSyncNotePermission(notePermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityPermission
            List<OpportunityPermission> newOrModifiedOpportunityPermissionList = OpportunityPermissionDataHandlerBase.GetOpportunityPermissionupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityPermissionList.length > 0) {
                Logger.d("New Or Modified OpportunityPermissions - " + String.valueOf(newOrModifiedOpportunityPermissionList.length));
                totalRecordsToupSync += newOrModifiedOpportunityPermissionList.length;
            }
            for (OpportunityPermission opportunityPermission in newOrModifiedOpportunityPermissionList) {
                try {
                    if (!upSyncList.contains("OpportunityPermission-" + opportunityPermission.id)) {
                        upSyncList.add("OpportunityPermission-" + opportunityPermission.id);
                        upSyncOpportunityPermission(opportunityPermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTeam
            List<ActivityTeam> newOrModifiedActivityTeamList = ActivityTeamDataHandlerBase.GetActivityTeamupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTeamList.length > 0) {
                Logger.d("New Or Modified ActivityTeams - " + String.valueOf(newOrModifiedActivityTeamList.length));
                totalRecordsToupSync += newOrModifiedActivityTeamList.length;
            }
            for (ActivityTeam activityTeam in newOrModifiedActivityTeamList) {
                try {
                    if (!upSyncList.contains("ActivityTeam-" + activityTeam.id)) {
                        upSyncList.add("ActivityTeam-" + activityTeam.id);
                        upSyncActivityTeam(activityTeam);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserMessage
            List<AppUserMessage> newOrModifiedAppUserMessageList = AppUserMessageDataHandlerBase.GetAppUserMessageupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserMessageList.length > 0) {
                Logger.d("New Or Modified AppUserMessages - " + String.valueOf(newOrModifiedAppUserMessageList.length));
                totalRecordsToupSync += newOrModifiedAppUserMessageList.length;
            }
            for (AppUserMessage appUserMessage in newOrModifiedAppUserMessageList) {
                try {
                    if (!upSyncList.contains("AppUserMessage-" + appUserMessage.id)) {
                        upSyncList.add("AppUserMessage-" + appUserMessage.id);
                        upSyncAppUserMessage(appUserMessage);
                    }
                } catch ( e) {
                }
                return;
            }


            //OpportunityTeam
            List<OpportunityTeam> newOrModifiedOpportunityTeamList = OpportunityTeamDataHandlerBase.GetOpportunityTeamupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityTeamList.length > 0) {
                Logger.d("New Or Modified OpportunityTeams - " + String.valueOf(newOrModifiedOpportunityTeamList.length));
                totalRecordsToupSync += newOrModifiedOpportunityTeamList.length;
            }
            for (OpportunityTeam opportunityTeam in newOrModifiedOpportunityTeamList) {
                try {
                    if (!upSyncList.contains("OpportunityTeam-" + opportunityTeam.id)) {
                        upSyncList.add("OpportunityTeam-" + opportunityTeam.id);
                        upSyncOpportunityTeam(opportunityTeam);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelMapping
            List<ActivityTravelMapping> newOrModifiedActivityTravelMappingList = ActivityTravelMappingDataHandlerBase.GetActivityTravelMappingupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMappingList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelMappings - " + String.valueOf(newOrModifiedActivityTravelMappingList.length));
                totalRecordsToupSync += newOrModifiedActivityTravelMappingList.length;
            }
            for (ActivityTravelMapping activityTravelMapping in newOrModifiedActivityTravelMappingList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMapping-" + activityTravelMapping.id)) {
                        upSyncList.add("ActivityTravelMapping-" + activityTravelMapping.id);
                        upSyncActivityTravelMapping(activityTravelMapping);
                    }
                } catch ( e) {
                }
                return;
            }


            //AccountBusinessUnit
            List<AccountBusinessUnit> newOrModifiedAccountBusinessUnitList = AccountBusinessUnitDataHandlerBase.GetAccountBusinessUnitupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified AccountBusinessUnits - " + String.valueOf(newOrModifiedAccountBusinessUnitList.length));
                totalRecordsToupSync += newOrModifiedAccountBusinessUnitList.length;
            }
            for (AccountBusinessUnit accountBusinessUnit in newOrModifiedAccountBusinessUnitList) {
                try {
                    if (!upSyncList.contains("AccountBusinessUnit-" + accountBusinessUnit.id)) {
                        upSyncList.add("AccountBusinessUnit-" + accountBusinessUnit.id);
                        upSyncAccountBusinessUnit(accountBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityBusinessUnit
            List<ActivityBusinessunit> newOrModifiedActivityBusinessUnitList = ActivityBusinessUnitDataHandlerBase.GetActivityBusinessUnitupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityBusinessUnits - " + String.valueOf(newOrModifiedActivityBusinessUnitList.length));
                totalRecordsToupSync += newOrModifiedActivityBusinessUnitList.length;
            }
            for (ActivityBusinessunit activityBusinessUnit in newOrModifiedActivityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("ActivityBusinessUnit-" + activityBusinessUnit.id)) {
                        upSyncList.add("ActivityBusinessUnit-" + activityBusinessUnit.id);
                        upSyncActivityBusinessUnit(activityBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityBusinessUnit
            List<OpportunityBusinessUnit> newOrModifiedOpportunityBusinessUnitList = OpportunityBusinessUnitDataHandlerBase.GetOpportunityBusinessUnitupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityBusinessUnits - " + String.valueOf(newOrModifiedOpportunityBusinessUnitList.length));
                totalRecordsToupSync += newOrModifiedOpportunityBusinessUnitList.length;
            }
            for (OpportunityBusinessUnit opportunityBusinessUnit in newOrModifiedOpportunityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("OpportunityBusinessUnit-" + opportunityBusinessUnit.id)) {
                        upSyncList.add("OpportunityBusinessUnit-" + opportunityBusinessUnit.id);
                        upSyncOpportunityBusinessUnit(opportunityBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityApproval
            List<ActivityApproval> newOrModifiedActivityApprovalList = ActivityApprovalDataHandlerBase.GetActivityApprovalupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityApprovalList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityApprovals - " + String.valueOf(newOrModifiedActivityApprovalList.length));
                totalRecordsToupSync += newOrModifiedActivityApprovalList.length;
            }
            for (ActivityApproval activityApproval in newOrModifiedActivityApprovalList) {
                try {
                    if (!upSyncList.contains("ActivityApproval-" + activityApproval.id)) {
                        upSyncList.add("ActivityApproval-" + activityApproval.id);
                        upSyncActivityApproval(activityApproval);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityApproval
            List<OpportunityApproval> newOrModifiedOpportunityApprovalList = OpportunityApprovalDataHandlerBase.GetOpportunityApprovalupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityApprovalList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityApprovals - " + String.valueOf(newOrModifiedOpportunityApprovalList.length));
                totalRecordsToupSync += newOrModifiedOpportunityApprovalList.length;
            }
            for (OpportunityApproval opportunityApproval in newOrModifiedOpportunityApprovalList) {
                try {
                    if (!upSyncList.contains("OpportunityApproval-" + opportunityApproval.id)) {
                        upSyncList.add("OpportunityApproval-" + opportunityApproval.id);
                        upSyncOpportunityApproval(opportunityApproval);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountMedia Files
            List<AccountMedia> newOrModifiedAccountMediaFilesList = AccountMediaDataHandlerBase.GetAccountMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaFilesList.length > 0) {
                Logger.d("New Or Modified AccountMedia Files - " + String.valueOf(newOrModifiedAccountMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedAccountMediaFilesList.length;
            }
            for (AccountMedia accountMedia in newOrModifiedAccountMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("AccountMedia-" + accountMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = accountMedia.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            File localFile = new File(mediaPath);
                            if (localFile.isFile()) {
                                byte bytes[] = GetFileAsBytes(localFile.getAbsolutePath());
                                if (bytes.length > 0) {
                                    Globals.upSyncList.add("AccountMedia-" + accountMedia.id);
                                    String fileName = accountMedia.getAccountMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + localFile.getName();
                                    new FileUploadManager().UploadAccountFile( fileName, bytes, accountMedia.id);
                                    isQueued = true;
                                }
                            }
                        }
                        if (!isQueued) {
                            accountMedia.setIsDeleted1("true");
                            AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
                        }
                    }
                } catch ( e) {
                    Log.d("UploadError", e.toString());
                }
                return;
            }

            //Account Logo
            List<Account> newOrModifiedAccountLogoList = AccountDataHandlerBase.GetAccountLogoUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountLogoList.length > 0) {
                Logger.d("New Or Modified Account Logo Files - " + String.valueOf(newOrModifiedAccountLogoList.length));
                totalRecordsToupSync += newOrModifiedAccountLogoList.length;
            }
            for (Account account in newOrModifiedAccountLogoList) {
                try {
                    if (!Globals.upSyncList.contains("AccountLogo-" + account.id)) {
                        boolean isQueued = false;
                        String mediaPath = account.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            Globals.upSyncList.add("AccountLogo-" + account.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                String fileName = account.getAccountName().replaceAll("[^a-zA-Z0-9]", "") + "_Logo" + mediaPath.substring(mediaPath.lastIndexOf("."));
                                new FileUploadManager().UploadAccountLogoFile( fileName, bytes, account.id);
                                isQueued = true;
                            }
                        }
                        if (!isQueued) {
                            account.setIsUploaded("true");
                            AccountDataHandlerBase.UpdateAccountRecord(dbHandler,  account.id, account);
                        }
                    }
                } catch ( e) {
                    Log.d("UploadError", e.toString());
                }
                return;
            }

            //ContactMedia Files
            List<ContactMedia> newOrModifiedContactMediaFilesList = ContactMediaDataHandler.GetContactMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaFilesList.length > 0) {
                Logger.d("New Or Modified ContactMedia Files - " + String.valueOf(newOrModifiedContactMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedContactMediaFilesList.length;
            }
            for (ContactMedia contactMedia in newOrModifiedContactMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("ContactMedia-" + contactMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = contactMedia.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.upSyncList.add("ContactMedia-" + contactMedia.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = contactMedia.getContactMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadContactFile( fileName, bytes, contactMedia.id);
                            }
                        }
                        if (!isQueued) {
                            contactMedia.setIsDeleted1("true");
                            ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler,  contactMedia.id, contactMedia);
                        }
                    }
                } catch ( e) {
                    Log.d("UploadError", e.toString());
                }
                return;
            }

            //ActivityMedia Files
            List<ActivityMedia> newOrModifiedActivityMediaFilesList =await ActivityMediaDataHandler.GetActivityMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaFilesList.length > 0) {
                Logger.d("New Or Modified ActivityMedia Files - " + String.valueOf(newOrModifiedActivityMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedActivityMediaFilesList.length;
            }
            for (ActivityMedia activityMedia in newOrModifiedActivityMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("ActivityMedia-" + activityMedia.id)) {
                        String mediaPath = activityMedia.getLocalMediaPath();
                        boolean isQueued = false;
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.upSyncList.add("ActivityMedia-" + activityMedia.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                String fileName = activityMedia.getActivityMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadActivityFile( fileName, bytes, activityMedia.id);
                                isQueued = true;
                            }
                        }
                        if (!isQueued) {
                            activityMedia.setIsDeleted1("true");
                            ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler,  activityMedia.id, activityMedia);
                        }
                    }

                } catch ( e) {
                    logger.e("UploadErrorin " + e.toString());
                }
                return;
            }

            //OpportunityMedia Files
            List<OpportunityMedia> newOrModifiedOpportunityMediaFilesList = await OpportunityMediaDataHandler.GetOpportunityMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaFilesList.length > 0) {
                Logger.d("New Or Modified OpportunityMedia Files - " + String.valueOf(newOrModifiedOpportunityMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedOpportunityMediaFilesList.length;
            }
            for (OpportunityMedia opportunityMedia in newOrModifiedOpportunityMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("OpportunityMedia-" + opportunityMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = opportunityMedia.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.upSyncList.add("OpportunityMedia-" + opportunityMedia.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = opportunityMedia.getOpportunityMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadOpportunityFile( fileName, bytes, opportunityMedia.id);
                            }
                        }
                        if (!isQueued) {
                            opportunityMedia.setIsDeleted1("true");
                            OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler,  opportunityMedia.id, opportunityMedia);
                        }
                    }

                } catch ( e) {
                    logger.e("UploadErrorin " + e.toString());
                }
                return;
            }

            //NoteMedia Files
            List<NoteMedia> newOrModifiedNoteMediaFilesList = await NoteMediaDataHandler.GetNoteMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaFilesList.length > 0) {
                Logger.d("New Or Modified NoteMedia Files - " + String.valueOf(newOrModifiedNoteMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedNoteMediaFilesList.length;
            }
            for (NoteMedia noteMedia in newOrModifiedNoteMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("NoteMedia-" + noteMedia.id!)) {
                        boolean isQueued = false;
                        String mediaPath = noteMedia.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.upSyncList.add("NoteMedia-" + noteMedia.id!);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = noteMedia.getNoteCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadNoteFile( fileName, bytes, noteMedia.id);
                            }
                        }
                        if (!isQueued) {
                            noteMedia.setIsDeleted1("true");
                            NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler,  noteMedia.id, noteMedia);
                        }
                    }
                } catch ( e) {
                    logger.e("UploadErrorin " + e.toString());
                }
                return;
            }

            //ActivityTravelMedia Files
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaFilesList = ActivityTravelMediaDataHandler.GetActivityTravelMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaFilesList.length > 0) {
                Logger.d("New Or Modified ActivityTravelMedia Files - " + String.valueOf(newOrModifiedActivityTravelMediaFilesList.length));
                totalRecordsToupSync += newOrModifiedActivityTravelMediaFilesList.length;
            }
            for (ActivityTravelMedia activityTravelMedia in newOrModifiedActivityTravelMediaFilesList) {
                try {
                    if (!Globals.upSyncList.contains("ActivityTravelMedia-" + activityTravelMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = activityTravelMedia.getLocalMediaPath();
                        if (!Globals.isNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.upSyncList.add("ActivityTravelMedia-" + activityTravelMedia.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = activityTravelMedia.getActivityTravelMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadActivityTravelMediaFile( fileName, bytes, activityTravelMedia.id);
                            }
                        }
                        if (!isQueued) {
                            activityTravelMedia.setIsDeleted1("true");
                            ActivityTravelMediaDataHandlerBase.UpdateActivityTravelMediaRecord(dbHandler,  activityTravelMedia.id, activityTravelMedia);
                        }
                    }
                } catch ( e) {
                    logger.e("UploadErrorin " + e.toString());
                }
                return;
            }

            //ChatMessage
            List<ChatMessage> newOrModifiedChatMessageList = ChatMessageDataHandlerBase.GetChatMessageupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedChatMessageList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ChatMessages - " + String.valueOf(newOrModifiedChatMessageList.length));
                totalRecordsToupSync += newOrModifiedChatMessageList.length;
            }
            for (ChatMessage chatMessage in newOrModifiedChatMessageList) {
                try {
                    if (!upSyncList.contains("ChatMessage-" + chatMessage.id!)) {
                        upSyncList.add("ChatMessage-" + chatMessage.id!);
                        upSyncChatMessage(chatMessage);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserLocation
            List<AppUserLocation> newOrModifiedAppUserLocationList = await AppUserLocationDataHandlerBase.GetAppUserLocationUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserLocationList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified AppUserLocations - " + String.valueOf(newOrModifiedAppUserLocationList.length));
                totalRecordsToupSync += newOrModifiedAppUserLocationList.length;
            }
            for (AppUserLocation appUserLocation in newOrModifiedAppUserLocationList) {
                try {
                    if (!upSyncList.contains("AppUserLocation-" + appUserLocation.id!)) {
                        upSyncList.add("AppUserLocation-" + appUserLocation.id!);

                        upSyncAppUserLocation(appUserLocation);
                    }
                } catch ( e) {
                }
                return;
            }

            //HSSupportTicket
            List<HSSupportTicket> newOrModifiedHSSupportTicketList = await HSSupportTicketDataHandlerBase.GetHSSupportTicketUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTickets - " + String.valueOf(newOrModifiedHSSupportTicketList.length));
                totalRecordsToupSync += newOrModifiedHSSupportTicketList.length;
            }
            for (HSSupportTicket hSSupportTicket in newOrModifiedHSSupportTicketList) {
                try {
                    if (!upSyncList.contains("HSSupportTicket-" + hSSupportTicket.id!)) {
                        upSyncList.add("HSSupportTicket-" + hSSupportTicket.id!);
                        upSyncHSSupportTicket(hSSupportTicket);
                    }
                } catch ( e) {
                }
                return;
            }

            //HSSupportTicketMedia
            List<HSSupportTicketMedia> newOrModifiedHSSupportTicketMediaList =await  HSSupportTicketMediaDataHandlerBase.GetHSSupportTicketMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketMediaList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTicketMedia - " + String.valueOf(newOrModifiedHSSupportTicketMediaList.length));
                totalRecordsToupSync += newOrModifiedHSSupportTicketMediaList.length;
            }
            for (HSSupportTicketMedia hSSupportTicketMedia in newOrModifiedHSSupportTicketMediaList) {
                try {
                    if (!upSyncList.contains("HSSupportTicketMedia-" + hSSupportTicketMedia.id!)) {
                        upSyncList.add("HSSupportTicketMedia-" + hSSupportTicketMedia.id!);
                        upSyncHSSupportTicketMedia(hSSupportTicketMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //Reminder
            List<Reminder> newOrModifiedReminderList = ReminderDataHandlerBase.GetReminderupSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReminderList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified Reminders - " + String.valueOf(newOrModifiedReminderList.length));
                totalRecordsToupSync += newOrModifiedReminderList.length;
            }
            for (Reminder reminder in newOrModifiedReminderList) {
                try {
                    if (!upSyncList.contains("Reminder-" + reminder.id)) {
                        upSyncList.add("Reminder-" + reminder.id);
                        upSyncReminder(reminder);
                    }
                } catch ( e) {
                }
                return;
            }

            Globals.SyncIndex++;

            if (Globals.SyncIndex > Globals.MAX_UPSYNC_INDEX) {
                Globals.SyncIndex = 0;
            }

            if (totalRecordsToupSync == 0) {
                LogMessage("Reseting failed upSyncindexesin ");
                // DatabaseHandler.getInstance().ResetPendingupSyncIndexes();
                DatabaseHandler.db.ResetPendingUpSyncIndexes();
            }

            logger.d("upSync - Completed");

        } catch ( ex) {
            Globals.handleException( "SyncServiceinRunupSync()", ex);
        }

    }


   Future<void> runDownSync() async {
        try {
            LogMessage("Current download: " + currentdownload);

            if (currentdownload == "") {

                AppSyncItem? amiSync = await  SyncDataHandler.GetNextSyncRecord(dbHandler);

                if (amiSync != null) {

                    currentdownload = amiSync.tableName!;

                    if (currentdownload==("Account")) {
                        downSyncAccounts(currentdownload);
                    } else if (currentdownload==("AccountAddress")) {
                         downSyncAccountAddresses(currentdownload);
                    } else if (currentdownload==("AccountBusinessPlan")) {
                         downSyncAccountBusinessPlans(currentdownload);
                    } else if (currentdownload==("AccountBusinessUnit")) {
                         downSyncAccountBusinessUnits(currentdownload);
                    } else if (currentdownload==("AccountBuyingProcess")) {
                         downSyncAccountBuyingProcesses(currentdownload);
                    } else if (currentdownload==("AccountCategory")) {
                         downSyncAccountCategories(currentdownload);
                    } else if (currentdownload==("AccountCategoryMapping")) {
                         downSyncAccountCategoryMappings(currentdownload);
                    } else if (currentdownload==("AccountCompetitionActivity")) {
                         downSyncAccountCompetitionActivities(currentdownload);
                    } else if (currentdownload==("AccountForm")) {
                         downSyncAccountForms(currentdownload);
                    } else if (currentdownload==("AccountFormValue")) {
                         downSyncAccountFormValues(currentdownload);
                    } else if (currentdownload==("AccountMedia")) {
                         downSyncAccountMedia(currentdownload);
                    } else if (currentdownload==("AccountPhone")) {
                         downSyncAccountPhones(currentdownload);
                    } else if (currentdownload==("AccountSegment")) {
                         downSyncAccountSegments(currentdownload);
                    } else if (currentdownload==("AccountStatus")) {
                         downSyncAccountStatuses(currentdownload);
                    } else if (currentdownload==("AccountTerritory")) {
                         downSyncAccountTerritories(currentdownload);
                    } else if (currentdownload==("AccountType")) {
                         downSyncAccountTypes(currentdownload);
                    } else if (currentdownload==("Activity")) {
                         downSyncActivities(currentdownload);
                    } else if (currentdownload==("ActivityApproval")) {
                         downSyncActivityApprovals(currentdownload);
                    } else if (currentdownload==("ActivityApprovalType")) {
                         downSyncActivityApprovalTypes(currentdownload);
                    } else if (currentdownload==("ActivityBusinessUnit")) {
                         downSyncActivityBusinessUnits(currentdownload);
                    } else if (currentdownload==("ActivityMeasure")) {
                         downSyncActivityMeasures(currentdownload);
                    } else if (currentdownload==("ActivityMedia")) {
                         downSyncActivityMedia(currentdownload);
                    } else if (currentdownload==("ActivityPermission")) {
                         downSyncActivityPermissions(currentdownload);
                    } else if (currentdownload==("ActivityPriority")) {
                         downSyncActivityPriorities(currentdownload);
                    } else if (currentdownload==("ActivityProduct")) {
                         downSyncActivityProducts(currentdownload);
                    } else if (currentdownload==("ActivityProductDetail")) {
                         downSyncActivityProductDetails(currentdownload);
                    } else if (currentdownload==("ActivityStatus")) {
                         downSyncActivityStatuses(currentdownload);
                    } else if (currentdownload==("ActivityTeam")) {
                         downSyncActivityTeams(currentdownload);
                    } else if (currentdownload==("ActivityTravel")) {
                         downSyncActivityTravels(currentdownload);
                    } else if (currentdownload==("ActivityTravelMapping")) {
                         downSyncActivityTravelMappings(currentdownload);
                    } else if (currentdownload==("ActivityTravelExpense")) {
                         downSyncActivityTravelExpenses(currentdownload);
                    } else if (currentdownload==("ActivityTravelMedia")) {
                         downSyncActivityTravelMedia(currentdownload);
                    } else if (currentdownload==("ActivityType")) {
                         downSyncActivityTypes(currentdownload);
                    } else if (currentdownload==("AddressType")) {
                         downSyncAddressTypes(currentdownload);
                    } else if (currentdownload==("AppFeature")) {
                         downSyncAppFeatures(currentdownload);
                    } else if (currentdownload==("AppFeatureField")) {
                         downSyncAppFeatureFields(currentdownload);
                    } else if (currentdownload==("AppFeatureGroup")) {
                         downSyncAppFeatureGroups(currentdownload);
                    } else if (currentdownload==("AppReport")) {
                         downSyncAppReports(currentdownload);
                    } else if (currentdownload==("AppUser")) {
                         downSyncAppUsers(currentdownload);
                    } else if (currentdownload==("AppUserLocation")) {
                         downSyncAppUserLocations(currentdownload);
                    } else if (currentdownload==("AppUserMessage")) {
                         downSyncAppUserMessages(currentdownload);
                    } else if (currentdownload==("AppUserProduct")) {
                         downSyncAppUserProducts(currentdownload);
                    } else if (currentdownload==("AppUserRemark")) {
                         downSyncAppUserRemarks(currentdownload);
                    } else if (currentdownload==("AppUserTeam")) {
                         downSyncAppUserTeams(currentdownload);
                    } else if (currentdownload==("AppUserTeamMember")) {
                         downSyncAppUserTeamMembers(currentdownload);
                    } else if (currentdownload==("AppUserTerritory")) {
                         downSyncAppUserTerritories(currentdownload);
                    } else if (currentdownload==("AppUserType")) {
                         downSyncAppUserTypes(currentdownload);
                    } else if (currentdownload==("Attribute")) {
                         downSyncAttributes(currentdownload);
                    } else if (currentdownload==("AttributeValue")) {
                         downSyncAttributeValues(currentdownload);
                    } else if (currentdownload==("BusinessEmail")) {
                         downSyncBusinessEmails(currentdownload);
                    } else if (currentdownload==("BusinessFeature")) {
                         downSyncBusinessFeatures(currentdownload);
                    } else if (currentdownload==("BusinessUnit")) {
                         downSyncBusinessUnits(currentdownload);
                    } else if (currentdownload==("ChatMessage")) {
                         downSyncChatMessages(currentdownload);
                    } else if (currentdownload==("ChatUserAndGroup")) {
                         downSyncChatUserAndGroups(currentdownload);
                    } else if (currentdownload==("ChatUserGroupMember")) {
                         downSyncChatUserGroupMembers(currentdownload);
                    } else if (currentdownload==("Competitor")) {
                         downSyncCompetitors(currentdownload);
                    } else if (currentdownload==("Contact")) {
                         downSyncContacts(currentdownload);
                    } else if (currentdownload==("ContactAlignment")) {
                         downSyncContactAlignments(currentdownload);
                    } else if (currentdownload==("ContactCategory")) {
                         downSyncContactCategories(currentdownload);
                    } else if (currentdownload==("ContactMedia")) {
                         downSyncContactMedia(currentdownload);
                    } else if (currentdownload==("ContactTitle")) {
                         downSyncContactTitles(currentdownload);
                    } else if (currentdownload==("ContentType")) {
                         downSyncContentTypes(currentdownload);
                    } else if (currentdownload==("Country")) {
                         downSyncCountries(currentdownload);
                    } else if (currentdownload==("CreditRating")) {
                         downSyncCreditRatings(currentdownload);
                    } else if (currentdownload==("Currency")) {
                         downSyncCurrencies(currentdownload);
                    } else if (currentdownload==("CustomerMeeting")) {
                         downSyncCustomerMeetings(currentdownload);
                    } else if (currentdownload==("Department")) {
                         downSyncDepartments(currentdownload);
                    } else if (currentdownload==("Designation")) {
                         downSyncDesignations(currentdownload);
                    } else if (currentdownload==("EmailManualTemplate")) {
                         downSyncEmailManualTemplates(currentdownload);
                    } else if (currentdownload==("ExpenseType")) {
                         downSyncExpenseTypes(currentdownload);
                    } else if (currentdownload==("FieldAttendance")) {
                         downSyncFieldAttendances(currentdownload);
                    } else if (currentdownload==("FinancialInstitution")) {
                         downSyncFinancialInstitutions(currentdownload);
                    } else if (currentdownload==("FinancialYear")) {
                         downSyncFinancialYears(currentdownload);
                    } else if (currentdownload==("Form")) {
                         downSyncForms(currentdownload);
                    } else if (currentdownload==("FormCell")) {
                         downSyncFormCells(currentdownload);
                    } else if (currentdownload==("FormCellElement")) {
                         downSyncFormCellElements(currentdownload);
                    } else if (currentdownload==("FormSection")) {
                         downSyncFormSections(currentdownload);
                    } else if (currentdownload==("Industry")) {
                         downSyncIndustries(currentdownload);
                    } else if (currentdownload==("LeadSource")) {
                         downSyncLeadSources(currentdownload);
                    } else if (currentdownload==("ModeOfTravel")) {
                         downSyncModeOfTravels(currentdownload);
                    } else if (currentdownload==("Note")) {
                         downSyncNotes(currentdownload);
                    } else if (currentdownload==("NoteMedia")) {
                         downSyncNoteMedia(currentdownload);
                    } else if (currentdownload==("NotePermission")) {
                         downSyncNotePermissions(currentdownload);
                    } else if (currentdownload==("Notification")) {
                         downSyncNotifications(currentdownload);
                    } else if (currentdownload==("NotificationAssignment")) {
                         downSyncNotificationAssignments(currentdownload);
                    } else if (currentdownload==("Opportunity")) {
                         downSyncOpportunities(currentdownload);
                    } else if (currentdownload==("OpportunityApproval")) {
                         downSyncOpportunityApprovals(currentdownload);
                    } else if (currentdownload==("OpportunityApprovalType")) {
                         downSyncOpportunityApprovalTypes(currentdownload);
                    } else if (currentdownload==("OpportunityBusinessUnit")) {
                         downSyncOpportunityBusinessUnits(currentdownload);
                    } else if (currentdownload==("OpportunityContact")) {
                         downSyncOpportunityContacts(currentdownload);
                    } else if (currentdownload==("OpportunityMeasure")) {
                         downSyncOpportunityMeasures(currentdownload);
                    } else if (currentdownload==("OpportunityFulfillmentStatus")) {
                         downSyncOpportunityFulfillmentStatuses(currentdownload);
                    } else if (currentdownload==("OpportunityMedia")) {
                         downSyncOpportunityMedia(currentdownload);
                    } else if (currentdownload==("OpportunityName")) {
                         downSyncOpportunityNames(currentdownload);
                    } else if (currentdownload==("OpportunityPermission")) {
                         downSyncOpportunityPermissions(currentdownload);
                    } else if (currentdownload==("OpportunityPriority")) {
                         downSyncOpportunityPriorities(currentdownload);
                    } else if (currentdownload==("OpportunityProduct")) {
                         downSyncOpportunityProducts(currentdownload);
                    } else if (currentdownload==("OpportunityProductDetail")) {
                         downSyncOpportunityProductDetails(currentdownload);
                    } else if (currentdownload==("OpportunityProductDetailAttribute")) {
                         downSyncOpportunityProductDetailAttributes(currentdownload);
                    } else if (currentdownload==("OpportunityStage")) {
                         downSyncOpportunityStages(currentdownload);
                    } else if (currentdownload==("OpportunityStageType")) {
                         downSyncOpportunityStageTypes(currentdownload);
                    } else if (currentdownload==("OpportunityStatus")) {
                         downSyncOpportunityStatuses(currentdownload);
                    } else if (currentdownload==("OpportunityTeam")) {
                         downSyncOpportunityTeams(currentdownload);
                    } else if (currentdownload==("OpportunityType")) {
                         downSyncOpportunityTypes(currentdownload);
                    } else if (currentdownload==("PerformanceSummary")) {
                         downSyncPerformanceSummaries(currentdownload);
                    } else if (currentdownload==("PhoneType")) {
                         downSyncPhoneTypes(currentdownload);
                    } else if (currentdownload==("Product")) {
                         downSyncProducts(currentdownload);
                    } else if (currentdownload==("ProductAuxiliary")) {
                         downSyncProductAuxiliaries(currentdownload);
                    } else if (currentdownload==("ProductCategory")) {
                         downSyncProductCategories(currentdownload);
                    } else if (currentdownload==("ProductInstallation")) {
                         downSyncProductInstallations(currentdownload);
                    } else if (currentdownload==("ProductInstallationDetail")) {
                         downSyncProductInstallationDetails(currentdownload);
                    } else if (currentdownload==("ProductMedia")) {
                         downSyncProductMedia(currentdownload);
                    } else if (currentdownload==("Reimbursement")) {
                         downSyncReimbursements(currentdownload);
                    } else if (currentdownload==("ReimbursementDetail")) {
                         downSyncReimbursementDetails(currentdownload);
                    } else if (currentdownload==("ReimbursementType")) {
                         downSyncReimbursementTypes(currentdownload);
                    } else if (currentdownload==("Reminder")) {
                         downSyncReminders(currentdownload);
                    } else if (currentdownload==("Resource")) {
                         downSyncResources(currentdownload);
                    } else if (currentdownload==("ServiceInvoice")) {
                         downSyncServiceInvoices(currentdownload);
                    } else if (currentdownload==("ServiceInvoiceDetail")) {
                         downSyncServiceInvoiceDetails(currentdownload);
                    } else if (currentdownload==("Tag")) {
                         downSyncTags(currentdownload);
                    } else if (currentdownload==("TagGroup")) {
                         downSyncTagGroups(currentdownload);
                    } else if (currentdownload==("Territory")) {
                         downSyncTerritories(currentdownload);
                    } else if (currentdownload==("TimeZone")) {
                         downSyncTimeZones(currentdownload);
                    } else if (currentdownload==("TravelPurpose")) {
                         downSyncTravelPurposes(currentdownload);
                    } else if (currentdownload==("Unit")) {
                         downSyncUnits(currentdownload);
                    } else if (currentdownload==("HSSupportTicket")) {
                         downSyncHSSupportTickets(currentdownload);
                    } else if (currentdownload==("HSSupportTicketMedia")) {
                         downSyncHSSupportTicketMedia(currentdownload);
                    }

                    LogMessage("SYNC Current download: " + currentdownload);


                } else {
                    currentdownload = "MaxDates";
                     downSyncMaxDates();
                    if (isFirstdownloadCompleted) {
                        if (syncCount == 5)
                             downSyncIDs("Account");
                        if (syncCount == 10)
                             downSyncIDs("Contact");
                        if (syncCount == 15)
                             downSyncIDs("Activity");
                        if (syncCount == 20)
                             downSyncIDs("Opportunity");
                        if (syncCount == 25) {
                            // downSyncIDs("Product");
                            syncCount = 0;
                        }
                        syncCount++;
                    }
                    isFirstdownloadCompleted = true;
                }

            }
        } catch ( ex) {
            Globals.handleException( "SyncService:Run downSync()", ex);
        }
    }


void upSyncAccountCategoryMapping(AccountCategoryMapping accountCategoryMapping) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + '/accountcategorymapping';

      Map<String, dynamic> postData = {
        'AccountCategoryMappingID': Globals.isNullOrEmpty(accountCategoryMapping.accountCategoryMappingID!) ? '-1' : accountCategoryMapping.accountCategoryMappingID,
        'AccountCategoryMappingCode': Globals.isNullOrEmpty(accountCategoryMapping.accountCategoryMappingCode!) ? '' : accountCategoryMapping.accountCategoryMappingCode,
        'AccountID':   AccountDataHandlerBase.GetServerId(dbHandler,  accountCategoryMapping.accountID!),
        'AccountCategoryID': AccountCategoryDataHandlerBase.GetServerId(dbHandler,  accountCategoryMapping.accountCategoryID!),
        'CreatedBy': accountCategoryMapping.createdBy,
        'CreatedOn': accountCategoryMapping.createdOn,
        'ModifiedBy': accountCategoryMapping.modifiedBy,
        'ModifiedOn': accountCategoryMapping.modifiedOn,
        'IsActive': Globals.tryParseBoolean(accountCategoryMapping.isActive),
        'Uid': accountCategoryMapping.uid,
        'AppUserID': accountCategoryMapping.appUserID,
        'AppUserGroupID': accountCategoryMapping.appUserGroupID,
        'IsArchived': Globals.tryParseBoolean(accountCategoryMapping.isArchived),
        'IsDeleted': Globals.tryParseBoolean(accountCategoryMapping.isDeleted),
      };

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
          'Content-Type': 'application/json',
        },
        body: json.encode(postData),
      );

      if (response.statusCode == 200) {
        var jsonObject = json.decode(response.body);
        if (jsonObject != null) {
          try {
            AccountCategoryMapping accountCategoryMappingReturn = AccountCategoryMapping();
            JSONCopier.copyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, accountCategoryMappingReturn, false);
            accountCategoryMappingReturn.isDirty = 'false';
            accountCategoryMappingReturn.upSyncMessage = 'SUCCESS';
            accountCategoryMappingReturn.upSyncIndex = '${Globals.SyncIndex}';
            AccountCategoryMappingDataHandlerBase.UpdateAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping.id!, accountCategoryMappingReturn);
            logger.d('AccountCategoryMapping - Saved successfully.');

          } catch (ex) {
            logger.e('Error: SyncService:upSyncAccountCategoryMapping() 1-> ${ex.toString()}');
          }
        } else {
          logger.e('VolleyError: SyncService:upSyncAccountCategoryMapping() 2-> ${accountCategoryMapping.id} : Object not returned.');
          accountCategoryMapping.upSyncMessage = 'FAIL: Object not returned';
          accountCategoryMapping.upSyncIndex = '${Globals.SyncIndex}';
          AccountCategoryMappingDataHandlerBase.UpdateAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping.id!, accountCategoryMapping);
        }
        upSyncList.remove('AccountCategoryMapping-${accountCategoryMapping.id}');
      } else {
        String postError = response.body.isNotEmpty ? response.body : response.statusCode.toString();
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          accountCategoryMapping.upSyncMessage = 'FAIL: $postError';
          accountCategoryMapping.upSyncIndex = '${Globals.SyncIndex}';
          AccountCategoryMappingDataHandlerBase.UpdateAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping.id!, accountCategoryMapping);
        }
        upSyncList.remove('AccountCategoryMapping-${accountCategoryMapping.id}');
        logger.e('VolleyError: SyncService:upSyncAccountCategoryMapping() 3-> $postError');
      }
    }
  } catch (e) {
    logger.e('Error: SyncService:upSyncAccountCategoryMapping() 4-> ${e.toString()}');
  }
}

void upSyncContact(Contact contact) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/contact";

      Map<String, dynamic> postData = {
  "ContactID": !Globals.isNullOrEmpty(contact.contactID!) ? contact.contactID : "-1",
  "ContactCode": !Globals.isNullOrEmpty(contact.contactCode!) ? contact.contactCode : "",
  "Title": contact.title,
  "FirstName": contact.firstName,
  "MiddleName": contact.middleName,
  "LastName": contact.lastName,
  "ContactName": contact.contactName,
  "ContactIdentifier": contact.contactIdentifier,
  "AccountID": AccountDataHandlerBase.GetServerId(dbHandler, contact.accountID!),
  "ContactCategoryID": ContactCategoryDataHandlerBase.GetServerId(dbHandler, contact.contactCategoryID!),
  "DepartmentName": contact.departmentName,
  "Designation": contact.designation,
  "RolesAndResponsibilities": contact.rolesAndResponsibilities,
  "ReportingManager": contact.reportingManager,
  "ReportingContactID": ContactHandlerDataBase.GetServerId(dbHandler, contact.reportingContactID!),
  "MobileNumber": contact.mobileNumber,
  "AlternateMobileNumber": contact.alternateMobileNumber,
  "WorkPhone": contact.workPhone,
  "ResidencePhone": contact.residencePhone,
  "Email": contact.email,
  "AlternateEmail": contact.alternateEmail,
  "AddressLine1": contact.addressLine1,
  "AddressLine2": contact.addressLine2,
  "AddressLine3": contact.addressLine3,
  "City": contact.city,
  "State": contact.state,
  "Country": contact.country,
  "PIN": contact.pin,
  "GPSCoordinates": contact.gpsCoordinates,
  "LinkedIn": contact.linkedIn,
  "PastAccounts": contact.pastAccounts,
  "PastDesignations": contact.pastDesignations,
  "DateOfBirth": contact.dateOfBirth,
  "RemindBirthday": Globals.tryParseBoolean(contact.remindBirthday),
  "ContactAlignmentID": ContactAlignmentDataHandlerBase.GetServerId(dbHandler, contact.contactAlignmentID!),
  "Remarks": contact.remarks,
  "ReferenceHistory": contact.referenceHistory,
  "IsPrimaryContact": Globals.tryParseBoolean(contact.isPrimaryContact),
  "ContactCodeInternal": contact.contactCodeInternal,
  "Tags": contact.tags,
  "FreeTextField1": contact.freeTextField1,
  "FreeTextField2": contact.freeTextField2,
  "FreeTextField3": contact.freeTextField3,
  // "MarketingContactID": MarketingContactHandlerDataBase.GetServerId(dbHandler,  contact.marketingContactID),
  "CreatedBy": contact.createdBy,
  "CreatedOn": contact.createdOn,
  "ModifiedBy": contact.modifiedBy,
  "ModifiedOn": contact.modifiedOn,
  "DeviceIdentifier": contact.deviceIdentifier,
  "ReferenceIdentifier": contact.referenceIdentifier,
  "IsActive": Globals.tryParseBoolean(contact.isActive),
  "Uid": contact.uid,
  "AppUserID": contact.appUserID,
  "AssignedByAppUserID": contact.assignedByAppUserID,
  "AppUserGroupID": contact.appUserGroupID,
  "IsArchived": Globals.tryParseBoolean(contact.isArchived),
  "IsDeleted": Globals.tryParseBoolean(contact.isDeleted),
};


      var headers = {
        "Authorization": "Bearer ${Globals.USER_TOKEN}",
      };

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(postData),
      );

      if (response.statusCode == 200) {
        var jsonObject = json.decode(response.body);
        if (jsonObject != null) {
          try {
            Contact contactReturn = new Contact();
            // Copy JSON data to Contact object using a helper method
            // JSONCopier.CopyJsonDataToContact( dbHandler, jsonObject, contactReturn, false);
            contactReturn.isDirty = "false";
            contactReturn.upSyncMessage = "SUCCESS";
            contactReturn.upSyncIndex = Globals.SyncIndex.toString();
            var id = await ContactHandlerDataBase.UpdateContactRecord(dbHandler, contact.id!, contactReturn);
            logger.d("Contact - Saved successfully.");
          } catch ( ex) {
            logger.e("Error: SyncService:upSyncContact() 1-> ${ex.toString()}");
          }
        } else {
          logger.e("VolleyError: SyncService:upSyncContact() 2-> ${contact.id} : Object not returned.");
          contact.upSyncMessage = "FAIL: Object not returned";
          contact.upSyncIndex = Globals.SyncIndex.toString();
          ContactHandlerDataBase.UpdateContactRecord(dbHandler, contact.id!, contact);
        }
        upSyncList.remove("Contact-${contact.id}");
      } else {
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = "";
        } else {
          String posterror = response.body;
          logger.e("VolleyError: SyncService:upSyncContact() 3-> $posterror");
          contact.upSyncMessage = "FAIL: $posterror";
          contact.upSyncIndex = Globals.SyncIndex.toString();
          ContactHandlerDataBase.UpdateContactRecord(dbHandler,  contact.id!, contact);
        }
        upSyncList.remove("Contact-${contact.id}");
      }
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncContact() 4-> ${e.toString()}");
  }
}

Future<void> upSyncActivity(Activity activity) async {
  if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
    String url = AppConstants.API_VERSION_URL + "/activity";

    Map<String, dynamic> postData = {
      "ActivityID": !Globals.isNullOrEmpty(activity.activityID) ? activity.activityID : "-1",
      "ActivityCode": !Globals.isNullOrEmpty(activity.activityCode) ? activity.activityCode : "",
      "ActivityTitle": activity.activityTitle,
      "ActivityTypeID": ActivityTypeDataHandlerBase.GetServerId(dbHandler,  activity.activityTypeID),
      "LeadSource": activity.leadSource,
      "AccountID": AccountDataHandler.GetServerId(dbHandler,  activity.accountID),
      "ContactID": ContactHandlerDataBase.GetServerId(dbHandler,  activity.contactID),
      "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  activity.opportunityID),
      "ActivityMeasure": activity.activityMeasure,
      "ActivityDate": activity.activityDate,
      "ActivityEndDate": activity.activityEndDate,
      "ActivityDetails": activity.activityDetails,
      "ActivityPriorityID": ActivityPriorityDataHandlerBase.GetServerId(dbHandler,  activity.activityPriorityID),
      "TotalAmount": activity.totalAmount,
      "AmountCollected": activity.amountCollected,
      "CurrencyID": CurrencyDataHandlerBase.GetServerId(dbHandler,  activity.currencyID),
      "CollectionDetails": activity.collectionDetails,
      "IsTravelled": Globals.tryParseBoolean(activity.isTravelled),
      "TravelPurposeName": activity.travelPurposeName,
      "ActivityStatusID": ActivityStatusDataHandler.GetServerId(dbHandler,  activity.activityStatusID),
      "NeedFollowUpActivity": Globals.tryParseBoolean(activity.needFollowUpActivity),
      "ParentActivityID": ActivityDataHandler.GetServerId(dbHandler,  activity.parentActivityID),
      "ExpectedCompletionDate": activity.expectedCompletionDate,
      "ActivityCodeInternal": activity.activityCodeInternal,
      "Tags": activity.tags,
      "FreeTextField1": activity.freeTextField1,
      "FreeTextField2": activity.freeTextField2,
      "FreeTextField3": activity.freeTextField3,
      "IsApprovalRequired": Globals.tryParseBoolean(activity.isApprovalRequired),
      "IsApproved": Globals.tryParseBoolean(activity.isApproved),
      "CompletedDate": activity.completedDate,
      "IsWorkflowStageUpdated": Globals.tryParseBoolean(activity.isWorkflowStageUpdated),
      "CreatedBy": activity.createdBy,
      "CreatedOn": activity.createdOn,
      "ModifiedBy": activity.modifiedBy,
      "ModifiedOn": activity.modifiedOn,
      "DeviceIdentifier": activity.deviceIdentifier,
      "ReferenceIdentifier": activity.referenceIdentifier,
      "Location": activity.location,
      "IsActive": Globals.tryParseBoolean(activity.isActive),
      "IsLocked": Globals.tryParseBoolean(activity.isLocked),
      "Uid": activity.uid,
      "AppUserID": activity.appUserID,
      "AppUserGroupID": activity.appUserGroupID,
      "IsArchived": Globals.tryParseBoolean(activity.isArchived),
      "IsDeleted": Globals.tryParseBoolean(activity.isDeleted),
    };

    String json = jsonEncode(postData);
    print('ACT_SAVE: $json');

    http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${Globals.USER_TOKEN}',
      },
      body: json,
    ).then((response) {
      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject != null) {
          try {
            Activity activityReturn = new Activity();
            JSONCopier.copyJsonDataToActivity(dbHandler, jsonObject, activityReturn, false);
            activityReturn.isDirty = false.toString();
            activityReturn.upSyncMessage = "SUCCESS";
            activityReturn.upSyncIndex = Globals.SyncIndex.toString();
            ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activityReturn);
            logger.d("Activity - Saved successfully.");
          } catch (ex) {
            logger.e("Error: SyncService:upSyncActivity() 1-> $ex");
          }
        } else {
          logger.e("VolleyError: SyncService:upSyncActivity() 2-> ${activity.id} : Object not returned.");
          activity.upSyncMessage = "FAIL: Object not returned";
          activity.upSyncIndex = Globals.SyncIndex.toString();
          ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        }
        upSyncList.remove("Activity-${activity.id}");
      } 
      
      else {
        String postError = response.body;
        logger.e("VolleyError: SyncService:upSyncActivity() 3-> $postError");
        activity.upSyncMessage = "FAIL: $postError";
        activity.upSyncIndex = Globals.SyncIndex.toString();
        ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        upSyncList.remove("Activity-${activity.id}");
      }
    }).catchError((error) {
      if (error is http.Client) {
        Globals.USER_TOKEN_ALT = "";
      } else {
        String postError = error.toString();
        logger.e("VolleyError: SyncService:upSyncActivity() 4-> $postError");
        activity.upSyncMessage = "FAIL: $postError";
        activity.upSyncIndex = Globals.SyncIndex.toString();
        ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        upSyncList.remove("Activity-${activity.id}");
      }
    });
  }

}

Future<void> upSyncOpportunity(Opportunity opportunity) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/opportunity";

      Map<String, dynamic> postData = {
        "OpportunityID": !Globals.isNullOrEmpty(opportunity.opportunityID!) ? opportunity.opportunityID : "-1",
        "OpportunityCode": !Globals.isNullOrEmpty(opportunity.opportunityCode!) ? opportunity.opportunityCode : "",
        "OpportunityName": opportunity.opportunityName,
        "OpportunityDetail": opportunity.opportunityDetail,
        "LeadSource": opportunity.leadSource,
        "OpportunityTypeID": OpportunityTypeDataHandlerBase.GetServerId(dbHandler,  opportunity.opportunityTypeID!),
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  opportunity.accountID),
        "ContactID": ContactHandlerDataBase.getServerId(dbHandler,  opportunity.contactID!),
        "OpportunityMeasure": opportunity.opportunityMeasure,
        "OpportunityValue": opportunity.opportunityValue,
        "CurrencyID": CurrencyDataHandlerBase.getServerId(dbHandler,  opportunity.currencyID),
        "GrossProfit": opportunity.grossProfit,
        "DealRegistrationNumber": opportunity.dealRegistrationNumber,
        "ClosureDate": opportunity.closureDate,
        "Probability": opportunity.probability,
        "OpportunityPriorityID": OpportunityPriorityDataHandlerBase.getServerId(dbHandler,  opportunity.opportunityPriorityID),
        "OpportunityStageID": OpportunityStageDataHandlerBase.GetServerId(dbHandler,  opportunity.opportunityStageID!),
        "OpportunityStatusID": OpportunityStatusDataHandlerBase.GetServerId(dbHandler,  opportunity.opportunityStatusID!),
        "ActualOpportunityValue": opportunity.actualOpportunityValue,
        "LostToCompetitor": opportunity.lostToCompetitor,
        "ReasonForOpportunityStatus": opportunity.reasonForOpportunityStatus,
        "OpportunityIdentifier": opportunity.opportunityIdentifier,
        "PurchaseOrderNumber": opportunity.purchaseOrderNumber,
        "QuotationNumber": opportunity.quotationNumber,
        "IsFinanceRequired": Globals.tryParseBoolean(opportunity.isFinanceRequired),
        "FinanceBy": opportunity.financeBy,
        "FinanceRemarks": opportunity.financeRemarks,
        "IsApprovalRequired": Globals.tryParseBoolean(opportunity.isApprovalRequired),
        "ParentOpportunityID": OpportunityDataHandlerBase.GetServerId(dbHandler,  opportunity.parentOpportunityID!),
        "IsRecurringOpportunity": Globals.tryParseBoolean(opportunity.isRecurringOpportunity),
        "RecurrenceIntervalInDays": opportunity.recurrenceIntervalInDays,
        "RecurrenceCount": opportunity.recurrenceCount,
        "RecurringOpportunityID": OpportunityDataHandlerBase.GetServerId(dbHandler,  opportunity.recurringOpportunityID!),
        "DateGeneratedForRecurring": opportunity.dateGeneratedForRecurring,
        "RequestedDeliveryDate": opportunity.requestedDeliveryDate,
        "PlannedDeliveryDate": opportunity.plannedDeliveryDate,
        "ActualDeliveryDate": opportunity.actualDeliveryDate,
        "SupplierAccountID": AccountDataHandler.GetServerId(dbHandler,  opportunity.supplierAccountID),
        "Tags": opportunity.tags,
        "OpportunityCodeInternal": opportunity.opportunityCodeInternal,
        "FreeTextField1": opportunity.freeTextField1,
        "FreeTextField2": opportunity.freeTextField2,
        "FreeTextField3": opportunity.freeTextField3,
        "IsAssigned": Globals.tryParseBoolean(opportunity.isAssigned),
        "AssignedDate": opportunity.assignedDate,
        "AssignedByAppUserID": opportunity.assignedByAppUserID,
        "AssignmentRemarks": opportunity.assignmentRemarks,
        "OpportunityFulfillmentStatus": opportunity.opportunityFulfillmentStatus,
        "IsOpportunityFulfilled": Globals.tryParseBoolean(opportunity.isOpportunityFulfilled),
        "CreatedBy": opportunity.createdBy,
        "CreatedOn": opportunity.createdOn,
        "ModifiedBy": opportunity.modifiedBy,
        "ModifiedOn": opportunity.modifiedOn,
        "IsWonAlerted": Globals.tryParseBoolean(opportunity.isWonAlerted),
        "IsNewAlerted": Globals.tryParseBoolean(opportunity.isNewAlerted),
        "IsActive": Globals.tryParseBoolean(opportunity.isActive),
        "IsLocked": Globals.tryParseBoolean(opportunity.isLocked),
        "IsApproved": Globals.tryParseBoolean(opportunity.isApproved),
        "Uid": opportunity.uid,
        "AppUserID": opportunity.appUserID,
        "AppUserGroupID": opportunity.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunity.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunity.isDeleted),
        "LeadQualificationID": opportunity.leadQualificationID
      };

      http.post(
        Uri.parse(url),
        body: json.encode(postData),
        headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
      ).then((response) {
        if (response.statusCode == 200) {
          if (response.body != null) {
            try {
              Opportunity opportunityReturn = new Opportunity();
              JSONCopier.copyJsonDataToOpportunity( dbHandler, json.decode(response.body), opportunityReturn, false);
              opportunityReturn.isDirty = false.toString();
              opportunityReturn.upSyncMessage = "SUCCESS";
              opportunityReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunityReturn);
              LogupSyncItemMessage("Opportunity - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncOpportunity() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncOpportunity() 2-> ${opportunity.id} : Object not returned.");
            opportunity.upSyncMessage = "FAIL: Object not returned";
            opportunity.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          }
          upSyncList.remove("Opportunity-${opportunity.id}");
        } else {
          String postError = response.body;
          logger.e("VolleyError: SyncService:upSyncOpportunity() 3-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          Globals.USER_TOKEN_ALT = "";
        } else {
          String postError = error.toString();
          logger.e("VolleyError: SyncService:upSyncOpportunity() 4-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncOpportunity() 4-> $e");
  }
}


void upSyncCustomerMeeting(CustomerMeeting customerMeeting) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstants.API_VERSION_URL}/customermeeting';

      Map<String, dynamic> postData = {
        'CustomerMeetingID': customerMeeting.customerMeetingID != null && customerMeeting.customerMeetingID.isNotEmpty ? customerMeeting.customerMeetingID : '-1',
        'CustomerMeetingCode': customerMeeting.customerMeetingCode != null && customerMeeting.customerMeetingCode.isNotEmpty ? customerMeeting.customerMeetingCode : '',
        'CustomerMeetingTitle': customerMeeting.customerMeetingTitle,
        'ActivityID': ActivityDataHandler.GetServerId(dbHandler,  customerMeeting.activityID),
        'AccountID': AccountDataHandler.GetServerId(dbHandler,  customerMeeting.accountID),
        'ContactID': ContactHandlerDataBase.GetServerId(dbHandler,  customerMeeting.contactID),
        'CustomerMeetingDate': customerMeeting.customerMeetingDate,
        'PunchInTime': customerMeeting.punchInTime,
        'PunchOutTime': customerMeeting.punchOutTime,
        'PunchInLocation': customerMeeting.punchInLocation,
        'PunchOutLocation': customerMeeting.punchOutLocation,
        'Remarks': customerMeeting.remarks,
        'CreatedBy': customerMeeting.createdBy,
        'CreatedOn': customerMeeting.createdOn,
        'ModifiedBy': customerMeeting.modifiedBy,
        'ModifiedOn': customerMeeting.modifiedOn,
        'DeviceIdentifier': customerMeeting.deviceIdentifier,
        'ReferenceIdentifier': customerMeeting.referenceIdentifier,
        'IsActive': Globals.tryParseBoolean(customerMeeting.isActive),
        'Uid': customerMeeting.uid,
        'AppUserID': customerMeeting.appUserID,
        'AppUserGroupID': customerMeeting.appUserGroupID,
        'IsArchived': Globals.tryParseBoolean(customerMeeting.isArchived),
        'IsDeleted': Globals.tryParseBoolean(customerMeeting.isDeleted),
      };

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject != null) {
          try {
            CustomerMeeting customerMeetingReturn = new CustomerMeeting();
            JSONCopier.CopyJsonDataToCustomerMeeting( dbHandler, jsonObject, customerMeetingReturn, false);
            customerMeetingReturn.isDirty = false;
            customerMeetingReturn.upSyncMessage = 'SUCCESS';
            customerMeetingReturn.upSyncIndex = Globals.SyncIndex.toString();
            CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeetingReturn);
            LogupSyncItemMessage('CustomerMeeting - Saved successfully.');
          } catch ( ex) {
            logger.e('Error: SyncService:upSyncCustomerMeeting() 1-> ${ex.toString()}');
          }
        } else {
          logger.e('VolleyError: SyncService:upSyncCustomerMeeting() 2-> ${customerMeeting.id}: Object not returned.');
          customerMeeting.upSyncMessage = 'FAIL: Object not returned';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeeting);
        }
      } else {
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          String postError = response.body;
          logger.e('VolleyError: SyncService:upSyncCustomerMeeting() 3-> $postError');
          customerMeeting.upSyncMessage = 'FAIL: $postError';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeeting);
        }
      }
      upSyncList.remove('CustomerMeeting-${customerMeeting.id}');
    }
  } catch (e) {
    logger.e('Error: SyncService:upSyncCustomerMeeting() 4-> ${e.toString()}');
  }
}


void upSyncActivityProduct(String activityId, List<ActivityProduct> activityProductListOriginal, List<ActivityProductDetail> activityProductDetailListOriginal, List<ActivityProduct> activityProductList, List<ActivityProductDetail> activityProductDetailList) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/activityproduct/savecollection';
      Map<String, String> headers = {'Authorization': 'Bearer ${Globals.USER_TOKEN}'};

     
var userdata1 = jsonEncode(activityProductList);
var userdata2 = jsonEncode(activityProductDetailList);
      
      var requestBody = jsonEncode({
        'ObjectID': activityId,
        'DataString1': userdata1,
        'DataString2': userdata2,
      });

      var response = await http.post(Uri.parse(url), headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null && jsonResponse != '' && !jsonResponse.startsWith('ERROR_')) {
          var jsonObjCollection = jsonDecode(response.body);

          // ActivityProduct
          var jsonarray = jsonObjCollection['ActivityProduct'];
          for (var j = 0; j < jsonarray.length; j++) {
            var jsonObj = jsonarray[j];
            var cid = jsonObj['CID'];
            var sid = jsonObj['SID'];
            if (Globals.TryParseAsIntString(cid) != '' && Globals.TryParseAsIntString(sid) != '') {
              var activityProduct = ActivityProductDataHandler.GetActivityProductRecord(dbHandler,  cid);
              if (activityProduct != null) {
                activityProduct.setupSyncIndex(Globals.SyncIndex.toString());
                activityProduct.setActivityProductID(sid);
                activityProduct.setIsDirty('false');
                activityProduct.setupSyncMessage('SUCCESS');
                var rid = ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler,  activityProduct.id, activityProduct);
              }
            }
          }

          // ActivityProductDetail
          jsonarray = jsonObjCollection['ActivityProductDetail'];
          for (var j = 0; j < jsonarray.length; j++) {
            var jsonObj = jsonarray[j];
            var cid = jsonObj['CID'];
            var sid = jsonObj['SID'];
            if (Globals.TryParseAsIntString(cid) != '' && Globals.TryParseAsIntString(sid) != '') {
              var activityProductDetail = ActivityProductDetailDataHandler.GetActivityProductDetailRecord(dbHandler,  cid);
              if (activityProductDetail != null) {
                activityProductDetail.setupSyncIndex(Globals.SyncIndex.toString());
                activityProductDetail.setActivityProductDetailID(sid);
                activityProductDetail.setIsDirty('false');
                activityProductDetail.setupSyncMessage('SUCCESS');
                var rid = ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.id, activityProductDetail);
              }
            }
          }

          LogupSyncItemMessage('ActivityProduct - Saved successfully.');
        } else {
          logger.e('VolleyError: SyncService:upSyncActivityProduct() 1-> $activityId : Object not returned.');

          for (var activityProduct in activityProductListOriginal) {
            activityProduct.setupSyncMessage('FAIL: Object not returned');
            activityProduct.setupSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler,  activityProduct.id, activityProduct);
          }

          for (var activityProductDetail in activityProductDetailListOriginal) {
            activityProductDetail.setupSyncMessage('FAIL: Object not returned');
            activityProductDetail.setupSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.id, activityProductDetail);
          }
        }

        upSyncList.remove('ActivityProduct-$activityId');
      } else {
        var postError = '';
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          var errorResponse = response.body;
          if (errorResponse != null) {
            postError = utf8.decode(response.bodyBytes);
          }
        }

        logger.e('Error: SyncService:upSyncActivityProduct() 3-> $postError');

        for (var activityProduct in activityProductListOriginal) {
          activityProduct.setupSyncMessage('FAIL: $postError');
          activityProduct.setupSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDataHandlerBase.UpdateActivityProductRecord(dbHandler,  activityProduct.id, activityProduct);
        }

        for (var activityProductDetail in activityProductDetailListOriginal) {
          activityProductDetail.setupSyncMessage('FAIL: $postError');
          activityProductDetail.setupSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.id, activityProductDetail);
        }

        upSyncList.remove('ActivityProduct-$activityId');
      }
    }
  } catch (e) {
    logger.e('Error: SyncService:upSyncActivityProduct() 4-> ${e.toString()}');
  }
}

 
  Future<void> upSyncOpportunityProduct(String opportunityId, List<OpportunityProduct> opportunityProductListOriginal, List<OpportunityProductDetail> opportunityProductDetailListOriginal, List<OpportunityProduct> opportunityProductList, List<OpportunityProductDetail> opportunityProductDetailList)async {
  try {
    if (await  Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/opportunityproduct/savecollection";

      var userdata1 = jsonEncode(opportunityProductList);
      var userdata2 = jsonEncode(opportunityProductDetailList);

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "ObjectID": opportunityId,
          "DataString1": userdata1,
          "DataString2": userdata2,
        }),
      ).then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          // OpportunityProduct
          var opportunityProductArray = jsonResponse["OpportunityProduct"];
          for (var j = 0; j < opportunityProductArray.length; j++) {
            var jsonObj = opportunityProductArray[j];
            var cid = jsonObj["CID"];
            var sid = jsonObj["SID"];
            if (Globals.tryParseAsIntString(cid) != "" && Globals.tryParseAsIntString(sid) != "") {
              List<OpportunityProduct> opportunityProduct = await  OpportunityProductDataHandlerBase.GetOpportunityProductRecords(dbHandler,  cid);
              if (opportunityProduct != null) {
                opportunityProduct.upSyncIndex = Globals.SyncIndex.toString();
                opportunityProduct.opportunityProductID = sid;
                opportunityProduct.isDirty = "false";
                opportunityProduct.upSyncMessage = "SUCCESS";
                var rid = OpportunityProductDataHandlerBase.UpdateOpportunityProductRecord(dbHandler,  opportunityProduct.id, opportunityProduct);
              }
            }
          }

          // OpportunityProductDetail
          var opportunityProductDetailArray = jsonResponse["OpportunityProductDetail"];
          for (var j = 0; j < opportunityProductDetailArray.length; j++) {
            var jsonObj = opportunityProductDetailArray[j];
            var cid = jsonObj["CID"];
            var sid = jsonObj["SID"];
            if (Globals.tryParseAsIntString(cid) != "" && Globals.tryParseAsIntString(sid) != "") {
              var opportunityProductDetail = OpportunityProductDetailDataHandlerBase.GetOpportunityProductDetailRecord(dbHandler,  cid);
              if (opportunityProductDetail != null) {
                opportunityProductDetail.upSyncIndex = Globals.SyncIndex.toString();
                opportunityProductDetail.opportunityProductDetailID = sid;
                opportunityProductDetail.isDirty = "false";
                opportunityProductDetail.upSyncMessage = "SUCCESS";
                var rid = await  OpportunityProductDetailDataHandlerBase.UpdateOpportunityProductDetailRecord(dbHandler,  opportunityProductDetail.id, opportunityProductDetail);
              }
            }
          }

          logupSyncItemMessage("OpportunityProduct - Saved successfully.");
        } else {
          logger.e("VolleyError: SyncService:upSyncOpportunityProduct() 1-> $opportunityId : Object not returned.");

          for (var opportunityProduct in opportunityProductListOriginal) {
            opportunityProduct.upSyncMessage = "FAIL: Object not returned";
            opportunityProduct.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityProductDataHandler.updateOpportunityProductRecord(dbHandler,  opportunityProduct.id, opportunityProduct);
          }

          for (var opportunityProductDetail in opportunityProductDetailListOriginal) {
            opportunityProductDetail.upSyncMessage = "FAIL: Object not returned";
            opportunityProductDetail.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityProductDetailDataHandler.updateOpportunityProductDetailRecord(dbHandler,  opportunityProductDetail.id, opportunityProductDetail);
          }
        }
        upSyncList.remove("OpportunityProduct-$opportunityId");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncOpportunityProduct() 2-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncOpportunityProduct() 4-> $e");
  }
}


Future<void> upSyncOpportunityProductDetailAttribute(OpportunityProductDetailAttribute opportunityProductDetailAttribute) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/opportunityproductdetailattribute";

      var postData = {
        "OpportunityProductDetailAttributeID": Globals.isNullOrEmpty(opportunityProductDetailAttribute.opportunityProductDetailAttributeID) ? "-1" : opportunityProductDetailAttribute.opportunityProductDetailAttributeID,
        "OpportunityProductDetailAttributeCode": Globals.isNullOrEmpty(opportunityProductDetailAttribute.opportunityProductDetailAttributeCode) ? "" : opportunityProductDetailAttribute.opportunityProductDetailAttributeCode,
        "OpportunityProductDetailID": OpportunityProductDetailDataHandler.GetServerId(dbHandler,  opportunityProductDetailAttribute.opportunityProductDetailID),
        "AttributeID": AttributeDataHandler.GetServerId(dbHandler,  opportunityProductDetailAttribute.attributeID),
        "AttributeValueID": AttributeValueDataHandler.GetServerId(dbHandler,  opportunityProductDetailAttribute.attributeValueID),
        "AttributeValue": opportunityProductDetailAttribute.attributeValue,
        "CreatedBy": opportunityProductDetailAttribute.createdBy,
        "CreatedOn": opportunityProductDetailAttribute.createdOn,
        "ModifiedBy": opportunityProductDetailAttribute.modifiedBy,
        "ModifiedOn": opportunityProductDetailAttribute.modifiedOn,
        "IsActive": Globals.tryParseBoolean(opportunityProductDetailAttribute.isActive),
        "Uid": opportunityProductDetailAttribute.uid,
        "ReferenceIdentifier": opportunityProductDetailAttribute.referenceIdentifier,
        "AppUserID": opportunityProductDetailAttribute.appUserID,
        "AppUserGroupID": opportunityProductDetailAttribute.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunityProductDetailAttribute.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityProductDetailAttribute.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var opportunityProductDetailAttributeReturn = OpportunityProductDetailAttribute();
              JSONCopier.CopyJsonDataToOpportunityProductDetailAttribute( dbHandler, jsonResponse, opportunityProductDetailAttributeReturn, false);
              opportunityProductDetailAttributeReturn.isDirty = "false";
              opportunityProductDetailAttributeReturn.upSyncMessage = "SUCCESS";
              opportunityProductDetailAttributeReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityProductDetailAttributeDataHandler.UpdateOpportunityProductDetailAttributeRecord(dbHandler,  opportunityProductDetailAttribute.id, opportunityProductDetailAttributeReturn);
              logMessage("OpportunityProductDetailAttribute - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncOpportunityProductDetailAttribute() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncOpportunityProductDetailAttribute() 2-> ${opportunityProductDetailAttribute.id} : Object not returned.");
            opportunityProductDetailAttribute.upSyncMessage = "FAIL: Object not returned";
            opportunityProductDetailAttribute.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityProductDetailAttributeDataHandler.UpdateOpportunityProductDetailAttributeRecord(dbHandler,  opportunityProductDetailAttribute.id, opportunityProductDetailAttribute);
          }
        } else {
          String posterror = response.body != null ? response.body.toString() : "";
          if (response.statusCode == 401) {
            Globals.USER_TOKEN = "";
          } else if (response.statusCode == 500) {
            posterror += response.statusCode.toString() + " - " + response.reasonPhrase.toString();
          }

          opportunityProductDetailAttribute.upSyncMessage = "FAIL: $posterror";
          opportunityProductDetailAttribute.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityProductDetailAttributeDataHandler.UpdateOpportunityProductDetailAttributeRecord(dbHandler,  opportunityProductDetailAttribute.id, opportunityProductDetailAttribute);
          logger.e("VolleyError: SyncService:upSyncOpportunityProductDetailAttribute() 3-> $posterror");
        }

        upSyncList.remove("OpportunityProductDetailAttribute-${opportunityProductDetailAttribute.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncOpportunityProductDetailAttribute() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncOpportunityProductDetailAttribute() 4-> $e");
  }
}



Future<void> upSyncAccountAddress(AccountAddress accountAddress) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountaddress";

      var postData = {
        "AccountAddressID": Globals.isNullOrEmpty(accountAddress.accountAddressID) ? "-1" : accountAddress.accountAddressID,
        "AccountAddressCode": Globals.isNullOrEmpty(accountAddress.accountAddressCode) ? "" : accountAddress.accountAddressCode,
        "AddressTypeName": accountAddress.addressTypeName,
        "AddressLine1": accountAddress.addressLine1,
        "AddressLine2": accountAddress.addressLine2,
        "AddressLine3": accountAddress.addressLine3,
        "City": accountAddress.city,
        "State": accountAddress.state,
        "Country": accountAddress.country,
        "PIN": accountAddress.pin,
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  accountAddress.accountID),
        "ContactID": ContactHandlerDataBase.GetServerId(dbHandler,  accountAddress.contactID),
        "GPSCoordinates": accountAddress.gpsCoordinates,
        "CreatedBy": accountAddress.createdBy,
        "CreatedOn": accountAddress.createdOn,
        "ModifiedBy": accountAddress.modifiedBy,
        "ModifiedOn": accountAddress.modifiedOn,
        "DeviceIdentifier": accountAddress.deviceIdentifier,
        "ReferenceIdentifier": accountAddress.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountAddress.isActive),
        "Uid": accountAddress.uid,
        "AppUserID": accountAddress.appUserID,
        "AppUserGroupID": accountAddress.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountAddress.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountAddress.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountAddressReturn = AccountAddress();
              JSONCopier.CopyJsonDataToAccountAddress( dbHandler, jsonResponse, accountAddressReturn, false);
              accountAddressReturn.isDirty = "false";
              accountAddressReturn.upSyncMessage = "SUCCESS";
              accountAddressReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddressReturn);
              logupSyncItemMessage("AccountAddress - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountAddress() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountAddress() 2-> ${accountAddress.id} : Object not returned.");
            accountAddress.upSyncMessage = "FAIL: Object not returned";
            accountAddress.upSyncIndex = Globals.SyncIndex.toString();
            AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddress);
          }
        } else {
          String posterror = response.body != null ? response.body.toString() : "";
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else if (response.statusCode == 500) {
            posterror += response.statusCode.toString() + " - " + response.reasonPhrase.toString();
          }

          logger.e("VolleyError: SyncService:upSyncAccountAddress() 3-> $posterror");
          accountAddress.upSyncMessage = "FAIL: $posterror";
          accountAddress.upSyncIndex = Globals.SyncIndex.toString();
          AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddress);
        }

        upSyncList.remove("AccountAddress-${accountAddress.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncAccountAddress() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountAddress() 4-> $e");
  }
}


Future<void> upSyncOpportunityContact(OpportunityContact opportunityContact) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/opportunitycontact";

      var postData = {
        "OpportunityContactID": Globals.isNullOrEmpty(opportunityContact.opportunityContactID) ? "-1" : opportunityContact.opportunityContactID,
        "OpportunityContactCode": Globals.isNullOrEmpty(opportunityContact.opportunityContactCode) ? "" : opportunityContact.opportunityContactCode,
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  opportunityContact.opportunityID),
        "ContactID": ContactHandlerDataBase.GetServerId(dbHandler,  opportunityContact.contactID),
        "Description": opportunityContact.description,
        "CreatedBy": opportunityContact.createdBy,
        "CreatedOn": opportunityContact.createdOn,
        "ModifiedBy": opportunityContact.modifiedBy,
        "ModifiedOn": opportunityContact.modifiedOn,
        "IsActive": Globals.tryParseBoolean(opportunityContact.isActive),
        "Uid": opportunityContact.uid,
        "AppUserID": opportunityContact.appUserID,
        "AppUserGroupID": opportunityContact.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunityContact.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityContact.isDeleted),
        "ReferenceIdentifier": opportunityContact.referenceIdentifier,
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var opportunityContactReturn = OpportunityContact();
              JSONCopier.CopyJsonDataToOpportunityContact( dbHandler, jsonResponse, opportunityContactReturn, false);
              opportunityContactReturn.isDirty = "false";
              opportunityContactReturn.upSyncMessage = "SUCCESS";
              opportunityContactReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityContactHandlerDataBase.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContactReturn);
              logMessage("OpportunityContact - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncOpportunityContact() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncOpportunityContact() 2-> ${opportunityContact.id} : Object not returned.");
            opportunityContact.upSyncMessage = "FAIL: Object not returned";
            opportunityContact.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityContactHandlerDataBase.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContact);
          }
        } else {
          String posterror = response.body != null ? response.body.toString() : "";
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else if (response.statusCode == 500) {
            posterror += response.statusCode.toString() + " - " + response.reasonPhrase.toString();
          }

          opportunityContact.upSyncMessage = "FAIL: $posterror";
          opportunityContact.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityContactHandlerDataBase.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContact);
          logger.e("VolleyError: SyncService:upSyncOpportunityContact() 3-> $posterror");
        }

        upSyncList.remove("OpportunityContact-${opportunityContact.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncOpportunityContact() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncOpportunityContact() 4-> $e");
  }
}


Future<void> upSyncAccountPhone(AccountPhone accountPhone) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountphone";

      var postData = {
        "AccountPhoneID": Globals.isNullOrEmpty(accountPhone.accountPhoneID) ? "-1" : accountPhone.accountPhoneID,
        "AccountPhoneCode": Globals.isNullOrEmpty(accountPhone.accountPhoneCode) ? "" : accountPhone.accountPhoneCode,
        "Phone": accountPhone.phone,
        "PhoneTypeName": accountPhone.phoneTypeName,
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  accountPhone.accountID),
        "AccountAddressID": AccountAddressDataHandler.GetServerId(dbHandler,  accountPhone.accountAddressID),
        "CreatedBy": accountPhone.createdBy,
        "CreatedOn": accountPhone.createdOn,
        "ModifiedBy": accountPhone.modifiedBy,
        "ModifiedOn": accountPhone.modifiedOn,
        "DeviceIdentifier": accountPhone.deviceIdentifier,
        "ReferenceIdentifier": accountPhone.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountPhone.isActive),
        "Uid": accountPhone.uid,
        "AppUserID": accountPhone.appUserID,
        "AppUserGroupID": accountPhone.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountPhone.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountPhone.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountPhoneReturn = AccountPhone();
              JSONCopier.CopyJsonDataToAccountPhone( dbHandler, jsonResponse, accountPhoneReturn, false);
              accountPhoneReturn.isDirty = "false";
              accountPhoneReturn.upSyncMessage = "SUCCESS";
              accountPhoneReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhoneReturn);
              logupSyncItemMessage("AccountPhone - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountPhone() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountPhone() 2-> ${accountPhone.id} : Object not returned.");
            accountPhone.upSyncMessage = "FAIL: Object not returned";
            accountPhone.upSyncIndex = Globals.SyncIndex.toString();
            AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhone);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:upSyncAccountPhone() 3-> $posterror");
          accountPhone.upSyncMessage = "FAIL: $posterror";
          accountPhone.upSyncIndex = Globals.SyncIndex.toString();
          AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhone);
        }

        upSyncList.remove("AccountPhone-${accountPhone.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncAccountPhone() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountPhone() 4-> $e");
  }
}


Future<void> upSyncAccountBuyingProcess(AccountBuyingProcess accountBuyingProcess) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountbuyingprocess";

      var postData = {
        "AccountBuyingProcessID": Globals.isNullOrEmpty(accountBuyingProcess.accountBuyingProcessID) ? "-1" : accountBuyingProcess.accountBuyingProcessID,
        "AccountBuyingProcessCode": Globals.isNullOrEmpty(accountBuyingProcess.accountBuyingProcessCode) ? "" : accountBuyingProcess.accountBuyingProcessCode,
        "BuyingProcess": accountBuyingProcess.buyingProcess,
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  accountBuyingProcess.accountID),
        "CreatedBy": accountBuyingProcess.createdBy,
        "CreatedOn": accountBuyingProcess.createdOn,
        "ModifiedBy": accountBuyingProcess.modifiedBy,
        "ModifiedOn": accountBuyingProcess.modifiedOn,
        "DeviceIdentifier": accountBuyingProcess.deviceIdentifier,
        "ReferenceIdentifier": accountBuyingProcess.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountBuyingProcess.isActive),
        "Uid": accountBuyingProcess.uid,
        "AppUserID": accountBuyingProcess.appUserID,
        "AppUserGroupID": accountBuyingProcess.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountBuyingProcess.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountBuyingProcess.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountBuyingProcessReturn = AccountBuyingProcess();
              JSONCopier.CopyJsonDataToAccountBuyingProcess( dbHandler, jsonResponse, accountBuyingProcessReturn, false);
              accountBuyingProcessReturn.isDirty = "false";
              accountBuyingProcessReturn.upSyncMessage = "SUCCESS";
              accountBuyingProcessReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcessReturn);
              logupSyncItemMessage("AccountBuyingProcess - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountBuyingProcess() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountBuyingProcess() 2-> ${accountBuyingProcess.id} : Object not returned.");
            accountBuyingProcess.upSyncMessage = "FAIL: Object not returned";
            accountBuyingProcess.upSyncIndex = Globals.SyncIndex.toString();
            AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:upSyncAccountBuyingProcess() 3-> $posterror");
          accountBuyingProcess.upSyncMessage = "FAIL: $posterror";
          accountBuyingProcess.upSyncIndex = Globals.SyncIndex.toString();
          AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
        }

        upSyncList.remove("AccountBuyingProcess-${accountBuyingProcess.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncAccountBuyingProcess() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountBuyingProcess() 4-> $e");
  }
}


Future<void> upSyncAccountBusinessPlan(AccountBusinessPlan accountBusinessPlan) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountbusinessplan";

      var postData = {
        "AccountBusinessPlanID": Globals.isNullOrEmpty(accountBusinessPlan.accountBusinessPlanID) ? "-1" : accountBusinessPlan.accountBusinessPlanID,
        "AccountBusinessPlanCode": Globals.isNullOrEmpty(accountBusinessPlan.accountBusinessPlanCode) ? "" : accountBusinessPlan.accountBusinessPlanCode,
        "BusinessPlans": accountBusinessPlan.businessPlans,
        "AccountID": AccountDataHandler.GetServerId(dbHandler, accountBusinessPlan.accountID),
        "CustomerTargetDate": accountBusinessPlan.customerTargetDate,
        "CreatedBy": accountBusinessPlan.createdBy,
        "CreatedOn": accountBusinessPlan.createdOn,
        "ModifiedBy": accountBusinessPlan.modifiedBy,
        "ModifiedOn": accountBusinessPlan.modifiedOn,
        "DeviceIdentifier": accountBusinessPlan.deviceIdentifier,
        "ReferenceIdentifier": accountBusinessPlan.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountBusinessPlan.isActive),
        "Uid": accountBusinessPlan.uid,
        "AppUserID": accountBusinessPlan.appUserID,
        "AppUserGroupID": accountBusinessPlan.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountBusinessPlan.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountBusinessPlan.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountBusinessPlanReturn = AccountBusinessPlan();
              JSONCopier.CopyJsonDataToAccountBusinessPlan( dbHandler, jsonResponse, accountBusinessPlanReturn, false);
              accountBusinessPlanReturn.isDirty = "false";
              accountBusinessPlanReturn.upSyncMessage = "SUCCESS";
              accountBusinessPlanReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlanReturn);
              logupSyncItemMessage("AccountBusinessPlan - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountBusinessPlan() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountBusinessPlan() 2-> ${accountBusinessPlan.id} : Object not returned.");
            accountBusinessPlan.upSyncMessage = "FAIL: Object not returned";
            accountBusinessPlan.upSyncIndex = Globals.SyncIndex.toString();
            AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlan);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:upSyncAccountBusinessPlan() 3-> $posterror");
          accountBusinessPlan.upSyncMessage = "FAIL: $posterror";
          accountBusinessPlan.upSyncIndex = Globals.SyncIndex.toString();
          AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlan);
        }

        upSyncList.remove("AccountBusinessPlan-${accountBusinessPlan.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncAccountBusinessPlan() 4-> $error");
        upSyncList.remove("AccountBusinessPlan-${accountBusinessPlan.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountBusinessPlan() 4-> $e");
  }
}


Future<void> upSyncAccountCompetitionActivity(AccountCompetitionActivity accountCompetitionActivity) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountcompetitionactivity";

      var postData = {
        "AccountCompetitionActivityID": Globals.isNullOrEmpty(accountCompetitionActivity.accountCompetitionActivityID) ? "-1" : accountCompetitionActivity.accountCompetitionActivityID,
        "AccountCompetitionActivityCode": Globals.isNullOrEmpty(accountCompetitionActivity.accountCompetitionActivityCode) ? "" : accountCompetitionActivity.accountCompetitionActivityCode,
        "CompetitionActivity": accountCompetitionActivity.competitionActivity,
        "AccountID": AccountDataHandler.GetServerId(dbHandler, accountCompetitionActivity.accountID),
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler, accountCompetitionActivity.opportunityID),
        "CompetitorName": accountCompetitionActivity.competitorName,
        "CreatedBy": accountCompetitionActivity.createdBy,
        "CreatedOn": accountCompetitionActivity.createdOn,
        "ModifiedBy": accountCompetitionActivity.modifiedBy,
        "ModifiedOn": accountCompetitionActivity.modifiedOn,
        "DeviceIdentifier": accountCompetitionActivity.deviceIdentifier,
        "ReferenceIdentifier": accountCompetitionActivity.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountCompetitionActivity.isActive),
        "Uid": accountCompetitionActivity.uid,
        "AppUserID": accountCompetitionActivity.appUserID,
        "AppUserGroupID": accountCompetitionActivity.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountCompetitionActivity.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountCompetitionActivity.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountCompetitionActivityReturn = AccountCompetitionActivity();
              JSONCopier.CopyJsonDataToAccountCompetitionActivity( dbHandler, jsonResponse, accountCompetitionActivityReturn, false);
              accountCompetitionActivityReturn.isDirty = "false";
              accountCompetitionActivityReturn.upSyncMessage = "SUCCESS";
              accountCompetitionActivityReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivityReturn);
              logupSyncItemMessage("AccountCompetitionActivity - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountCompetitionActivity() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountCompetitionActivity() 2-> ${accountCompetitionActivity.id} : Object not returned.");
            accountCompetitionActivity.upSyncMessage = "FAIL: Object not returned";
            accountCompetitionActivity.upSyncIndex = Globals.SyncIndex.toString();
            AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivity);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:upSyncAccountCompetitionActivity() 3-> $posterror");
          accountCompetitionActivity.upSyncMessage = "FAIL: $posterror";
          accountCompetitionActivity.upSyncIndex = Globals.SyncIndex.toString();
          AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivity);
        }
        upSyncList.remove("AccountCompetitionActivity-${accountCompetitionActivity.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncAccountCompetitionActivity() 4-> $error");
        upSyncList.remove("AccountCompetitionActivity-${accountCompetitionActivity.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountCompetitionActivity() 4-> $e");
  }
}


Future<void> upSyncNote(Note note) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/note";

      var postData = {
        "NoteID": Globals.isNullOrEmpty(note.noteID) ? "-1" : note.noteID,
        "NoteCode": Globals.isNullOrEmpty(note.noteCode) ? "" : note.noteCode,
        "AccountID": AccountDataHandler.GetServerId(dbHandler, note.accountID),
        "ContactID": ContactHandlerDataBase.GetServerId(dbHandler, note.contactID),
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler, note.opportunityID),
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, note.activityID),
        "IsPersonal": Globals.tryParseBoolean(note.isPersonal),
        "NoteDate": note.noteDate,
        "NoteContent": note.noteContent,
        "Tags": note.tags,
        "FreeTextField1": note.freeTextField1,
        "FreeTextField2": note.freeTextField2,
        "FreeTextField3": note.freeTextField3,
        "CreatedBy": note.createdBy,
        "CreatedOn": note.createdOn,
        "ModifiedBy": note.modifiedBy,
        "ModifiedOn": note.modifiedOn,
        "DeviceIdentifier": note.deviceIdentifier,
        "ReferenceIdentifier": note.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(note.isActive),
        "Uid": note.uid,
        "AppUserID": note.appUserID,
        "AppUserGroupID": note.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(note.isArchived),
        "IsDeleted": Globals.tryParseBoolean(note.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var noteReturn = Note();
              JSONCopier.CopyJsonDataToNote( dbHandler, jsonResponse, noteReturn, false);
              noteReturn.isDirty = "false";
              noteReturn.upSyncMessage = "SUCCESS";
              noteReturn.upSyncIndex = Globals.SyncIndex.toString();
              NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, noteReturn);
              logupSyncItemMessage("Note - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncNote() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncNote() 2-> ${note.id} : Object not returned.");
            note.upSyncMessage = "FAIL: Object not returned";
            note.upSyncIndex = Globals.SyncIndex.toString();
            NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, note);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:upSyncNote() 3-> $posterror");
          note.upSyncMessage = "FAIL: $posterror";
          note.upSyncIndex = Globals.SyncIndex.toString();
          NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, note);
        }
        upSyncList.remove("Note-${note.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:upSyncNote() 4-> $error");
        upSyncList.remove("Note-${note.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncNote() 4-> $e");
  }
}

Future<void> upSyncActivityTravel(ActivityTravel activityTravel) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/activitytravel";

      var postData = {
        "ActivityTravelID": Globals.isNullOrEmpty(activityTravel.activityTravelID) ? "-1" : activityTravel.activityTravelID,
        "ActivityTravelCode": Globals.isNullOrEmpty(activityTravel.activityTravelCode) ? "" : activityTravel.activityTravelCode,
        "ActivityTravelTitle": activityTravel.activityTravelTitle,
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, activityTravel.activityID),
        "ActivityTravelDate": activityTravel.activityTravelDate,
        "ActivityTravelEndDate": activityTravel.activityTravelEndDate,
        "TravelPurposeName": activityTravel.travelPurposeName,
        "StartLocation": activityTravel.startLocation,
        "EndLocation": activityTravel.endLocation,
        "StartLocationCoordinate": activityTravel.startLocationCoordinate,
        "EndLocationCoordinate": activityTravel.endLocationCoordinate,
        "ActualDistance": activityTravel.actualDistance,
        "DistanceTravelled": activityTravel.distanceTravelled,
        "ModeOfTravelID": ModeOfTravelDataHandler.GetServerId(dbHandler, activityTravel.modeOfTravelID),
        "TravelExpense": activityTravel.travelExpense,
        "ReasonForDeviation": activityTravel.reasonForDeviation,
        "OtherExpense": activityTravel.otherExpense,
        "TotalExpense": activityTravel.totalExpense,
        "IsSubmitted": Globals.tryParseBoolean(activityTravel.isSubmitted),
        "Remarks": activityTravel.remarks,
        "CreatedBy": activityTravel.createdBy,
        "CreatedOn": activityTravel.createdOn,
        "ModifiedBy": activityTravel.modifiedBy,
        "ModifiedOn": activityTravel.modifiedOn,
        "DeviceIdentifier": activityTravel.deviceIdentifier,
        "ReferenceIdentifier": activityTravel.referenceIdentifier,
        "Location": activityTravel.location,
        "IsActive": Globals.tryParseBoolean(activityTravel.isActive),
        "Uid": activityTravel.uid,
        "AppUserID": activityTravel.appUserID,
        "AppUserGroupID": activityTravel.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityTravel.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityTravel.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var activityTravelReturn = ActivityTravel();
              JSONCopier.CopyJsonDataToActivityTravel( dbHandler, jsonResponse, activityTravelReturn, false);
              activityTravelReturn.isDirty = "false";
              activityTravelReturn.upSyncMessage = "SUCCESS";
              activityTravelReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravelReturn);
              logupSyncItemMessage("ActivityTravel - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncActivityTravel() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncActivityTravel() 2-> ${activityTravel.id} : Object not returned.");
            activityTravel.upSyncMessage = "FAIL: Object not returned";
            activityTravel.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
          }
          upSyncList.remove("ActivityTravel-${activityTravel.id}");
        } else {
          logger.e("VolleyError: SyncService:upSyncActivityTravel() 3-> ${response.body}");
          activityTravel.upSyncMessage = "FAIL: ${response.body}";
          activityTravel.upSyncIndex = Globals.SyncIndex.toString();
          ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
          upSyncList.remove("ActivityTravel-${activityTravel.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logger.e("VolleyError: SyncService:upSyncActivityTravel() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:upSyncActivityTravel() 3-> $error");
        }
        activityTravel.upSyncMessage = "FAIL: $error";
        activityTravel.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
        upSyncList.remove("ActivityTravel-${activityTravel.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncActivityTravel() 4-> $e");
  }
}

Future<void> upSyncAccountMedia(AccountMedia accountMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountmedia";

      var postData = {
        "AccountMediaID": Globals.isNullOrEmpty(accountMedia.accountMediaID) ? "-1" : accountMedia.accountMediaID,
        "AccountMediaCode": Globals.isNullOrEmpty(accountMedia.accountMediaCode) ? "" : accountMedia.accountMediaCode,
        "AccountMediaName": accountMedia.accountMediaName,
        "AccountID": AccountDataHandlerBase.GetServerId(dbHandler, accountMedia.accountID!),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler,  accountMedia.contentTypeID),
        "MediaPath": accountMedia.mediaPath,
        "MediaContent": accountMedia.mediaContent,
        "Description": accountMedia.description,
        "Tags": accountMedia.tags,
        "CreatedBy": accountMedia.createdBy,
        "CreatedOn": accountMedia.createdOn,
        "ModifiedBy": accountMedia.modifiedBy,
        "ModifiedOn": accountMedia.modifiedOn,
        "DeviceIdentifier": accountMedia.deviceIdentifier,
        "ReferenceIdentifier": accountMedia.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(accountMedia.isActive),
        "Uid": accountMedia.uid,
        "AppUserID": accountMedia.appUserID,
        "AppUserGroupID": accountMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var accountMediaReturn = AccountMedia();
              JSONCopier.CopyJsonDataToAccountMedia( dbHandler, jsonResponse, accountMediaReturn, false);
              accountMediaReturn.isDirty = "false";
              accountMediaReturn.upSyncMessage = "SUCCESS";
              accountMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMediaReturn);
              logupSyncItemMessage("AccountMedia - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncAccountMedia() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncAccountMedia() 2-> ${accountMedia.id} : Object not returned.");
            accountMedia.upSyncMessage = "FAIL: Object not returned";
            accountMedia.upSyncIndex = Globals.SyncIndex.toString();
            AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
          }
          upSyncList.remove("AccountMedia-${accountMedia.id}");
        } 
        
        else {
          logger.e("VolleyError: SyncService:upSyncAccountMedia() 3-> ${response.body}");
          accountMedia.upSyncMessage = "FAIL: ${response.body}";
          accountMedia.upSyncIndex = Globals.SyncIndex.toString();
          AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
          upSyncList.remove("AccountMedia-${accountMedia.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logger.e("VolleyError: SyncService:upSyncAccountMedia() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:upSyncAccountMedia() 3-> $error");
        }
        accountMedia.upSyncMessage = "FAIL: $error";
        accountMedia.upSyncIndex = Globals.SyncIndex.toString();
        AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
        upSyncList.remove("AccountMedia-${accountMedia.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncAccountMedia() 4-> $e");
  }
}


Future<void> upSyncContactMedia(ContactMedia contactMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/contactmedia";

      var postData = {
        "ContactMediaID": Globals.isNullOrEmpty(contactMedia.contactMediaID) ? "-1" : contactMedia.contactMediaID,
        "ContactMediaCode": Globals.isNullOrEmpty(contactMedia.contactMediaCode) ? "" : contactMedia.contactMediaCode,
        "ContactMediaName": contactMedia.contactMediaName,
        "ContactID": ContactHandlerDataBase.GetServerId(dbHandler, contactMedia.contactID),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler, contactMedia.contentTypeID),
        "MediaPath": contactMedia.mediaPath,
        "MediaContent": contactMedia.mediaContent,
        "Description": contactMedia.description,
        "Tags": contactMedia.tags,
        "CreatedBy": contactMedia.createdBy,
        "CreatedOn": contactMedia.createdOn,
        "ModifiedBy": contactMedia.modifiedBy,
        "ModifiedOn": contactMedia.modifiedOn,
        "DeviceIdentifier": contactMedia.deviceIdentifier,
        "ReferenceIdentifier": contactMedia.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(contactMedia.isActive),
        "Uid": contactMedia.uid,
        "AppUserID": contactMedia.appUserID,
        "AppUserGroupID": contactMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(contactMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(contactMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var contactMediaReturn = ContactMedia();
              JSONCopier.CopyJsonDataToContactMedia( dbHandler, jsonResponse, contactMediaReturn, false);
              contactMediaReturn.isDirty = "false";
              contactMediaReturn.upSyncMessage = "SUCCESS";
              contactMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMediaReturn);
              logupSyncItemMessage("ContactMedia - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:upSyncContactMedia() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:upSyncContactMedia() 2-> ${contactMedia.id} : Object not returned.");
            contactMedia.upSyncMessage = "FAIL: Object not returned";
            contactMedia.upSyncIndex = Globals.SyncIndex.toString();
            ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
          }
          upSyncList.remove("ContactMedia-${contactMedia.id}");
        } else {
          logger.e("VolleyError: SyncService:upSyncContactMedia() 3-> ${response.body}");
          contactMedia.upSyncMessage = "FAIL: ${response.body}";
          contactMedia.upSyncIndex = Globals.SyncIndex.toString();
          ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
          upSyncList.remove("ContactMedia-${contactMedia.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logger.e("VolleyError: SyncService:upSyncContactMedia() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:upSyncContactMedia() 3-> $error");
        }
        contactMedia.upSyncMessage = "FAIL: $error";
        contactMedia.upSyncIndex = Globals.SyncIndex.toString();
        ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
        upSyncList.remove("ContactMedia-${contactMedia.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:upSyncContactMedia() 4-> $e");
  }
}

Future<void> upSyncOpportunityMedia(OpportunityMedia opportunityMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/opportunitymedia";

      var postData = {
        "OpportunityMediaID": Globals.isNullOrEmpty(opportunityMedia.opportunityMediaID) ? "-1" : opportunityMedia.opportunityMediaID,
        "OpportunityMediaCode": Globals.isNullOrEmpty(opportunityMedia.opportunityMediaCode) ? "" : opportunityMedia.opportunityMediaCode,
        "OpportunityMediaName": opportunityMedia.opportunityMediaName,
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler, opportunityMedia.opportunityID),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler, opportunityMedia.contentTypeID),
        "MediaPath": opportunityMedia.mediaPath,
        "MediaContent": opportunityMedia.mediaContent,
        "Description": opportunityMedia.description,
        "Tags": opportunityMedia.tags,
        "CreatedBy": opportunityMedia.createdBy,
        "CreatedOn": opportunityMedia.createdOn,
        "ModifiedBy": opportunityMedia.modifiedBy,
        "ModifiedOn": opportunityMedia.modifiedOn,
        "IsActive": Globals.tryParseBoolean(opportunityMedia.isActive),
        "Uid": opportunityMedia.uid,
        "AppUserID": opportunityMedia.appUserID,
        "AppUserGroupID": opportunityMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunityMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var opportunityMediaReturn = OpportunityMedia();
              JSONCopier.CopyJsonDataToOpportunityMedia( dbHandler, jsonResponse, opportunityMediaReturn, false);
              opportunityMediaReturn.isDirty = "false";
              opportunityMediaReturn.upSyncMessage = "SUCCESS";
              opportunityMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMediaReturn);
              logupSyncItemMessage("OpportunityMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncOpportunityMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncOpportunityMedia() 2-> ${opportunityMedia.id} : Object not returned.");
            opportunityMedia.upSyncMessage = "FAIL: Object not returned";
            opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
          }
          upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
        } else {
          logError("VolleyError: SyncService:upSyncOpportunityMedia() 3-> ${response.body}");
          opportunityMedia.upSyncMessage = "FAIL: ${response.body}";
          opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
          upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logError("VolleyError: SyncService:upSyncOpportunityMedia() 3-> $error");
        } else {
          logError("Error: SyncService:upSyncOpportunityMedia() 4-> $error");
        }
        opportunityMedia.upSyncMessage = "FAIL: $error";
        opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
        OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
        upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncOpportunityMedia() 4-> $e");
  }
}

Future<void> upSyncActivityMedia(ActivityMedia activityMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/activitymedia";

      var postData = {
        "ActivityMediaID": Globals.isNullOrEmpty(activityMedia.activityMediaID) ? "-1" : activityMedia.activityMediaID,
        "ActivityMediaCode": Globals.isNullOrEmpty(activityMedia.activityMediaCode) ? "" : activityMedia.activityMediaCode,
        "ActivityMediaName": activityMedia.activityMediaName,
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, activityMedia.activityID),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler, activityMedia.contentTypeID),
        "MediaPath": activityMedia.mediaPath,
        "MediaContent": activityMedia.mediaContent,
        "Description": activityMedia.description,
        "Tags": activityMedia.tags,
        "CreatedBy": activityMedia.createdBy,
        "CreatedOn": activityMedia.createdOn,
        "ModifiedBy": activityMedia.modifiedBy,
        "ModifiedOn": activityMedia.modifiedOn,
        "DeviceIdentifier": activityMedia.deviceIdentifier,
        "ReferenceIdentifier": activityMedia.referenceIdentifier,
        "Location": activityMedia.location,
        "IsActive": Globals.tryParseBoolean(activityMedia.isActive),
        "Uid": activityMedia.uid,
        "AppUserID": activityMedia.appUserID,
        "AppUserGroupID": activityMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var activityMediaReturn = ActivityMedia();
              JSONCopier.CopyJsonDataToActivityMedia( dbHandler, jsonResponse, activityMediaReturn, false);
              activityMediaReturn.isDirty = "false";
              activityMediaReturn.upSyncMessage = "SUCCESS";
              activityMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMediaReturn);
              logupSyncItemMessage("ActivityMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityMedia() 2-> ${activityMedia.id} : Object not returned.");
            activityMedia.upSyncMessage = "FAIL: Object not returned";
            activityMedia.upSyncIndex = Globals.SyncIndex.toString();
            ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
          }
          upSyncList.remove("ActivityMedia-${activityMedia.id}");
        } else {
          logError("VolleyError: SyncService:upSyncActivityMedia() 3-> ${response.body}");
          activityMedia.upSyncMessage = "FAIL: ${response.body}";
          activityMedia.upSyncIndex = Globals.SyncIndex.toString();
          ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
          upSyncList.remove("ActivityMedia-${activityMedia.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logError("VolleyError: SyncService:upSyncActivityMedia() 3-> ${error.message}");
        } else {
          logError("Error: SyncService:upSyncActivityMedia() 4-> $error");
        }
        activityMedia.upSyncMessage = "FAIL: $error";
        activityMedia.upSyncIndex = Globals.SyncIndex.toString();
        ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
        upSyncList.remove("ActivityMedia-${activityMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityMedia() 4-> $e");
  }
}


Future<void> upSyncNoteMedia(NoteMedia noteMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/notemedia";

      var postData = {
        "NoteMediaID": Globals.isNullOrEmpty(noteMedia.noteMediaID) ? "-1" : noteMedia.noteMediaID,
        "NoteMediaCode": Globals.isNullOrEmpty(noteMedia.noteMediaCode) ? "" : noteMedia.noteMediaCode,
        "NoteMediaName": noteMedia.noteMediaName,
        "NoteID": NoteDataHandler.GetServerId(dbHandler, noteMedia.noteID),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler, noteMedia.contentTypeID),
        "MediaPath": noteMedia.mediaPath,
        "MediaContent": noteMedia.mediaContent,
        "Description": noteMedia.description,
        "Tags": noteMedia.tags,
        "CreatedBy": noteMedia.createdBy,
        "CreatedOn": noteMedia.createdOn,
        "ModifiedBy": noteMedia.modifiedBy,
        "ModifiedOn": noteMedia.modifiedOn,
        "DeviceIdentifier": noteMedia.deviceIdentifier,
        "ReferenceIdentifier": noteMedia.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(noteMedia.isActive),
        "Uid": noteMedia.uid,
        "AppUserID": noteMedia.appUserID,
        "AppUserGroupID": noteMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(noteMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(noteMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var noteMediaReturn = NoteMedia();
              JSONCopier.CopyJsonDataToNoteMedia( dbHandler, jsonResponse, noteMediaReturn, false);
              noteMediaReturn.isDirty = "false";
              noteMediaReturn.upSyncMessage = "SUCCESS";
              noteMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMediaReturn);
              logupSyncItemMessage("NoteMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncNoteMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncNoteMedia() 2-> ${noteMedia.id} : Object not returned.");
            noteMedia.upSyncMessage = "FAIL: Object not returned";
            noteMedia.upSyncIndex = Globals.SyncIndex.toString();
            NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
          }
          upSyncList.remove("NoteMedia-${noteMedia.id}");
        } else {
          logError("VolleyError: SyncService:upSyncNoteMedia() 3-> ${response.body}");
          noteMedia.upSyncMessage = "FAIL: ${response.body}";
          noteMedia.upSyncIndex = Globals.SyncIndex.toString();
          NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
          upSyncList.remove("NoteMedia-${noteMedia.id}");
        }
      }).catchError((error) {
        if (error is http.Client) {
          logError("VolleyError: SyncService:upSyncNoteMedia() 3-> ${error.message}");
        } else {
          logError("Error: SyncService:upSyncNoteMedia() 4-> $error");
        }
        noteMedia.upSyncMessage = "FAIL: $error";
        noteMedia.upSyncIndex = Globals.SyncIndex.toString();
        NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
        upSyncList.remove("NoteMedia-${noteMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncNoteMedia() 4-> $e");
  }
}


Future<void> upSyncActivityTravelMedia(ActivityTravelMedia activityTravelMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/activitytravelmedia";

      var postData = {
        "ActivityTravelMediaID": Globals.isNullOrEmpty(activityTravelMedia.activityTravelMediaID) ? "-1" : activityTravelMedia.activityTravelMediaID,
        "ActivityTravelMediaCode": Globals.isNullOrEmpty(activityTravelMedia.activityTravelMediaCode) ? "" : activityTravelMedia.activityTravelMediaCode,
        "ActivityTravelMediaName": activityTravelMedia.activityTravelMediaName,
        "ActivityTravelID": ActivityTravelDataHandler.GetServerId(dbHandler, activityTravelMedia.activityTravelID),
        "ContentTypeID": ContentTypeDataHandler.GetServerId(dbHandler, activityTravelMedia.contentTypeID),
        "MediaPath": activityTravelMedia.mediaPath,
        "MediaContent": activityTravelMedia.mediaContent,
        "Description": activityTravelMedia.description,
        "Tags": activityTravelMedia.tags,
        "CreatedBy": activityTravelMedia.createdBy,
        "CreatedOn": activityTravelMedia.createdOn,
        "ModifiedBy": activityTravelMedia.modifiedBy,
        "ModifiedOn": activityTravelMedia.modifiedOn,
        "DeviceIdentifier": activityTravelMedia.deviceIdentifier,
        "ReferenceIdentifier": activityTravelMedia.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(activityTravelMedia.isActive),
        "Uid": activityTravelMedia.uid,
        "AppUserID": activityTravelMedia.appUserID,
        "AppUserGroupID": activityTravelMedia.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityTravelMedia.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityTravelMedia.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var activityTravelMediaReturn = ActivityTravelMedia();
              JSONCopier.CopyJsonDataToActivityTravelMedia( dbHandler, jsonResponse, activityTravelMediaReturn, false);
              activityTravelMediaReturn.isDirty = "false";
              activityTravelMediaReturn.upSyncMessage = "SUCCESS";
              activityTravelMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMediaReturn);
              logMessage("ActivityTravelMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityTravelMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityTravelMedia() 2-> ${activityTravelMedia.id} : Object not returned.");
            activityTravelMedia.upSyncMessage = "FAIL: Object not returned";
            activityTravelMedia.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMedia);
          }
          upSyncList.remove("ActivityTravelMedia-${activityTravelMedia.id}");
        } else {
          var posterror = response.body ?? "";
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else if (response.statusCode == 500 && response.headers.containsKey("content-type") && response.headers["content-type"]?.contains("application/json") == true) {
            var jsonResponse = json.decode(response.body);

            if (jsonResponse != null && jsonResponse.containsKey("message")) {
              posterror += jsonResponse["message"];
            }
          }

          activityTravelMedia.upSyncMessage = "FAIL: $posterror";
          activityTravelMedia.upSyncIndex = Globals.SyncIndex.toString();
          ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMedia);
          upSyncList.remove("ActivityTravelMedia-${activityTravelMedia.id}");
          logError("VolleyError: SyncService:upSyncActivityTravelMedia() 3-> $posterror");
        }
      }).catchError((error) {
        var posterror = error.toString();
        activityTravelMedia.upSyncMessage = "FAIL: $posterror";
        activityTravelMedia.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMedia);
        upSyncList.remove("ActivityTravelMedia-${activityTravelMedia.id}");
        logError("VolleyError: SyncService:upSyncActivityTravelMedia() 3-> $posterror");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityTravelMedia() 4-> $e");
  }
}


Future<void> upSyncActivityTravelExpense(ActivityTravelExpense activityTravelExpense)async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/activitytravelexpense";

      var postData = {
        "ActivityTravelExpenseID": Globals.isNullOrEmpty(activityTravelExpense.activityTravelExpenseID) ? "-1" : activityTravelExpense.activityTravelExpenseID,
        "ActivityTravelExpenseCode": Globals.isNullOrEmpty(activityTravelExpense.activityTravelExpenseCode) ? "" : activityTravelExpense.activityTravelExpenseCode,
        "ActivityTravelExpenseTitle": activityTravelExpense.activityTravelExpenseTitle,
        "ActivityTravelID": ActivityTravelDataHandler.GetServerId(dbHandler, activityTravelExpense.activityTravelID),
        "ExpenseTypeID": ExpenseTypeDataHandler.GetServerId(dbHandler, activityTravelExpense.expenseTypeID),
        "DistanceTravelled": activityTravelExpense.distanceTravelled,
        "ModeOfTravelID": ModeOfTravelDataHandler.GetServerId(dbHandler, activityTravelExpense.modeOfTravelID),
        "Amount": activityTravelExpense.amount,
        "Remarks": activityTravelExpense.remarks,
        "CreatedBy": activityTravelExpense.createdBy,
        "CreatedOn": activityTravelExpense.createdOn,
        "ModifiedBy": activityTravelExpense.modifiedBy,
        "ModifiedOn": activityTravelExpense.modifiedOn,
        "DeviceIdentifier": activityTravelExpense.deviceIdentifier,
        "ReferenceIdentifier": activityTravelExpense.referenceIdentifier,
        "Location": activityTravelExpense.location,
        "IsActive": Globals.tryParseBoolean(activityTravelExpense.isActive),
        "Uid": activityTravelExpense.uid,
        "AppUserID": activityTravelExpense.appUserID,
        "AppUserGroupID": activityTravelExpense.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityTravelExpense.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityTravelExpense.isDeleted),
      };

      var jsonRequest = http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      jsonRequest.then((response) {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            try {
              var activityTravelExpenseReturn = ActivityTravelExpense();
               await  JSONCopier.CopyJsonDataToActivityTravelExpense(dbHandler, jsonResponse, activityTravelExpenseReturn, false);
              activityTravelExpenseReturn.isDirty = "false";
              activityTravelExpenseReturn.upSyncMessage = "SUCCESS";
              activityTravelExpenseReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpenseReturn);
              logMessage("ActivityTravelExpense - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityTravelExpense() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityTravelExpense() 2-> ${activityTravelExpense.id} : Object not returned.");
            activityTravelExpense.upSyncMessage = "FAIL: Object not returned";
            activityTravelExpense.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpense);
          }
          upSyncList.remove("ActivityTravelExpense-${activityTravelExpense.id}");
        } else {
          var posterror = response.body ?? "";
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else if (response.headers.containsKey("content-type") && response.headers["content-type"].contains("application/json")) {
            var jsonResponse = json.decode(response.body);

            if (jsonResponse != null && jsonResponse.containsKey("message")) {
              posterror += jsonResponse["message"];
            }
          }

          activityTravelExpense.upSyncMessage = "FAIL: $posterror";
          activityTravelExpense.upSyncIndex = Globals.SyncIndex.toString();
          ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpense);
          upSyncList.remove("ActivityTravelExpense-${activityTravelExpense.id}");
          logError("VolleyError: SyncService:upSyncActivityTravelExpense() 3-> $posterror");
        }
      }).catchError((error) {
        var posterror = error.toString();
        activityTravelExpense.upSyncMessage = "FAIL: $posterror";
        activityTravelExpense.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpense);
        upSyncList.remove("ActivityTravelExpense-${activityTravelExpense.id}");
        logError("VolleyError: SyncService:upSyncActivityTravelExpense() 3-> $posterror");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityTravelExpense() 4-> $e");
  }
}

Future<void> upSyncFieldAttendance(FieldAttendance fieldAttendance) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/fieldattendance";

      var postData = {
        "FieldAttendanceID": fieldAttendance.fieldAttendanceID != null && fieldAttendance.fieldAttendanceID.isNotEmpty ? fieldAttendance.fieldAttendanceID : "-1",
        "FieldAttendanceCode": fieldAttendance.fieldAttendanceCode != null && fieldAttendance.fieldAttendanceCode.isNotEmpty ? fieldAttendance.fieldAttendanceCode : "",
        "FieldAttendanceTitle": fieldAttendance.fieldAttendanceTitle,
        "FieldAttendanceDate": fieldAttendance.fieldAttendanceDate,
        "PunchInTime": fieldAttendance.punchInTime,
        "PunchOutTime": fieldAttendance.punchOutTime,
        "PunchInLocation": fieldAttendance.punchInLocation,
        "PunchOutLocation": fieldAttendance.punchOutLocation,
        "Remarks": fieldAttendance.remarks,
        "CreatedBy": fieldAttendance.createdBy,
        "CreatedOn": fieldAttendance.createdOn,
        "ModifiedBy": fieldAttendance.modifiedBy,
        "ModifiedOn": fieldAttendance.modifiedOn,
        "DeviceIdentifier": fieldAttendance.deviceIdentifier,
        "ReferenceIdentifier": fieldAttendance.referenceIdentifier,
        "IsActive": Globals.tryParseBoolean(fieldAttendance.isActive),
        "Uid": fieldAttendance.uid,
        "AppUserID": fieldAttendance.appUserID,
        "AppUserGroupID": fieldAttendance.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(fieldAttendance.isArchived),
        "IsDeleted": Globals.tryParseBoolean(fieldAttendance.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body);
          if (jsonObject != null) {
            try {
              var fieldAttendanceReturn = FieldAttendance();
              await JSONCopier.copyJsonDataToFieldAttendance( dbHandler, jsonObject, fieldAttendanceReturn, false);
              var fieldAttendance1 = FieldAttendanceDataHandler.getFieldAttendanceRecord(dbHandler, fieldAttendance.id);
              if (fieldAttendance1 != null) {
                fieldAttendance1.fieldAttendanceCode = fieldAttendanceReturn.fieldAttendanceCode;
                fieldAttendance1.fieldAttendanceID = fieldAttendanceReturn.fieldAttendanceID;
                fieldAttendance1.sCreatedOn = fieldAttendanceReturn.createdOn;
                fieldAttendance1.createdByUser = fieldAttendanceReturn.createdByUser;
                fieldAttendance1.sModifiedOn = fieldAttendanceReturn.modifiedOn;
                fieldAttendance1.modifiedByUser = fieldAttendanceReturn.modifiedByUser;
                fieldAttendance1.isDirty = "false";
                fieldAttendance1.upSyncMessage = "SUCCESS";
                fieldAttendance1.upSyncIndex = Globals.syncIndex.toString();
                FieldAttendanceDataHandler.updateFieldAttendanceRecord(dbHandler, fieldAttendance.id, fieldAttendance1);
                logupSyncItemMessage("FieldAttendance - Saved successfully.");
              }
            } catch (ex) {
              logError("Error: SyncService:upSyncFieldAttendance() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncFieldAttendance() 2-> ${fieldAttendance.id} : Object not returned.");
            fieldAttendance.upSyncMessage = "FAIL: Object not returned";
            fieldAttendance.upSyncIndex = Globals.syncIndex.toString();
            FieldAttendanceDataHandler.updateFieldAttendanceRecord(dbHandler, fieldAttendance.id, fieldAttendance);
          }
          upSyncList.remove("FieldAttendance-${fieldAttendance.id}");
        } else {
          logError("VolleyError: SyncService:upSyncFieldAttendance() 3-> ${response.body}");
          fieldAttendance.upSyncMessage = "FAIL: ${response.body}";
          fieldAttendance.upSyncIndex = Globals.syncIndex.toString();
          FieldAttendanceDataHandler.updateFieldAttendanceRecord(dbHandler, fieldAttendance.id, fieldAttendance);
        }
      } catch (error) {
        logError("Error: SyncService:upSyncFieldAttendance() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncFieldAttendance() 5-> $e");
  }
}

Future<void> upSyncAppUserRemark(AppUserRemark appUserRemark) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/appuserremark";

      var postData = {
        "AppUserRemarkID": appUserRemark.appUserRemarkID != null && appUserRemark.appUserRemarkID.isNotEmpty ? appUserRemark.appUserRemarkID : "-1",
        "AppUserRemarkCode": appUserRemark.appUserRemarkCode != null && appUserRemark.appUserRemarkCode.isNotEmpty ? appUserRemark.appUserRemarkCode : "",
        "AppUserRemarkDetails": appUserRemark.appUserRemarkDetails,
        "AppUserRemarkObject": appUserRemark.appUserRemarkObject,
        "AppUserRemarkObjectID": appUserRemark.appUserRemarkObjectID,
        "CreatedBy": appUserRemark.createdBy,
        "CreatedOn": appUserRemark.createdOn,
        "ModifiedBy": appUserRemark.modifiedBy,
        "ModifiedOn": appUserRemark.modifiedOn,
        "DeviceIdentifier": appUserRemark.deviceIdentifier,
        "ReferenceIdentifier": appUserRemark.referenceIdentifier,
        "Location": appUserRemark.location,
        "IsActive": Globals.tryParseBoolean(appUserRemark.isActive),
        "Uid": appUserRemark.uid,
        "AppUserID": appUserRemark.appUserID,
        "AppUserGroupID": appUserRemark.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(appUserRemark.isArchived),
        "IsDeleted": Globals.tryParseBoolean(appUserRemark.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body);
          if (jsonObject != null) {
            try {
              var appUserRemarkReturn = AppUserRemark();
              await JSONCopier.copyJsonDataToAppUserRemark(, dbHandler, jsonObject, appUserRemarkReturn, false);
              appUserRemarkReturn.isDirty = "false";
              appUserRemarkReturn.upSyncMessage = "SUCCESS";
              appUserRemarkReturn.upSyncIndex = Globals.syncIndex.toString();
              AppUserRemarkDataHandler.updateAppUserRemarkRecord(dbHandler, appUserRemark.id, appUserRemarkReturn);
              logupSyncItemMessage("AppUserRemark - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncAppUserRemark() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAppUserRemark() 2-> ${appUserRemark.id} : Object not returned.");
            appUserRemark.upSyncMessage = "FAIL: Object not returned";
            appUserRemark.upSyncIndex = Globals.syncIndex.toString();
            AppUserRemarkDataHandler.updateAppUserRemarkRecord(dbHandler, appUserRemark.id, appUserRemark);
          }
          upSyncList.remove("AppUserRemark-${appUserRemark.id}");
        } else {
          logError("VolleyError: SyncService:upSyncAppUserRemark() 3-> ${response.body}");
          appUserRemark.upSyncMessage = "FAIL: ${response.body}";
          appUserRemark.upSyncIndex = Globals.syncIndex.toString();
          AppUserRemarkDataHandler.updateAppUserRemarkRecord(dbHandler, appUserRemark.id, appUserRemark);
        }
      } catch (error) {
        logError("Error: SyncService:upSyncAppUserRemark() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAppUserRemark() 5-> $e");
  }
}

Future<void> upSyncAccountForm(AccountForm accountForm) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/accountform";

      var postData = {
        "AccountFormID": accountForm.accountFormID != null && accountForm.accountFormID.isNotEmpty ? accountForm.accountFormID : "-1",
        "AccountFormCode": accountForm.accountFormCode != null && accountForm.accountFormCode.isNotEmpty ? accountForm.accountFormCode : "",
        "AccountFormTitle": accountForm.accountFormTitle,
        "FormID": FormDataHandler.GetServerId(dbHandler, accountForm.formID),
        "AccountID": AccountDataHandler.GetServerId(dbHandler, accountForm.accountID),
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, accountForm.activityID),
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler, accountForm.opportunityID),
        "FileName": accountForm.fileName,
        "FileUrl": accountForm.fileUrl,
        "CreatedOn": accountForm.createdOn,
        "CreatedBy": accountForm.createdBy,
        "ModifiedOn": accountForm.modifiedOn,
        "ModifiedBy": accountForm.modifiedBy,
        "IsActive": Globals.tryParseBoolean(accountForm.isActive),
        "Uid": accountForm.uid,
        "AppUserID": accountForm.appUserID,
        "AppUserGroupID": accountForm.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(accountForm.isArchived),
        "IsDeleted": Globals.tryParseBoolean(accountForm.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body);
          if (jsonObject != null) {
            try {
              var accountFormReturn = AccountForm();
              await JSONCopier.copyJsonDataToAccountForm( dbHandler, jsonObject, accountFormReturn, false);
              accountFormReturn.isDirty = "false";
              accountFormReturn.upSyncMessage = "SUCCESS";
              accountFormReturn.upSyncIndex = Globals.syncIndex.toString();
              AccountFormDataHandler.updateAccountFormRecord(dbHandler, accountForm.id, accountFormReturn);
              logupSyncItemMessage("AccountForm - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncAccountForm() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAccountForm() 2-> ${accountForm.id} : Object not returned.");
            accountForm.upSyncMessage = "FAIL: Object not returned";
            accountForm.upSyncIndex = Globals.syncIndex.toString();
            AccountFormDataHandler.updateAccountFormRecord(dbHandler, accountForm.id, accountForm);
          }
          upSyncList.remove("AccountForm-${accountForm.id}");
        } else {
          logError("VolleyError: SyncService:upSyncAccountForm() 3-> ${response.body}");
          accountForm.upSyncMessage = "FAIL: ${response.body}";
          accountForm.upSyncIndex = Globals.syncIndex.toString();
          AccountFormDataHandler.updateAccountFormRecord(dbHandler, accountForm.id, accountForm);
        }
      } catch (error) {
        logError("Error: SyncService:upSyncAccountForm() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAccountForm() 5-> $e");
  }
}

Future<void> upSyncAccountFormValue(String accountFormId, List<AccountFormValue> accountFormValueListOriginal, List<AccountFormValue> accountFormValueList) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/accountformvalue/savecollection";

      var postData = {
        "DataString1": json.encode(accountFormValueList),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonArray = json.decode(response.body) as List<dynamic>;
          if (jsonArray != null) {
            for (var i = 0; i < jsonArray.length; i++) {
              var jsonObject = jsonArray[i] as Map<String, dynamic>;
              if (jsonObject != null) {
                var cid = jsonObject["CID"] as String;
                var sid = jsonObject["SID"] as String;
                if (Globals.tryParseLongForDBId(cid) != "-1" && Globals.tryParseLongForDBId(sid) != "-1") {
                  AccountFormValue accountFormValue = AccountFormValueDataHandlerBase.GetAccountFormValueRecord(dbHandler, cid);
                  if (accountFormValue != null) {
                    accountFormValue.accountFormValueID = sid;
                    accountFormValue.isDirty = "false";
                    accountFormValue.upSyncMessage = "SUCCESS";
                    accountFormValue.upSyncIndex = Globals.syncIndex.toString();
                    AccountFormValueDataHandler.updateAccountFormValueRecord(dbHandler, accountFormValue.id, accountFormValue);
                    logupSyncItemMessage("AccountFormValues - Saved successfully of form $accountFormId.");
                  }
                }
              }
            }
          } else {
            logError("VolleyError: SyncService:upSyncAccountFormValue() 2-> : Server Response not returned for values of form $accountFormId");
            for (var accountFormValue in accountFormValueListOriginal) {
              accountFormValue.upSyncMessage = "FAIL: Server Response not returned";
              accountFormValue.upSyncIndex = Globals.syncIndex.toString();
              AccountFormValueDataHandler.updateAccountFormValueRecord(dbHandler, accountFormValue.id, accountFormValue);
            }
          }
          upSyncList.remove("AccountFormValue-$accountFormId");
        } else {
          logError("VolleyError: SyncService:upSyncAccountFormValue() 3-> ${response.body}");
          for (var accountFormValue in accountFormValueListOriginal) {
            accountFormValue.upSyncMessage = "FAIL: ${response.body}";
            accountFormValue.upSyncIndex = Globals.syncIndex.toString();
            AccountFormValueDataHandler.updateAccountFormValueRecord(dbHandler, accountFormValue.id, accountFormValue);
          }
        }
      } catch (error) {
        logError("Error: SyncService:upSyncAccountFormValue() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAccountFormValue() 5-> $e");
  }
}

Future<void> upSyncReimbursement(Reimbursement reimbursement) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/reimbursement";

      var postData = {
        "ReimbursementID": !Globals.isNullOrEmpty(reimbursement.reimbursementID) ? reimbursement.reimbursementID : "-1",
        "ReimbursementCode": !Globals.isNullOrEmpty(reimbursement.reimbursementCode) ? reimbursement.reimbursementCode : "",
        "ReimbursementTitle": reimbursement.reimbursementTitle,
        "ReimbursementDate": reimbursement.reimbursementDate,
        "VoucherNumber": reimbursement.voucherNumber,
        "Description": reimbursement.description,
        "Amount": reimbursement.amount,
        "IsPaid": Globals.tryParseBoolean(reimbursement.isPaid),
        "CreatedOn": reimbursement.createdOn,
        "CreatedBy": reimbursement.createdBy,
        "ModifiedOn": reimbursement.modifiedOn,
        "ModifiedBy": reimbursement.modifiedBy,
        "IsActive": Globals.tryParseBoolean(reimbursement.isActive),
        "Uid": reimbursement.uid,
        "AppUserID": reimbursement.appUserID,
        "AppUserGroupID": reimbursement.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(reimbursement.isArchived),
        "IsDeleted": Globals.tryParseBoolean(reimbursement.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var reimbursementReturn = Reimbursement();
              JSONCopier.copyJsonDataToReimbursement( dbHandler, jsonObject, reimbursementReturn, false);
              reimbursementReturn.isDirty = "false";
              reimbursementReturn.upSyncMessage = "SUCCESS";
              reimbursementReturn.upSyncIndex = Globals.syncIndex.toString();
              ReimbursementDataHandler.updateReimbursementRecord(dbHandler, reimbursement.id, reimbursementReturn);
              logupSyncItemMessage("Reimbursement - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncReimbursement() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncReimbursement() 2-> ${reimbursement.id} : Object not returned.");
            reimbursement.upSyncMessage = "FAIL: Object not returned";
            reimbursement.upSyncIndex = Globals.syncIndex.toString();
            ReimbursementDataHandler.updateReimbursementRecord(dbHandler, reimbursement.id, reimbursement);
          }
          upSyncList.remove("Reimbursement-${reimbursement.id}");
        } else {
          logError("VolleyError: SyncService:upSyncReimbursement() 3-> ${response.body}");
          reimbursement.upSyncMessage = "FAIL: ${response.body}";
          reimbursement.upSyncIndex = Globals.syncIndex.toString();
          ReimbursementDataHandler.updateReimbursementRecord(dbHandler, reimbursement.id, reimbursement);
        }
      } catch (error) {
        logError("Error: SyncService:upSyncReimbursement() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncReimbursement() 5-> $e");
  }
}

Future<void> upSyncReimbursementDetail(ReimbursementDetail reimbursementDetail) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/reimbursementdetail";

      var postData = {
        "ReimbursementDetailID": !Globals.isNullOrEmpty(reimbursementDetail.reimbursementDetailID) ? reimbursementDetail.reimbursementDetailID : "-1",
        "ReimbursementDetailCode": !Globals.isNullOrEmpty(reimbursementDetail.reimbursementDetailCode) ? reimbursementDetail.reimbursementDetailCode : "",
        "ReimbursementDetailTitle": reimbursementDetail.reimbursementDetailTitle,
        "BillNumber": reimbursementDetail.billNumber,
        "BillDate": reimbursementDetail.billDate,
        "Amount": reimbursementDetail.amount,
        "ReimbursementID": ReimbursementDataHandler.GetServerId(dbHandler, reimbursementDetail.reimbursementID),
        "ReimbursementTypeID": ReimbursementTypeDataHandler.GetServerId(dbHandler, reimbursementDetail.reimbursementTypeID),
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, reimbursementDetail.activityID),
        "ActivityTravelID": ActivityTravelDataHandler.GetServerId(dbHandler, reimbursementDetail.activityTravelID),
        "Description": reimbursementDetail.description,
        "DocumentPath": reimbursementDetail.documentPath,
        "DocumentContent": reimbursementDetail.documentContent,
        "CreatedOn": reimbursementDetail.createdOn,
        "CreatedBy": reimbursementDetail.createdBy,
        "ModifiedOn": reimbursementDetail.modifiedOn,
        "ModifiedBy": reimbursementDetail.modifiedBy,
        "IsActive": Globals.tryParseBoolean(reimbursementDetail.isActive),
        "Uid": reimbursementDetail.uid,
        "AppUserID": reimbursementDetail.appUserID,
        "AppUserGroupID": reimbursementDetail.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(reimbursementDetail.isArchived),
        "IsDeleted": Globals.tryParseBoolean(reimbursementDetail.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var reimbursementDetailReturn = ReimbursementDetail();
              JSONCopier.copyJsonDataToReimbursementDetail(, dbHandler, jsonObject, reimbursementDetailReturn, false);
              reimbursementDetailReturn.isDirty = "false";
              reimbursementDetailReturn.upSyncMessage = "SUCCESS";
              reimbursementDetailReturn.upSyncIndex = Globals.syncIndex.toString();
              ReimbursementDetailDataHandler.updateReimbursementDetailRecord(dbHandler, reimbursementDetail.id, reimbursementDetailReturn);
              logupSyncItemMessage("ReimbursementDetail - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncReimbursementDetail() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncReimbursementDetail() 2-> ${reimbursementDetail.id} : Object not returned.");
            reimbursementDetail.upSyncMessage = "FAIL: Object not returned";
            reimbursementDetail.upSyncIndex = Globals.syncIndex.toString();
            ReimbursementDetailDataHandler.updateReimbursementDetailRecord(dbHandler, reimbursementDetail.id, reimbursementDetail);
          }
          upSyncList.remove("ReimbursementDetail-${reimbursementDetail.id}");
        } else {
          logError("VolleyError: SyncService:upSyncReimbursementDetail() 3-> ${response.body}");
          reimbursementDetail.upSyncMessage = "FAIL: ${response.body}";
          reimbursementDetail.upSyncIndex = Globals.syncIndex.toString();
          ReimbursementDetailDataHandler.updateReimbursementDetailRecord(dbHandler, reimbursementDetail.id, reimbursementDetail);
        }
      } catch (error) {
        logError("Error: SyncService:upSyncReimbursementDetail() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncReimbursementDetail() 5-> $e");
  }
}

Future<void> upSyncAppUserLocation(AppUserLocation appUserLocation) async{
  try {
    if ( await await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/appuserlocation";

      var postData = {
        "AppUserLocationID": !Globals.isNullOrEmpty(appUserLocation.appUserLocationID) ? appUserLocation.appUserLocationID : "-1",
        "AppUserLocationCode": !Globals.isNullOrEmpty(appUserLocation.appUserLocationCode) ? appUserLocation.appUserLocationCode : "",
        "AppUserLocationTitle": appUserLocation.appUserLocationTitle,
        "AppUserLocationDate": appUserLocation.appUserLocationDate,
        "AppUserLocationCoordinates": appUserLocation.appUserLocationCoordinates,
        "AppUserLocationAddress": appUserLocation.appUserLocationAddress,
        "CheckSum": appUserLocation.checkSum,
        "LastLocationCoordinates": appUserLocation.lastLocationCoordinates,
        "LastLocationAddress": appUserLocation.lastLocationAddress,
        "LastLocationTime": appUserLocation.lastLocationTime,
        "CreatedBy": appUserLocation.createdBy,
        "CreatedOn": appUserLocation.createdOn,
        "ModifiedBy": appUserLocation.modifiedBy,
        "ModifiedOn": appUserLocation.modifiedOn,
        "DeviceIdentifier": appUserLocation.deviceIdentifier,
        "ReferenceIdentifier": appUserLocation.referenceIdentifier,
        "Location": appUserLocation.location,
        "IsActive": Globals.tryParseBoolean(appUserLocation.isActive),
        "Uid": appUserLocation.uid,
        "AppUserID": appUserLocation.appUserID,
        "AppUserGroupID": appUserLocation.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(appUserLocation.isArchived),
        "IsDeleted": Globals.tryParseBoolean(appUserLocation.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var appUserLocationReturn = AppUserLocation();
              JSONCopier.copyJsonDataToAppUserLocation(, dbHandler, jsonObject, appUserLocationReturn, false);

              if (appUserLocationReturn.appUserLocationID.isNotEmpty) {
                var db = dbHandler.getWritableDatabase();
                var sql1 = "UPDATE " + Tables.TABLE_APPUSERLOCATION + " SET ";
                sql1 += Columns.KEY_APPUSERLOCATION_APPUSERLOCATIONCODE + " = '${appUserLocationReturn.appUserLocationCode}'";
                sql1 += "," + Columns.KEY_APPUSERLOCATION_APPUSERLOCATIONID + " = '${appUserLocationReturn.appUserLocationID}'";
                sql1 += "," + Columns.KEY_ISDIRTY + " = 'false'";
                sql1 += "," + Columns.KEY_upSyncMESSAGE + " = 'SUCCESS'";
                sql1 += "," + Columns.KEY_upSyncINDEX + " = '${Globals.SyncIndex.toString()}'";
                sql1 += " WHERE " + Columns.KEY_ID + " = ${appUserLocation.id.toString()}";
                db.execute(sql1);
              }

            } catch (error) {
              logError("Error: SyncService:upSyncAppUserLocation() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAppUserLocation() 2-> ${appUserLocation.id} : Object not returned.");

          var db = await dbHandler.database;
            var sql1 = "UPDATE " + TablesBase.TABLE_APPUSERLOCATION + " SET ";
            sql1 += " " + ColumnsBase.KEY_upSyncMESSAGE + " = 'FAIL: Object not returned'";
            sql1 += "," + ColumnsBase.KEY_upSyncINDEX + " = '${Globals.SyncIndex.toString()}'";
            sql1 += " WHERE " + Columns.KEY_ID + " = ${appUserLocation.id.toString()}";
            db.execute(sql1);
          }
          upSyncList.remove("AppUserLocation-${appUserLocation.id.toString()}");
        } else {
          String postError = response.body;
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else if (response.statusCode == 500) {
            postError = "Internal Server Error";
          }

          var db = await dbHandler.database;
          var sql1 = "UPDATE " + Tables.TABLE_APPUSERLOCATION + " SET ";
          sql1 += " " + Columns.KEY_upSyncMESSAGE + " = 'FAIL: ${postError.replaceAll("'", "''")}'";
          sql1 += "," + Columns.KEY_upSyncINDEX + " = '${Globals.SyncIndex.toString()}'";
          sql1 += " WHERE " + Columns.KEY_ID + " = ${appUserLocation.id.toString()}";
          db.execute(sql1);

          upSyncList.remove("AppUserLocation-${appUserLocation.id.toString()}");
          logError("VolleyError: SyncService:upSyncAppUserLocation() 3-> $postError");
        }
      } catch (error) {
        logError("Error: SyncService:upSyncAppUserLocation() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAppUserLocation() 5-> $e");
  }
}

Future<void> upSyncActivityPermission(ActivityPermission activityPermission) async{
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/activitypermission";

      var postData = {
        "ActivityPermissionID": !Globals.isNullOrEmpty(activityPermission.activityPermissionID) ? activityPermission.activityPermissionID : "-1",
        "ActivityPermissionCode": !Globals.isNullOrEmpty(activityPermission.activityPermissionCode) ? activityPermission.activityPermissionCode : "",
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, activityPermission.activityID),
        "AppUserID": activityPermission.appUserID,
        "PermissionLevel": activityPermission.permissionLevel,
        "CreatedOn": activityPermission.createdOn,
        "CreatedBy": activityPermission.createdBy,
        "ModifiedOn": activityPermission.modifiedOn,
        "ModifiedBy": activityPermission.modifiedBy,
        "IsActive": Globals.tryParseBoolean(activityPermission.isActive),
        "Uid": activityPermission.uid,
        "AppUserGroupID": activityPermission.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityPermission.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityPermission.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var activityPermissionReturn = ActivityPermission();
              JSONCopier.copyJsonDataToActivityPermission(, dbHandler, jsonObject, activityPermissionReturn, false);
              activityPermissionReturn.isDirty = "false";
              activityPermissionReturn.upSyncMessage = "SUCCESS";
              activityPermissionReturn.upSyncIndex = Globals.syncIndex.toString();
              ActivityPermissionDataHandler.updateActivityPermissionRecord(dbHandler, activityPermission.id, activityPermissionReturn);
              logupSyncItemMessage("ActivityPermission - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncActivityPermission() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityPermission() 2-> ${activityPermission.id} : Object not returned.");
            activityPermission.upSyncMessage = "FAIL: Object not returned";
            activityPermission.upSyncIndex = Globals.syncIndex.toString();
            ActivityPermissionDataHandler.updateActivityPermissionRecord(dbHandler, activityPermission.id, activityPermission);
          }
          upSyncList.remove("ActivityPermission-${activityPermission.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String postError = "";
            if (response.statusCode == 500) {
              postError = "Internal Server Error";
            }
            logError("VolleyError: SyncService:upSyncActivityPermission() 3-> $postError");
            activityPermission.upSyncMessage = "FAIL: $postError";
            activityPermission.upSyncIndex = Globals.syncIndex.toString();
            ActivityPermissionDataHandler.updateActivityPermissionRecord(dbHandler, activityPermission.id, activityPermission);
          }
          upSyncList.remove("ActivityPermission-${activityPermission.id}");
        }
      } catch (error) {
        logError("Error: SyncService:upSyncActivityPermission() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityPermission() 5-> $e");
  }
}

Future<void> upSyncNotePermission(NotePermission notePermission)async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/notepermission";

      var postData = {
        "NotePermissionID": !Globals.isNullOrEmpty(notePermission.notePermissionID) ? notePermission.notePermissionID : "-1",
        "NotePermissionCode": !Globals.isNullOrEmpty(notePermission.notePermissionCode) ? notePermission.notePermissionCode : "",
        "NoteID": NoteDataHandler.GetServerId(dbHandler, notePermission.noteID),
        "AppUserID": notePermission.appUserID,
        "PermissionLevel": notePermission.permissionLevel,
        "CreatedOn": notePermission.createdOn,
        "CreatedBy": notePermission.createdBy,
        "ModifiedOn": notePermission.modifiedOn,
        "ModifiedBy": notePermission.modifiedBy,
        "IsActive": Globals.tryParseBoolean(notePermission.isActive),
        "Uid": notePermission.uid,
        "AppUserGroupID": notePermission.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(notePermission.isArchived),
        "IsDeleted": Globals.tryParseBoolean(notePermission.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var notePermissionReturn = NotePermission();
              JSONCopier.copyJsonDataToNotePermission(, dbHandler, jsonObject, notePermissionReturn, false);
              notePermissionReturn.isDirty = "false";
              notePermissionReturn.upSyncMessage = "SUCCESS";
              notePermissionReturn.upSyncIndex = Globals.syncIndex.toString();
              NotePermissionDataHandler.updateNotePermissionRecord(dbHandler,  notePermission.id, notePermissionReturn);
              logupSyncItemMessage("NotePermission - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncNotePermission() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncNotePermission() 2-> ${notePermission.id} : Object not returned.");
            notePermission.upSyncMessage = "FAIL: Object not returned";
            notePermission.upSyncIndex = Globals.syncIndex.toString();
            NotePermissionDataHandler.updateNotePermissionRecord(dbHandler, notePermission.id, notePermission);
          }
          upSyncList.remove("NotePermission-${notePermission.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String postError = "";
            if (response.statusCode == 500) {
              postError = "Internal Server Error";
            }
            logError("VolleyError: SyncService:upSyncNotePermission() 3-> $postError");
            notePermission.upSyncMessage = "FAIL: $postError";
            notePermission.upSyncIndex = Globals.syncIndex.toString();
            NotePermissionDataHandler.updateNotePermissionRecord(dbHandler, notePermission.id, notePermission);
          }
          upSyncList.remove("NotePermission-${notePermission.id}");
        }
      } catch (error) {
        logError("Error: SyncService:upSyncNotePermission() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncNotePermission() 5-> $e");
  }
}

Future<void> upSyncOpportunityPermission(OpportunityPermission opportunityPermission)async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/opportunitypermission";

      var postData = {
        "OpportunityPermissionID": !Globals.isNullOrEmpty(opportunityPermission.opportunityPermissionID) ? opportunityPermission.opportunityPermissionID : "-1",
        "OpportunityPermissionCode": !Globals.isNullOrEmpty(opportunityPermission.opportunityPermissionCode) ? opportunityPermission.opportunityPermissionCode : "",
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler, opportunityPermission.opportunityID),
        "AppUserID": opportunityPermission.appUserID,
        "PermissionLevel": opportunityPermission.permissionLevel,
        "CreatedOn": opportunityPermission.createdOn,
        "CreatedBy": opportunityPermission.createdBy,
        "ModifiedOn": opportunityPermission.modifiedOn,
        "ModifiedBy": opportunityPermission.modifiedBy,
        "IsActive": Globals.tryParseBoolean(opportunityPermission.isActive),
        "Uid": opportunityPermission.uid,
        "AppUserGroupID": opportunityPermission.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunityPermission.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityPermission.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var opportunityPermissionReturn = OpportunityPermission();
              JSONCopier.copyJsonDataToOpportunityPermission(, dbHandler, jsonObject, opportunityPermissionReturn, false);
              opportunityPermissionReturn.isDirty = "false";
              opportunityPermissionReturn.upSyncMessage = "SUCCESS";
              opportunityPermissionReturn.upSyncIndex = Globals.syncIndex.toString();
              OpportunityPermissionDataHandler.updateOpportunityPermissionRecord(dbHandler, opportunityPermission.id, opportunityPermissionReturn);
              logupSyncItemMessage("OpportunityPermission - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncOpportunityPermission() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncOpportunityPermission() 2-> ${opportunityPermission.id} : Object not returned.");
            opportunityPermission.upSyncMessage = "FAIL: Object not returned";
            opportunityPermission.upSyncIndex = Globals.syncIndex.toString();
            OpportunityPermissionDataHandler.updateOpportunityPermissionRecord(dbHandler, opportunityPermission.id, opportunityPermission);
          }
          upSyncList.remove("OpportunityPermission-${opportunityPermission.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String postError = "";
            if (response.statusCode == 500) {
              postError = "Internal Server Error";
            }
            logError("VolleyError: SyncService:upSyncOpportunityPermission() 3-> $postError");
            opportunityPermission.upSyncMessage = "FAIL: $postError";
            opportunityPermission.upSyncIndex = Globals.syncIndex.toString();
            OpportunityPermissionDataHandler.updateOpportunityPermissionRecord(dbHandler, opportunityPermission.id, opportunityPermission);
          }
          upSyncList.remove("OpportunityPermission-${opportunityPermission.id}");
        }
      } catch (error) {
        logError("Error: SyncService:upSyncOpportunityPermission() 4-> $error");
      }
    }
  } catch (e) {
    logError("Error: SyncService:upSyncOpportunityPermission() 5-> $e");
  }
}

Future<void> upSyncActivityTeam(ActivityTeam activityTeam) async{
  try {
    if (await  await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/activityteam";
      Map<String, dynamic> postData = {
        "ActivityTeamID": Globals.isNullOrEmpty(activityTeam.activityTeamID) ? "-1" : activityTeam.activityTeamID,
        "ActivityTeamCode": Globals.isNullOrEmpty(activityTeam.activityTeamCode) ? "" : activityTeam.activityTeamCode,
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler, activityTeam.activityID),
        "ActivityTeamAppUserID": activityTeam.activityTeamAppUserID,
        "Description": activityTeam.description,
        "CreatedBy": activityTeam.createdBy,
        "CreatedOn": activityTeam.createdOn,
        "ModifiedBy": activityTeam.modifiedBy,
        "ModifiedOn": activityTeam.modifiedOn,
        "IsActive": Globals.tryParseBoolean(activityTeam.isActive),
        "Uid": activityTeam.uid,
        "AppUserGroupID": activityTeam.appUserGroupID,
        "AppUserID": activityTeam.appUserID,
        "IsArchived": Globals.tryParseBoolean(activityTeam.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityTeam.isDeleted),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              ActivityTeam activityTeamReturn = ActivityTeam();
              JSONCopier.copyJsonDataToActivityTeam( dbHandler, jsonObject, activityTeamReturn, false);
              activityTeamReturn.isDirty = "false";
              activityTeamReturn.upSyncMessage = "SUCCESS";
              activityTeamReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTeamDataHandler.UpdateActivityTeamRecord(dbHandler, activityTeam.id, activityTeamReturn);
              logupSyncItemMessage("ActivityTeam - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityTeam() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityTeam() 2-> ${activityTeam.id} : Object not returned.");
            activityTeam.upSyncMessage = "FAIL: Object not returned";
            activityTeam.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTeamDataHandler.UpdateActivityTeamRecord(dbHandler, activityTeam.id, activityTeam);
          }
          upSyncList.remove("ActivityTeam-${activityTeam.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = "";
            if (response.body != null) {
              posterror = utf8.decode(response.bodyBytes);
            }
            logError("VolleyError: SyncService:upSyncActivityTeam() 3-> $posterror");
            activityTeam.upSyncMessage = "FAIL: $posterror";
            activityTeam.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTeamDataHandler.UpdateActivityTeamRecord(dbHandler, activityTeam.id, activityTeam);
          }
          upSyncList.remove("ActivityTeam-${activityTeam.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncActivityTeam() 4-> ${error.toString()}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityTeam() 4-> ${e.toString()}");
  }
}

Future<void> upSyncAppUserMessage(AppUserMessage appUserMessage)async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/appusermessage";
      Map<String, dynamic> postData = {
        "AppUserMessageID": Globals.isNullOrEmpty(appUserMessage.appUserMessageID) ? "-1" : appUserMessage.appUserMessageID,
        "AppUserMessageCode": Globals.isNullOrEmpty(appUserMessage.appUserMessageCode) ? "" : appUserMessage.appUserMessageCode,
        "AppUserMessageText": appUserMessage.appUserMessageText,
        "ObjectType": appUserMessage.objectType,
        "ObjectID": appUserMessage.objectID,
        "IsAttachment": Globals.tryParseBoolean(appUserMessage.isAttachment),
        "ParentAppUserMessageID": AppUserMessageDataHandler.GetServerId(dbHandler, appUserMessage.parentAppUserMessageID),
        "AppUserMessageTo": appUserMessage.appUserMessageTo,
        "AppUserMessageReadBy": appUserMessage.appUserMessageReadBy,
        "CreatedBy": appUserMessage.createdBy,
        "CreatedOn": appUserMessage.createdOn,
        "ModifiedBy": appUserMessage.modifiedBy,
        "ModifiedOn": appUserMessage.modifiedOn,
        "IsActive": Globals.tryParseBoolean(appUserMessage.isActive),
        "Uid": appUserMessage.uid,
        "AppUserID": appUserMessage.appUserID,
        "AppUserGroupID": appUserMessage.appUserGroupID,
        "IsDeleted": Globals.tryParseBoolean(appUserMessage.isDeleted),
        "ReferenceIdentifier": appUserMessage.referenceIdentifier,
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              AppUserMessage appUserMessageReturn = AppUserMessage();
              JSONCopier.CopyJsonDataToAppUserMessage(, dbHandler, jsonObject, appUserMessageReturn, false);
              appUserMessageReturn.isDirty = "false";
              appUserMessageReturn.upSyncMessage = "SUCCESS";
              appUserMessageReturn.upSyncIndex = Globals.SyncIndex.toString();
              AppUserMessageDataHandler.UpdateAppUserMessageRecord(dbHandler, appUserMessage.id, appUserMessageReturn);
              logupSyncItemMessage("AppUserMessage - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncAppUserMessage() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAppUserMessage() 2-> ${appUserMessage.id} : Object not returned.");
            appUserMessage.upSyncMessage = "FAIL: Object not returned";
            appUserMessage.upSyncIndex = Globals.SyncIndex.toString();
            AppUserMessageDataHandler.UpdateAppUserMessageRecord(dbHandler, appUserMessage.id, appUserMessage);
          }
          upSyncList.remove("AppUserMessage-${appUserMessage.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = "";
            if (response.body != null) {
              posterror = utf8.decode(response.bodyBytes);
            }
            logError("VolleyError: SyncService:upSyncAppUserMessage() 3-> $posterror");
            appUserMessage.upSyncMessage = "FAIL: $posterror";
            appUserMessage.upSyncIndex = Globals.SyncIndex.toString();
            AppUserMessageDataHandler.UpdateAppUserMessageRecord(dbHandler, appUserMessage.id, appUserMessage);
          }
          upSyncList.remove("AppUserMessage-${appUserMessage.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncAppUserMessage() 3-> ${error.toString()}");
        upSyncList.remove("AppUserMessage-${appUserMessage.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAppUserMessage() 4-> ${e.toString()}");
  }
}

Future<void> upSyncOpportunityTeam(OpportunityTeam opportunityTeam) async{
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/opportunityteam";
      Map<String, dynamic> postData = {
        "OpportunityTeamID": Globals.isNullOrEmpty(opportunityTeam.opportunityTeamID) ? "-1" : opportunityTeam.opportunityTeamID,
        "OpportunityTeamCode": Globals.isNullOrEmpty(opportunityTeam.opportunityTeamCode) ? "" : opportunityTeam.opportunityTeamCode,
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  opportunityTeam.opportunityID),
        "OpportunityTeamAppUserID": opportunityTeam.opportunityTeamAppUserID,
        "Description": opportunityTeam.description,
        "CreatedBy": opportunityTeam.createdBy,
        "CreatedOn": opportunityTeam.createdOn,
        "ModifiedBy": opportunityTeam.modifiedBy,
        "ModifiedOn": opportunityTeam.modifiedOn,
        "IsActive": Globals.tryParseBoolean(opportunityTeam.isActive),
        "Uid": opportunityTeam.uid,
        "AppUserGroupID": opportunityTeam.appUserGroupID,
        "AppUserID": opportunityTeam.appUserID,
        "IsArchived": Globals.tryParseBoolean(opportunityTeam.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityTeam.isDeleted),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              OpportunityTeam opportunityTeamReturn = OpportunityTeam();
              JSONCopier.copyJsonDataToOpportunityTeam( dbHandler, jsonObject, opportunityTeamReturn, false);
              opportunityTeamReturn.isDirty = "false";
              opportunityTeamReturn.upSyncMessage = "SUCCESS";
              opportunityTeamReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityTeamDataHandler.UpdateOpportunityTeamRecord(dbHandler,  opportunityTeam.id, opportunityTeamReturn);
              logupSyncItemMessage("OpportunityTeam - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncOpportunityTeam() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncOpportunityTeam() 2-> ${opportunityTeam.id} : Object not returned.");
            opportunityTeam.upSyncMessage = "FAIL: Object not returned";
            opportunityTeam.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityTeamDataHandler.UpdateOpportunityTeamRecord(dbHandler,  opportunityTeam.id, opportunityTeam);
          }
          upSyncList.remove("OpportunityTeam-${opportunityTeam.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = "";
            if (response.body != null) {
              posterror = utf8.decode(response.bodyBytes);
            }
            logError("VolleyError: SyncService:upSyncOpportunityTeam() 3-> $posterror");
            opportunityTeam.upSyncMessage = "FAIL: $posterror";
            opportunityTeam.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityTeamDataHandler.UpdateOpportunityTeamRecord(dbHandler,  opportunityTeam.id, opportunityTeam);
          }
          upSyncList.remove("OpportunityTeam-${opportunityTeam.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncOpportunityTeam() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityTeam-${opportunityTeam.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncOpportunityTeam() 4-> ${e.toString()}");
  }
}

Future<void> upSyncActivityTravelMapping(ActivityTravelMapping activityTravelMapping) async{
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + "/activitytravelmapping";

      var postData = {
        "ActivityTravelMappingID": !Globals.isNullOrEmpty(activityTravelMapping.activityTravelMappingID) ? activityTravelMapping.activityTravelMappingID : "-1",
        "ActivityTravelMappingCode": !Globals.isNullOrEmpty(activityTravelMapping.activityTravelMappingCode) ? activityTravelMapping.activityTravelMappingCode : "",
        "ActivityTravelID": ActivityTravelDataHandler.GetServerId(dbHandler,  activityTravelMapping.activityTravelID),
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler,  activityTravelMapping.activityID),
        "CreatedBy": activityTravelMapping.createdBy,
        "CreatedOn": activityTravelMapping.createdOn,
        "ModifiedBy": activityTravelMapping.modifiedBy,
        "ModifiedOn": activityTravelMapping.modifiedOn,
        "IsActive": Globals.tryParseBoolean(activityTravelMapping.isActive),
        "Uid": activityTravelMapping.uid,
        "AppUserID": activityTravelMapping.appUserID,
        "AppUserGroupID": activityTravelMapping.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityTravelMapping.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityTravelMapping.isDeleted),
      };

      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Authorization": "Bearer ${Globals.USER_TOKEN}"},
          body: json.encode(postData),
        );

        if (response.statusCode == 200) {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          if (jsonObject != null) {
            try {
              var activityTravelMappingReturn = ActivityTravelMapping();
              JSONCopier.copyJsonDataToActivityTravelMapping( dbHandler, jsonObject, activityTravelMappingReturn, false);
              activityTravelMappingReturn.isDirty = "false";
              activityTravelMappingReturn.upSyncMessage = "SUCCESS";
              activityTravelMappingReturn.upSyncIndex = Globals.syncIndex.toString();
              ActivityTravelMappingDataHandlerBase.updateActivityTravelMappingRecord(dbHandler,  activityTravelMapping.id, activityTravelMappingReturn);
              logMessage("ActivityTravelMapping - Saved successfully.");
            } catch (error) {
              logError("Error: SyncService:upSyncActivityTravelMapping() 1-> $error");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityTravelMapping() 2-> ${activityTravelMapping.id} : Object not returned.");
            activityTravelMapping.upSyncMessage = "FAIL: Object not returned";
            activityTravelMapping.upSyncIndex = Globals.syncIndex.toString();
            ActivityTravelMappingDataHandler.updateActivityTravelMappingRecord(dbHandler,  activityTravelMapping.id, activityTravelMapping);
          }
          upSyncList.remove("ActivityTravelMapping-${activityTravelMapping.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String postError = "";
            if (response.statusCode == 500) {
              postError = "Internal Server Error";
            }
            activityTravelMapping.upSyncMessage = "FAIL: $postError";
            activityTravelMapping.upSyncIndex = Globals.syncIndex.toString();
            ActivityTravelMappingDataHandler.updateActivityTravelMappingRecord(dbHandler,  activityTravelMapping.id, activityTravelMapping);
            logError("VolleyError: SyncService:upSyncActivityTravelMapping() 3-> $postError");
          }
          upSyncList.remove("ActivityTravelMapping-${activityTravelMapping.id}");
        }
      } catch (error) {
        logError("Error: SyncService:upSyncActivityTravelMapping() 4-> $error");
      }
    }
  } catch (error) {
    logError("Error: SyncService:upSyncActivityTravelMapping() 5-> $error");
  }
}

Future<void> upSyncAccountBusinessUnit(AccountBusinessUnit accountBusinessUnit)async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/accountbusinessunit";
      Map<String, dynamic> postData = {
        "AccountBusinessUnitID": Globals.isNullOrEmpty(accountBusinessUnit.accountBusinessUnitID) ? "-1" : accountBusinessUnit.accountBusinessUnitID,
        "AccountBusinessUnitCode": Globals.isNullOrEmpty(accountBusinessUnit.accountBusinessUnitCode) ? "" : accountBusinessUnit.accountBusinessUnitCode,
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  accountBusinessUnit.accountID),
        "BusinessUnitID": BusinessUnitDataHandler.GetServerId(dbHandler,  accountBusinessUnit.businessUnitID),
        "CreatedBy": accountBusinessUnit.createdBy,
        "CreatedOn": accountBusinessUnit.createdOn,
        "ModifiedBy": accountBusinessUnit.modifiedBy,
        "ModifiedOn": accountBusinessUnit.modifiedOn,
        "IsActive": Globals.tryParseBoolean(accountBusinessUnit.isActive),
        "Uid": accountBusinessUnit.uid,
        "AppUserID": accountBusinessUnit.appUserID,
        "AppUserGroupID": accountBusinessUnit.appUserGroupID,
        "ReferenceIdentifier": accountBusinessUnit.referenceIdentifier,
        "IsDeleted": Globals.tryParseBoolean(accountBusinessUnit.isDeleted),
        "IsArchived": Globals.tryParseBoolean(accountBusinessUnit.isArchived),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              AccountBusinessUnit accountBusinessUnitReturn = AccountBusinessUnit();
              JSONCopier.CopyJsonDataToAccountBusinessUnit( dbHandler, jsonObject, accountBusinessUnitReturn, false);
              accountBusinessUnitReturn.isDirty = "false";
              accountBusinessUnitReturn.upSyncMessage = "SUCCESS";
              accountBusinessUnitReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountBusinessUnitDataHandler.UpdateAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit.id, accountBusinessUnitReturn);
              logMessage("AccountBusinessUnit - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncAccountBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAccountBusinessUnit() 2-> ${accountBusinessUnit.id} : Object not returned.");
            accountBusinessUnit.upSyncMessage = "FAIL: Object not returned";
            accountBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            AccountBusinessUnitDataHandler.UpdateAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit.id, accountBusinessUnit);
          }
          upSyncList.remove("AccountBusinessUnit-${accountBusinessUnit.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = response.body ?? "";
            if (response.headers != null && response.headers["content-type"]?.contains("charset=utf-8") ?? false) {
              posterror = utf8.decode(response.bodyBytes);
            }
            accountBusinessUnit.upSyncMessage = "FAIL: $posterror";
            accountBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            AccountBusinessUnitDataHandler.UpdateAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit.id, accountBusinessUnit);
          }
          upSyncList.remove("AccountBusinessUnit-${accountBusinessUnit.id}");
          logError("VolleyError: SyncService:upSyncAccountBusinessUnit() 3-> ${response.statusCode}: $posterror");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncAccountBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("AccountBusinessUnit-${accountBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncAccountBusinessUnit() 4-> ${e.toString()}");
  }
}

void upSyncActivityBusinessUnit(ActivityBusinessunit activityBusinessUnit) {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/activitybusinessunit";
      Map<String, dynamic> postData = {
        "ActivityBusinessUnitID": Globals.isNullOrEmpty(activityBusinessUnit.activityBusinessUnitID) ? "-1" : activityBusinessUnit.activityBusinessUnitID,
        "ActivityBusinessUnitCode": Globals.isNullOrEmpty(activityBusinessUnit.activityBusinessUnitCode) ? "" : activityBusinessUnit.activityBusinessUnitCode,
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler,  activityBusinessUnit.activityID),
        "BusinessUnitID": BusinessUnitDataHandler.GetServerId(dbHandler,  activityBusinessUnit.businessUnitID),
        "CreatedBy": activityBusinessUnit.createdBy,
        "CreatedOn": activityBusinessUnit.createdOn,
        "ModifiedBy": activityBusinessUnit.modifiedBy,
        "ModifiedOn": activityBusinessUnit.modifiedOn,
        "IsActive": Globals.tryParseBoolean(activityBusinessUnit.isActive),
        "Uid": activityBusinessUnit.uid,
        "AppUserID": activityBusinessUnit.appUserID,
        "AppUserGroupID": activityBusinessUnit.appUserGroupID,
        "ReferenceIdentifier": activityBusinessUnit.referenceIdentifier,
        "IsDeleted": Globals.tryParseBoolean(activityBusinessUnit.isDeleted),
        "IsArchived": Globals.tryParseBoolean(activityBusinessUnit.isArchived),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              ActivityBusinessunit activityBusinessUnitReturn = ActivityBusinessunit();
              JSONCopier.CopyJsonDataToActivityBusinessUnit( dbHandler, jsonObject, activityBusinessUnitReturn, false);
              activityBusinessUnitReturn.isDirty = "false";
              activityBusinessUnitReturn.upSyncMessage = "SUCCESS";
              activityBusinessUnitReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityBusinessUnitDataHandler.UpdateActivityBusinessUnitRecord(dbHandler,  activityBusinessUnit.id, activityBusinessUnitReturn);
              logMessage("ActivityBusinessUnit - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityBusinessUnit() 2-> ${activityBusinessUnit.id} : Object not returned.");
            activityBusinessUnit.upSyncMessage = "FAIL: Object not returned";
            activityBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            ActivityBusinessUnitDataHandler.UpdateActivityBusinessUnitRecord(dbHandler,  activityBusinessUnit.id, activityBusinessUnit);
          }
          upSyncList.remove("ActivityBusinessUnit-${activityBusinessUnit.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = response.body ?? "";
            if (response.headers != null && response.headers["content-type"]?.contains("charset=utf-8") ?? false) {
              posterror = utf8.decode(response.bodyBytes);
            }
            activityBusinessUnit.upSyncMessage = "FAIL: $posterror";
            activityBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            ActivityBusinessUnitDataHandler.UpdateActivityBusinessUnitRecord(dbHandler,  activityBusinessUnit.id, activityBusinessUnit);
          }
          upSyncList.remove("ActivityBusinessUnit-${activityBusinessUnit.id}");
          logError("VolleyError: SyncService:upSyncActivityBusinessUnit() 3-> ${response.statusCode}: $posterror");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncActivityBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("ActivityBusinessUnit-${activityBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityBusinessUnit() 4-> ${e.toString()}");
  }
}

void upSyncOpportunityBusinessUnit(OpportunityBusinessUnit opportunityBusinessUnit) {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/opportunitybusinessunit";
      Map<String, dynamic> postData = {
        "OpportunityBusinessUnitID": Globals.isNullOrEmpty(opportunityBusinessUnit.opportunityBusinessUnitID) ? "-1" : opportunityBusinessUnit.opportunityBusinessUnitID,
        "OpportunityBusinessUnitCode": Globals.isNullOrEmpty(opportunityBusinessUnit.opportunityBusinessUnitCode) ? "" : opportunityBusinessUnit.opportunityBusinessUnitCode,
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  opportunityBusinessUnit.opportunityID),
        "BusinessUnitID": BusinessUnitDataHandler.GetServerId(dbHandler,  opportunityBusinessUnit.businessUnitID),
        "CreatedBy": opportunityBusinessUnit.createdBy,
        "CreatedOn": opportunityBusinessUnit.createdOn,
        "ModifiedBy": opportunityBusinessUnit.modifiedBy,
        "ModifiedOn": opportunityBusinessUnit.modifiedOn,
        "IsActive": Globals.tryParseBoolean(opportunityBusinessUnit.isActive),
        "Uid": opportunityBusinessUnit.uid,
        "AppUserID": opportunityBusinessUnit.appUserID,
        "AppUserGroupID": opportunityBusinessUnit.appUserGroupID,
        "ReferenceIdentifier": opportunityBusinessUnit.referenceIdentifier,
        "IsDeleted": Globals.tryParseBoolean(opportunityBusinessUnit.isDeleted),
        "IsArchived": Globals.tryParseBoolean(opportunityBusinessUnit.isArchived),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              OpportunityBusinessUnit opportunityBusinessUnitReturn = OpportunityBusinessUnit();
              JSONCopier.CopyJsonDataToOpportunityBusinessUnit( dbHandler, jsonObject, opportunityBusinessUnitReturn, false);
              opportunityBusinessUnitReturn.isDirty = "false";
              opportunityBusinessUnitReturn.upSyncMessage = "SUCCESS";
              opportunityBusinessUnitReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityBusinessUnitDataHandler.UpdateOpportunityBusinessUnitRecord(dbHandler,  opportunityBusinessUnit.id, opportunityBusinessUnitReturn);
              logMessage("OpportunityBusinessUnit - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncOpportunityBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncOpportunityBusinessUnit() 2-> ${opportunityBusinessUnit.id} : Object not returned.");
            opportunityBusinessUnit.upSyncMessage = "FAIL: Object not returned";
            opportunityBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityBusinessUnitDataHandler.UpdateOpportunityBusinessUnitRecord(dbHandler,  opportunityBusinessUnit.id, opportunityBusinessUnit);
          }
          upSyncList.remove("OpportunityBusinessUnit-${opportunityBusinessUnit.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            String posterror = response.body ?? "";
            if (response.headers != null && response.headers["content-type"]?.contains("charset=utf-8") ?? false) {
              posterror = utf8.decode(response.bodyBytes);
            }
            opportunityBusinessUnit.upSyncMessage = "FAIL: $posterror";
            opportunityBusinessUnit.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityBusinessUnitDataHandler.UpdateOpportunityBusinessUnitRecord(dbHandler,  opportunityBusinessUnit.id, opportunityBusinessUnit);
          }
          upSyncList.remove("OpportunityBusinessUnit-${opportunityBusinessUnit.id}");
          logError("VolleyError: SyncService:upSyncOpportunityBusinessUnit() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncOpportunityBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityBusinessUnit-${opportunityBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncOpportunityBusinessUnit() 4-> ${e.toString()}");
  }
}

Future<void> upSyncActivityApproval(ActivityApproval activityApproval)async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/activityapproval";
      Map<String, dynamic> postData = {
        "ActivityApprovalID": Globals.isNullOrEmpty(activityApproval.activityApprovalID) ? "-1" : activityApproval.activityApprovalID,
        "ActivityApprovalCode": Globals.isNullOrEmpty(activityApproval.activityApprovalCode) ? "" : activityApproval.activityApprovalCode,
        "ActivityApprovalTitle": activityApproval.activityApprovalTitle,
        "ActivityApprovalTypeID": ActivityApprovalTypeDataHandler.GetServerId(dbHandler,  activityApproval.activityApprovalTypeID),
        "ActivityID": ActivityDataHandler.GetServerId(dbHandler,  activityApproval.activityID),
        "RequestDate": activityApproval.requestDate,
        "RequestDetail": activityApproval.requestDetail,
        "IsSubmitted": Globals.tryParseBoolean(activityApproval.isSubmitted),
        "ParentActivityApprovalID": ActivityApprovalDataHandler.GetServerId(dbHandler,  activityApproval.parentActivityApprovalID),
        "ApprovalStatus": activityApproval.approvalStatus,
        "ApprovalByAppUserID": activityApproval.approvalByAppUserID,
        "ApprovalTime": activityApproval.approvalTime,
        "ApproverRemarks": activityApproval.approverRemarks,
        "IsApprovalCompleted": activityApproval.isApprovalCompleted,
        "CreatedBy": activityApproval.createdBy,
        "CreatedOn": activityApproval.createdOn,
        "ModifiedBy": activityApproval.modifiedBy,
        "ModifiedOn": activityApproval.modifiedOn,
        "DeviceIdentifier": activityApproval.deviceIdentifier,
        "ReferenceIdentifier": activityApproval.referenceIdentifier,
        "Location": activityApproval.location,
        "IsActive": Globals.tryParseBoolean(activityApproval.isActive),
        "Uid": activityApproval.uid,
        "AppUserID": activityApproval.appUserID,
        "AppUserGroupID": activityApproval.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(activityApproval.isArchived),
        "IsDeleted": Globals.tryParseBoolean(activityApproval.isDeleted),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              ActivityApproval activityApprovalReturn = ActivityApproval();
              JSONCopier.CopyJsonDataToActivityApproval( dbHandler, jsonObject, activityApprovalReturn, false);
              activityApprovalReturn.isDirty = "false";
              activityApprovalReturn.upSyncMessage = "SUCCESS";
              activityApprovalReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityApprovalDataHandler.UpdateActivityApprovalRecord(dbHandler,  activityApproval.id, activityApprovalReturn);
              logMessage("ActivityApproval - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncActivityApproval() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncActivityApproval() 2-> ${activityApproval.id} : Object not returned.");
            activityApproval.upSyncMessage = "FAIL: Object not returned";
            activityApproval.upSyncIndex = Globals.SyncIndex.toString();
            ActivityApprovalDataHandler.UpdateActivityApprovalRecord(dbHandler,  activityApproval.id, activityApproval);
          }
          upSyncList.remove("ActivityApproval-${activityApproval.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN = "";
          } else {
            var posterror = response.body != null ? response.body : "";
            activityApproval.upSyncMessage = "FAIL: $posterror";
            activityApproval.upSyncIndex = Globals.SyncIndex.toString();
            ActivityApprovalDataHandler.UpdateActivityApprovalRecord(dbHandler,  activityApproval.id, activityApproval);
          }
          upSyncList.remove("ActivityApproval-${activityApproval.id}");
          logError("VolleyError: SyncService:upSyncActivityApproval() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncActivityApproval() 3-> ${error.toString()}");
        upSyncList.remove("ActivityApproval-${activityApproval.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncActivityApproval() 4-> ${e.toString()}");
  }
}

Future<void> upSyncOpportunityApproval(OpportunityApproval opportunityApproval)async {
  try {
    if ( await await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/opportunityapproval";
      Map<String, dynamic> postData = {
        "OpportunityApprovalID": !Globals.isNullOrEmpty(opportunityApproval.opportunityApprovalID) ? opportunityApproval.opportunityApprovalID : "-1",
        "OpportunityApprovalCode": !Globals.isNullOrEmpty(opportunityApproval.opportunityApprovalCode) ? opportunityApproval.opportunityApprovalCode : "",
        "OpportunityApprovalTitle": opportunityApproval.opportunityApprovalTitle,
        "OpportunityApprovalTypeID": OpportunityApprovalTypeDataHandler.GetServerId(dbHandler,  opportunityApproval.opportunityApprovalTypeID),
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  opportunityApproval.opportunityID),
        "RequestDate": opportunityApproval.requestDate,
        "RequestDetail": opportunityApproval.requestDetail,
        "IsSubmitted": Globals.tryParseBoolean(opportunityApproval.isSubmitted),
        "ParentOpportunityApprovalID": OpportunityApprovalDataHandler.GetServerId(dbHandler,  opportunityApproval.parentOpportunityApprovalID),
        "ApprovalStatus": opportunityApproval.approvalStatus,
        "ApprovalByAppUserID": opportunityApproval.approvalByAppUserID,
        "ApprovalTime": opportunityApproval.approvalTime,
        "ApproverRemarks": opportunityApproval.approverRemarks,
        "IsApprovalCompleted": opportunityApproval.isApprovalCompleted,
        "CreatedBy": opportunityApproval.createdBy,
        "CreatedOn": opportunityApproval.createdOn,
        "ModifiedBy": opportunityApproval.modifiedBy,
        "ModifiedOn": opportunityApproval.modifiedOn,
        "DeviceIdentifier": opportunityApproval.deviceIdentifier,
        "ReferenceIdentifier": opportunityApproval.referenceIdentifier,
        "Location": opportunityApproval.location,
        "IsActive": Globals.tryParseBoolean(opportunityApproval.isActive),
        "Uid": opportunityApproval.uid,
        "AppUserID": opportunityApproval.appUserID,
        "AppUserGroupID": opportunityApproval.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(opportunityApproval.isArchived),
        "IsDeleted": Globals.tryParseBoolean(opportunityApproval.isDeleted),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              OpportunityApproval opportunityApprovalReturn = OpportunityApproval();
              JSONCopier.CopyJsonDataToOpportunityApproval( dbHandler, jsonObject, opportunityApprovalReturn, false);
              opportunityApprovalReturn.isDirty = "false";
              opportunityApprovalReturn.upSyncMessage = "SUCCESS";
              opportunityApprovalReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityApprovalDataHandler.UpdateOpportunityApprovalRecord(dbHandler,  opportunityApproval.id, opportunityApprovalReturn);
              logMessage("OpportunityApproval - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncOpportunityApproval() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncOpportunityApproval() 2-> ${opportunityApproval.id} : Object not returned.");
            opportunityApproval.upSyncMessage = "FAIL: Object not returned";
            opportunityApproval.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityApprovalDataHandler.UpdateOpportunityApprovalRecord(dbHandler,  opportunityApproval.id, opportunityApproval);
          }
          upSyncList.remove("OpportunityApproval-${opportunityApproval.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN = "";
          } else {
            var posterror = response.body != null ? response.body : "";
            if (response.statusCode == 500 && response.headers.containsKey("content-type") && response.headers["content-type"]!.startsWith("application/json")) {
              var json = jsonDecode(response.body);
              if (json.containsKey("Message")) {
                posterror = json["Message"];
              }
            }
            opportunityApproval.upSyncMessage = "FAIL: $posterror";
            opportunityApproval.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityApprovalDataHandler.UpdateOpportunityApprovalRecord(dbHandler,  opportunityApproval.id, opportunityApproval);
          }
          upSyncList.remove("OpportunityApproval-${opportunityApproval.id}");
          logError("VolleyError: SyncService:upSyncOpportunityApproval() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncOpportunityApproval() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityApproval-${opportunityApproval.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:upSyncOpportunityApproval() 4-> ${e.toString()}");
  }
}

void upSyncAppLog(AppLog appLog) {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/applog";
      Map<String, dynamic> postData = {
        "AppLogID": !Globals.isNullOrEmpty(appLog.appLogID) ? appLog.appLogID : "-1",
        "AppLogCode": !Globals.isNullOrEmpty(appLog.appLogCode) ? appLog.appLogCode : "",
        "AppLogDetail": appLog.appLogDetail,
        "OperatingSystem": appLog.operatingSystem,
        "OperatingSystemVersion": appLog.operatingSystemVersion,
        "CreatedBy": appLog.createdBy,
        "CreatedOn": appLog.createdOn,
        "DeviceIdentifier": appLog.deviceIdentifier,
        "Uid": appLog.uid,
        "AppUserID": appLog.appUserID,
        "AppUserGroupID": appLog.appUserGroupID,
        "IsArchived": Globals.tryParseBoolean(appLog.isArchived),
        "IsDeleted": Globals.tryParseBoolean(appLog.isDeleted),
      };

      http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${Globals.USER_TOKEN}",
        },
        body: jsonEncode(postData),
      ).then((http.Response response) {
        if (response.statusCode == 200) {
          var jsonObject = jsonDecode(response.body);
          if (jsonObject != null) {
            try {
              AppLog appLogReturn = AppLog();
              JSONCopier.CopyJsonDataToAppLog( dbHandler, jsonObject, appLogReturn, false);
              appLogReturn.isDirty = "false";
              appLogReturn.upSyncMessage = "SUCCESS";
              appLogReturn.upSyncIndex = Globals.SyncIndexApplog.toString();
              AppLogDataHandler.UpdateAppLogRecord(dbHandler,  appLog.id, appLogReturn);
              logMessage("AppLog - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:upSyncAppLog() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:upSyncAppLog() 2-> ${appLog.id} : Object not returned.");
            appLog.upSyncMessage = "FAIL: Object not returned";
            appLog.upSyncIndex = Globals.SyncIndexApplog.toString();
            AppLogDataHandler.UpdateAppLogRecord(dbHandler,  appLog.id, appLog);
          }
          upSyncListApplog.remove("AppLog-${appLog.id}");
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          } else {
            var posterror = response.body != null ? response.body : "";
            if (response.statusCode == 500 && response.headers.containsKey("content-type") && response.headers["content-type"]!.startsWith("application/json")) {
              var json = jsonDecode(response.body);
              if (json.containsKey("Message")) {
                posterror = json["Message"];
              }
            }
            appLog.upSyncMessage = "FAIL: $posterror";
            appLog.upSyncIndex = Globals.SyncIndexApplog.toString();
            AppLogDataHandler.UpdateAppLogRecord(dbHandler,  appLog.id, appLog);
          }
          upSyncListApplog.remove("AppLog-${appLog.id}");
          logError("VolleyError: SyncService:upSyncAppLog() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:upSyncAppLog() 3-> ${error.toString()}");
        upSyncListApplog.remove("AppLog-${appLog.id}");
      });
    }
  } catch (e) {
    //logError("Error: SyncService:upSyncAppLog() 4-> ${e.toString()}");
  }
}

Future<void> upSyncHSSupportTicket(HSSupportTicket hSSupportTicket) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstants.API_VERSION_URL}/hssupportticket';

      Map<String, dynamic> postData = {
        'HSSupportTicketID': Globals.isNullOrEmpty(hSSupportTicket.HSSupportTicketID) ? '-1' : hSSupportTicket.HSSupportTicketID,
        'HSSupportTicketCode': Globals.isNullOrEmpty(hSSupportTicket.HSSupportTicketCode) ? '' : hSSupportTicket.HSSupportTicketCode,
        'HSSupportTicketTitle': hSSupportTicket.HSSupportTicketTitle,
        'HSSupportTicketType': hSSupportTicket.HSSupportTicketType,
        'HSSupportTicketDetail': hSSupportTicket.HSSupportTicketDetail,
        'CreatedBy': hSSupportTicket.CreatedBy,
        'CreatedOn': hSSupportTicket.CreatedOn,
        'ModifiedBy': hSSupportTicket.ModifiedBy,
        'ModifiedOn': hSSupportTicket.ModifiedOn,
        'ParentHSSupportTicketID': hSSupportTicket.ParentHSSupportTicketID,
        'AssignedToHSUserID': hSSupportTicket.AssignedToHSUserID,
        'TicketStatus': hSSupportTicket.TicketStatus,
        'Resolution': hSSupportTicket.Resolution,
        'ResolutionTime': hSSupportTicket.ResolutionTime,
        'IsActive': Globals.tryParseBoolean(hSSupportTicket.IsActive),
        'Uid': hSSupportTicket.Uid,
        'AppUserID': hSSupportTicket.AppUserID,
        'AppUserGroupID': hSSupportTicket.AppUserGroupID,
        'IsDeleted': Globals.tryParseBoolean(hSSupportTicket.IsDeleted),
      };

      var headers = {
        'Authorization': 'Bearer ${Globals.USER_TOKEN}',
      };

      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject != null) {
          try {
            HSSupportTicket hSSupportTicketReturn = HSSupportTicket();
            JSONCopier.copyJsonDataToHSSupportTicket(
                 dbHandler, jsonObject, hSSupportTicketReturn, false);
            hSSupportTicketReturn.isDirty = false;
            hSSupportTicketReturn.upSyncMessage = 'SUCCESS';
            hSSupportTicketReturn.upSyncIndex = Globals.SyncIndex.toString();
            HSSupportTicketDataHandler.updateHSSupportTicketRecord(
                dbHandler,  hSSupportTicket.id, hSSupportTicketReturn);
            logMessage('HSSupportTicket - Saved successfully.');
          } catch (ex) {
            logError('Error: SyncService:upSyncHSSupportTicket() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:upSyncHSSupportTicket() 2-> ${hSSupportTicket.id}: Object not returned.');
          hSSupportTicket.upSyncMessage = 'FAIL: Object not returned';
          hSSupportTicket.upSyncIndex = Globals.SyncIndex.toString();
          HSSupportTicketDataHandler.updateHSSupportTicketRecord(
              dbHandler,  hSSupportTicket.id, hSSupportTicket);
        }
        upSyncList.remove('HSSupportTicket-${hSSupportTicket.id}');
      } else {
        String posterror = response.body != null ? response.body.toString() : '';
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          posterror = 'FAIL: $posterror';
          hSSupportTicket.upSyncMessage = posterror;
          hSSupportTicket.upSyncIndex = Globals.SyncIndex.toString();
          HSSupportTicketDataHandler.updateHSSupportTicketRecord(
              dbHandler,  hSSupportTicket.id, hSSupportTicket);
        }
        upSyncList.remove('HSSupportTicket-${hSSupportTicket.id}');
        logError('VolleyError: SyncService:upSyncHSSupportTicket() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:upSyncHSSupportTicket() 4-> $e');
  }
}

void upSyncHSSupportTicketMedia(HSSupportTicketMedia hSSupportTicketMedia) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstants.API_VERSION_URL}/hssupportticketmedia';

      Map<String, dynamic> postData = {
        'HSSupportTicketMediaID': Globals.isNullOrEmpty(hSSupportTicketMedia.HSSupportTicketMediaID) ? '-1' : hSSupportTicketMedia.HSSupportTicketMediaID,
        'HSSupportTicketMediaCode': Globals.isNullOrEmpty(hSSupportTicketMedia.HSSupportTicketMediaCode) ? '' : hSSupportTicketMedia.HSSupportTicketMediaCode,
        'HSSupportTicketMediaName': hSSupportTicketMedia.HSSupportTicketMediaName,
        'HSSupportTicketID': HSSupportTicketDataHandler.GetServerId(dbHandler,  hSSupportTicketMedia.HSSupportTicketID),
        'ContentTypeID': ContentTypeDataHandler.GetServerId(dbHandler,  hSSupportTicketMedia.ContentTypeID),
        'MediaPath': hSSupportTicketMedia.MediaPath,
        'MediaContent': hSSupportTicketMedia.MediaContent,
        'Description': hSSupportTicketMedia.Description,
        'Tags': hSSupportTicketMedia.Tags,
        'CreatedBy': hSSupportTicketMedia.CreatedBy,
        'CreatedOn': hSSupportTicketMedia.CreatedOn,
        'ModifiedBy': hSSupportTicketMedia.ModifiedBy,
        'ModifiedOn': hSSupportTicketMedia.ModifiedOn,
        'DeviceIdentifier': hSSupportTicketMedia.DeviceIdentifier,
        'ReferenceIdentifier': hSSupportTicketMedia.ReferenceIdentifier,
        'IsActive': Globals.tryParseBoolean(hSSupportTicketMedia.IsActive),
        'Uid': hSSupportTicketMedia.Uid,
        'AppUserID': hSSupportTicketMedia.AppUserID,
        'AppUserGroupID': hSSupportTicketMedia.AppUserGroupID,
        'IsArchived': Globals.tryParseBoolean(hSSupportTicketMedia.IsArchived),
        'IsDeleted': Globals.tryParseBoolean(hSSupportTicketMedia.IsDeleted),
      };

      var headers = {
        'Authorization': 'Bearer ${Globals.USER_TOKEN}',
      };

      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject != null) {
          try {
            HSSupportTicketMedia hSSupportTicketMediaReturn = HSSupportTicketMedia();
            JSONCopier.copyJsonDataToHSSupportTicketMedia(
                 dbHandler, jsonObject, hSSupportTicketMediaReturn, false);
            hSSupportTicketMediaReturn.isDirty = false;
            hSSupportTicketMediaReturn.upSyncMessage = 'SUCCESS';
            hSSupportTicketMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
            HSSupportTicketMediaDataHandler.updateHSSupportTicketMediaRecord(
                dbHandler,  hSSupportTicketMedia.id, hSSupportTicketMediaReturn);
            logMessage('HSSupportTicketMedia - Saved successfully.');
          } catch (ex) {
            logError('Error: SyncService:upSyncHSSupportTicketMedia() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:upSyncHSSupportTicketMedia() 2-> ${hSSupportTicketMedia.id}: Object not returned.');
          hSSupportTicketMedia.upSyncMessage = 'FAIL: Object not returned';
          hSSupportTicketMedia.upSyncIndex = Globals.SyncIndex.toString();
          HSSupportTicketMediaDataHandler.updateHSSupportTicketMediaRecord(
              dbHandler,  hSSupportTicketMedia.id, hSSupportTicketMedia);
        }
        upSyncList.remove('HSSupportTicketMedia-${hSSupportTicketMedia.id}');
      } else {
        var posterror = response.statusCode.toString();
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          if (response.body != null) {
            posterror += utf8.decode(response.bodyBytes);
          }
          hSSupportTicketMedia.upSyncMessage = 'FAIL: $posterror';
          hSSupportTicketMedia.upSyncIndex = Globals.SyncIndex.toString();
          HSSupportTicketMediaDataHandler.updateHSSupportTicketMediaRecord(
              dbHandler,  hSSupportTicketMedia.id, hSSupportTicketMedia);
        }
        upSyncList.remove('HSSupportTicketMedia-${hSSupportTicketMedia.id}');
        logError('VolleyError: SyncService:upSyncHSSupportTicketMedia() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:upSyncHSSupportTicketMedia() 4-> $e');
  }
}

Future<void> upSyncReminder(Reminder reminder) async {
  try {
    if (await await Utility.isNetworkConnected() && !Globals.USER_TOKEN.isEmpty) {
      String url = '${AppConstants.API_VERSION_URL}/reminder';

      Map<String, dynamic> postData = {
        'ReminderID': Globals.isNullOrEmpty(reminder.ReminderID) ? '-1' : reminder.ReminderID,
        'ReminderCode': Globals.isNullOrEmpty(reminder.ReminderCode) ? '' : reminder.ReminderCode,
        'ReminderTitle': reminder.ReminderTitle,
        'ReminderDescription': reminder.ReminderDescription,
        'ReminderDate': reminder.ReminderDate,
        'ReminderTime': reminder.ReminderTime,
        'ReminderRepeat': Globals.tryParseBoolean(reminder.ReminderRepeat),
        'RepeatNumber': reminder.RepeatNumber,
        'RepeatType': reminder.RepeatType,
        'Active': Globals.tryParseBoolean(reminder.Active),
        'ActivityID': ActivityDataHandler.GetServerId(dbHandler,  reminder.ActivityID),
        'OpportunityID': OpportunityDataHandler.GetServerId(dbHandler,  reminder.OpportunityID),
        'AccountID': AccountDataHandler.GetServerId(dbHandler,  reminder.AccountID),
        'IsSetBySystem': Globals.tryParseBoolean(reminder.IsSetBySystem),
        'CreatedBy': reminder.CreatedBy,
        'CreatedOn': reminder.CreatedOn,
        'ModifiedBy': reminder.ModifiedBy,
        'ModifiedOn': reminder.ModifiedOn,
        'IsActive': Globals.tryParseBoolean(reminder.IsActive),
        'Uid': reminder.Uid,
        'AppUserID': reminder.AppUserID,
        'AppUserGroupID': reminder.AppUserGroupID,
        'IsDeleted': Globals.tryParseBoolean(reminder.IsDeleted),
      };

      var headers = {
        'Authorization': 'Bearer ${Globals.USER_TOKEN}',
      };

      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject != null) {
          try {
            Reminder reminderReturn = Reminder();
            JSONCopier.copyJsonDataToReminder(
                 dbHandler, jsonObject, reminderReturn, false);
            reminderReturn.isDirty = false;
            reminderReturn.upSyncMessage = 'SUCCESS';
            reminderReturn.upSyncIndex = Globals.SyncIndex.toString();
            ReminderDataHandler.updateReminderRecord(
                dbHandler,  reminder.id, reminderReturn);
            logMessage('Reminder - Saved successfully.');
          } catch (ex) {
            logError('Error: SyncService:upSyncReminder() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:upSyncReminder() 2-> ${reminder.id}: Object not returned.');
          reminder.upSyncMessage = 'FAIL: Object not returned';
          reminder.upSyncIndex = Globals.SyncIndex.toString();
          ReminderDataHandler.updateReminderRecord(
              dbHandler,  reminder.id, reminder);
        }
        upSyncList.remove('Reminder-${reminder.id}');
      } else {
        var posterror = response.statusCode.toString();
        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        } else {
          if (response.body != null) {
            posterror += utf8.decode(response.bodyBytes);
          }
          reminder.upSyncMessage = 'FAIL: $posterror';
          reminder.upSyncIndex = Globals.SyncIndex.toString();
          ReminderDataHandler.updateReminderRecord(
              dbHandler,  reminder.id, reminder);
        }
        upSyncList.remove('Reminder-${reminder.id}');
        logError('VolleyError: SyncService:upSyncReminder() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:upSyncReminder() 4-> $e');
  }
}


//*************************************DOWN-SYNC***************************************


//*************************************************************************************



Future<void> downSyncMaxDates() async {
    try {
      if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
        final url =
            AppConstants.API_VERSION_URL + '/ downSyncManager/GetMaxServerDate';

        final dbHandler = DatabaseHandler();
        final syncItems = SyncDataHandler.GetAppSyncItemRecordsMin(
          dbHandler,
        );
        final userdata = json.encode(syncItems);

        final postData = {'UserData': userdata};

        final headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
          'Content-Type': 'application/json',
        };

        final response = await http.post(Uri.parse(url),
            headers: headers, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          if (jsonResponse != null) {
            final dataString = jsonResponse['DataObject'];

            if (Globals.isJSONArray(dataString)) {
              final jsonArray = json.decode(dataString) as List<dynamic>;

              for (final jsonObject in jsonArray) {
                if (jsonObject != null) {
                  final tableName = jsonObject['TableName'];
                  final serverMaxDate = jsonObject['SMaxDate'];
                  final recordCount = jsonObject['Records'];
                  final lastSyncTime = jsonObject['SCreatedOn'];

                  if (tableName != null && tableName != '') {
                    final appSyncItem = SyncDataHandler.GetAppSyncItemRecord(
                        dbHandler, tableName);
                    if (appSyncItem != null) {
                      appSyncItem.setSMaxDate(serverMaxDate);
                      appSyncItem.setRecords(recordCount);
                      appSyncItem.setSyncTime(lastSyncTime);
                      final rid = SyncDataHandler.UpdateAppSyncItemRecord(
                          dbHandler, appSyncItem.id, appSyncItem);
                    }
                  }
                }
              }
              LogMessage(' downSyncMaxDates - Completed.');
            }
          }
        } else {
          final error = response.body;
          // Handle the error accordingly
          LogError('HTTP Error: $error');
        }
      }
    } catch (e) {
      // Handle any s that occur
      LogError('Error: SyncService: downSyncMaxDates() -> $e');
    } finally {
      ResetPageIndexes();
      currentdownload = '';
    }
  }

Future<void> downSyncAccounts(String typeOfData) async {
    try {
      if (await await Utility.isNetworkConnected() &&
          Globals.USER_TOKEN != '') {
        String url =
            AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountPaged';

        final dataItem = SyncDataHandler.GetAppSyncItemRecord(
            dbHandler,  typeOfData);
        if (dataItem != null && dataItem.records != '0') {
          int records = Globals.tryParseInt(dataItem.records);
          int pageSize = Globals.tryParseInt(dataItem.pgSize);
          int totalPages = (records / pageSize).ceil();

          int pageNow = Globals.tryParseInt(dataItem.page);
          AccountsPageCurrent = pageNow + 1;

          var postData = {
            'pageindex': AccountsPageCurrent,
            'pagesize': pageSize,
            'objectdate1': dataItem.lMaxDate,
            'objectdate2': dataItem.sMaxDate,
          };

          var headers = {
            'Authorization': 'Bearer ${Globals.USER_TOKEN}',
          };

          var response = await http.post(Uri.parse(url),
              headers: headers, body: jsonEncode(postData));
          if (response.statusCode == 200) {
            var jsonArray = jsonDecode(response.body) as List<dynamic>;
            for (var jsonObject in jsonArray) {
              var id = jsonObject['AccountID'].toString();
              var uid = jsonObject['Uid'].toString();
              var account = AccountDataHandler.GetMasterAccountRecord(
                  dbHandler,  id);
              if (account == null && doDoubleCheck && uid != '') {
                account = AccountDataHandler.GetAccountRecordByUid(
                    dbHandler,  uid);
              }

              if (account == null) {
                account = Account();
                account = JSONCopier.CopyJsonDataToAccount(
                     dbHandler, jsonObject, account, true);
                var rid = AccountDataHandlerBase.AddAccountRecord(
                    dbHandler, account);
              } else {
                var isUploaded = Globals.getStringValue(account.isUploaded);
                account = JSONCopier.CopyJsonDataToAccount(
                    dbHandler, jsonObject, account, false);
                account.isUploaded = isUploaded;
                var rid = AccountDataHandlerBase.UpdateAccountRecord(
                    dbHandler, account.id, account);
              }
            }

            bool isAllPagesDone = await update downSyncPageStatus(dataItem);
            if (isAllPagesDone) AccountsPageCurrent = 0;
          } else if (response.statusCode == 401) {
            // Handle authentication failure
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500 && response.statusCode < 600) {
            try {
              String errorResponse = utf8.decode(response.bodyBytes);
              LogError('Server Error: ${response.statusCode}\n$errorResponse');
            } catch (e) {
              LogError('Error decoding server error response: $e');
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    } catch (e) {
      LogError('Error: SyncService: downSyncAccount() 3-> $e');
    }
  }

Future<void> downSyncAccountAddresses(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountAddressPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountAddressesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountAddressesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountAddress accountAddress;
              var id = jsonObject['AccountAddressID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountAddress = AccountAddressDataHandler.GetMasterAccountAddressRecord(dbHandler,  id);
              }
              if (accountAddress == null && doDoubleCheck && uid.isNotEmpty) {
                accountAddress = AccountAddressDataHandler.GetAccountAddressRecordByUid(dbHandler,  uid);
              }

              if (accountAddress == null) {
                accountAddress = AccountAddress();
                accountAddress = JSONCopier.CopyJsonDataToAccountAddress( dbHandler, jsonObject, accountAddress, true);
                var rid = AccountAddressDataHandlerB.AddAccountAddressRecord(dbHandler,  accountAddress);
              } else {
                accountAddress = JSONCopier.CopyJsonDataToAccountAddress( dbHandler, jsonObject, accountAddress, false);
                var rid = AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddress);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountAddressesPageCurrent = 0;
        } 
        
        else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } 
        
        else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountAddress() 3-> $e');
  }
}


Future<void> downSyncAccountBusinessPlans(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountBusinessPlanPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountBusinessPlansPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBusinessPlansPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBusinessPlan accountBusinessPlan;
              var id = jsonObject['AccountBusinessPlanID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBusinessPlan = AccountBusinessPlanDataHandler.GetMasterAccountBusinessPlanRecord(dbHandler,  id);
              }
              if (accountBusinessPlan == null && doDoubleCheck && uid.isNotEmpty) {
                accountBusinessPlan = AccountBusinessPlanDataHandler.GetAccountBusinessPlanRecordByUid(dbHandler,  uid);
              }

              if (accountBusinessPlan == null) {
                accountBusinessPlan = AccountBusinessPlan();
                accountBusinessPlan = JSONCopier.CopyJsonDataToAccountBusinessPlan( dbHandler, jsonObject, accountBusinessPlan, true);
                var rid = AccountBusinessPlanDataHandler.AddAccountBusinessPlanRecord(dbHandler,  accountBusinessPlan);
              } else {
                accountBusinessPlan = JSONCopier.CopyJsonDataToAccountBusinessPlan( dbHandler, jsonObject, accountBusinessPlan, false);
                var rid = AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler,  accountBusinessPlan.id, accountBusinessPlan);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBusinessPlansPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountBusinessPlan() 3-> $e');
  }
}


Future<void> downSyncAccountBusinessUnits(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountBusinessUnitPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountBusinessUnitsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBusinessUnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {


          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBusinessUnit accountBusinessUnit;
              var id = jsonObject['AccountBusinessUnitID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBusinessUnit = AccountBusinessUnitDataHandler.GetMasterAccountBusinessUnitRecord(dbHandler,  id);
              }
              if (accountBusinessUnit == null && doDoubleCheck && uid.isNotEmpty) {
                accountBusinessUnit = AccountBusinessUnitDataHandler.GetAccountBusinessUnitRecordByUid(dbHandler,  uid);
              }

              if (accountBusinessUnit == null) {
                accountBusinessUnit = AccountBusinessUnit();
                accountBusinessUnit = JSONCopier.CopyJsonDataToAccountBusinessUnit( dbHandler, jsonObject, accountBusinessUnit, true);
                var rid = AccountBusinessUnitDataHandlerBase.AddAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit);
              } else {
                accountBusinessUnit = JSONCopier.CopyJsonDataToAccountBusinessUnit( dbHandler, jsonObject, accountBusinessUnit, false);
                var rid = AccountBusinessUnitDataHandlerBase.UpdateAccountBusinessUnitRecord(dbHandler,  accountBusinessUnit.id, accountBusinessUnit);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBusinessUnitsPageCurrent = 0;
        } 
        else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } 
        
        else if (response.statusCode >= 500 && response.statusCode < 600) {
          
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } 
          
          catch (e) {
            LogError('Error decoding server error response: $e');
          }


        } 

        else {
          resetRecordCount(dataItem);
        }

      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountBusinessUnit() 3-> $e');
  }
}


Future<void> downSyncAccountBuyingProcesses(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountBuyingProcessPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountBuyingProcessesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountBuyingProcessesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountBuyingProcess accountBuyingProcess;
              var id = jsonObject['AccountBuyingProcessID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountBuyingProcess = AccountBuyingProcessDataHandler.GetMasterAccountBuyingProcessRecord(dbHandler,  id);
              }
              if (accountBuyingProcess == null && doDoubleCheck && uid.isNotEmpty) {
                accountBuyingProcess = AccountBuyingProcessDataHandler.GetAccountBuyingProcessRecordByUid(dbHandler,  uid);
              }

              if (accountBuyingProcess == null) {
                accountBuyingProcess = AccountBuyingProcess();
                accountBuyingProcess = JSONCopier.CopyJsonDataToAccountBuyingProcess( dbHandler, jsonObject, accountBuyingProcess, true);
                var rid = AccountBuyingProcessDataHandler.AddAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess);
              } else {
                accountBuyingProcess = JSONCopier.CopyJsonDataToAccountBuyingProcess( dbHandler, jsonObject, accountBuyingProcess, false);
                var rid = AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountBuyingProcessesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountBuyingProcess() 3-> $e');
  }
}

Future<void> downSyncAccountCategories(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/ downSyncManager/GetAccountCategoryPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountCategoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountCategoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountCategory accountCategory;
              var id = jsonObject['AccountCategoryID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountCategory = AccountCategoryDataHandler.GetMasterAccountCategoryRecord(dbHandler,  id);
              }
              if (accountCategory == null && doDoubleCheck && uid.isNotEmpty) {
                accountCategory = AccountCategoryDataHandler.GetAccountCategoryRecordByUid(dbHandler,  uid);
              }

              if (accountCategory == null) {
                accountCategory = AccountCategory();
                accountCategory = JSONCopier.CopyJsonDataToAccountCategory( dbHandler, jsonObject, accountCategory, true);
                var rid = AccountCategoryDataHandler.AddAccountCategoryRecord(dbHandler,  accountCategory);
              } else {
                accountCategory = JSONCopier.CopyJsonDataToAccountCategory( dbHandler, jsonObject, accountCategory, false);
                var rid = AccountCategoryDataHandler.UpdateAccountCategoryRecord(dbHandler,  accountCategory.id, accountCategory);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountCategoriesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountCategory() 3-> $e');
  }
}


Future<void> downSyncAccountCategoryMappings(String typeOfData) async {
  try {
    if (await await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountCategoryMappingPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountCategoryMappingsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountCategoryMappingsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountCategoryMapping accountCategoryMapping;
              var id = jsonObject['AccountCategoryMappingID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountCategoryMapping = AccountCategoryMappingDataHandler.GetMasterAccountCategoryMappingRecord(dbHandler,  id);
              }
              if (accountCategoryMapping == null && doDoubleCheck && uid.isNotEmpty) {
                accountCategoryMapping = AccountCategoryMappingDataHandler.GetAccountCategoryMappingRecordByUid(dbHandler,  uid);
              }

              if (accountCategoryMapping == null) {
                accountCategoryMapping = AccountCategoryMapping();
                accountCategoryMapping = JSONCopier.CopyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, accountCategoryMapping, true);
                var rid = AccountCategoryMappingDataHandler.AddAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping);
              } else {
                accountCategoryMapping = JSONCopier.CopyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, accountCategoryMapping, false);
                var rid = AccountCategoryMappingDataHandler.UpdateAccountCategoryMappingRecord(dbHandler,  accountCategoryMapping.id, accountCategoryMapping);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountCategoryMappingsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountCategoryMapping() 3-> $e');
  }
}


Future<void> downSyncAccountCompetitionActivities(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountCompetitionActivityPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountCompetitionActivitiesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountCompetitionActivitiesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountCompetitionActivity accountCompetitionActivity;
              var id = jsonObject['AccountCompetitionActivityID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountCompetitionActivity = AccountCompetitionActivityDataHandler.GetMasterAccountCompetitionActivityRecord(dbHandler,  id);
              }
              if (accountCompetitionActivity == null && doDoubleCheck && uid.isNotEmpty) {
                accountCompetitionActivity = AccountCompetitionActivityDataHandler.GetAccountCompetitionActivityRecordByUid(dbHandler,  uid);
              }

              if (accountCompetitionActivity == null) {
                accountCompetitionActivity = AccountCompetitionActivity();
                accountCompetitionActivity = JSONCopier.copyJsonDataToAccountCompetitionActivity( dbHandler, jsonObject, accountCompetitionActivity, true);
                var rid = AccountCompetitionActivityDataHandler.AddAccountCompetitionActivityRecord(dbHandler,  accountCompetitionActivity);
              } else {
                accountCompetitionActivity = JSONCopier.copyJsonDataToAccountCompetitionActivity( dbHandler, jsonObject, accountCompetitionActivity, false);
                var rid = AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler,  accountCompetitionActivity.id, accountCompetitionActivity);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountCompetitionActivitiesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountCompetitionActivity() 3-> $e');
  }
}



Future<void> downSyncAccountForms(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountFormPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountFormsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountFormsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountForm accountForm;
              var id = jsonObject['AccountFormID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountForm = AccountFormDataHandler.GetMasterAccountFormRecord(dbHandler,  id);
              }
              if (accountForm == null && doDoubleCheck && uid.isNotEmpty) {
                accountForm = AccountFormDataHandler.GetAccountFormRecordByUid(dbHandler,  uid);
              }

              if (accountForm == null) {
                accountForm = AccountForm();
                accountForm = JSONCopier.CopyJsonDataToAccountForm( dbHandler, jsonObject, accountForm, true);
                var rid = AccountFormDataHandler.AddAccountFormRecord(dbHandler,  accountForm);
              } else {
                accountForm = JSONCopier.CopyJsonDataToAccountForm( dbHandler, jsonObject, accountForm, false);
                var rid = AccountFormDataHandler.UpdateAccountFormRecord(dbHandler,  accountForm.id, accountForm);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountFormsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountForm() 3-> $e');
  }
}


Future<void> downSyncAccountFormValues(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountFormValuePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountFormValuesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountFormValuesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountFormValue accountFormValue;
              var id = jsonObject['AccountFormValueID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountFormValue = AccountFormValueDataHandler.GetMasterAccountFormValueRecord(dbHandler,  id);
              }
              if (accountFormValue == null && doDoubleCheck && uid.isNotEmpty) {
                accountFormValue = AccountFormValueDataHandler.GetAccountFormValueRecordByUid(dbHandler,  uid);
              }

              if (accountFormValue == null) {
                accountFormValue = AccountFormValue();
                accountFormValue = JSONCopier.CopyJsonDataToAccountFormValue( dbHandler, jsonObject, accountFormValue, true);
                var rid = AccountFormValueDataHandler.AddAccountFormValueRecord(dbHandler,  accountFormValue);
              } else {
                accountFormValue = JSONCopier.CopyJsonDataToAccountFormValue( dbHandler, jsonObject, accountFormValue, false);
                var rid = AccountFormValueDataHandler.UpdateAccountFormValueRecord(dbHandler,  accountFormValue.id, accountFormValue);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountFormValuesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountFormValue() 3-> $e');
  }
}



Future<void> downSyncAccountMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountMediaPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountMedia accountMedia;
              var id = jsonObject['AccountMediaID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountMedia = AccountMediaDataHandler.GetMasterAccountMediaRecord(dbHandler,  id);
              }
              if (accountMedia == null && doDoubleCheck && uid.isNotEmpty) {
                accountMedia = AccountMediaDataHandler.GetAccountMediaRecordByUid(dbHandler,  uid);
              }

              if (accountMedia == null) {
                accountMedia = AccountMedia();
                accountMedia = JSONCopier.CopyJsonDataToAccountMedia( dbHandler, jsonObject, accountMedia, true);
                accountMedia.isUploaded = true;
                var rid = AccountMediaDataHandler.AddAccountMediaRecord(dbHandler,  accountMedia);
              } else {
                accountMedia = JSONCopier.CopyJsonDataToAccountMedia( dbHandler, jsonObject, accountMedia, false);
                var rid = AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountMediaPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountMedia() 3-> $e');
  }
}


Future<void> downSyncAccountPhones(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountPhonePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountPhonesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountPhonesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountPhone accountPhone;
              var id = jsonObject['AccountPhoneID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountPhone = AccountPhoneDataHandler.GetMasterAccountPhoneRecord(dbHandler,  id);
              }
              if (accountPhone == null && doDoubleCheck && uid.isNotEmpty) {
                accountPhone = AccountPhoneDataHandler.GetAccountPhoneRecordByUid(dbHandler,  uid);
              }

              if (accountPhone == null) {
                accountPhone = AccountPhone();
                accountPhone = JSONCopier.CopyJsonDataToAccountPhone( dbHandler, jsonObject, accountPhone, true);
                var rid = AccountPhoneDataHandler.AddAccountPhoneRecord(dbHandler,  accountPhone);
              } else {
                accountPhone = JSONCopier.CopyJsonDataToAccountPhone( dbHandler, jsonObject, accountPhone, false);
                var rid = AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhone);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountPhonesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountPhone() 3-> $e');
  }
}


Future<void> downSyncAccountSegments(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountSegmentPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountSegmentsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountSegmentsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountSegment accountSegment;
              var id = jsonObject['AccountSegmentID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountSegment = AccountSegmentDataHandler.GetMasterAccountSegmentRecord(dbHandler,  id);
              }
              if (accountSegment == null && doDoubleCheck && uid.isNotEmpty) {
                accountSegment = AccountSegmentDataHandler.GetAccountSegmentRecordByUid(dbHandler,  uid);
              }

              if (accountSegment == null) {
                accountSegment = AccountSegment();
                accountSegment = JSONCopier.CopyJsonDataToAccountSegment( dbHandler, jsonObject, accountSegment, true);
                var rid = AccountSegmentDataHandler.AddAccountSegmentRecord(dbHandler,  accountSegment);
              } else {
                accountSegment = JSONCopier.CopyJsonDataToAccountSegment( dbHandler, jsonObject, accountSegment, false);
                var rid = AccountSegmentDataHandler.UpdateAccountSegmentRecord(dbHandler,  accountSegment.id, accountSegment);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountSegmentsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountSegment() 3-> $e');
  }
}



Future<void> downSyncAccountStatuses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountStatusPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountStatusesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountStatusesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountStatus accountStatus;
              var id = jsonObject['AccountStatusID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountStatus = AccountStatusDataHandler.GetMasterAccountStatusRecord(dbHandler,  id);
              }
              if (accountStatus == null && doDoubleCheck && uid.isNotEmpty) {
                accountStatus = AccountStatusDataHandler.GetAccountStatusRecordByUid(dbHandler,  uid);
              }

              if (accountStatus == null) {
                accountStatus = AccountStatus();
                accountStatus = JSONCopier.CopyJsonDataToAccountStatus( dbHandler, jsonObject, accountStatus, true);
                var rid = AccountStatusDataHandler.AddAccountStatusRecord(dbHandler,  accountStatus);
              } else {
                accountStatus = JSONCopier.CopyJsonDataToAccountStatus( dbHandler, jsonObject, accountStatus, false);
                var rid = AccountStatusDataHandler.UpdateAccountStatusRecord(dbHandler,  accountStatus.id, accountStatus);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountStatusesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountStatus() 3-> $e');
  }
}



Future<void> downSyncAccountTerritories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountTerritoryPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountTerritoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountTerritoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountTerritory accountTerritory;
              var id = jsonObject['AccountTerritoryID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountTerritory = AccountTerritoryDataHandler.GetMasterAccountTerritoryRecord(dbHandler,  id);
              }
              if (accountTerritory == null && doDoubleCheck && uid.isNotEmpty) {
                accountTerritory = AccountTerritoryDataHandler.GetAccountTerritoryRecordByUid(dbHandler,  uid);
              }

              if (accountTerritory == null) {
                accountTerritory = AccountTerritory();
                accountTerritory = JSONCopier.CopyJsonDataToAccountTerritory( dbHandler, jsonObject, accountTerritory, true);
                var rid = AccountTerritoryDataHandler.AddAccountTerritoryRecord(dbHandler,  accountTerritory);
              } else {
                accountTerritory = JSONCopier.CopyJsonDataToAccountTerritory( dbHandler, jsonObject, accountTerritory, false);
                var rid = AccountTerritoryDataHandler.UpdateAccountTerritoryRecord(dbHandler,  accountTerritory.id, accountTerritory);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountTerritoriesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountTerritory() 3-> $e');
  }
}



Future<void> downSyncAccountTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAccountTypePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AccountTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AccountTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;
          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AccountType accountType;
              var id = jsonObject['AccountTypeID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                accountType = AccountTypeDataHandler.GetMasterAccountTypeRecord(dbHandler,  id);
              }
              if (accountType == null && doDoubleCheck && uid.isNotEmpty) {
                accountType = AccountTypeDataHandler.GetAccountTypeRecordByUid(dbHandler,  uid);
              }

              if (accountType == null) {
                accountType = AccountType();
                accountType = JSONCopier.CopyJsonDataToAccountType( dbHandler, jsonObject, accountType, true);
                var rid = AccountTypeDataHandler.AddAccountTypeRecord(dbHandler,  accountType);
              } else {
                accountType = JSONCopier.CopyJsonDataToAccountType( dbHandler, jsonObject, accountType, false);
                var rid = AccountTypeDataHandler.UpdateAccountTypeRecord(dbHandler,  accountType.id, accountType);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AccountTypesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAccountType() 3-> $e');
  }
}


Future<void> downSyncActivities(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivitiesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivitiesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          bool allAccountsPresent = chekPresenceOfAccountIDLocally(jsonArray);

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              Activity activity;
              var id = jsonObject['ActivityID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activity = ActivityDataHandler.GetMasterActivityRecord(dbHandler,  id);
              }
              if (activity == null && doDoubleCheck && uid.isNotEmpty) {
                activity = ActivityDataHandler.GetActivityRecordByUid(dbHandler,  uid);
              }

              if (activity == null) {
                activity = Activity();
                activity = JSONCopier.CopyJsonDataToActivity( dbHandler, jsonObject, activity, true);
                var rid = ActivityDataHandler.AddActivityRecord(dbHandler,  activity);

                if (activity.createdBy != Globals.AppUserLoginName &&
                    (isForCurrentDate(activity.createdOn) || isForCurrentDate(activity.modifiedOn))) {
                  //Create a reminder with 'New acivity assigned: ' + activity title. Time = current datetime + 2;
                  HSReminder().saveReminderData(
                    rid.toString(),
                    '',
                    'New activity assigned',
                    activity.activityTitle,
                    
                  );
                }
              } else {
                activity = JSONCopier.CopyJsonDataToActivity( dbHandler, jsonObject, activity, false);
                var rid = ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
              }
            }
          }

          if (allAccountsPresent) {
            bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
            if (isAllPagesDone) ActivitiesPageCurrent = 0;
          }
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivity() 3-> $e');
  }
}



Future<void> downSyncActivityApprovals(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityApprovalPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityApprovalsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityApprovalsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response =  await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityApproval activityApproval;
              var id = jsonObject['ActivityApprovalID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityApproval = ActivityApprovalDataHandler.GetMasterActivityApprovalRecord(dbHandler,  id);
              }
              if (activityApproval == null && doDoubleCheck && uid.isNotEmpty) {
                activityApproval = ActivityApprovalDataHandler.GetActivityApprovalRecordByUid(dbHandler,  uid);
              }

              if (activityApproval == null) {
                activityApproval = ActivityApproval();
                activityApproval = JSONCopier.CopyJsonDataToActivityApproval( dbHandler, jsonObject, activityApproval, true);
                var rid = ActivityApprovalDataHandler.AddActivityApprovalRecord(dbHandler,  activityApproval);
              } else {
                activityApproval = JSONCopier.CopyJsonDataToActivityApproval( dbHandler, jsonObject, activityApproval, false);
                var rid = ActivityApprovalDataHandler.UpdateActivityApprovalRecord(dbHandler,  activityApproval.id, activityApproval);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityApprovalsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityApproval() 3-> $e');
  }
}



Future<void> downSyncActivityApprovalTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityApprovalTypePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityApprovalTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityApprovalTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityApprovalType activityApprovalType;
              var id = jsonObject['ActivityApprovalTypeID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityApprovalType = ActivityApprovalTypeDataHandler.GetMasterActivityApprovalTypeRecord(dbHandler,  id);
              }
              if (activityApprovalType == null && doDoubleCheck && uid.isNotEmpty) {
                activityApprovalType = ActivityApprovalTypeDataHandler.GetActivityApprovalTypeRecordByUid(dbHandler,  uid);
              }

              if (activityApprovalType == null) {
                activityApprovalType = ActivityApprovalType();
                activityApprovalType = JSONCopier.CopyJsonDataToActivityApprovalType( dbHandler, jsonObject, activityApprovalType, true);
                var rid = ActivityApprovalTypeDataHandler.AddActivityApprovalTypeRecord(dbHandler,  activityApprovalType);
              } else {
                activityApprovalType = JSONCopier.CopyJsonDataToActivityApprovalType( dbHandler, jsonObject, activityApprovalType, false);
                var rid = ActivityApprovalTypeDataHandler.UpdateActivityApprovalTypeRecord(dbHandler,  activityApprovalType.id, activityApprovalType);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityApprovalTypesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityApprovalType() 3-> $e');
  }
}


Future<void> downSyncActivityMeasures(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityMeasurePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityMeasuresPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityMeasuresPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityMeasure activityMeasure;
              var id = jsonObject['ActivityMeasureID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityMeasure = ActivityMeasureDataHandler.GetMasterActivityMeasureRecord(dbHandler,  id);
              }
              if (activityMeasure == null && doDoubleCheck && uid.isNotEmpty) {
                activityMeasure = ActivityMeasureDataHandler.GetActivityMeasureRecordByUid(dbHandler,  uid);
              }

              if (activityMeasure == null) {
                activityMeasure = ActivityMeasure();
                activityMeasure = JSONCopier.CopyJsonDataToActivityMeasure( dbHandler, jsonObject, activityMeasure, true);
                var rid = ActivityMeasureDataHandler.AddActivityMeasureRecord(dbHandler,  activityMeasure);
              } else {
                activityMeasure = JSONCopier.CopyJsonDataToActivityMeasure( dbHandler, jsonObject, activityMeasure, false);
                var rid = ActivityMeasureDataHandler.UpdateActivityMeasureRecord(dbHandler,  activityMeasure.id, activityMeasure);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityMeasuresPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityMeasure() 3-> $e');
  }
}



Future<void> downSyncActivityBusinessUnits(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityBusinessUnitPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityBusinessUnitsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityBusinessUnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityBusinessunit activityBusinessUnit;
              var id = jsonObject['ActivityBusinessUnitID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityBusinessUnit = ActivityBusinessUnitDataHandler.GetMasterActivityBusinessUnitRecord(dbHandler,  id);
              }
              if (activityBusinessUnit == null && doDoubleCheck && uid.isNotEmpty) {
                activityBusinessUnit = ActivityBusinessUnitDataHandler.GetActivityBusinessUnitRecordByUid(dbHandler,  uid);
              }

              if (activityBusinessUnit == null) {
                activityBusinessUnit = ActivityBusinessUnit();
                activityBusinessUnit = JSONCopier.CopyJsonDataToActivityBusinessUnit( dbHandler, jsonObject, activityBusinessUnit, true);
                var rid = ActivityBusinessUnitDataHandler.AddActivityBusinessUnitRecord(dbHandler,  activityBusinessUnit);
              } else {
                activityBusinessUnit = JSONCopier.CopyJsonDataToActivityBusinessUnit( dbHandler, jsonObject, activityBusinessUnit, false);
                var rid = ActivityBusinessUnitDataHandler.UpdateActivityBusinessUnitRecord(dbHandler,  activityBusinessUnit.id, activityBusinessUnit);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityBusinessUnitsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityBusinessUnit() 3-> $e');
  }
}



Future<void> downSyncActivityMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityMediaPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityMedia activityMedia;
              var id = jsonObject['ActivityMediaID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityMedia = ActivityMediaDataHandler.GetMasterActivityMediaRecord(dbHandler,  id);
              }
              if (activityMedia == null && doDoubleCheck && uid.isNotEmpty) {
                activityMedia = ActivityMediaDataHandler.GetActivityMediaRecordByUid(dbHandler,  uid);
              }

              if (activityMedia == null) {
                activityMedia = ActivityMedia();
                activityMedia = JSONCopier.CopyJsonDataToActivityMedia( dbHandler, jsonObject, activityMedia, true);
                activityMedia.setIsUploaded('true');
                var rid = ActivityMediaDataHandler.AddActivityMediaRecord(dbHandler,  activityMedia);
              } else {
                // String isUploaded = Globals.GetStringValue(activityMedia.getIsUploaded()); //Save the uploaded status
                // Log.d("AMEDIA-UPLD", isUploaded);
                activityMedia = JSONCopier.CopyJsonDataToActivityMedia( dbHandler, jsonObject, activityMedia, false);
                //activityMedia.setIsUploaded(isUploaded);
                var rid = ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler,  activityMedia.id, activityMedia);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityMediaPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityMedia() 3-> $e');
  }
}


Future<void> downSyncActivityPermissions(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityPermissionPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityPermissionsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityPermissionsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityPermission activityPermission;
              var id = jsonObject['ActivityPermissionID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityPermission = ActivityPermissionDataHandler.GetMasterActivityPermissionRecord(dbHandler,  id);
              }
              if (activityPermission == null && doDoubleCheck && uid.isNotEmpty) {
                activityPermission = ActivityPermissionDataHandler.GetActivityPermissionRecordByUid(dbHandler,  uid);
              }

              if (activityPermission == null) {
                activityPermission = ActivityPermission();
                activityPermission = JSONCopier.CopyJsonDataToActivityPermission( dbHandler, jsonObject, activityPermission, true);
                var rid = ActivityPermissionDataHandler.AddActivityPermissionRecord(dbHandler,  activityPermission);
              } else {
                activityPermission = JSONCopier.CopyJsonDataToActivityPermission( dbHandler, jsonObject, activityPermission, false);
                var rid = ActivityPermissionDataHandler.UpdateActivityPermissionRecord(dbHandler,  activityPermission.id, activityPermission);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityPermissionsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityPermission() 3-> $e');
  }
}


Future<void> downSyncActivityPriorities(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityPriorityPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityPrioritiesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityPrioritiesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityPriority activityPriority;
              var id = jsonObject['ActivityPriorityID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityPriority = ActivityPriorityDataHandlerBase.getMasterActivityPriorityRecord(dbHandler,  id);
              }
              if (activityPriority == null && doDoubleCheck && uid.isNotEmpty) {
                activityPriority = ActivityPriorityDataHandlerBase.GetActivityPriorityRecordByUid(dbHandler,  uid);
              }

              if (activityPriority == null) {
                activityPriority = ActivityPriority();
                activityPriority = JSONCopier.CopyJsonDataToActivityPriority( dbHandler, jsonObject, activityPriority, true);
                var rid = ActivityPriorityDataHandlerBase.AddActivityPriorityRecord(dbHandler,  activityPriority);
              } else {
                activityPriority = JSONCopier.CopyJsonDataToActivityPriority( dbHandler, jsonObject, activityPriority, false);
                var rid = ActivityPriorityDataHandlerBase.UpdateActivityPriorityRecord(dbHandler,  activityPriority.id, activityPriority);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityPrioritiesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityPriority() 3-> $e');
  }
}


Future<void> downSyncActivityProducts(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityProductPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityProductsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityProductsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityProduct activityProduct;
              var id = jsonObject['ActivityProductID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityProduct = ActivityProductDataHandler.GetMasterActivityProductRecord(dbHandler,  id);
              }
              if (activityProduct == null && doDoubleCheck && uid.isNotEmpty) {
                activityProduct = ActivityProductDataHandler.GetActivityProductRecordByUid(dbHandler,  uid);
              }

              if (activityProduct == null) {
                activityProduct = ActivityProduct();
                activityProduct = JSONCopier.CopyJsonDataToActivityProduct( dbHandler, jsonObject, activityProduct, true);
                var rid = ActivityProductDataHandler.AddActivityProductRecord(dbHandler,  activityProduct);
              } else {
                activityProduct = JSONCopier.CopyJsonDataToActivityProduct( dbHandler, jsonObject, activityProduct, false);
                var rid = ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler,  activityProduct.id, activityProduct);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityProductsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityProduct() 3-> $e');
  }
}


Future<void> downSyncActivityProductDetails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityProductDetailPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityProductDetailsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityProductDetailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityProductDetail activityProductDetail;
              var id = jsonObject['ActivityProductDetailID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityProductDetail = ActivityProductDetailDataHandler.GetMasterActivityProductDetailRecord(dbHandler,  id);
              }
              if (activityProductDetail == null && doDoubleCheck && uid.isNotEmpty) {
                activityProductDetail = ActivityProductDetailDataHandler.GetActivityProductDetailRecordByUid(dbHandler,  uid);
              }

              if (activityProductDetail == null) {
                activityProductDetail = ActivityProductDetail();
                activityProductDetail = JSONCopier.CopyJsonDataToActivityProductDetail( dbHandler, jsonObject, activityProductDetail, true);
                var rid = ActivityProductDetailDataHandler.AddActivityProductDetailRecord(dbHandler,  activityProductDetail);
              } else {
                activityProductDetail = JSONCopier.CopyJsonDataToActivityProductDetail( dbHandler, jsonObject, activityProductDetail, false);
                var rid = ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.id, activityProductDetail);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityProductDetailsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityProductDetail() 3-> $e');
  }
}


Future<void> downSyncActivityStatuses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityStatusPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityStatusesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityStatusesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityStatus activityStatus;
              var id = jsonObject['ActivityStatusID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityStatus = ActivityStatusDataHandler.GetMasterActivityStatusRecord(dbHandler,  id);
              }
              if (activityStatus == null && doDoubleCheck && uid.isNotEmpty) {
                activityStatus = ActivityStatusDataHandler.GetActivityStatusRecordByUid(dbHandler,  uid);
              }

              if (activityStatus == null) {
                activityStatus = ActivityStatus();
                activityStatus = JSONCopier.CopyJsonDataToActivityStatus( dbHandler, jsonObject, activityStatus, true);
                var rid = ActivityStatusDataHandler.AddActivityStatusRecord(dbHandler,  activityStatus);
              } else {
                activityStatus = JSONCopier.CopyJsonDataToActivityStatus( dbHandler, jsonObject, activityStatus, false);
                var rid = ActivityStatusDataHandler.UpdateActivityStatusRecord(dbHandler,  activityStatus.id, activityStatus);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityStatusesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityStatus() 3-> $e');
  }
}


Future<void> downSyncActivityTeams(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTeamPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTeamsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTeamsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityTeam activityTeam;
              var id = jsonObject['ActivityTeamID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityTeam = ActivityTeamDataHandler.GetMasterActivityTeamRecord(dbHandler,  id);
              }
              if (activityTeam == null && doDoubleCheck && uid.isNotEmpty) {
                activityTeam = ActivityTeamDataHandler.GetActivityTeamRecordByUid(dbHandler,  uid);
              }

              if (activityTeam == null) {
                activityTeam = ActivityTeam();
                activityTeam = JSONCopier.CopyJsonDataToActivityTeam( dbHandler, jsonObject, activityTeam, true);
                var rid = ActivityTeamDataHandler.AddActivityTeamRecord(dbHandler,  activityTeam);
              } else {
                activityTeam = JSONCopier.CopyJsonDataToActivityTeam( dbHandler, jsonObject, activityTeam, false);
                var rid = ActivityTeamDataHandler.UpdateActivityTeamRecord(dbHandler,  activityTeam.id, activityTeam);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTeamsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityTeam() 3-> $e');
  }
}


Future<void> downSyncActivityTravels(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTravelPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTravelsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTravelsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityTravel activityTravel;
              var id = jsonObject['ActivityTravelID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityTravel = ActivityTravelDataHandler.GetMasterActivityTravelRecord(dbHandler,  id);
              }
              if (activityTravel == null && doDoubleCheck && uid.isNotEmpty) {
                activityTravel = ActivityTravelDataHandler.GetActivityTravelRecordByUid(dbHandler,  uid);
              }

              if (activityTravel == null) {
                activityTravel = ActivityTravel();
                activityTravel = JSONCopier.CopyJsonDataToActivityTravel( dbHandler, jsonObject, activityTravel, true);
                var rid = ActivityTravelDataHandler.AddActivityTravelRecord(dbHandler,  activityTravel);
              } else {
                activityTravel = JSONCopier.CopyJsonDataToActivityTravel( dbHandler, jsonObject, activityTravel, false);
                var rid = ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler,  activityTravel.id, activityTravel);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTravelsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityTravel() 3-> $e');
  }
}


Future<void> downSyncActivityTravelExpenses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTravelExpensePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTravelExpensesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTravelExpensesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityTravelExpense activityTravelExpense;
              var id = jsonObject['ActivityTravelExpenseID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityTravelExpense = ActivityTravelExpenseDataHandler.GetMasterActivityTravelExpenseRecord(dbHandler,  id);
              }
              if (activityTravelExpense == null && doDoubleCheck && uid.isNotEmpty) {
                activityTravelExpense = ActivityTravelExpenseDataHandler.GetActivityTravelExpenseRecordByUid(dbHandler,  uid);
              }

              if (activityTravelExpense == null) {
                activityTravelExpense = ActivityTravelExpense();
                activityTravelExpense = JSONCopier.CopyJsonDataToActivityTravelExpense( dbHandler, jsonObject, activityTravelExpense, true);
                var rid = ActivityTravelExpenseDataHandler.AddActivityTravelExpenseRecord(dbHandler,  activityTravelExpense);
              } else {
                activityTravelExpense = JSONCopier.CopyJsonDataToActivityTravelExpense( dbHandler, jsonObject, activityTravelExpense, false);
                var rid = ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler,  activityTravelExpense.id, activityTravelExpense);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTravelExpensesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityTravelExpense() 3-> $e');
  }
}


Future<void> downSyncActivityTravelMappings(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTravelMappingPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTravelMappingsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTravelMappingsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityTravelMapping activityTravelMapping;
              var id = jsonObject['ActivityTravelMappingID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityTravelMapping = ActivityTravelMappingDataHandler.GetMasterActivityTravelMappingRecord(dbHandler,  id);
              }
              if (activityTravelMapping == null && doDoubleCheck && uid.isNotEmpty) {
                activityTravelMapping = ActivityTravelMappingDataHandler.GetActivityTravelMappingRecordByUid(dbHandler,  uid);
              }

              if (activityTravelMapping == null) {
                activityTravelMapping = ActivityTravelMapping();
                activityTravelMapping = JSONCopier.CopyJsonDataToActivityTravelMapping( dbHandler, jsonObject, activityTravelMapping, true);
                var rid = ActivityTravelMappingDataHandler.AddActivityTravelMappingRecord(dbHandler,  activityTravelMapping);
              } else {
                activityTravelMapping = JSONCopier.CopyJsonDataToActivityTravelMapping( dbHandler, jsonObject, activityTravelMapping, false);
                var rid = ActivityTravelMappingDataHandler.UpdateActivityTravelMappingRecord(dbHandler,  activityTravelMapping.id, activityTravelMapping);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTravelMappingsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityTravelMapping() 3-> $e');
  }
}


Future<void> downSyncActivityTravelMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTravelMediaPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTravelMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTravelMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityTravelMedia activityTravelMedia;
              var id = jsonObject['ActivityTravelMediaID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityTravelMedia = ActivityTravelMediaDataHandler.GetMasterActivityTravelMediaRecord(dbHandler,  id);
              }
              if (activityTravelMedia == null && doDoubleCheck && uid.isNotEmpty) {
                activityTravelMedia = ActivityTravelMediaDataHandler.GetActivityTravelMediaRecordByUid(dbHandler,  uid);
              }

              if (activityTravelMedia == null) {
                activityTravelMedia = ActivityTravelMedia();
                activityTravelMedia = JSONCopier.CopyJsonDataToActivityTravelMedia( dbHandler, jsonObject, activityTravelMedia, true);
                activityTravelMedia.isUploaded = true;
                var rid = ActivityTravelMediaDataHandler.AddActivityTravelMediaRecord(dbHandler,  activityTravelMedia);
              } else {
                activityTravelMedia = JSONCopier.CopyJsonDataToActivityTravelMedia( dbHandler, jsonObject, activityTravelMedia, false);
                var rid = ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler,  activityTravelMedia.id, activityTravelMedia);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTravelMediaPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityTravelMedia() 3-> $e');
  }
}


Future<void> downSyncActivityTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetActivityTypePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ActivityTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ActivityTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          Globals.DisplayData('ACTTYPES', jsonArray);

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              ActivityType activityType;
              var id = jsonObject['ActivityTypeID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                activityType = ActivityTypeDataHandlerBase.GetMasterActivityTypeRecord(dbHandler,  id);
              }
              if (activityType == null && doDoubleCheck && uid.isNotEmpty) {
                activityType = ActivityTypeDataHandlerBase.GetActivityTypeRecordByUid(dbHandler,  uid);
              }

              if (activityType == null) {
                activityType = ActivityType();
                activityType = JSONCopier.CopyJsonDataToActivityType( dbHandler, jsonObject, activityType, true);
                var rid = ActivityTypeDataHandlerBase.AddActivityTypeRecord(dbHandler,  activityType);
              } else {
                activityType = JSONCopier.CopyJsonDataToActivityType( dbHandler, jsonObject, activityType, false);
                var rid = ActivityTypeDataHandlerBase.UpdateActivityTypeRecord(dbHandler,  activityType.id, activityType);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) ActivityTypesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          resetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncActivityType() 3-> $e');
  }
}

Future<void> downSyncAddressTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAddressTypePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AddressTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AddressTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AddressType addressType;
              var id = jsonObject['AddressTypeID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                addressType = AddressTypeDataHandler.GetMasterAddressTypeRecord(dbHandler,  id);
              }
              if (addressType == null && doDoubleCheck && uid.isNotEmpty) {
                addressType = AddressTypeDataHandler.GetAddressTypeRecordByUid(dbHandler,  uid);
              }

              if (addressType == null) {
                addressType = AddressType();
                addressType = JSONCopier.CopyJsonDataToAddressType( dbHandler, jsonObject, addressType, true);
                var rid = AddressTypeDataHandler.AddAddressTypeRecord(dbHandler,  addressType);
              } else {
                addressType = JSONCopier.CopyJsonDataToAddressType( dbHandler, jsonObject, addressType, false);
                var rid = AddressTypeDataHandler.UpdateAddressTypeRecord(dbHandler,  addressType.id, addressType);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AddressTypesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAddressType() 3-> $e');
  }
}


Future<void> downSyncAppFeatures(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAppFeaturePaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppFeaturesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppFeaturesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppFeature appFeature;
              var id = jsonObject['AppFeatureID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appFeature = AppFeatureDataHandler.GetMasterAppFeatureRecord(dbHandler,  id);
              }
              if (appFeature == null && doDoubleCheck && uid.isNotEmpty) {
                appFeature = AppFeatureDataHandler.GetAppFeatureRecordByUid(dbHandler,  uid);
              }

              if (appFeature == null) {
                appFeature = AppFeature();
                appFeature = JSONCopier.CopyJsonDataToAppFeature( dbHandler, jsonObject, appFeature, true);
                var rid = AppFeatureDataHandler.AddAppFeatureRecord(dbHandler,  appFeature);
              } else {
                appFeature = JSONCopier.CopyJsonDataToAppFeature( dbHandler, jsonObject, appFeature, false);
                var rid = AppFeatureDataHandler.UpdateAppFeatureRecord(dbHandler,  appFeature.id, appFeature);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppFeaturesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAppFeature() 3-> $e');
  }
}


Future<void> downSyncAppFeatureFields(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/ downSyncManager/GetAppFeatureFieldPaged';

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppFeatureFieldsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppFeatureFieldsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppFeatureField appFeatureField;
              var id = jsonObject['AppFeatureFieldID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appFeatureField = AppFeatureFieldDataHandler.GetMasterAppFeatureFieldRecord(dbHandler,  id);
              }
              if (appFeatureField == null && doDoubleCheck && uid.isNotEmpty) {
                appFeatureField = AppFeatureFieldDataHandler.GetAppFeatureFieldRecordByUid(dbHandler,  uid);
              }

              if (appFeatureField == null) {
                appFeatureField = AppFeatureField();
                appFeatureField = JSONCopier.CopyJsonDataToAppFeatureField( dbHandler, jsonObject, appFeatureField, true);
                var rid = AppFeatureFieldDataHandler.AddAppFeatureFieldRecord(dbHandler,  appFeatureField);
              } else {
                appFeatureField = JSONCopier.CopyJsonDataToAppFeatureField( dbHandler, jsonObject, appFeatureField, false);
                var rid = AppFeatureFieldDataHandler.UpdateAppFeatureFieldRecord(dbHandler,  appFeatureField.id, appFeatureField);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppFeatureFieldsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncAppFeatureField() 3-> $e');
  }
}

Future<void> downSyncAppFeatureGroups(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/ downSyncManager/GetAppFeatureGroupPaged";

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppFeatureGroupsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppFeatureGroupsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppFeatureGroup appFeatureGroup;
              var id = jsonObject['AppFeatureGroupID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appFeatureGroup = AppFeatureGroupDataHandler.GetMasterAppFeatureGroupRecord(dbHandler,  id);
              }
              if (appFeatureGroup == null && doDoubleCheck && uid.isNotEmpty) {
                appFeatureGroup = AppFeatureGroupDataHandler.GetAppFeatureGroupRecordByUid(dbHandler,  uid);
              }

              if (appFeatureGroup == null) {
                appFeatureGroup = AppFeatureGroup();
                appFeatureGroup = JSONCopier.CopyJsonDataToAppFeatureGroup( dbHandler, jsonObject, appFeatureGroup, true);
                var rid = AppFeatureGroupDataHandler.AddAppFeatureGroupRecord(dbHandler,  appFeatureGroup);
              } else {
                appFeatureGroup = JSONCopier.CopyJsonDataToAppFeatureGroup( dbHandler, jsonObject, appFeatureGroup, false);
                var rid = AppFeatureGroupDataHandler.UpdateAppFeatureGroupRecord(dbHandler,  appFeatureGroup.id, appFeatureGroup);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppFeatureGroupsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:downSyncAppFeatureGroups() 3-> $e');
  }
}


Future<void> downSyncAppReports(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/ downSyncManager/GetAppReportPaged";

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppReportsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppReportsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppReport appReport;
              var id = jsonObject['AppReportID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appReport = AppReportDataHandler.GetMasterAppReportRecord(dbHandler,  id);
              }
              if (appReport == null && doDoubleCheck && uid.isNotEmpty) {
                appReport = AppReportDataHandler.GetAppReportRecordByUid(dbHandler,  uid);
              }

              if (appReport == null) {
                appReport = AppReport();
                appReport = JSONCopier.CopyJsonDataToAppReport( dbHandler, jsonObject, appReport, true);
                var rid = AppReportDataHandler.AddAppReportRecord(dbHandler,  appReport);
              } else {
                appReport = JSONCopier.CopyJsonDataToAppReport( dbHandler, jsonObject, appReport, false);
                var rid = AppReportDataHandler.UpdateAppReportRecord(dbHandler,  appReport.id, appReport);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppReportsPageCurrent = 0;
          
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:downSyncAppReports() 3-> $e');
  }
}


Future<void> downSyncAppUsers(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/ downSyncManager/GetAppUserPaged";

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppUsersPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppUsersPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppUser appUser;
              var id = jsonObject['AppUserID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appUser = AppUserDataHandler.GetMasterAppUserRecord(dbHandler,  id);
              }
              if (appUser == null && doDoubleCheck && uid.isNotEmpty) {
                appUser = AppUserDataHandler.GetAppUserRecordByUid(dbHandler,  uid);
              }

              if (appUser == null) {
                appUser = AppUser();
                appUser = JSONCopier.CopyJsonDataToAppUser( dbHandler, jsonObject, appUser, true);
                var rid = AppUserDataHandler.AddAppUserRecord(dbHandler,  appUser);
              } else {
                appUser = JSONCopier.CopyJsonDataToAppUser( dbHandler, jsonObject, appUser, false);
                var rid = AppUserDataHandler.UpdateAppUserRecord(dbHandler,  appUser.id, appUser);

                //Remove user data, if REMOVE WIPE enabled
                if (Globals.GetStringValue(appUser.getIsWor()).toLowerCase() == 'true') {
                  try {
                    var appUserList = AppUserDataHandler.GetAppUserRecords(dbHandler,  '');
                    if (appUserList.length > 1) {
                      dbHandler.RemoveUserData(appUser.getAppUserID(), appUser.getAppUserGroupID());
                    } else {
                      dbHandler.RemoveTables();
                    }
                    Globals.ClearUserSession();
                    Globals.USER_TOKEN = '';
                  } catch (e1) {}
                }

                //To force user to re-login
                if (Globals.GetStringValue(appUser.getIsActive()).toLowerCase() == 'false' ||
                    Globals.GetStringValue(appUser.getAppLastLoginOn()).contains('2000')) {
                  Globals.ClearUserSession();
                }
              }

              Globals.AppUserObjectChanged = true;
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppUsersPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:downSyncAppUser() 3-> $e');
  }
}


Future<void> downSyncAppUserLocations(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/ downSyncManager/GetAppUserLocationPaged";

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppUserLocationsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppUserLocationsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppUserLocation appUserLocation;
              var id = jsonObject['AppUserLocationID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appUserLocation = AppUserLocationDataHandler.GetMasterAppUserLocationRecord(dbHandler,  id);
              }
              if (appUserLocation == null && doDoubleCheck && uid.isNotEmpty) {
                appUserLocation = AppUserLocationDataHandler.GetAppUserLocationRecordByUid(dbHandler,  uid);
              }

              if (appUserLocation == null) {
                appUserLocation = AppUserLocation();
                appUserLocation = JSONCopier.CopyJsonDataToAppUserLocation( dbHandler, jsonObject, appUserLocation, true);
                var rid = AppUserLocationDataHandler.AddAppUserLocationRecord(dbHandler,  appUserLocation);
              }
              /*else {
                appUserLocation = JSONCopier.CopyJsonDataToAppUserLocation( dbHandler, jsonObject, appUserLocation, false);
                var rid = AppUserLocationDataHandler.UpdateAppUserLocationRecord(dbHandler,  appUserLocation.id, appUserLocation);
              }*/
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppUserLocationsPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:downSyncAppUserLocation() 3-> $e');
  }
}


Future<void> downSyncAppUserMessages(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/ downSyncManager/GetAppUserMessagePaged";

      final dataItem = await SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        AppUserMessagesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': AppUserMessagesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        var headers = {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        };

        var response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(postData));
        if (response.statusCode == 200) {
          var jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (var jsonObject in jsonArray) {
            if (jsonObject != null) {
              AppUserMessage appUserMessage;
              var id = jsonObject['AppUserMessageID'].toString();
              var uid = jsonObject['Uid'].toString();
              if (id.isNotEmpty) {
                appUserMessage = AppUserMessageDataHandler.GetMasterAppUserMessageRecord(dbHandler,  id);
              }
              if (appUserMessage == null && doDoubleCheck && uid.isNotEmpty) {
                appUserMessage = AppUserMessageDataHandler.GetAppUserMessageRecordByUid(dbHandler,  uid);
              }

              if (appUserMessage == null) {
                appUserMessage = AppUserMessage();
                appUserMessage = JSONCopier.CopyJsonDataToAppUserMessage( dbHandler, jsonObject, appUserMessage, true);
                var rid = AppUserMessageDataHandler.AddAppUserMessageRecord(dbHandler,  appUserMessage);
              } else {
                appUserMessage = JSONCopier.CopyJsonDataToAppUserMessage( dbHandler, jsonObject, appUserMessage, false);
                var rid = AppUserMessageDataHandler.UpdateAppUserMessageRecord(dbHandler,  appUserMessage.id, appUserMessage);
              }
            }
          }

          bool isAllPagesDone = await Update downSyncPageStatus(dataItem);
          if (isAllPagesDone) AppUserMessagesPageCurrent = 0;
        } else if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500 && response.statusCode < 600) {
          try {
            String errorResponse = utf8.decode(response.bodyBytes);
            LogError('Server Error: ${response.statusCode}\n$errorResponse');
          } catch (e) {
            LogError('Error decoding server error response: $e');
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:downSyncAppUserMessage() 3-> $e');
  }
}


Future<void> downSyncAppUserLocations(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserLocationPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserLocationsPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserLocationsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AppUserLocation? appUserLocation;
                final id = jsonObject['AppUserLocationID'];
                final uid = jsonObject['Uid'];
                if (id != null && id.isNotEmpty) {
                  appUserLocation = AppUserLocationDataHandler.getMasterAppUserLocationRecord(dbHandler,  id);
                }
                if (appUserLocation == null && doDoubleCheck && uid != null && uid.isNotEmpty) {
                  appUserLocation = AppUserLocationDataHandler.getAppUserLocationRecordByUid(dbHandler,  uid);
                }
                if (appUserLocation == null) {
                  appUserLocation = AppUserLocation();
                  appUserLocation = JSONCopier.copyJsonDataToAppUserLocation( dbHandler, jsonObject, appUserLocation, true);
                  final rid = AppUserLocationDataHandler.addAppUserLocationRecord(dbHandler,  appUserLocation);
                } else {
                  appUserLocation = JSONCopier.copyJsonDataToAppUserLocation( dbHandler, jsonObject, appUserLocation, false);
                  final rid = AppUserLocationDataHandler.updateAppUserLocationRecord(dbHandler,  appUserLocation.id, appUserLocation);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserLocationsPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserLocations() 3-> $e');
  }
}


Future<void> downSyncAppUserRemarks(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserRemarkPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserRemarksPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserRemarksPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                final id = jsonObject['AppUserRemarkID'];
                if (id != null && id.isNotEmpty) {
                  AppUserRemark? appUserRemark =
                      AppUserRemarkDataHandler.getMasterAppUserRemarkRecord(dbHandler,  id);
                  if (appUserRemark == null) {
                    appUserRemark = AppUserRemark();
                    appUserRemark = JSONCopier.copyJsonDataToAppUserRemark( dbHandler, jsonObject, appUserRemark, true);
                    final rid = AppUserRemarkDataHandler.addAppUserRemarkRecord(dbHandler,  appUserRemark);
                  } else {
                    appUserRemark = JSONCopier.copyJsonDataToAppUserRemark( dbHandler, jsonObject, appUserRemark, false);
                    final rid = AppUserRemarkDataHandler.updateAppUserRemarkRecord(dbHandler,  appUserRemark.id, appUserRemark);
                  }
                }
              }
            }

            final isAllPagesDone = updatedownSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserRemarksPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserRemark() 3-> $e');
  }
}



Future<void> downSyncAppUserTeams(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserTeamPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserTeamsPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserTeamsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AppUserTeam? appUserTeam;
                final id = jsonObject['AppUserTeamID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  appUserTeam = AppUserTeamDataHandler.getMasterAppUserTeamRecord(dbHandler,  id);
                }
                if (appUserTeam == null && doDoubleCheck && uid.isNotEmpty) {
                  appUserTeam = AppUserTeamDataHandler.getAppUserTeamRecordByUid(dbHandler,  uid);
                }
                if (appUserTeam == null) {
                  appUserTeam = AppUserTeam();
                  appUserTeam = JSONCopier.copyJsonDataToAppUserTeam( dbHandler, jsonObject, appUserTeam, true);
                  final rid = AppUserTeamDataHandler.addAppUserTeamRecord(dbHandler,  appUserTeam);
                } else {
                  appUserTeam = JSONCopier.copyJsonDataToAppUserTeam( dbHandler, jsonObject, appUserTeam, false);
                  final rid = AppUserTeamDataHandler.updateAppUserTeamRecord(dbHandler,  appUserTeam.id, appUserTeam);
                }
              }
            }

            final isAllPagesDone = updatedownSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserTeamsPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserTeam() 3-> $e');
  }
}


Future<void> downSyncAppUserTeamMembers(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserTeamMemberPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserTeamMembersPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserTeamMembersPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AppUserTeamMember? appUserTeamMember;
                final id = jsonObject['AppUserTeamMemberID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  appUserTeamMember = AppUserTeamMemberDataHandler.getMasterAppUserTeamMemberRecord(dbHandler,  id);
                }
                if (appUserTeamMember == null && doDoubleCheck && uid.isNotEmpty) {
                  appUserTeamMember = AppUserTeamMemberDataHandler.getAppUserTeamMemberRecordByUid(dbHandler,  uid);
                }
                if (appUserTeamMember == null) {
                  appUserTeamMember = AppUserTeamMember();
                  appUserTeamMember = JSONCopier.copyJsonDataToAppUserTeamMember( dbHandler, jsonObject, appUserTeamMember, true);
                  final rid = AppUserTeamMemberDataHandler.addAppUserTeamMemberRecord(dbHandler,  appUserTeamMember);
                } else {
                  appUserTeamMember = JSONCopier.copyJsonDataToAppUserTeamMember( dbHandler, jsonObject, appUserTeamMember, false);
                  final rid = AppUserTeamMemberDataHandler.updateAppUserTeamMemberRecord(dbHandler,  appUserTeamMember.id, appUserTeamMember);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserTeamMembersPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserTeamMember() 3-> $e');
  }
}


Future<void> downSyncAppUserTerritories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserTerritoryPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserTerritoriesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserTerritoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AppUserTerritory? appUserTerritory;
                final id = jsonObject['AppUserTerritoryID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  appUserTerritory = AppUserTerritoryDataHandler.getMasterAppUserTerritoryRecord(dbHandler,  id);
                }
                if (appUserTerritory == null && doDoubleCheck && uid.isNotEmpty) {
                  appUserTerritory = AppUserTerritoryDataHandler.getAppUserTerritoryRecordByUid(dbHandler,  uid);
                }
                if (appUserTerritory == null) {
                  appUserTerritory = AppUserTerritory();
                  appUserTerritory = JSONCopier.copyJsonDataToAppUserTerritory( dbHandler, jsonObject, appUserTerritory, true);
                  final rid = AppUserTerritoryDataHandler.addAppUserTerritoryRecord(dbHandler,  appUserTerritory);
                } else {
                  appUserTerritory = JSONCopier.copyJsonDataToAppUserTerritory( dbHandler, jsonObject, appUserTerritory, false);
                  final rid = AppUserTerritoryDataHandler.updateAppUserTerritoryRecord(dbHandler,  appUserTerritory.id, appUserTerritory);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserTerritoriesPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserTerritory() 3-> $e');
  }
}


Future<void> downSyncAppUserTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAppUserTypePaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AppUserTypesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AppUserTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AppUserType? appUserType;
                final id = jsonObject['AppUserTypeID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  appUserType = AppUserTypeDataHandler.getMasterAppUserTypeRecord(dbHandler,  id);
                }
                if (appUserType == null && doDoubleCheck && uid.isNotEmpty) {
                  appUserType = AppUserTypeDataHandler.getAppUserTypeRecordByUid(dbHandler,  uid);
                }
                if (appUserType == null) {
                  appUserType = AppUserType();
                  appUserType = JSONCopier.copyJsonDataToAppUserType( dbHandler, jsonObject, appUserType, true);
                  final rid = AppUserTypeDataHandler.addAppUserTypeRecord(dbHandler,  appUserType);
                } else {
                  appUserType = JSONCopier.copyJsonDataToAppUserType( dbHandler, jsonObject, appUserType, false);
                  final rid = AppUserTypeDataHandler.updateAppUserTypeRecord(dbHandler,  appUserType.id, appUserType);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AppUserTypesPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAppUserType() 3-> $e');
  }
}


Future<void> downSyncAttributes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAttributePaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AttributesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AttributesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                Attribute? attribute;
                final id = jsonObject['AttributeID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  attribute = AttributeDataHandler.getMasterAttributeRecord(dbHandler,  id);
                }
                if (attribute == null && doDoubleCheck && uid.isNotEmpty) {
                  attribute = AttributeDataHandler.getAttributeRecordByUid(dbHandler,  uid);
                }
                if (attribute == null) {
                  attribute = Attribute();
                  attribute = JSONCopier.copyJsonDataToAttribute( dbHandler, jsonObject, attribute, true);
                  final rid = AttributeDataHandler.addAttributeRecord(dbHandler,  attribute);
                } else {
                  attribute = JSONCopier.copyJsonDataToAttribute( dbHandler, jsonObject, attribute, false);
                  final rid = AttributeDataHandler.updateAttributeRecord(dbHandler,  attribute.id, attribute);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AttributesPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAttribute() 3-> $e');
  }
}


Future<void> downSyncAttributeValues(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetAttributeValuePaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        AttributeValuesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': AttributeValuesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                AttributeValue? attributeValue;
                final id = jsonObject['AttributeValueID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  attributeValue = AttributeValueDataHandler.getMasterAttributeValueRecord(dbHandler,  id);
                }
                if (attributeValue == null && doDoubleCheck && uid.isNotEmpty) {
                  attributeValue = AttributeValueDataHandler.getAttributeValueRecordByUid(dbHandler,  uid);
                }
                if (attributeValue == null) {
                  attributeValue = AttributeValue();
                  attributeValue = JSONCopier.copyJsonDataToAttributeValue( dbHandler, jsonObject, attributeValue, true);
                  final rid = AttributeValueDataHandler.addAttributeValueRecord(dbHandler,  attributeValue);
                } else {
                  attributeValue = JSONCopier.copyJsonDataToAttributeValue( dbHandler, jsonObject, attributeValue, false);
                  final rid = AttributeValueDataHandler.updateAttributeValueRecord(dbHandler,  attributeValue.id, attributeValue);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              AttributeValuesPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncAttributeValue() 3-> $e');
  }
}

Future<void> downSyncBusinessEmails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetBusinessEmailPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        BusinessEmailsPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': BusinessEmailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                BusinessEmail? businessEmail;
                final id = jsonObject['BusinessEmailID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  businessEmail = BusinessEmailDataHandler.getMasterBusinessEmailRecord(dbHandler,  id);
                }
                if (businessEmail == null && doDoubleCheck && uid.isNotEmpty) {
                  businessEmail = BusinessEmailDataHandler.getBusinessEmailRecordByUid(dbHandler,  uid);
                }
                if (businessEmail == null) {
                  businessEmail = BusinessEmail();
                  businessEmail = JSONCopier.copyJsonDataToBusinessEmail( dbHandler, jsonObject, businessEmail, true);
                  final rid = BusinessEmailDataHandler.addBusinessEmailRecord(dbHandler,  businessEmail);
                } else {
                  businessEmail = JSONCopier.copyJsonDataToBusinessEmail( dbHandler, jsonObject, businessEmail, false);
                  final rid = BusinessEmailDataHandler.updateBusinessEmailRecord(dbHandler,  businessEmail.id, businessEmail);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              BusinessEmailsPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncBusinessEmail() 3-> $e');
  }
}

Future<void> downSyncBusinessFeatures(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetBusinessFeaturePaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        BusinessFeaturesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': BusinessFeaturesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                BusinessFeature? businessFeature;
                final id = jsonObject['BusinessFeatureID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  businessFeature = BusinessFeatureDataHandler.getMasterBusinessFeatureRecord(dbHandler,  id);
                }
                if (businessFeature == null && doDoubleCheck && uid.isNotEmpty) {
                  businessFeature = BusinessFeatureDataHandler.getBusinessFeatureRecordByUid(dbHandler,  uid);
                }
                if (businessFeature == null) {
                  businessFeature = BusinessFeature();
                  businessFeature = JSONCopier.copyJsonDataToBusinessFeature( dbHandler, jsonObject, businessFeature, true);
                  final rid = BusinessFeatureDataHandler.addBusinessFeatureRecord(dbHandler,  businessFeature);
                } else {
                  businessFeature = JSONCopier.copyJsonDataToBusinessFeature( dbHandler, jsonObject, businessFeature, false);
                  final rid = BusinessFeatureDataHandler.updateBusinessFeatureRecord(dbHandler,  businessFeature.id, businessFeature);
                }
              }
            }

            final isAllPagesDone = update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              BusinessFeaturesPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncBusinessFeature() 3-> $e');
  }
}

Future<void> downSyncBusinessUnits(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetBusinessUnitPaged';

      final dataItem = SyncDataHandler.getAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = Globals.tryParseInt(dataItem.records);
        final pageSize = Globals.tryParseInt(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = Globals.tryParseInt(dataItem.page);
        BusinessUnitsPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': BusinessUnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url),
            headers: {'Authorization': 'Bearer ${Globals.USER_TOKEN}'}, body: json.encode(postData));

        if (response.statusCode == 200) {
          final jsonArray = json.decode(response.body);
          if (jsonArray != null) {
            for (final jsonObject in jsonArray) {
              if (jsonObject != null) {
                BusinessUnit? businessUnit;
                final id = jsonObject['BusinessUnitID'] ?? '';
                final uid = jsonObject['Uid'] ?? '';
                if (id.isNotEmpty) {
                  businessUnit = BusinessUnitDataHandler.getMasterBusinessUnitRecord(dbHandler,  id);
                }
                if (businessUnit == null && doDoubleCheck && uid.isNotEmpty) {
                  businessUnit = BusinessUnitDataHandler.getBusinessUnitRecordByUid(dbHandler,  uid);
                }
                if (businessUnit == null) {
                  businessUnit = BusinessUnit();
                  businessUnit = JSONCopier.copyJsonDataToBusinessUnit( dbHandler, jsonObject, businessUnit, true);
                  final rid = BusinessUnitDataHandler.addBusinessUnitRecord(dbHandler,  businessUnit);
                } else {
                  businessUnit = JSONCopier.copyJsonDataToBusinessUnit( dbHandler, jsonObject, businessUnit, false);
                  final rid = BusinessUnitDataHandler.updateBusinessUnitRecord(dbHandler,  businessUnit.id, businessUnit);
                }
              }
            }

            bool isAllPagesDone = Update downSyncPageStatus(dataItem);
            if (isAllPagesDone) {
              BusinessUnitsPageCurrent = 0;
            }
          } else {
            resetRecordCount(dataItem);
          }

          
        }
      }
    }
  } catch (e) {
    logError('Error: SyncService:downSyncBusinessUnit() 3-> $e');
  }


}

Future<void> downSyncChatMessages(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      final url = '${AppConstant.API_VERSION_URL}/ downSyncManager/GetChatMessagePaged';

      final dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        final records = int.tryParse(dataItem.records);
        final pageSize = int.tryParse(dataItem.pgSize);
        final totalPages = (records / pageSize).ceil();

        final pageNow = int.tryParse(dataItem.page);
        ChatMessagesPageCurrent = pageNow + 1;

        final postData = {
          'pageindex': ChatMessagesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          final jsonArray = jsonDecode(response.body) as List<dynamic>;

          for (final jsonObject in jsonArray) {
            ChatMessage? chatMessage;
            final id = jsonObject['ChatMessageID'] as String;
            final uid = jsonObject['Uid'] as String;

            if (id != '') {
              chatMessage = ChatMessageDataHandler.GetMasterChatMessageRecord(dbHandler,  id);
            }

            if (chatMessage == null && doDoubleCheck && uid != '') {
              chatMessage = ChatMessageDataHandler.GetChatMessageRecordByUid(dbHandler,  uid);
            }

            if (chatMessage == null) {
              chatMessage = ChatMessage();
              chatMessage = JSONCopier.CopyJsonDataToChatMessage( dbHandler, jsonObject, chatMessage, true);
              final rid = ChatMessageDataHandler.AddChatMessageRecord(dbHandler,  chatMessage);
            } else {
              chatMessage = JSONCopier.CopyJsonDataToChatMessage( dbHandler, jsonObject, chatMessage, false);
              final rid = ChatMessageDataHandler.UpdateChatMessageRecord(dbHandler,  chatMessage.id, chatMessage);
            }
          }

          final isAllPagesDone = updatedownSyncPageStatus(dataItem);
          if (isAllPagesDone) {
            ChatMessagesPageCurrent = 0;
          }
        } else {
          ResetRecordCount(dataItem);
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService: downSyncChatMessage() 3-> $e');
  } finally {
    // Finally block code
  }
}

Future<void> downSyncChatUserAndGroups(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/DownSyncManager/GetChatUserAndGroupPaged";

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != "0") {
        int records = int.tryParse(dataItem.records);
        int pageSize = int.tryParse(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = int.tryParse(dataItem.page);
        ChatUserAndGroupsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ChatUserAndGroupsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {

          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ChatUserAndGroup? chatUserAndGroup;
                  var id = jsonObject['ChatUserAndGroupID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    chatUserAndGroup = ChatUserAndGroupDataHandlerBase.GetMasterChatUserAndGroupRecord(dbHandler,  id);
                  }

                  if (chatUserAndGroup == null && doDoubleCheck && uid != null && uid != '') {
                    chatUserAndGroup = ChatUserAndGroupDataHandlerBase.GetChatUserAndGroupRecordByUid(dbHandler,  uid);
                  }

                  if (chatUserAndGroup == null) {
                    chatUserAndGroup = ChatUserAndGroup();
                    chatUserAndGroup = JSONCopier.copyJsonDataToChatUserAndGroup( dbHandler, jsonObject, chatUserAndGroup, true);
                    var rid = ChatUserAndGroupDataHandler.AddChatUserAndGroupRecord(dbHandler,  chatUserAndGroup);
                  } else {
                    chatUserAndGroup = JSONCopier.copyJsonDataToChatUserAndGroup( dbHandler, jsonObject, chatUserAndGroup, false);
                    var rid = ChatUserAndGroupDataHandlerBase.UpdateChatUserAndGroupRecord(dbHandler, chatUserAndGroup.id, chatUserAndGroup);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ChatUserAndGroupsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch (e) {
            LogError("Error: SyncService:DownSyncChatUserAndGroup() 1-> " + e.toString());
          } finally {
            currentDownload = "";
          }
        }

        String posterror = "";

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = "";
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e1) {
            print(e1);
          }
        }

        LogError("VolleyError: SyncService:DownSyncChatUserAndGroup() 2-> " + posterror);
        currentDownload = "";
      }
    }
  } catch (e) {
    LogError("Error: SyncService:DownSyncChatUserAndGroup() 3-> " + e.toString());
  } finally {
    // Add your finalization code here
  }
}

Future<void> downSyncChatUserGroupMembers(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetChatUserGroupMemberPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ChatUserGroupMembersPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ChatUserGroupMembersPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ChatUserGroupMember chatUserGroupMember;
                  var id = jsonObject['ChatUserGroupMemberID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    chatUserGroupMember = ChatUserGroupMemberDataHandlerBase.GetMasterChatUserGroupMemberRecord(dbHandler,  id);
                  }

                  if (chatUserGroupMember == null && doDoubleCheck && uid != null && uid != '') {
                    chatUserGroupMember = ChatUserGroupMemberDataHandlerBase.GetChatUserGroupMemberRecordByUid(dbHandler,  uid);
                  }

                  if (chatUserGroupMember == null) {
                    chatUserGroupMember = ChatUserGroupMember();
                    chatUserGroupMember = JSONCopier.CopyJsonDataToChatUserGroupMember( dbHandler, jsonObject, chatUserGroupMember, true);
                    var rid = ChatUserGroupMemberDataHandler.AddChatUserGroupMemberRecord(dbHandler,  chatUserGroupMember);
                  } else {
                    chatUserGroupMember = JSONCopier.CopyJsonDataToChatUserGroupMember( dbHandler, jsonObject, chatUserGroupMember, false);
                    var rid = ChatUserGroupMemberDataHandlerBase.UpdateChatUserGroupMemberRecord(dbHandler,  chatUserGroupMember.id, chatUserGroupMember);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ChatUserGroupMembersPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncChatUserGroupMember() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncChatUserGroupMember() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncChatUserGroupMember() 3-> ' + e.toString());
  }
}

Future<void> downSyncCompetitors(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetCompetitorPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        CompetitorsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': CompetitorsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Competitor competitor;
                  var id = jsonObject['CompetitorID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    competitor = CompetitorDataHandlerBase.GetMasterCompetitorRecord(dbHandler,  id);
                  }

                  if (competitor == null && doDoubleCheck && uid != null && uid != '') {
                    competitor = CompetitorDataHandlerBase.GetCompetitorRecordByUid(dbHandler,  uid);
                  }

                  if (competitor == null) {
                    competitor = Competitor();
                    competitor = JSONCopier.CopyJsonDataToCompetitor( dbHandler, jsonObject, competitor, true);
                    var rid = CompetitorDataHandlerBase.AddCompetitorRecord(dbHandler,  competitor);
                  } else {
                    competitor = JSONCopier.CopyJsonDataToCompetitor( dbHandler, jsonObject, competitor, false);
                    var rid = CompetitorDataHandlerBase.UpdateCompetitorRecord(dbHandler,  competitor.id, competitor);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) CompetitorsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncCompetitor() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncCompetitor() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncCompetitor() 3-> ' + e.toString());
  }
}

Future<void> downSyncContacts(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContactsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Contact contact;
                  var id = jsonObject['ContactID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contact = ContactHandlerDataBase.GetMasterContactRecord(dbHandler,  id);
                  }

                  if (contact == null && doDoubleCheck && uid != null && uid != '') {
                    contact = ContactHandlerDataBase.GetContactRecordByUid(dbHandler,  uid);
                  }

                  if (contact == null) {
                    contact = Contact();
                    contact = JSONCopier.CopyJsonDataToContact( dbHandler, jsonObject, contact, true);
                    var rid = ContactHandlerDataBase.AddContactRecord(dbHandler,  contact);
                  } else {
                    contact = JSONCopier.CopyJsonDataToContact( dbHandler, jsonObject, contact, false);
                    var rid = ContactHandlerDataBase.UpdateContactRecord(dbHandler,  contact.id, contact);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContact() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContact() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContact() 3-> ' + e.toString());
  }
}


Future<void> downSyncContactAlignments(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactAlignmentPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContactAlignmentsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactAlignmentsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContactAlignment contactAlignment;
                  var id = jsonObject['ContactAlignmentID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contactAlignment = ContactAlignmentDataHandlerBase.GetMasterContactAlignmentRecord(dbHandler,  id);
                  }

                  if (contactAlignment == null && doDoubleCheck && uid != null && uid != '') {
                    contactAlignment = ContactAlignmentDataHandlerBase.GetContactAlignmentRecordByUid(dbHandler,  uid);
                  }

                  if (contactAlignment == null) {
                    contactAlignment = ContactAlignment();
                    contactAlignment = JSONCopier.copyJsonDataToContactAlignment( dbHandler, jsonObject, contactAlignment, true);
                    var rid = ContactAlignmentDataHandler.AddContactAlignmentRecord(dbHandler,  contactAlignment);
                  } else {
                    contactAlignment = JSONCopier.copyJsonDataToContactAlignment( dbHandler, jsonObject, contactAlignment, false);
                    var rid = ContactAlignmentDataHandlerBase.UpdateContactAlignmentRecord(dbHandler,  contactAlignment.id, contactAlignment);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactAlignmentsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContactAlignment() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContactAlignment() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContactAlignment() 3-> ' + e.toString());
  }
}

Future<void> downSyncContactCategories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactCategoryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContactCategoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactCategoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContactCategory contactCategory;
                  var id = jsonObject['ContactCategoryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contactCategory = ContactCategoryDataHandlerBase.GetMasterContactCategoryRecord(dbHandler,  id);
                  }

                  if (contactCategory == null && doDoubleCheck && uid != null && uid != '') {
                    contactCategory = ContactCategoryDataHandlerBase.GetContactCategoryRecordByUid(dbHandler,  uid);
                  }

                  if (contactCategory == null) {
                    contactCategory = ContactCategory();
                    contactCategory = JSONCopier.CopyJsonDataToContactCategory( dbHandler, jsonObject, contactCategory, true);
                    var rid = ContactCategoryDataHandler.AddContactCategoryRecord(dbHandler,  contactCategory);
                  } else {
                    contactCategory = JSONCopier.CopyJsonDataToContactCategory( dbHandler, jsonObject, contactCategory, false);
                    var rid = ContactCategoryDataHandlerBase.UpdateContactCategoryRecord(dbHandler,  contactCategory.id, contactCategory);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactCategoriesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContactCategory() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContactCategory() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContactCategory() 3-> ' + e.toString());
  }
}



void downSyncContactMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactMediaPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContactMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContactMedia contactMedia;
                  var id = jsonObject['ContactMediaID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contactMedia = ContactMediaDataHandlerBase.GetMasterContactMediaRecord(dbHandler,  id);
                  }

                  if (contactMedia == null && doDoubleCheck && uid != null && uid != '') {
                    contactMedia = ContactMediaDataHandlerBase.GetContactMediaRecordByUid(dbHandler,  uid);
                  }

                  if (contactMedia == null) {
                    contactMedia = ContactMedia();
                    contactMedia = JSONCopier.copyJsonDataToContactMedia( dbHandler, jsonObject, contactMedia, true);
                    contactMedia.setIsUploaded('true');
                    var rid = ContactMediaDataHandlerBase.AddContactMediaRecord(dbHandler,  contactMedia);
                  } else {
                    contactMedia = JSONCopier.copyJsonDataToContactMedia( dbHandler, jsonObject, contactMedia, false);
                    var rid = ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler,  contactMedia.id, contactMedia);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactMediaPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContactMedia() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContactMedia() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContactMedia() 3-> ' + e.toString());
  }
}

void downSyncContactTitles(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContactTitlePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContactTitlesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContactTitlesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContactTitle contactTitle;
                  var id = jsonObject['ContactTitleID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contactTitle = ContactTitleDataHandlerBase.GetMasterContactTitleRecord(dbHandler,  id);
                  }

                  if (contactTitle == null && doDoubleCheck && uid != null && uid != '') {
                    contactTitle = ContactTitleDataHandlerBase.GetContactTitleRecordByUid(dbHandler,  uid);
                  }

                  if (contactTitle == null) {
                    contactTitle = ContactTitle();
                    contactTitle = JSONCopier.CopyJsonDataToContactTitle( dbHandler, jsonObject, contactTitle, true);
                    var rid = await ContactTitleDataHandlerBase.addContactTitleRecord(dbHandler, contactTitle);
                  } else {
                    contactTitle = JSONCopier.CopyJsonDataToContactTitle( dbHandler, jsonObject, contactTitle, false);
                    var rid = ContactTitleDataHandler.UpdateContactTitleRecord(dbHandler,  contactTitle.id, contactTitle);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContactTitlesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContactTitle() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContactTitle() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContactTitle() 3-> ' + e.toString());
  }
}

void downSyncContentTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetContentTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ContentTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ContentTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ContentType contentType;
                  var id = jsonObject['ContentTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    contentType = ContentTypeDataHandlerBase.GetMasterContentTypeRecord(dbHandler,  id);
                  }

                  if (contentType == null && doDoubleCheck && uid != null && uid != '') {
                    contentType = ContentTypeDataHandlerBase.GetContentTypeRecordByUid(dbHandler,  uid);
                  }

                  if (contentType == null) {
                    contentType = ContentType();
                    contentType = JSONCopier.copyJsonDataToContentType( dbHandler, jsonObject, contentType, true);
                    var rid = ContentTypeDataHandlerBase.AddContentTypeRecord(dbHandler,  contentType);
                  } else {
                    contentType = JSONCopier.copyJsonDataToContentType( dbHandler, jsonObject, contentType, false);
                    var rid = ContentTypeDataHandlerBase.UpdateContentTypeRecord(dbHandler,  contentType.id, contentType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ContentTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncContentType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncContentType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncContentType() 3-> ' + e.toString());
  }
}

void downSyncCountries(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetCountryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        CountriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': CountriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Country country;
                  var id = jsonObject['CountryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    country = CountryDataHandlerBase.GetMasterCountryRecord(dbHandler,  id);
                  }

                  if (country == null && doDoubleCheck && uid != null && uid != '') {
                    country = CountryDataHandlerBase.GetCountryRecordByUid(dbHandler,  uid);
                  }

                  if (country == null) {
                    country = Country();
                    country = JSONCopier.CopyJsonDataToCountry( dbHandler, jsonObject, country, true);
                    var rid = CountryDataHandlerBase.AddCountryRecord(dbHandler,  country);
                  } else {
                    country = JSONCopier.CopyJsonDataToCountry( dbHandler, jsonObject, country, false);
                    var rid = CountryDataHandlerBase.UpdateCountryRecord(dbHandler,  country.id, country);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) CountriesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncCountry() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncCountry() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncCountry() 3-> ' + e.toString());
  }
}


void downSyncCreditRatings(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetCreditRatingPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        CreditRatingsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': CreditRatingsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  CreditRating creditRating;
                  var id = jsonObject['CreditRatingID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    creditRating = CreditRatingDataHandlerBase.GetMasterCreditRatingRecord(dbHandler,  id);
                  }

                  if (creditRating == null && doDoubleCheck && uid != null && uid != '') {
                    creditRating = CreditRatingDataHandlerBase.GetCreditRatingRecordByUid(dbHandler,  uid);
                  }

                  if (creditRating == null) {
                    creditRating = CreditRating();
                    creditRating = JSONCopier.CopyJsonDataToCreditRating( dbHandler, jsonObject, creditRating, true);
                    var rid = CreditRatingDataHandlerBase.AddCreditRatingRecord(dbHandler,  creditRating);
                  } else {
                    creditRating = JSONCopier.CopyJsonDataToCreditRating( dbHandler, jsonObject, creditRating, false);
                    var rid = CreditRatingDataHandlerBase.UpdateCreditRatingRecord(dbHandler,  creditRating.id, creditRating);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) CreditRatingsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncCreditRating() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncCreditRating() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncCreditRating() 3-> ' + e.toString());
  } finally {
    // Any code to execute in the finally block can be added here
  }
}

void downSyncCurrencies(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetCurrencyPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        CurrenciesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': CurrenciesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Currency currency;
                  var id = jsonObject['CurrencyID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    currency = CurrencyDataHandlerBaseBase.GetMasterCurrencyRecord(dbHandler,  id);
                  }

                  if (currency == null && doDoubleCheck && uid != null && uid != '') {
                    currency = CurrencyDataHandlerBaseBase.GetCurrencyRecordByUid(dbHandler,  uid);
                  }

                  if (currency == null) {
                    currency = Currency();
                    currency = JSONCopier.CopyJsonDataToCurrency( dbHandler, jsonObject, currency, true);
                    var rid = CurrencyDataHandlerBaseBase.AddCurrencyRecord(dbHandler,  currency);
                  } else {
                    currency = JSONCopier.CopyJsonDataToCurrency( dbHandler, jsonObject, currency, false);
                    var rid = CurrencyDataHandlerBaseBase.UpdateCurrencyRecord(dbHandler,  currency.id, currency);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) CurrenciesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncCurrency() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncCurrency() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncCurrency() 3-> ' + e.toString());
  } finally {
    // Any code to execute in the finally block can be added here
  }
}

void downSyncCustomerMeetings(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetCustomerMeetingPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        CustomerMeetingsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': CustomerMeetingsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  CustomerMeeting customerMeeting;
                  var id = jsonObject['CustomerMeetingID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    customerMeeting = CustomerMeetingDataHandlerBase.GetMasterCustomerMeetingRecord(dbHandler,  id);
                  }

                  if (customerMeeting == null && doDoubleCheck && uid != null && uid != '') {
                    customerMeeting = CustomerMeetingDataHandlerBase.GetCustomerMeetingRecordByUid(dbHandler,  uid);
                  }

                  if (customerMeeting == null) {
                    customerMeeting = CustomerMeeting();
                    customerMeeting = JSONCopier.copyJsonDataToCustomerMeeting( dbHandler, jsonObject, customerMeeting, true);
                    var rid = CustomerMeetingDataHandlerBase.AddCustomerMeetingRecord(dbHandler,  customerMeeting);
                  } else {
                    customerMeeting = JSONCopier.copyJsonDataToCustomerMeeting( dbHandler, jsonObject, customerMeeting, false);
                    var rid = CustomerMeetingDataHandlerBase.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeeting);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) CustomerMeetingsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncCustomerMeeting() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncCustomerMeeting() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncCustomerMeeting() 3-> ' + e.toString());
  } finally {
    // Any code to execute in the finally block can be added here
  }
}


void downSyncDepartments(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetDepartmentPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        DepartmentsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': DepartmentsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Department department;
                  var id = jsonObject['DepartmentID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    department = DepartmentDataHandler.GetMasterDepartmentRecord(dbHandler,  id);
                  }

                  if (department == null && doDoubleCheck && uid != null && uid != '') {
                    department = DepartmentDataHandler.GetDepartmentRecordByUid(dbHandler,  uid);
                  }

                  if (department == null) {
                    department = Department();
                    department = JSONCopier.CopyJsonDataToDepartment( dbHandler, jsonObject, department, true);
                    var rid = DepartmentDataHandler.AddDepartmentRecord(dbHandler,  department);
                  } else {
                    department = JSONCopier.CopyJsonDataToDepartment( dbHandler, jsonObject, department, false);
                    var rid = DepartmentDataHandler.UpdateDepartmentRecord(dbHandler,  department.id, department);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) DepartmentsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncDepartment() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncDepartment() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncDepartment() 3-> ' + e.toString());
  } finally {
    // Any code to execute in the finally block can be added here
  }
}

void downSyncDesignations(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetDesignationPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        DesignationsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': DesignationsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Designation designation;
                  var id = jsonObject['DesignationID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    designation = DesignationDataHandlerBase.GetMasterDesignationRecord(dbHandler,  id);
                  }

                  if (designation == null && doDoubleCheck && uid != null && uid != '') {
                    designation =  await DesignationDataHandlerBase.GetDesignationRecordByUid(dbHandler,  uid);
                  }

                  if (designation == null) {
                    designation = Designation();
                    designation = JSONCopier.copyJsonDataToDesignation( dbHandler, jsonObject, designation, true);
                    var rid = await DesignationDataHandlerBase.AddDesignationRecord(dbHandler,  designation);
                  } else {
                    designation = JSONCopier.copyJsonDataToDesignation( dbHandler, jsonObject, designation, false);
                    var rid =await  DesignationDataHandlerBase.UpdateDesignationRecord(dbHandler,  designation.id, designation);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) DesignationsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncDesignation() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncDesignation() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncDesignation() 3-> ' + e.toString());
  } finally {
    // Any code to execute in the finally block can be added here
  }
}


void downSyncEmailManualTemplates(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetEmailManualTemplatePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        EmailManualTemplatesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': EmailManualTemplatesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  EmailManualTemplate? emailManualTemplate;
                  var id = jsonObject['EmailManualTemplateID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    emailManualTemplate = await  EmailManualTemplateDataHandlerBase.GetMasterEmailManualTemplateRecord(dbHandler,  id);
                  }

                  if (emailManualTemplate == null && doDoubleCheck && uid != null && uid != '') {
                    emailManualTemplate =  await EmailManualTemplateDataHandlerBase.GetEmailManualTemplateRecordByUid(dbHandler,  uid);
                  }

                  if (emailManualTemplate == null) {
                    emailManualTemplate = EmailManualTemplate();
                    emailManualTemplate = JSONCopier.CopyJsonDataToEmailManualTemplate( dbHandler, jsonObject, emailManualTemplate, true);
                    var rid = await  EmailManualTemplateDataHandlerBase.AddEmailManualTemplateRecord(dbHandler,  emailManualTemplate);
                  } else {
                    emailManualTemplate = JSONCopier.CopyJsonDataToEmailManualTemplate( dbHandler, jsonObject, emailManualTemplate, false);
                    var rid = await EmailManualTemplateDataHandlerBase.UpdateEmailManualTemplateRecord(dbHandler,  emailManualTemplate.id, emailManualTemplate);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) EmailManualTemplatesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncEmailManualTemplate() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncEmailManualTemplate() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncEmailManualTemplate() 3-> ' + e.toString());
  }
}

void downSyncExpenseTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetExpenseTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ExpenseTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ExpenseTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ExpenseType? expenseType;
                  var id = jsonObject['ExpenseTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    expenseType = ExpenseTypeDataHandlerBase.GetMasterExpenseTypeRecord(dbHandler,  id);
                  }

                  if (expenseType == null && doDoubleCheck && uid != null && uid != '') {
                    expenseType = await ExpenseTypeDataHandlerBase.GetExpenseTypeRecordByUid(dbHandler,  uid);
                  }

                  if (expenseType == null) {
                    expenseType = ExpenseType();
                    expenseType = JSONCopier.copyJsonDataToExpenseType( dbHandler, jsonObject, expenseType, true);
                    var rid = await ExpenseTypeDataHandlerBase.AddExpenseTypeRecord(dbHandler,  expenseType);
                  } else {
                    expenseType = JSONCopier.copyJsonDataToExpenseType( dbHandler, jsonObject, expenseType, false);
                    var rid = await ExpenseTypeDataHandlerBase.UpdateExpenseTypeRecord(dbHandler,  expenseType.id, expenseType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ExpenseTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncExpenseType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncExpenseType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncExpenseType() 3-> ' + e.toString());
  } finally {
    // Add any necessary cleanup code here
  }
}


void downSyncFieldAttendances(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFieldAttendancePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FieldAttendancesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FieldAttendancesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FieldAttendance ?fieldAttendance;
                  var id = jsonObject['FieldAttendanceID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    fieldAttendance = await FieldAttendanceDataHandlerBase.GetMasterFieldAttendanceRecord(dbHandler,  id);
                  }

                  if (fieldAttendance == null && doDoubleCheck && uid != null && uid != '') {
                    fieldAttendance = await FieldAttendanceDataHandlerBase.GetFieldAttendanceRecordByUid(dbHandler,  uid);
                  }

                  if (fieldAttendance == null) {
                    fieldAttendance = FieldAttendance();
                    fieldAttendance = JSONCopier.copyJsonDataToFieldAttendance( dbHandler, jsonObject, fieldAttendance, true);
                    var rid = await FieldAttendanceDataHandlerBase.AddFieldAttendanceRecord(dbHandler,  fieldAttendance);
                  } else {
                    fieldAttendance = JSONCopier.copyJsonDataToFieldAttendance( dbHandler, jsonObject, fieldAttendance, false);
                    var rid = await FieldAttendanceDataHandlerBase.UpdateFieldAttendanceRecord(dbHandler,  fieldAttendance.id, fieldAttendance);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FieldAttendancesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFieldAttendance() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFieldAttendance() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncFieldAttendance() 3-> ' + e.toString());
  } finally {}
}

void downSyncFinancialInstitutions(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFinancialInstitutionPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FinancialInstitutionsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FinancialInstitutionsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FinancialInstitution? financialInstitution;
                  var id = jsonObject['FinancialInstitutionID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    financialInstitution = await FinancialInstitutionDataHandlerBase.GetMasterFinancialInstitutionRecord(dbHandler,  id);
                  }

                  if (financialInstitution == null && doDoubleCheck && uid != null && uid != '') {
                    financialInstitution =  await FinancialInstitutionDataHandlerBase.GetFinancialInstitutionRecordByUid(dbHandler,  uid);
                  }

                  if (financialInstitution == null) {
                    financialInstitution = FinancialInstitution();
                    financialInstitution = JSONCopier.copyJsonDataToFinancialInstitution( dbHandler, jsonObject, financialInstitution, true);
                    var rid = await FinancialInstitutionDataHandlerBase.AddFinancialInstitutionRecord(dbHandler,  financialInstitution);
                  } else {
                    financialInstitution = JSONCopier.copyJsonDataToFinancialInstitution( dbHandler, jsonObject, financialInstitution, false);
                    var rid = await FinancialInstitutionDataHandlerBase.UpdateFinancialInstitutionRecord(dbHandler,  financialInstitution.id, financialInstitution);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FinancialInstitutionsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFinancialInstitution() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFinancialInstitution() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncFinancialInstitution() 3-> ' + e.toString());
  } finally {}
}


void downSyncFinancialYears(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFinancialYearPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FinancialYearsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FinancialYearsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FinancialYear? financialYear;
                  var id = jsonObject['FinancialYearID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    financialYear = await  FinancialYearDataHandlerBase.GetMasterFinancialYearRecord(dbHandler,  id);
                  }

                  if (financialYear == null && doDoubleCheck && uid != null && uid != '') {
                    financialYear = await FinancialYearDataHandlerBase.GetFinancialYearRecordByUid(dbHandler,  uid);
                  }

                  if (financialYear == null) {
                    financialYear = FinancialYear();
                    financialYear = JSONCopier.copyJsonDataToFinancialYear( dbHandler, jsonObject, financialYear, true);
                    var rid = await FinancialYearDataHandlerBase.AddFinancialYearRecord(dbHandler,  financialYear);
                  } else {
                    financialYear = JSONCopier.copyJsonDataToFinancialYear( dbHandler, jsonObject, financialYear, false);
                    var rid = await FinancialYearDataHandlerBase.UpdateFinancialYearRecord(dbHandler,  financialYear.id, financialYear);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FinancialYearsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFinancialYear() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFinancialYear() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncFinancialYear() 3-> ' + e.toString());
  }
}


void downSyncForms(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFormPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FormsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FormsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Form form;
                  var id = jsonObject['FormID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    form = FormDataHandlerBase.GetMasterFormRecord(dbHandler,  id);
                  }

                  if (form == null && doDoubleCheck && uid != null && uid != '') {
                    form = FormDataHandlerBase.GetFormRecordByUid(dbHandler,  uid);
                  }

                  if (form == null) {
                    form = Form();
                    form = JSONCopier.CopyJsonDataToForm( dbHandler, jsonObject, form, true);
                    var rid = FormDataHandlerBase.AddFormRecord(dbHandler,  form);
                  } else {
                    form = JSONCopier.CopyJsonDataToForm( dbHandler, jsonObject, form, false);
                    var rid = FormDataHandlerBase.UpdateFormRecord(dbHandler,  form.id, form);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FormsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncForm() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncForm() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncForm() 3-> ' + e.toString());
  } finally {
  }
}


void downSyncFormCells(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFormCellPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FormCellsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FormCellsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FormCell? formCell;
                  var id = jsonObject['FormCellID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    formCell = await FormCellDataHandlerBase.GetMasterFormCellRecord(dbHandler,  id);
                  }

                  if (formCell == null && doDoubleCheck && uid != null && uid != '') {
                    formCell = await  FormCellDataHandlerBase.GetFormCellRecordByUid(dbHandler,  uid);
                  }

                  if (formCell == null) {
                    formCell = FormCell();
                    formCell = JSONCopier.CopyJsonDataToFormCell( dbHandler, jsonObject, formCell, true);
                    var rid = await FormCellDataHandlerBase.AddFormCellRecord(dbHandler,  formCell);
                  } else {
                    formCell = JSONCopier.CopyJsonDataToFormCell( dbHandler, jsonObject, formCell, false);
                    var rid = await FormCellDataHandlerBase.UpdateFormCellRecord(dbHandler,  formCell.id, formCell);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FormCellsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFormCell() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFormCell() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncFormCell() 3-> ' + e.toString());
  } finally {
  }
}


void downSyncFormCellElements(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFormCellElementPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FormCellElementsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FormCellElementsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FormCellElement? formCellElement;
                  var id = jsonObject['FormCellElementID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    formCellElement =await  FormCellElementDataHandlerBase.GetMasterFormCellElementRecord(dbHandler,  id);
                  }

                  if (formCellElement == null && doDoubleCheck && uid != null && uid != '') {
                    formCellElement = await  FormCellElementDataHandlerBase.GetFormCellElementRecordByUid(dbHandler,  uid);
                  }

                  if (formCellElement == null) {
                    formCellElement = FormCellElement();
                    formCellElement = JSONCopier.copyJsonDataToFormCellElement( dbHandler, jsonObject, formCellElement, true);
                    var rid =await  FormCellElementDataHandlerBase.AddFormCellElementRecord(dbHandler,  formCellElement);
                  } else {
                    formCellElement = JSONCopier.copyJsonDataToFormCellElement( dbHandler, jsonObject, formCellElement, false);
                    var rid =  await FormCellElementDataHandlerBase.UpdateFormCellElementRecord(dbHandler,  formCellElement.id, formCellElement);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FormCellElementsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFormCellElement() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFormCellElement() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncFormCellElement() 3-> ' + e.toString());
  } finally {}
}

void downSyncFormSections(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetFormSectionPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        FormSectionsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': FormSectionsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  FormSection ? formSection;
                  var id = jsonObject['FormSectionID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    formSection = await FormSectionDataHandlerBase.GetMasterFormSectionRecord(dbHandler,  id);
                  }

                  if (formSection == null && doDoubleCheck && uid != null && uid != '') {
                    formSection = await  FormSectionDataHandlerBase.GetFormSectionRecordByUid(dbHandler,  uid);
                  }

                  if (formSection == null) {
                    formSection = FormSection();
                    formSection = await JSONCopier.copyJsonDataToFormSection( dbHandler, jsonObject, formSection, true);
                    var rid = await FormSectionDataHandlerBase.AddFormSectionRecord(dbHandler,  formSection);
                  } else {
                    formSection = await JSONCopier.copyJsonDataToFormSection( dbHandler, jsonObject, formSection, false);
                    var rid = await FormSectionDataHandlerBase.UpdateFormSectionRecord(dbHandler,  formSection.id, formSection);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) FormSectionsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncFormSection() 1-> ' + ex.toString());
          } finally {
            currentdownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncFormSection() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncFormSection() 3-> ' + e.toString());
  } finally {}

}

void downSyncIndustries(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetIndustryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        IndustriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': IndustriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Industry? industry;
                  var id = jsonObject['IndustryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    industry = await IndustryDataHandlerBase.GetMasterIndustryRecord(dbHandler,  id);
                  }

                  if (industry == null && doDoubleCheck && uid != null && uid != '') {
                    industry = await IndustryDataHandlerBase.GetIndustryRecordByUid(dbHandler,  uid);
                  }

                  if (industry == null) {
                    industry = Industry();
                    industry = JSONCopier.copyJsonDataToIndustry( dbHandler, jsonObject, industry, true);
                    var rid = await IndustryDataHandlerBase.AddIndustryRecord(dbHandler,  industry);
                  } else {
                    industry = JSONCopier.copyJsonDataToIndustry( dbHandler, jsonObject, industry, false);
                    var rid = IndustryDataHandlerBase.UpdateIndustryRecord(dbHandler,  industry.id, industry);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) IndustriesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncIndustry() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncIndustry() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncIndustry() 3-> ' + e.toString());
  } finally {
    // ...
  }
}

void downSyncLeadSources(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetLeadSourcePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        LeadSourcesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': LeadSourcesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  LeadSource? leadSource;
                  var id = jsonObject['LeadSourceID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    leadSource = await LeadSourceDataHandlerBase.GetMasterLeadSourceRecord(dbHandler,  id);
                  }

                  if (leadSource == null && doDoubleCheck && uid != null && uid != '') {
                    leadSource = await LeadSourceDataHandlerBase.GetLeadSourceRecordByUid(dbHandler,  uid);
                  }

                  if (leadSource == null) {
                    leadSource = LeadSource();
                    leadSource = JSONCopier.copyJsonDataToLeadSource( dbHandler, jsonObject, leadSource, true);
                    var rid = LeadSourceDataHandlerBase.AddLeadSourceRecord(dbHandler,  leadSource);
                  } else {
                    leadSource = JSONCopier.copyJsonDataToLeadSource( dbHandler, jsonObject, leadSource, false);
                    var rid = await LeadSourceDataHandlerBase.UpdateLeadSourceRecord(dbHandler,  leadSource.id, leadSource);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) LeadSourcesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncLeadSource() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncLeadSource() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncLeadSource() 3-> ' + e.toString());
  } finally {
    // ...
  }
}


void downSyncModeOfTravels(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetModeOfTravelPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ModeOfTravelsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ModeOfTravelsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ModeOfTravel? modeOfTravel;
                  var id = jsonObject['ModeOfTravelID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    modeOfTravel =await  ModeOfTravelDataHandlerBase.GetMasterModeOfTravelRecord(dbHandler,  id);
                  }

                  if (modeOfTravel == null && doDoubleCheck && uid != null && uid != '') {
                    modeOfTravel = await ModeOfTravelDataHandlerBase.GetModeOfTravelRecordByUid(dbHandler,  uid);
                  }

                  if (modeOfTravel == null) {
                    modeOfTravel = ModeOfTravel();
                    modeOfTravel = JSONCopier.copyJsonDataToModeOfTravel( dbHandler, jsonObject, modeOfTravel, true);
                    var rid =await  ModeOfTravelDataHandlerBase.AddModeOfTravelRecord(dbHandler,  modeOfTravel);
                  } else {
                    modeOfTravel = JSONCopier.copyJsonDataToModeOfTravel( dbHandler, jsonObject, modeOfTravel, false);
                    var rid = await ModeOfTravelDataHandlerBase.UpdateModeOfTravelRecord(dbHandler,  modeOfTravel.id, modeOfTravel);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ModeOfTravelsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncModeOfTravel() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncModeOfTravel() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncModeOfTravel() 3-> ' + e.toString());
  }
}


void downSyncNotes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetNotePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        NotesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': NotesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Note note;
                  var id = jsonObject['NoteID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    note =await  NoteDataHandlerBase.GetMasterNoteRecord(dbHandler,  id);
                  }

                  if (note == null && doDoubleCheck && uid != null && uid != '') {
                    note = await NoteDataHandlerBase.GetNoteRecordByUid(dbHandler,  uid);
                  }

                  if (note == null) {
                    note = Note();
                    note = JSONCopier.copyJsonDataToNote( dbHandler, jsonObject, note, true);
                    var rid = await NoteDataHandlerBase.AddNoteRecord(dbHandler,  note);
                  } else {
                    note = JSONCopier.copyJsonDataToNote( dbHandler, jsonObject, note, false);
                    var rid =await NoteDataHandlerBase.UpdateNoteRecord(dbHandler,  note.id, note);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) NotesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncNote() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncNote() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncNote() 3-> ' + e.toString());
  }
}


void downSyncNoteMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetNoteMediaPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        NoteMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': NoteMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  NoteMedia noteMedia;
                  var id = jsonObject['NoteMediaID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    noteMedia = NoteMediaDataHandlerBase.GetMasterNoteMediaRecord(dbHandler,  id);
                  }

                  if (noteMedia == null && doDoubleCheck && uid != null && uid != '') {
                    noteMedia = NoteMediaDataHandlerBase.GetNoteMediaRecordByUid(dbHandler,  uid);
                  }

                  if (noteMedia == null) {
                    noteMedia = NoteMedia();
                    noteMedia = JSONCopier.copyJsonDataToNoteMedia( dbHandler, jsonObject, noteMedia, true);
                    noteMedia.setIsUploaded('true');
                    var rid = NoteMediaDataHandlerBase.AddNoteMediaRecord(dbHandler,  noteMedia);
                  } else {
                    noteMedia = JSONCopier.copyJsonDataToNoteMedia( dbHandler, jsonObject, noteMedia, false);
                    var rid = NoteMediaDataHandlerBase.UpdateNoteMediaRecord(dbHandler,  noteMedia.id, noteMedia);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) NoteMediaPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncNoteMedia() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncNoteMedia() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncNoteMedia() 3-> ' + e.toString());
  }
  finally{}
}

void downSyncNotePermissions(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetNotePermissionPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        NotePermissionsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': NotePermissionsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  NotePermission notePermission;
                  var id = jsonObject['NotePermissionID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    notePermission = await NotePermissionDataHandlerBase.GetMasterNotePermissionRecord(dbHandler,  id);
                  }

                  if (notePermission == null && doDoubleCheck && uid != null && uid != '') {
                    notePermission = await NotePermissionDataHandlerBase.GetNotePermissionRecordByUid(dbHandler,  uid);
                  }

                  if (notePermission == null) {
                    notePermission = NotePermission();
                    notePermission = JSONCopier.copyJsonDataToNotePermission( dbHandler, jsonObject, notePermission, true);
                    var rid = await NotePermissionDataHandlerBase.AddNotePermissionRecord(dbHandler,  notePermission);
                  } else {
                    notePermission = JSONCopier.copyJsonDataToNotePermission( dbHandler, jsonObject, notePermission, false);
                    var rid =await  NotePermissionDataHandlerBase.UpdateNotePermissionRecord(dbHandler,  notePermission.id, notePermission);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) NotePermissionsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncNotePermission() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncNotePermission() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncNotePermission() 3-> ' + e.toString());
  }
}


void downSyncNotifications(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetNotificationPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        NotificationsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': NotificationsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Notification? notification;
                  var id = jsonObject['NotificationID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    notification = await NotificationDataHandlerBase.GetMasterNotificationRecord(dbHandler,  id);
                  }

                  if (notification == null && doDoubleCheck && uid != null && uid != '') {
                    notification = await NotificationDataHandlerBase.GetNotificationRecordByUid(dbHandler,  uid);
                  }

                  if (notification == null) {
                    notification = Notification();
                    notification = JSONCopier.copyJsonDataToNotification( dbHandler, jsonObject, notification, true);
                    var rid = await NotificationDataHandlerBase.AddNotificationRecord(dbHandler,  notification);
                  } else {
                    notification = JSONCopier.copyJsonDataToNotification( dbHandler, jsonObject, notification, false);
                    var rid = await  NotificationDataHandlerBase.UpdateNotificationRecord(dbHandler,  notification.id, notification);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) NotificationsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncNotification() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncNotification() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncNotification() 3-> ' + e.toString());
  } finally {}
}
void downSyncNotificationAssignments(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetNotificationAssignmentPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        NotificationAssignmentsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': NotificationAssignmentsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  NotificationAssignment? notificationAssignment;
                  var id = jsonObject['NotificationAssignmentID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    notificationAssignment = await NotificationAssignmentDataHandlerBase.GetMasterNotificationAssignmentRecord(dbHandler,  id);
                  }

                  if (notificationAssignment == null && doDoubleCheck && uid != null && uid != '') {
                    notificationAssignment =await  NotificationAssignmentDataHandlerBase.GetNotificationAssignmentRecordByUid(dbHandler,  uid);
                  }

                  if (notificationAssignment == null) {
                    notificationAssignment = NotificationAssignment();
                    notificationAssignment = JSONCopier.copyJsonDataToNotificationAssignment( dbHandler, jsonObject, notificationAssignment, true);
                    var rid = await NotificationAssignmentDataHandlerBase.AddNotificationAssignmentRecord(dbHandler,  notificationAssignment);
                  } else {
                    notificationAssignment = JSONCopier.copyJsonDataToNotificationAssignment( dbHandler, jsonObject, notificationAssignment, false);
                    var rid =await  NotificationAssignmentDataHandlerBase.UpdateNotificationAssignmentRecord(dbHandler,  notificationAssignment.id, notificationAssignment);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) NotificationAssignmentsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncNotificationAssignment() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            var responseBody = utf8.decode(response.bodyBytes);
            posterror += responseBody;
          } catch (e) {
            print(e.toString());
          }
        }

        LogError('VolleyError: SyncService:DownSyncNotificationAssignment() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncNotificationAssignment() 3-> ' + e.toString());
  } finally {}
}
void downSyncOpportunities(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunitiesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunitiesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              bool allAccountsPresent = ChekPresenceOfAccountIDLocally(jsonArray);

              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Opportunity ?opportunity;
                  var id = jsonObject['OpportunityID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunity = await OpportunityDataHandlerBase.GetMasterOpportunityRecord(dbHandler,  id);
                  }

                  if (opportunity == null && doDoubleCheck && uid != null && uid != '') {
                    opportunity = await OpportunityDataHandlerBase.GetOpportunityRecordByUid(dbHandler,  uid);
                  }

                  if (opportunity == null) {
                    opportunity = Opportunity();
                    opportunity = JSONCopier.copyJsonDataToOpportunity( dbHandler, jsonObject, opportunity, true);
                    var rid = OpportunityDataHandlerBase.AddOpportunityRecord(dbHandler,  opportunity);
                    if (opportunity.getCreatedBy() != Globals.AppUserLoginName && (IsForCurrentDate(opportunity.createdOn) || IsForCurrentDate(opportunity.modifiedOn))) {
                      // Create a reminder with 'New opportunity assigned: ' + opportunity title. Time = current datetime + 2;
                      new HSReminder().saveReminderData('', rid.toString(), 'New opportunity assigned', opportunity.opportunityName);
                    }
                  } else {
                    opportunity = JSONCopier.copyJsonDataToOpportunity( dbHandler, jsonObject, opportunity, false);
                    var rid = await OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id, opportunity);
                  }
                }
              }

              if (allAccountsPresent) {
                bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
                if (isAllPagesDone) OpportunitiesPageCurrent = 0;
              }
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunity() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            posterror += utf8.decode(response.bodyBytes);
          } catch (e) {
            e.printStackTrace();
          }
        }

        LogError('VolleyError: SyncService:DownSyncOpportunity() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncOpportunity() 3-> ' + e.toString());
  }
}

void downSyncOpportunityApprovals(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityApprovalPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityApprovalsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityApprovalsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityApproval opportunityApproval;
                  var id = jsonObject['OpportunityApprovalID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityApproval = await OpportunityApprovalDataHandlerBase.GetMasterOpportunityApprovalRecord(dbHandler,  id);
                  }

                  if (opportunityApproval == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityApproval = await OpportunityApprovalDataHandlerBase.GetOpportunityApprovalRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityApproval == null) {
                    opportunityApproval = OpportunityApproval();
                    opportunityApproval = JSONCopier.copyJsonDataToOpportunityApproval( dbHandler, jsonObject, opportunityApproval, true);
                    var rid = await OpportunityApprovalDataHandlerBase.AddOpportunityApprovalRecord(dbHandler,  opportunityApproval);
                  } else {
                    opportunityApproval = JSONCopier.copyJsonDataToOpportunityApproval( dbHandler, jsonObject, opportunityApproval, false);
                    var rid = await OpportunityApprovalDataHandlerBase.UpdateOpportunityApprovalRecord(dbHandler,  opportunityApproval.id, opportunityApproval);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityApprovalsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityApproval() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        }

        if (response.statusCode == 500) {
          try {
            posterror += utf8.decode(response.bodyBytes);
          } catch (e) {
            e.printStackTrace();
          }
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityApproval() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch ( e) {
    LogError('Error: SyncService:DownSyncOpportunityApproval() 3-> ' + e.toString());
  }
}


void downSyncOpportunityApprovalTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityApprovalTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityApprovalTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityApprovalTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityApprovalType? opportunityApprovalType;
                  var id = jsonObject['OpportunityApprovalTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityApprovalType = await  OpportunityApprovalTypeDataHandlerBase.GetMasterOpportunityApprovalTypeRecord(dbHandler,  id);
                  }

                  if (opportunityApprovalType == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityApprovalType =  await  OpportunityApprovalTypeDataHandlerBase.GetOpportunityApprovalTypeRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityApprovalType == null) {
                    opportunityApprovalType = OpportunityApprovalType();
                    opportunityApprovalType = JSONCopier.copyJsonDataToOpportunityApprovalType( dbHandler, jsonObject, opportunityApprovalType, true);
                    var rid = await OpportunityApprovalTypeDataHandlerBase.AddOpportunityApprovalTypeRecord(dbHandler,  opportunityApprovalType);
                  } else {
                    opportunityApprovalType = JSONCopier.copyJsonDataToOpportunityApprovalType( dbHandler, jsonObject, opportunityApprovalType, false);
                    var rid = await  OpportunityApprovalTypeDataHandlerBase.UpdateOpportunityApprovalTypeRecord(dbHandler,  opportunityApprovalType.id, opportunityApprovalType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityApprovalTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityApprovalType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        }

        if (response.statusCode == 500) {
          try {
            posterror += utf8.decode(response.bodyBytes);
          } catch (e) {
            e.printStackTrace();
          }
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityApprovalType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityApprovalType() 3-> ' + e.toString());
  }
}


void downSyncOpportunityBusinessUnits(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityBusinessUnitPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityBusinessUnitsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityBusinessUnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityBusinessUnit opportunityBusinessUnit;
                  var id = jsonObject['OpportunityBusinessUnitID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityBusinessUnit = OpportunityBusinessUnitDataHandlerBase.GetMasterOpportunityBusinessUnitRecord(dbHandler,  id);
                  }

                  if (opportunityBusinessUnit == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityBusinessUnit = OpportunityBusinessUnitDataHandlerBase.GetOpportunityBusinessUnitRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityBusinessUnit == null) {
                    opportunityBusinessUnit = OpportunityBusinessUnit();
                    opportunityBusinessUnit = JSONCopier.copyJsonDataToOpportunityBusinessUnit( dbHandler, jsonObject, opportunityBusinessUnit, true);
                    var rid = OpportunityBusinessUnitDataHandlerBase.AddOpportunityBusinessUnitRecord(dbHandler,  opportunityBusinessUnit);
                  } else {
                    opportunityBusinessUnit = JSONCopier.copyJsonDataToOpportunityBusinessUnit( dbHandler, jsonObject, opportunityBusinessUnit, false);
                    var rid = OpportunityBusinessUnitDataHandlerBase.UpdateOpportunityBusinessUnitRecord(dbHandler,  opportunityBusinessUnit.id, opportunityBusinessUnit);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityBusinessUnitsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityBusinessUnit() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            posterror += utf8.decode(response.bodyBytes);
          } catch (e) {
            e.printStackTrace();
          }
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityBusinessUnit() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityBusinessUnit() 3-> ' + e.toString());
  }
}

void downSyncOpportunityContacts(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityContactPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityContactsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityContactsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityContact ?opportunityContact;
                  var id = jsonObject['OpportunityContactID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityContact = await OpportunityContactHandlerDataBaseBase.GetMasterOpportunityContactRecord(dbHandler,  id);
                  }

                  if (opportunityContact == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityContact = await OpportunityContactHandlerDataBaseBase.GetOpportunityContactRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityContact == null) {
                    opportunityContact = OpportunityContact();
                    opportunityContact = JSONCopier.copyJsonDataToOpportunityContact( dbHandler, jsonObject, opportunityContact, true);
                    var rid = await OpportunityContactHandlerDataBaseBase.AddOpportunityContactRecord(dbHandler,  opportunityContact);
                  } else {
                    opportunityContact = JSONCopier.copyJsonDataToOpportunityContact( dbHandler, jsonObject, opportunityContact, false);
                    var rid = await OpportunityContactHandlerDataBaseBase.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContact);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityContactsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityContact() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        }

        if (response.statusCode == 500) {
          try {
            posterror += utf8.decode(response.bodyBytes);
          } catch (e) {
            e.printStackTrace();
          }
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityContact() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityContact() 3-> ' + e.toString());
  }
}


void downSyncOpportunityFulfillmentStatuses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityFulfillmentStatusPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityFulfillmentStatusesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityFulfillmentStatusesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityFulfillmentStatus? opportunityFulfillmentStatus;
                  var id = jsonObject['OpportunityFulfillmentStatusID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityFulfillmentStatus = await OpportunityFulfillmentStatusDataHandlerBase.GetMasterOpportunityFulfillmentStatusRecord(dbHandler,  id);
                  }

                  if (opportunityFulfillmentStatus == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityFulfillmentStatus = await OpportunityFulfillmentStatusDataHandlerBase.GetOpportunityFulfillmentStatusRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityFulfillmentStatus == null) {
                    opportunityFulfillmentStatus = OpportunityFulfillmentStatus();
                    opportunityFulfillmentStatus = JSONCopier.CopyJsonDataToOpportunityFulfillmentStatus( dbHandler, jsonObject, opportunityFulfillmentStatus, true);
                    var rid =  await OpportunityFulfillmentStatusDataHandlerBase.AddOpportunityFulfillmentStatusRecord(dbHandler,  opportunityFulfillmentStatus);
                  } else {
                    opportunityFulfillmentStatus = JSONCopier.CopyJsonDataToOpportunityFulfillmentStatus( dbHandler, jsonObject, opportunityFulfillmentStatus, false);
                    var rid = await OpportunityFulfillmentStatusDataHandlerBase.UpdateOpportunityFulfillmentStatusRecord(dbHandler,  opportunityFulfillmentStatus.id, opportunityFulfillmentStatus);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityFulfillmentStatusesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityFulfillmentStatus() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityFulfillmentStatus() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityFulfillmentStatus() 3-> ' + e.toString());
  }
}


void downSyncOpportunityMeasures(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityMeasurePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityMeasuresPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityMeasuresPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityMeasure? opportunityMeasure;
                  var id = jsonObject['OpportunityMeasureID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityMeasure = await OpportunityMeasureDataHandlerBase.GetMasterOpportunityMeasureRecord(dbHandler,  id);
                  }

                  if (opportunityMeasure == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityMeasure = await OpportunityMeasureDataHandlerBase.GetOpportunityMeasureRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityMeasure == null) {
                    opportunityMeasure = OpportunityMeasure();
                    opportunityMeasure = JSONCopier.CopyJsonDataToOpportunityMeasure( dbHandler, jsonObject, opportunityMeasure, true);
                    var rid = await OpportunityMeasureDataHandlerBase.AddOpportunityMeasureRecord(dbHandler,  opportunityMeasure);
                  } else {
                    opportunityMeasure = JSONCopier.CopyJsonDataToOpportunityMeasure( dbHandler, jsonObject, opportunityMeasure, false);
                    var rid =await  OpportunityMeasureDataHandlerBase.UpdateOpportunityMeasureRecord(dbHandler,  opportunityMeasure.id, opportunityMeasure);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityMeasuresPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityMeasure() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityMeasure() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityMeasure() 3-> ' + e.toString());
  }
}

void downSyncOpportunityMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityMediaPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityMedia opportunityMedia;
                  var id = jsonObject['OpportunityMediaID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityMedia =await  OpportunityMediaDataHandlerBase.GetMasterOpportunityMediaRecord(dbHandler,  id);
                  }

                  if (opportunityMedia == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityMedia = await OpportunityMediaDataHandlerBase.GetOpportunityMediaRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityMedia == null) {
                    opportunityMedia = OpportunityMedia();
                    opportunityMedia = await JSONCopier.copyJsonDataToOpportunityMedia( dbHandler, jsonObject, opportunityMedia, true);
                    opportunityMedia.isUploaded = ('true');
                    var rid = await OpportunityMediaDataHandlerBase.AddOpportunityMediaRecord(dbHandler,  opportunityMedia);
                  } else {
                    opportunityMedia = JSONCopier.copyJsonDataToOpportunityMedia( dbHandler, jsonObject, opportunityMedia, false);
                    var rid = OpportunityMediaDataHandlerBase.UpdateOpportunityMediaRecord(dbHandler,  opportunityMedia.id, opportunityMedia);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityMediaPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityMedia() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityMedia() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityMedia() 3-> ' + e.toString());
  }
}


void downSyncOpportunityNames(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityNamePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityNamesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityNamesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityName ?opportunityName;
                  var id = jsonObject['OpportunityNameID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityName = await OpportunityNameDataHandlerBase.GetMasterOpportunityNameRecord(dbHandler,  id);
                  }

                  if (opportunityName == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityName = await OpportunityNameDataHandlerBase.GetOpportunityNameRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityName == null) {
                    opportunityName = OpportunityName();
                    opportunityName = JSONCopier.copyJsonDataToOpportunityName( dbHandler, jsonObject, opportunityName, true);
                    var rid = await  OpportunityNameDataHandlerBase.AddOpportunityNameRecord(dbHandler,  opportunityName);
                  } else {
                    opportunityName = JSONCopier.copyJsonDataToOpportunityName( dbHandler, jsonObject, opportunityName, false);
                    var rid = await OpportunityNameDataHandlerBase.UpdateOpportunityNameRecord(dbHandler,  opportunityName.id, opportunityName);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityNamesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityName() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityName() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityName() 3-> ' + e.toString());
  }
}


void downSyncOpportunityPermissions(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityPermissionPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityPermissionsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityPermissionsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.lMaxDate,
          'objectdate2': dataItem.sMaxDate,
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityPermission? opportunityPermission;
                  var id = jsonObject['OpportunityPermissionID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityPermission = await OpportunityPermissionDataHandlerBase.GetMasterOpportunityPermissionRecord(dbHandler,  id);
                  }

                  if (opportunityPermission == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityPermission = await OpportunityPermissionDataHandlerBase.GetOpportunityPermissionRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityPermission == null) {
                    opportunityPermission = OpportunityPermission();
                    opportunityPermission = JSONCopier.copyJsonDataToOpportunityPermission( dbHandler, jsonObject, opportunityPermission, true);
                    var rid = await  OpportunityPermissionDataHandlerBase.AddOpportunityPermissionRecord(dbHandler,  opportunityPermission);
                  } else {
                    opportunityPermission = JSONCopier.copyJsonDataToOpportunityPermission( dbHandler, jsonObject, opportunityPermission, false);
                    var rid = await OpportunityPermissionDataHandlerBase.UpdateOpportunityPermissionRecord(dbHandler,  opportunityPermission.id, opportunityPermission);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityPermissionsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityPermission() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityPermission() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityPermission() 3-> ' + e.toString());
  }
}


void downSyncOpportunityProducts(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityProductPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityProductsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityProductsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityProduct opportunityProduct;
                  var id = jsonObject['OpportunityProductID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityProduct = OpportunityProductDataHandlerBase.GetMasterOpportunityProductRecord(dbHandler,  id);
                  }

                  if (opportunityProduct == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityProduct = OpportunityProductDataHandlerBase.GetOpportunityProductRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityProduct == null) {
                    opportunityProduct = OpportunityProduct();
                    opportunityProduct = JSONCopier.copyJsonDataToOpportunityProduct( dbHandler, jsonObject, opportunityProduct, true);
                    var rid = OpportunityProductDataHandlerBase.AddOpportunityProductRecord(dbHandler,  opportunityProduct);
                  } else {
                    opportunityProduct = JSONCopier.copyJsonDataToOpportunityProduct( dbHandler, jsonObject, opportunityProduct, false);
                    var rid = OpportunityProductDataHandlerBase.UpdateOpportunityProductRecord(dbHandler,  opportunityProduct.id, opportunityProduct);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityProductsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityProduct() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityProduct() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityProduct() 3-> ' + e.toString());
  }
}


void downSyncOpportunityProductDetails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityProductDetailPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityProductDetailsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityProductDetailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityProductDetail opportunityProductDetail;
                  var id = jsonObject['OpportunityProductDetailID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityProductDetail = OpportunityProductDetailDataHandlerBase.GetMasterOpportunityProductDetailRecord(dbHandler,  id);
                  }

                  if (opportunityProductDetail == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityProductDetail = OpportunityProductDetailDataHandlerBase.GetOpportunityProductDetailRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityProductDetail == null) {
                    opportunityProductDetail = OpportunityProductDetail();
                    opportunityProductDetail = JSONCopier.copyJsonDataToOpportunityProductDetail( dbHandler, jsonObject, opportunityProductDetail, true);
                    var rid = OpportunityProductDetailDataHandlerBase.AddOpportunityProductDetailRecord(dbHandler,  opportunityProductDetail);
                  } else {
                    opportunityProductDetail = JSONCopier.copyJsonDataToOpportunityProductDetail( dbHandler, jsonObject, opportunityProductDetail, false);
                    var rid = OpportunityProductDetailDataHandlerBase.UpdateOpportunityProductDetailRecord(dbHandler,  opportunityProductDetail.id, opportunityProductDetail);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityProductDetailsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityProductDetail() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityProductDetail() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityProductDetail() 3-> ' + e.toString());
  }
}


void downSyncOpportunityProductDetailAttributes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityProductDetailAttributePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityProductDetailAttributesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityProductDetailAttributesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityProductDetailAttribute opportunityProductDetailAttribute;
                  var id = jsonObject['OpportunityProductDetailAttributeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityProductDetailAttribute = OpportunityProductDetailAttributeDataHandlerBase.GetMasterOpportunityProductDetailAttributeRecord(dbHandler,  id);
                  }

                  if (opportunityProductDetailAttribute == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityProductDetailAttribute = OpportunityProductDetailAttributeDataHandlerBase.GetOpportunityProductDetailAttributeRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityProductDetailAttribute == null) {
                    opportunityProductDetailAttribute = OpportunityProductDetailAttribute();
                    opportunityProductDetailAttribute = JSONCopier.copyJsonDataToOpportunityProductDetailAttribute( dbHandler, jsonObject, opportunityProductDetailAttribute, true);
                    var rid = OpportunityProductDetailAttributeDataHandlerBase.AddOpportunityProductDetailAttributeRecord(dbHandler,  opportunityProductDetailAttribute);
                  } else {
                    opportunityProductDetailAttribute = JSONCopier.copyJsonDataToOpportunityProductDetailAttribute( dbHandler, jsonObject, opportunityProductDetailAttribute, false);
                    var rid = OpportunityProductDetailAttributeDataHandlerBase.UpdateOpportunityProductDetailAttributeRecord(dbHandler,  opportunityProductDetailAttribute.id, opportunityProductDetailAttribute);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityProductDetailAttributesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityProductDetailAttribute() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityProductDetailAttribute() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityProductDetailAttribute() 3-> ' + e.toString());
  }
}


void downSyncOpportunityStages(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityStagePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityStagesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityStagesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityStage opportunityStage;
                  var id = jsonObject['OpportunityStageID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityStage = OpportunityStageDataHandlerBase.GetMasterOpportunityStageRecord(dbHandler,  id);
                  }

                  if (opportunityStage == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityStage = OpportunityStageDataHandlerBase.GetOpportunityStageRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityStage == null) {
                    opportunityStage = OpportunityStage();
                    opportunityStage = JSONCopier.copyJsonDataToOpportunityStage( dbHandler, jsonObject, opportunityStage, true);
                    var rid = OpportunityStageDataHandlerBase.AddOpportunityStageRecord(dbHandler,  opportunityStage);
                  } else {
                    opportunityStage = JSONCopier.copyJsonDataToOpportunityStage( dbHandler, jsonObject, opportunityStage, false);
                    var rid = OpportunityStageDataHandlerBase.UpdateOpportunityStageRecord(dbHandler,  opportunityStage.id, opportunityStage);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityStagesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityStage() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityStage() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityStage() 3-> ' + e.toString());
  }
}


void downSyncOpportunityStageTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityStageTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityStageTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityStageTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityStageType ?opportunityStageType;
                  var id = jsonObject['OpportunityStageTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityStageType = OpportunityStageTypeDataHandlerBase.GetMasterOpportunityStageTypeRecord(dbHandler,  id);
                  }

                  if (opportunityStageType == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityStageType = OpportunityStageTypeDataHandlerBase.GetOpportunityStageTypeRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityStageType == null) {
                    opportunityStageType = OpportunityStageType();
                    opportunityStageType = JSONCopier.copyJsonDataToOpportunityStageType( dbHandler, jsonObject, opportunityStageType, true);
                    var rid = OpportunityStageTypeDataHandlerBase.AddOpportunityStageTypeRecord(dbHandler,  opportunityStageType);
                  } else {
                    opportunityStageType = JSONCopier.copyJsonDataToOpportunityStageType( dbHandler, jsonObject, opportunityStageType, false);
                    var rid = OpportunityStageTypeDataHandlerBase.UpdateOpportunityStageTypeRecord(dbHandler,  opportunityStageType.id, opportunityStageType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityStageTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityStageType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityStageType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityStageType() 3-> ' + e.toString());
  }
}


void downSyncOpportunityStatuses(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityStatusPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityStatusesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityStatusesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityStatus? opportunityStatus;
                  var id = jsonObject['OpportunityStatusID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityStatus = OpportunityStatusDataHandlerBase.GetMasterOpportunityStatusRecord(dbHandler,  id);
                  }

                  if (opportunityStatus == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityStatus = OpportunityStatusDataHandlerBase.GetOpportunityStatusRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityStatus == null) {
                    opportunityStatus = OpportunityStatus();
                    opportunityStatus = JSONCopier.copyJsonDataToOpportunityStatus( dbHandler, jsonObject, opportunityStatus, true);
                    var rid = OpportunityStatusDataHandlerBase.AddOpportunityStatusRecord(dbHandler,  opportunityStatus);
                  } else {
                    opportunityStatus = JSONCopier.copyJsonDataToOpportunityStatus( dbHandler, jsonObject, opportunityStatus, false);
                    var rid = OpportunityStatusDataHandlerBase.UpdateOpportunityStatusRecord(dbHandler,  opportunityStatus.id, opportunityStatus);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityStatusesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityStatus() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityStatus() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityStatus() 3-> ' + e.toString());
  }
}


void downSyncOpportunityTeams(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityTeamPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityTeamsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityTeamsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityTeam opportunityTeam;
                  var id = jsonObject['OpportunityTeamID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityTeam = OpportunityTeamDataHandlerBase.GetMasterOpportunityTeamRecord(dbHandler,  id);
                  }

                  if (opportunityTeam == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityTeam = OpportunityTeamDataHandlerBase.GetOpportunityTeamRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityTeam == null) {
                    opportunityTeam = OpportunityTeam();
                    opportunityTeam = JSONCopier.copyJsonDataToOpportunityTeam( dbHandler, jsonObject, opportunityTeam, true);
                    var rid = OpportunityTeamDataHandlerBase.AddOpportunityTeamRecord(dbHandler,  opportunityTeam);
                  } else {
                    opportunityTeam = JSONCopier.copyJsonDataToOpportunityTeam( dbHandler, jsonObject, opportunityTeam, false);
                    var rid = OpportunityTeamDataHandlerBase.UpdateOpportunityTeamRecord(dbHandler,  opportunityTeam.id, opportunityTeam);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityTeamsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityTeam() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityTeam() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityTeam() 3-> ' + e.toString());
  }
}


void downSyncOpportunityTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetOpportunityTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        OpportunityTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': OpportunityTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  OpportunityType ?opportunityType;
                  var id = jsonObject['OpportunityTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    opportunityType = await  OpportunityTypeDataHandlerBase.GetMasterOpportunityTypeRecord(dbHandler,  id);
                  }

                  if (opportunityType == null && doDoubleCheck && uid != null && uid != '') {
                    opportunityType = await  OpportunityTypeDataHandlerBase.GetOpportunityTypeRecordByUid(dbHandler,  uid);
                  }

                  if (opportunityType == null) {
                    opportunityType = OpportunityType();
                    opportunityType = JSONCopier.copyJsonDataToOpportunityType( dbHandler, jsonObject, opportunityType, true);
                    var rid = await OpportunityTypeDataHandlerBase.AddOpportunityTypeRecord(dbHandler,  opportunityType);
                  } else {
                    opportunityType = JSONCopier.copyJsonDataToOpportunityType( dbHandler, jsonObject, opportunityType, false);
                    var rid = await OpportunityTypeDataHandlerBase.UpdateOpportunityTypeRecord(dbHandler,  opportunityType.id, opportunityType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) OpportunityTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncOpportunityType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncOpportunityType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncOpportunityType() 3-> ' + e.toString());
  }
}



void downSyncPerformanceSummaries(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetPerformanceSummaryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        PerformanceSummariesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': PerformanceSummariesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  PerformanceSummary? performanceSummary;
                  var id = jsonObject['PerformanceSummaryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    performanceSummary =  await PerformanceSummaryDataHandlerBase.GetMasterPerformanceSummaryRecord(dbHandler,  id);
                  }

                  if (performanceSummary == null && doDoubleCheck && uid != null && uid != '') {
                    performanceSummary = await  PerformanceSummaryDataHandlerBase.GetPerformanceSummaryRecordByUid(dbHandler,  uid);
                  }

                  if (performanceSummary == null) {
                    performanceSummary = PerformanceSummary();
                    performanceSummary = JSONCopier.copyJsonDataToPerformanceSummary( dbHandler, jsonObject, performanceSummary, true);
                    var rid = await  PerformanceSummaryDataHandlerBase.AddPerformanceSummaryRecord(dbHandler,  performanceSummary);
                  } else {
                    performanceSummary = JSONCopier.copyJsonDataToPerformanceSummary( dbHandler, jsonObject, performanceSummary, false);
                    var rid =  await PerformanceSummaryDataHandlerBase.UpdatePerformanceSummaryRecord(dbHandler,  performanceSummary.id, performanceSummary);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) PerformanceSummariesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncPerformanceSummary() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncPerformanceSummary() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncPerformanceSummary() 3-> ' + e.toString());
  }
}


void downSyncPhoneTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetPhoneTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        PhoneTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': PhoneTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  PhoneType? phoneType;
                  var id = jsonObject['PhoneTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    phoneType = PhoneTypeDataHandlerBase.GetMasterPhoneTypeRecord(dbHandler,  id);
                  }

                  if (phoneType == null && doDoubleCheck && uid != null && uid != '') {
                    phoneType = PhoneTypeDataHandlerBase.GetPhoneTypeRecordByUid(dbHandler,  uid);
                  }

                  if (phoneType == null) {
                    phoneType = PhoneType();
                    phoneType = JSONCopier.CopyJsonDataToPhoneType( dbHandler, jsonObject, phoneType, true);
                    var rid = PhoneTypeDataHandlerBase.AddPhoneTypeRecord(dbHandler,  phoneType);
                  } else {
                    phoneType = JSONCopier.CopyJsonDataToPhoneType( dbHandler, jsonObject, phoneType, false);
                    var rid = PhoneTypeDataHandlerBase.UpdatePhoneTypeRecord(dbHandler,  phoneType.id, phoneType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) PhoneTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncPhoneType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncPhoneType() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncPhoneType() 3-> ' + e.toString());
  }
}


void downSyncProducts(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Product? product;
                  var id = jsonObject['ProductID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    product = ProductDataHandlerBase.GetMasterProductRecord(dbHandler,  id);
                  }

                  if (product == null && doDoubleCheck && uid != null && uid != '') {
                    product = ProductDataHandlerBase.GetProductRecordByUid(dbHandler,  uid);
                  }

                  if (product == null) {
                    product = Product();
                    product = JSONCopier.copyJsonDataToProduct( dbHandler, jsonObject, product, true);
                    var rid = ProductDataHandlerBase.AddProductRecord(dbHandler,  product);
                  } else {
                    product = JSONCopier.copyJsonDataToProduct( dbHandler, jsonObject, product, false);
                    var rid = ProductDataHandlerBase.UpdateProductRecord(dbHandler,  product.id, product);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProduct() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProduct() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProduct() 3-> ' + e.toString());
  }
}


void downSyncProductAuxiliaries(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductAuxiliaryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductAuxiliariesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductAuxiliariesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ProductAuxiliary? productAuxiliary;
                  var id = jsonObject['ProductAuxiliaryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    productAuxiliary = ProductAuxiliaryDataHandlerBase.GetMasterProductAuxiliaryRecord(dbHandler,  id);
                  }

                  if (productAuxiliary == null && doDoubleCheck && uid != null && uid != '') {
                    productAuxiliary = ProductAuxiliaryDataHandlerBase.GetProductAuxiliaryRecordByUid(dbHandler,  uid);
                  }

                  if (productAuxiliary == null) {
                    productAuxiliary = ProductAuxiliary();
                    productAuxiliary = JSONCopier.copyJsonDataToProductAuxiliary( dbHandler, jsonObject, productAuxiliary, true);
                    var rid = ProductAuxiliaryDataHandlerBase.AddProductAuxiliaryRecord(dbHandler,  productAuxiliary);
                  } else {
                    productAuxiliary = JSONCopier.copyJsonDataToProductAuxiliary( dbHandler, jsonObject, productAuxiliary, false);
                    var rid = ProductAuxiliaryDataHandlerBase.UpdateProductAuxiliaryRecord(dbHandler,  productAuxiliary.id, productAuxiliary);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductAuxiliariesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProductAuxiliary() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProductAuxiliary() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProductAuxiliary() 3-> ' + e.toString());
  }
}


void downSyncProductCategories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductCategoryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductCategoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductCategoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ProductCategory ?productCategory;
                  var id = jsonObject['ProductCategoryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    productCategory = await ProductCategoryDataHandlerBase.GetMasterProductCategoryRecord(dbHandler,  id);
                  }

                  if (productCategory == null && doDoubleCheck && uid != null && uid != '') {
                    productCategory = await ProductCategoryDataHandlerBase.GetProductCategoryRecordByUid(dbHandler,  uid);
                  }

                  if (productCategory == null) {
                    productCategory = ProductCategory();
                    productCategory = JSONCopier.copyJsonDataToProductCategory( dbHandler, jsonObject, productCategory, true);
                    var rid = await ProductCategoryDataHandlerBase.AddProductCategoryRecord(dbHandler,  productCategory);
                  } else {
                    productCategory = JSONCopier.copyJsonDataToProductCategory( dbHandler, jsonObject, productCategory, false);
                    var rid =await ProductCategoryDataHandlerBase.UpdateProductCategoryRecord(dbHandler,  productCategory.id, productCategory);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductCategoriesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProductCategory() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProductCategory() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProductCategory() 3-> ' + e.toString());
  }
}


void downSyncProductInstallations(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductInstallationPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductInstallationsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductInstallationsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ProductInstallation? productInstallation;
                  var id = jsonObject['ProductInstallationID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    productInstallation = ProductInstallationDataHandlerBase.GetMasterProductInstallationRecord(dbHandler,  id);
                  }

                  if (productInstallation == null && doDoubleCheck && uid != null && uid != '') {
                    productInstallation = ProductInstallationDataHandlerBase.GetProductInstallationRecordByUid(dbHandler,  uid);
                  }

                  if (productInstallation == null) {
                    productInstallation = ProductInstallation();
                    productInstallation = JSONCopier.copyJsonDataToProductInstallation( dbHandler, jsonObject, productInstallation, true);
                    var rid = ProductInstallationDataHandlerBase.AddProductInstallationRecord(dbHandler,  productInstallation);
                  } else {
                    productInstallation = JSONCopier.copyJsonDataToProductInstallation( dbHandler, jsonObject, productInstallation, false);
                    var rid = ProductInstallationDataHandlerBase.UpdateProductInstallationRecord(dbHandler,  productInstallation.id, productInstallation);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductInstallationsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProductInstallation() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProductInstallation() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProductInstallation() 3-> ' + e.toString());
  }
}


void downSyncProductInstallationDetails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductInstallationDetailPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductInstallationDetailsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductInstallationDetailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ProductInstallationDetail? productInstallationDetail;
                  var id = jsonObject['ProductInstallationDetailID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    productInstallationDetail = await ProductInstallationDetailDataHandlerBase.GetMasterProductInstallationDetailRecord(dbHandler,  id);
                  }

                  if (productInstallationDetail == null && doDoubleCheck && uid != null && uid != '') {
                    productInstallationDetail = await ProductInstallationDetailDataHandlerBase.GetProductInstallationDetailRecordByUid(dbHandler,  uid);
                  }

                  if (productInstallationDetail == null) {
                    productInstallationDetail = ProductInstallationDetail();
                    productInstallationDetail = JSONCopier.copyJsonDataToProductInstallationDetail( dbHandler, jsonObject, productInstallationDetail, true);
                    var rid = await  ProductInstallationDetailDataHandlerBase.AddProductInstallationDetailRecord(dbHandler,  productInstallationDetail);
                  } else {
                    productInstallationDetail = JSONCopier.copyJsonDataToProductInstallationDetail( dbHandler, jsonObject, productInstallationDetail, false);
                    var rid =  await ProductInstallationDetailDataHandlerBase.UpdateProductInstallationDetailRecord(dbHandler,  productInstallationDetail.id, productInstallationDetail);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductInstallationDetailsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProductInstallationDetail() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProductInstallationDetail() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProductInstallationDetail() 3-> ' + e.toString());
  }
}


void downSyncProductMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetProductMediaPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ProductMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ProductMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ProductMedia? productMedia;
                  var id = jsonObject['ProductMediaID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    productMedia =  await ProductMediaDataHandlerBase.GetMasterProductMediaRecord(dbHandler,  id);
                  }

                  if (productMedia == null && doDoubleCheck && uid != null && uid != '') {
                    productMedia = await ProductMediaDataHandlerBase.GetProductMediaRecordByUid(dbHandler,  uid);
                  }

                  if (productMedia == null) {
                    productMedia = ProductMedia();
                    productMedia = JSONCopier.copyJsonDataToProductMedia( dbHandler, jsonObject, productMedia, true);
                    var rid = await ProductMediaDataHandlerBase.AddProductMediaRecord(dbHandler,  productMedia);
                  } else {
                    productMedia = JSONCopier.copyJsonDataToProductMedia( dbHandler, jsonObject, productMedia, false);
                    var rid = await ProductMediaDataHandlerBase.UpdateProductMediaRecord(dbHandler,  productMedia.id, productMedia);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ProductMediaPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncProductMedia() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncProductMedia() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncProductMedia() 3-> ' + e.toString());
  }
}

void downSyncReimbursements(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetReimbursementPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ReimbursementsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ReimbursementsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Reimbursement reimbursement;
                  var id = jsonObject['ReimbursementID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    reimbursement = await ReimbursementDataHandlerBase.GetMasterReimbursementRecord(dbHandler,  id);
                  }

                  if (reimbursement == null && doDoubleCheck && uid != null && uid != '') {
                    reimbursement = await ReimbursementDataHandlerBase.GetReimbursementRecordByUid(dbHandler,  uid);
                  }

                  if (reimbursement == null) {
                    reimbursement = Reimbursement();
                    reimbursement = JSONCopier.copyJsonDataToReimbursement( dbHandler, jsonObject, reimbursement, true);
                    var rid =  await ReimbursementDataHandlerBase.AddReimbursementRecord(dbHandler,  reimbursement);
                  } else {
                    reimbursement = JSONCopier.copyJsonDataToReimbursement( dbHandler, jsonObject, reimbursement, false);
                    var rid = await ReimbursementDataHandlerBase.UpdateReimbursementRecord(dbHandler,  reimbursement.id, reimbursement);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ReimbursementsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncReimbursement() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncReimbursement() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncReimbursement() 3-> ' + e.toString());
  }
}

void downSyncReimbursementDetails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetReimbursementDetailPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ReimbursementDetailsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ReimbursementDetailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ReimbursementDetail reimbursementDetail;
                  var id = jsonObject['ReimbursementDetailID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    reimbursementDetail =await  ReimbursementDetailDataHandlerBase.GetMasterReimbursementDetailRecord(dbHandler,  id);
                  }

                  if (reimbursementDetail == null && doDoubleCheck && uid != null && uid != '') {
                    reimbursementDetail = await ReimbursementDetailDataHandlerBase.GetReimbursementDetailRecordByUid(dbHandler,  uid);
                  }

                  if (reimbursementDetail == null) {
                    reimbursementDetail = ReimbursementDetail();
                    reimbursementDetail = JSONCopier.copyJsonDataToReimbursementDetail( dbHandler, jsonObject, reimbursementDetail, true);
                    var rid = await ReimbursementDetailDataHandlerBase.AddReimbursementDetailRecord(dbHandler,  reimbursementDetail);
                  } else {
                    reimbursementDetail = JSONCopier.copyJsonDataToReimbursementDetail( dbHandler, jsonObject, reimbursementDetail, false);
                    var rid = await ReimbursementDetailDataHandlerBase.UpdateReimbursementDetailRecord(dbHandler,  reimbursementDetail.id, reimbursementDetail);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ReimbursementDetailsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncReimbursementDetail() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        }

        String posterror = error != null ? error.toString() : '';

        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          posterror += utf8.decode(response.bodyBytes);
        }

        LogError('VolleyError: SyncService:DownSyncReimbursementDetail() 2-> ' + posterror);
        currentDownload = '';
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncReimbursementDetail() 3-> ' + e.toString());
  }
}

void downSyncReimbursementTypes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetReimbursementTypePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ReimbursementTypesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ReimbursementTypesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ReimbursementType? reimbursementType;
                  var id = jsonObject['ReimbursementTypeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    reimbursementType = await ReimbursementTypeDataHandlerBase.GetMasterReimbursementTypeRecord(dbHandler,  id);
                  }

                  if (reimbursementType == null && doDoubleCheck && uid != null && uid != '') {
                    reimbursementType = await ReimbursementTypeDataHandlerBase.GetReimbursementTypeRecordByUid(dbHandler,  uid);
                  }

                  if (reimbursementType == null) {
                    reimbursementType = ReimbursementType();
                    reimbursementType = JSONCopier.copyJsonDataToReimbursementType( dbHandler, jsonObject, reimbursementType, true);
                    var rid = await ReimbursementTypeDataHandlerBase.AddReimbursementTypeRecord(dbHandler,  reimbursementType);
                  } else {
                    reimbursementType = JSONCopier.copyJsonDataToReimbursementType( dbHandler, jsonObject, reimbursementType, false);
                    var rid = await ReimbursementTypeDataHandlerBase.UpdateReimbursementTypeRecord(dbHandler,  reimbursementType.id, reimbursementType);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ReimbursementTypesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncReimbursementType() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncReimbursementType() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncReimbursementType() 3-> ' + e.toString());
  }
}


void downSyncReminders(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetReminderPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        RemindersPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': RemindersPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Reminder reminder;
                  var id = jsonObject['ReminderID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    reminder = await ReminderDataHandlerBase.GetMasterReminderRecord(dbHandler,  id);
                  }

                  if (reminder == null && doDoubleCheck && uid != null && uid != '') {
                    reminder = await ReminderDataHandlerBase.GetReminderRecordByUid(dbHandler,  uid);
                  }

                  if (reminder == null) {
                    reminder = Reminder();
                    reminder = JSONCopier.copyJsonDataToReminder( dbHandler, jsonObject, reminder, true);
                    var rid = await ReminderDataHandlerBase.AddReminderRecord(dbHandler,  reminder);
                  } else {
                    reminder = JSONCopier.copyJsonDataToReminder( dbHandler, jsonObject, reminder, false);
                    var rid = await ReminderDataHandlerBase.UpdateReminderRecord(dbHandler,  reminder.id, reminder);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) RemindersPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncReminder() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncReminder() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncReminder() 3-> ' + e.toString());
  }
}
void downSyncResources(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetResourcePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ResourcesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ResourcesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Resource ?resource;
                  var id = jsonObject['ResourceID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    resource = await ResourceDataHandlerBase.GetMasterResourceRecord(dbHandler,  id);
                  }

                  if (resource == null && doDoubleCheck && uid != null && uid != '') {
                    resource =await ResourceDataHandlerBase.GetResourceRecordByUid(dbHandler,  uid);
                  }

                  if (resource == null) {
                    resource = Resource();
                    resource = JSONCopier.copyJsonDataToResource( dbHandler, jsonObject, resource, true);
                    var rid =  await ResourceDataHandlerBase.AddResourceRecord(dbHandler,  resource);
                  } else {
                    resource = JSONCopier.copyJsonDataToResource( dbHandler, jsonObject, resource, false);
                    var rid = await ResourceDataHandlerBase.UpdateResourceRecord(dbHandler,  resource.id, resource);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ResourcesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncResource() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncResource() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncResource() 3-> ' + e.toString());
  }
}
void downSyncServiceInvoices(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetServiceInvoicePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ServiceInvoicesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ServiceInvoicesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ServiceInvoice? serviceInvoice;
                  var id = jsonObject['ServiceInvoiceID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    serviceInvoice = await ServiceInvoiceDataHandlerBase.GetMasterServiceInvoiceRecord(dbHandler,  id);
                  }

                  if (serviceInvoice == null && doDoubleCheck && uid != null && uid != '') {
                    serviceInvoice = await ServiceInvoiceDataHandlerBase.GetServiceInvoiceRecordByUid(dbHandler,  uid);
                  }

                  if (serviceInvoice == null) {
                    serviceInvoice = ServiceInvoice();
                    serviceInvoice = JSONCopier.copyJsonDataToServiceInvoice( dbHandler, jsonObject, serviceInvoice, true);
                    var rid = await ServiceInvoiceDataHandlerBase.AddServiceInvoiceRecord(dbHandler,  serviceInvoice);
                  } else {
                    serviceInvoice = JSONCopier.copyJsonDataToServiceInvoice( dbHandler, jsonObject, serviceInvoice, false);
                    var rid = await ServiceInvoiceDataHandlerBase.UpdateServiceInvoiceRecord(dbHandler,  serviceInvoice.id, serviceInvoice);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ServiceInvoicesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncServiceInvoice() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncServiceInvoice() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncServiceInvoice() 3-> ' + e.toString());
  }
}


void downSyncServiceInvoiceDetails(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetServiceInvoiceDetailPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        ServiceInvoiceDetailsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': ServiceInvoiceDetailsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  ServiceInvoiceDetail? serviceInvoiceDetail;
                  var id = jsonObject['ServiceInvoiceDetailID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    serviceInvoiceDetail = await ServiceInvoiceDetailDataHandlerBase.GetMasterServiceInvoiceDetailRecord(dbHandler,  id);
                  }

                  if (serviceInvoiceDetail == null && doDoubleCheck && uid != null && uid != '') {
                    serviceInvoiceDetail = await ServiceInvoiceDetailDataHandlerBase.GetServiceInvoiceDetailRecordByUid(dbHandler,  uid);
                  }

                  if (serviceInvoiceDetail == null) {
                    serviceInvoiceDetail = ServiceInvoiceDetail();
                    serviceInvoiceDetail = JSONCopier.copyJsonDataToServiceInvoiceDetail( dbHandler, jsonObject, serviceInvoiceDetail, true);
                    var rid = await ServiceInvoiceDetailDataHandlerBase.AddServiceInvoiceDetailRecord(dbHandler,  serviceInvoiceDetail);
                  } else {
                    serviceInvoiceDetail = JSONCopier.copyJsonDataToServiceInvoiceDetail( dbHandler, jsonObject, serviceInvoiceDetail, false);
                    var rid = await ServiceInvoiceDetailDataHandlerBase.UpdateServiceInvoiceDetailRecord(dbHandler,  serviceInvoiceDetail.id, serviceInvoiceDetail);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) ServiceInvoiceDetailsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncServiceInvoiceDetail() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncServiceInvoiceDetail() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncServiceInvoiceDetail() 3-> ' + e.toString());
  }
}

void downSyncTags(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetTagPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        TagsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': TagsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Tag tag;
                  var id = jsonObject['TagID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    tag =await TagDataHandlerBase.GetMasterTagRecord(dbHandler,  id);
                  }

                  if (tag == null && doDoubleCheck && uid != null && uid != '') {
                    tag =  await TagDataHandlerBase.GetTagRecordByUid(dbHandler,  uid);
                  }

                  if (tag == null) {
                    tag = Tag();
                    tag =await JSONCopier.copyJsonDataToAccountCategoryMapping( dbHandler, jsonObject, tag, true);
                    var rid = await TagDataHandlerBase.AddTagRecord(dbHandler,  tag);
                  } else {
                    tag =  await JSONCopier.copyJsonDataToTag( dbHandler, jsonObject, tag, false);
                    var rid = await TagDataHandlerBase.UpdateTagRecord(dbHandler,  tag.id, tag);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) TagsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncTag() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncTag() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncTag() 3-> ' + e.toString());
  }
}

void downSyncTagGroups(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetTagGroupPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        TagGroupsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': TagGroupsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  TagGroup tagGroup;
                  var id = jsonObject['TagGroupID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    tagGroup = await TagGroupDataHandlerBase.GetMasterTagGroupRecord(dbHandler,  id);
                  }

                  if (tagGroup == null && doDoubleCheck && uid != null && uid != '') {
                    tagGroup =  await TagGroupDataHandlerBase.GetTagGroupRecordByUid(dbHandler,  uid);
                  }

                  if (tagGroup == null) {
                    tagGroup = TagGroup();
                    tagGroup = await JSONCopier.copyJsonDataToTagGroup( dbHandler, jsonObject, tagGroup, true);
                    var rid = await TagGroupDataHandlerBase.AddTagGroupRecord(dbHandler,  tagGroup);
                  } else {
                    tagGroup = await JSONCopier.copyJsonDataToTagGroup( dbHandler, jsonObject, tagGroup, false);
                    var rid =  await TagGroupDataHandlerBase.UpdateTagGroupRecord(dbHandler,  tagGroup.id, tagGroup);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) TagGroupsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncTagGroup() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncTagGroup() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncTagGroup() 3-> ' + e.toString());
  }
}


void downSyncTerritories(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetTerritoryPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        TerritoriesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': TerritoriesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Territory? territory;
                  var id = jsonObject['TerritoryID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    territory =  await TerritoryDataHandlerBase.GetMasterTerritoryRecord(dbHandler,  id);
                  }

                  if (territory == null && doDoubleCheck && uid != null && uid != '') {
                    territory =  await TerritoryDataHandlerBase.GetTerritoryRecordByUid(dbHandler,  uid);
                  }

                  if (territory == null) {
                    territory = Territory();
                    territory =  await JSONCopier.copyJsonDataToTerritory( dbHandler, jsonObject, territory, true);
                    var rid =  await TerritoryDataHandlerBase.AddTerritoryRecord(dbHandler,  territory);
                  } else {
                    territory = await  JSONCopier.copyJsonDataToTerritory( dbHandler, jsonObject, territory, false);
                    var rid = await TerritoryDataHandlerBase.UpdateTerritoryRecord(dbHandler,  territory.id, territory);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) TerritoriesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncTerritory() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncTerritory() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncTerritory() 3-> ' + e.toString());
  }
}

void downSyncTimeZones(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetTimeZonePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        TimeZonesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': TimeZonesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  TimeZone? timeZone;
                  var id = jsonObject['TimeZoneID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    timeZone =  await TimeZoneDataHandlerBase.GetMasterTimeZoneRecord(dbHandler,  id);
                  }

                  if (timeZone == null && doDoubleCheck && uid != null && uid != '') {
                    timeZone = await  TimeZoneDataHandlerBase.GetTimeZoneRecordByUid(dbHandler,  uid);
                  }

                  if (timeZone == null) {
                    timeZone = TimeZone();
                    timeZone = await  JSONCopier.copyJsonDataToTimeZone( dbHandler, jsonObject, timeZone, true);
                    var rid = await TimeZoneDataHandlerBase.AddTimeZoneRecord(dbHandler,  timeZone);
                  } else {
                    timeZone = await JSONCopier.copyJsonDataToTimeZone( dbHandler, jsonObject, timeZone, false);
                    var rid = await TimeZoneDataHandlerBase.UpdateTimeZoneRecord(dbHandler,  timeZone.id, timeZone);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) TimeZonesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncTimeZone() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncTimeZone() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncTimeZone() 3-> ' + e.toString());
  }
}
void downSyncTravelPurposes(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetTravelPurposePaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        TravelPurposesPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': TravelPurposesPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  TravelPurpose ?travelPurpose;
                  var id = jsonObject['TravelPurposeID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    travelPurpose = await TravelPurposeDataHandlerBase.GetMasterTravelPurposeRecord(dbHandler,  id);
                  }

                  if (travelPurpose == null && doDoubleCheck && uid != null && uid != '') {
                    travelPurpose = await TravelPurposeDataHandlerBase.GetTravelPurposeRecordByUid(dbHandler,  uid);
                  }

                  if (travelPurpose == null) {
                    travelPurpose = TravelPurpose();
                    travelPurpose =  await JSONCopier.copyJsonDataToTravelPurpose( dbHandler, jsonObject, travelPurpose, true);
                    var rid = await TravelPurposeDataHandlerBase.AddTravelPurposeRecord(dbHandler,  travelPurpose);
                  } else {
                    travelPurpose =  await JSONCopier.copyJsonDataToTravelPurpose( dbHandler, jsonObject, travelPurpose, false);
                    var rid = await TravelPurposeDataHandlerBase.UpdateTravelPurposeRecord(dbHandler,  travelPurpose.id, travelPurpose);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) TravelPurposesPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncTravelPurpose() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncTravelPurpose() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncTravelPurpose() 3-> ' + e.toString());
  }
}

void downSyncUnits(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetUnitPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        UnitsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': UnitsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  Unit unit;
                  var id = jsonObject['UnitID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    unit = await  UnitDataHandlerBase.GetMasterUnitRecord(dbHandler,  id);
                  }

                  if (unit == null && doDoubleCheck && uid != null && uid != '') {
                    unit = await  UnitDataHandlerBase.GetUnitRecordByUid(dbHandler,  uid);
                  }

                  if (unit == null) {
                    unit = Unit();
                    unit = JSONCopier.copyJsonDataToUnit( dbHandler, jsonObject, unit, true);
                    var rid =await UnitDataHandlerBase.AddUnitRecord(dbHandler,  unit);
                  } else {
                    unit = JSONCopier.copyJsonDataToUnit( dbHandler, jsonObject, unit, false);
                    var rid =  await UnitDataHandlerBase.UpdateUnitRecord(dbHandler,  unit.id, unit);
                  }
                }
              } 

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) UnitsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncUnit() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncUnit() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncUnit() 3-> ' + e.toString());
  }
}



void downSyncHSSupportTickets(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetHSSupportTicketPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        HSSupportTicketsPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': HSSupportTicketsPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  HSSupportTicket hSSupportTicket;
                  var id = jsonObject['HSSupportTicketID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    hSSupportTicket = await  HSSupportTicketDataHandlerBase.GetMasterHSSupportTicketRecord(dbHandler,  id);
                  }

                  if (hSSupportTicket == null && doDoubleCheck && uid != null && uid != '') {
                    hSSupportTicket = await HSSupportTicketDataHandlerBase.GetHSSupportTicketRecordByUid(dbHandler,  uid);
                  }

                  if (hSSupportTicket == null) {
                    hSSupportTicket = HSSupportTicket();
                    hSSupportTicket = JSONCopier.copyJsonDataToHSSupportTicket( dbHandler, jsonObject, hSSupportTicket, true);
                    var rid = await HSSupportTicketDataHandlerBase.AddHSSupportTicketRecord(dbHandler,  hSSupportTicket);
                  } else {
                    hSSupportTicket = JSONCopier.copyJsonDataToHSSupportTicket( dbHandler, jsonObject, hSSupportTicket, false);
                    var rid = await HSSupportTicketDataHandlerBase.UpdateHSSupportTicketRecord(dbHandler,  hSSupportTicket.id, hSSupportTicket);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) HSSupportTicketsPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncHSSupportTicket() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += utf8.decode(response.bodyBytes);
          }

          LogError('VolleyError: SyncService:DownSyncHSSupportTicket() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncHSSupportTicket() 3-> ' + e.toString());
  }
}


void downSyncHSSupportTicketMedia(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/GetHSSupportTicketMediaPaged';

      final AppSyncItem dataItem = SyncDataHandler.GetAppSyncItemRecord(dbHandler,  typeOfData);
      if (dataItem != null && dataItem.records != '0') {
        int records = Globals.tryParseInt(dataItem.records);
        int pageSize = Globals.tryParseInt(dataItem.pgSize);
        int totalPages = (records / pageSize).ceil();

        int pageNow = Globals.tryParseInt(dataItem.page);
        HSSupportTicketMediaPageCurrent = pageNow + 1;

        var postData = {
          'pageindex': HSSupportTicketMediaPageCurrent,
          'pagesize': pageSize,
          'objectdate1': dataItem.getLMaxDate(),
          'objectdate2': dataItem.getSMaxDate(),
        };

        final response = await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
          'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        });

        if (response.statusCode == 200) {
          try {
            final jsonArray = jsonDecode(response.body) as List<dynamic>;

            if (jsonArray != null) {
              for (var i = 0; i < jsonArray.length; i++) {
                var jsonObject = jsonArray[i];

                if (jsonObject != null) {
                  HSSupportTicketMedia hSSupportTicketMedia;
                  var id = jsonObject['HSSupportTicketMediaID'];
                  var uid = jsonObject['Uid'];

                  if (id != null && id != '') {
                    hSSupportTicketMedia = await HSSupportTicketMediaDataHandlerBase.GetMasterHSSupportTicketMediaRecord(dbHandler,  id);
                  }

                  if (hSSupportTicketMedia == null && doDoubleCheck && uid != null && uid != '') {
                    hSSupportTicketMedia = await HSSupportTicketMediaDataHandlerBase.GetHSSupportTicketMediaRecordByUid(dbHandler,  uid);
                  }

                  if (hSSupportTicketMedia == null) {
                    hSSupportTicketMedia = HSSupportTicketMedia();
                    hSSupportTicketMedia =  await JSONCopier.copyJsonDataToHSSupportTicketMedia( dbHandler, jsonObject, hSSupportTicketMedia, true);
                    var rid = await HSSupportTicketMediaDataHandlerBase.AddHSSupportTicketMediaRecord(dbHandler,  hSSupportTicketMedia);
                  } else {
                    hSSupportTicketMedia =  await JSONCopier.copyJsonDataToHSSupportTicketMedia( dbHandler, jsonObject, hSSupportTicketMedia, false);
                    var rid = await HSSupportTicketMediaDataHandlerBase.UpdateHSSupportTicketMediaRecord(dbHandler,  hSSupportTicketMedia.id, hSSupportTicketMedia);
                  }
                }
              }

              bool isAllPagesDone = UpdateDownSyncPageStatus(dataItem);
              if (isAllPagesDone) HSSupportTicketMediaPageCurrent = 0;
            } else {
              ResetRecordCount(dataItem);
            }
          } catch ( ex) {
            LogError('Error: SyncService:DownSyncHSSupportTicketMedia() 1-> ' + ex.toString());
          } finally {
            currentDownload = '';
          }
        } else {
          String posterror = error != null ? error.toString() : '';

          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = '';
          } else if (response.statusCode >= 500) {
            posterror += response.body;
          }

          LogError('VolleyError: SyncService:DownSyncHSSupportTicketMedia() 2-> ' + posterror);
          currentDownload = '';
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncHSSupportTicketMedia() 3-> ' + e.toString());
  }
}


void downSyncIDs(String typeOfData) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
      String url = AppConstants.API_VERSION_URL + '/DownSyncManager/Get$typeOfDataIDs';

      final response = await http.post(Uri.parse(url), body: jsonEncode({
        'pageindex': '1',
        'pagesize': '10000',
        'objectdate1': '2000-01-01',
        'objectdate2': '2050-01-01',
      }), headers: {
        'Authorization': 'Bearer ${Globals.USER_TOKEN}',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        if (response.body != null && response.body != '' && !response.body.startsWith('ERROR_')) {
          dbHandler.activateDeactivateRecords(typeOfData, response.body);
        }
      } else {
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else if (response.statusCode >= 500) {
          String posterror = response.body ?? '';
          LogError('Error: SyncService:DownSyncIDs() 3-> $typeOfData:$posterror');
        }
      }
    }
  } catch (e) {
    LogError('Error: SyncService:DownSyncIDs() 3-> $typeOfData:${e.toString()}');
  }
}

 String getPostDataString(Map<String, dynamic> params) {
    StringBuffer result = StringBuffer();
    try {
      bool first = true;

      params.forEach((key, value) {
        if (first) {
          first = false;
        } else {
          result.write("&");
        }

        result.write(Uri.encodeQueryComponent(key));
        result.write("=");
        result.write(Uri.encodeQueryComponent(value.toString()));
      });
    } catch (error) {
      Globals.handle("SyncService:GetPostDataString()", error);
    }
    return result.toString();
  }
}
