import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactAlignmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactCategoryDataHandlerBase.dart';
import 'package:logger/logger.dart';

import '../Handlers/AccountHandlers/AccountMappingDataHandler.dart';
import '../Handlers/AccountHandlers/AccountMappingDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandlerBase.dart';
import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityDataHandlerBase.dart';
import '../models/OtherModels/Reminder.dart';

import '../AppConstants.dart';
import '../Globals.dart';
import '../Handlers/AccountHandlers/AccountDataHandler.dart';
import '../Handlers/AccountHandlers/AccountDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandler.dart';
import '../Handlers/ActivityHandlers/ActivityProductDataHandler.dart';
import '../Handlers/ActivityHandlers/ActivityProductDetailDataHandler.dart';
import '../Handlers/DataBaseHandler.dart';
import '../Handlers/OpportunityHandlers/OpportunityContactDataHandler.dart';
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
import 'JsonCopier.dart';
import 'Utility.dart';

import 'package:http/http.dart' as http;

class SyncService{

    // Handler handler;

     static Long DEFAULT_SYNC_INTERVAL = (5 * 1000) as Long;
     static final String LOG_TAG = "HS_SYNC";
     static late DatabaseHandler dbHandler;

     static var logger = Logger();

    //  static Context context;
     bool isRunning = false;
     bool doDoubleCheck = true;
     static String currentDownload = "";
     static List upSyncList = [];
     static List UpSyncListApplog = [];
     static int totalRecordsToUpsync = 0;

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

     static bool isFirstDownloadCompleted = false;
     static int syncCount = 0;

     static final int MY_DEFAULT_TIMEOUT = 15000;


      Future<void> RunUpSync() async {
        try {

            totalRecordsToUpsync = 0;

            //Account
          List<Account> newOrModifiedAccountList = await AccountDataHandlerBase.GetAccountUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedAccountList.length > 0) {

  logger.d("New Or Modified Accounts - ${newOrModifiedAccountList.length}");
  
  // Logger.d("New Or Modified Accounts - ${newOrModifiedAccountList.length}");
  totalRecordsToUpsync += newOrModifiedAccountList.length;
}

for (Account account in newOrModifiedAccountList) {
  try {
    if (!upSyncList.contains("Account-${account.id}")) {
      upSyncList.add("Account-${account.id}");
      UpSyncAccount(account);
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
  totalRecordsToUpsync += newOrModifiedAccountCategoryMappingList.length;
}

for (AccountCategoryMapping accountCategoryMapping in newOrModifiedAccountCategoryMappingList) {
  try {
    if (!upSyncList.contains("AccountCategoryMapping-${accountCategoryMapping.id}")) {
      upSyncList.add("AccountCategoryMapping-${accountCategoryMapping.id}");
      UpSyncAccountCategoryMapping(accountCategoryMapping);
    }
  } catch (e) {
  }
  return;
}


            //Contact
          List<Contact> newOrModifiedContactList = await await ContactHandlerDataBase.GetContactUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedContactList.length > 0) {
  logger.d("New Or Modified Contacts - ${newOrModifiedContactList.length}");
  totalRecordsToUpsync += newOrModifiedContactList.length;
}

for (Contact contact in newOrModifiedContactList) {
  try {
    if (!upSyncList.contains("Contact-${contact.id}")) {
      upSyncList.add("Contact-${contact.id}");
      UpSyncContact(contact);
    }
  } catch (e) {
  }
  return;
}

// Activity
List<Activity> newOrModifiedActivityList = await  ActivityDataHandlerBase.GetActivityUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedActivityList.length > 0) {
  logger.d("New Or Modified Activities - ${newOrModifiedActivityList.length}");
  totalRecordsToUpsync += newOrModifiedActivityList.length;
}

for (Activity activity in newOrModifiedActivityList) {
  try {
    if (!upSyncList.contains("Activity-${activity.id}")) {
      upSyncList.add("Activity-${activity.id}");
      UpSyncActivity(activity);
    }
  } catch (e) {
  }
  return;
}

// Opportunity
List<Opportunity> newOrModifiedOpportunityList = await OpportunityDataHandlerBase.GetOpportunityUpSyncRecords(dbHandler, AppConstants.DB_RECORD_NEW_OR_MODIFIED);
if (newOrModifiedOpportunityList.length > 0) {
  Logger.d("New Or Modified Opportunities - ${newOrModifiedOpportunityList.length}");
  totalRecordsToUpsync += newOrModifiedOpportunityList.length;
}

for (Opportunity opportunity in newOrModifiedOpportunityList) {
  try {
    if (!upSyncList.contains("Opportunity-${opportunity.id}")) {
      upSyncList.add("Opportunity-${opportunity.id}");
      UpSyncOpportunity(opportunity);
    }
  } catch (e) {
  }
  return;
}



            //ActivityProduct
            List<String> newOrModifiedActivityIdList = await ActivityProductDataHandler.GetActivityProductUpSyncRecordsActivityIds(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityIdList.length > 0) {
                  Logger.d("New Or Modified ActivityProducts - ${newOrModifiedActivityIdList.length}");
                totalRecordsToUpsync += newOrModifiedActivityIdList.length;
            }
            for (String activityId in  newOrModifiedActivityIdList) {
                try {

                    String masterActivityId =  await ActivityDataHandlerBase.getServerId(dbHandler,  activityId);

                    if (masterActivityId != ("") && !upSyncList.contains("ActivityProduct-" + masterActivityId)) {

                        List<ActivityProduct> activityProductListOriginal = await ActivityProductDataHandler.GetActivityProductUpSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailListOriginal = await ActivityProductDetailDataHandler.GetActivityProductDetailUpSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        List<ActivityProduct> activityProductList = await  ActivityProductDataHandler.GetActivityProductUpSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailList = await ActivityProductDetailDataHandler.GetActivityProductDetailUpSyncRecordsByActivityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        //String serverActivityId = ActivityDataHandler.GetServerId(dbHandler,  activityId);

                        for (ActivityProduct activityProduct in activityProductList) {
                            activityProduct.activityID = (masterActivityId);
                            activityProduct.productID = await (ProductDataHandler.GetServerId(dbHandler,  activityProduct.productID ));
                        }

                        for (ActivityProductDetail activityProductDetail in activityProductDetailList) {
                            activityProductDetail.activityProductID = ("-1");
                            activityProductDetail.supplierAccountID =  await (AccountDataHandlerBase.getServerId(dbHandler,  activityProductDetail.supplierAccountID! ));
                        }

                        upSyncList.add("ActivityProduct-" + masterActivityId);
                        UpSyncActivityProduct(masterActivityId, activityProductListOriginal, activityProductDetailListOriginal, activityProductList, activityProductDetailList);
                    }

                } catch ( e) {
                }
                return;
            }

            //OpportunityProduct
            List<String> newOrModifiedOpportunityIdList =await  OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsOpportunityIds(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityIdList.length > 0) {
                Logger.d("New Or Modified OpportunityProducts - " + String.valueOf(newOrModifiedOpportunityIdList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityIdList.length;
            }
            for (String opportunityId in  newOrModifiedOpportunityIdList) {
                try {

                    String masterOpportunityId = await  OpportunityDataHandlerBase.GetServerId(dbHandler,  opportunityId);

                    if (masterOpportunityId !=("") && !upSyncList.contains("OpportunityProduct-" + masterOpportunityId)) {

                        List<OpportunityProduct> opportunityProductListOriginal = await OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailListOriginal = await OpportunityProductDetailDataHandler.GetOpportunityProductDetailUpSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        List<OpportunityProduct> opportunityProductList = await OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailList =await  OpportunityProductDetailDataHandler.GetOpportunityProductDetailUpSyncRecordsByOpportunityId(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        //String serverOpportunityId = OpportunityDataHandler.GetServerId(dbHandler,  opportunityId);

                        for (OpportunityProduct opportunityProduct in  opportunityProductList) {
                            opportunityProduct.opportunityID = (masterOpportunityId);
                            opportunityProduct.productID = (ProductDataHandler.GetServerId(dbHandler,  opportunityProduct.getProductID));
                        }

                        for (OpportunityProductDetail opportunityProductDetail in opportunityProductDetailList) {
                            opportunityProductDetail.opportunityProductID = ("-1");
                            opportunityProductDetail.supplierAccountID = await (AccountDataHandlerBase.getServerId(dbHandler,  opportunityProductDetail.supplierAccountID!));
                        }

                        upSyncList.add("OpportunityProduct-" + masterOpportunityId);
                        UpSyncOpportunityProduct(masterOpportunityId, opportunityProductListOriginal, opportunityProductDetailListOriginal, opportunityProductList, opportunityProductDetailList);
                    }
                } catch ( e) {
                }
                return;
            }

           /* //OpportunityProductDetailAttribute
            List<OpportunityProductDetailAttribute> newOrModifiedOpportunityProductDetailAttributeList = OpportunityProductDetailAttributeDataHandler.GetOpportunityProductDetailAttributeUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            Log.d(LOG_TAG, "New Or Modified OpportunityProductDetailAttributes - " + String.valueOf(newOrModifiedOpportunityProductDetailAttributeList.length));
            for (OpportunityProductDetailAttribute opportunityProductDetailAttribute in newOrModifiedOpportunityProductDetailAttributeList) {
                try {
                    if(!upSyncList.contains("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.id)) {
                        upSyncList.add("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.id);
                        UpSyncOpportunityProductDetailAttribute(opportunityProductDetailAttribute);
                    }
                } catch ( e) {
                }
                return;
            }*/

            //CustomerMeeting
            List<CustomerMeeting> newOrModifiedCustomerMeetingList = CustomerMeetingDataHandler.GetCustomerMeetingUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedCustomerMeetingList.length > 0) {
                Logger.d("New Or Modified CustomerMeetings - " + String.valueOf(newOrModifiedCustomerMeetingList.length));
                totalRecordsToUpsync += newOrModifiedCustomerMeetingList.length;
            }
            for (CustomerMeeting customerMeeting in newOrModifiedCustomerMeetingList) {
                try {
                    if (!upSyncList.contains("CustomerMeeting-" + customerMeeting.id)) {
                        upSyncList.add("CustomerMeeting-" + customerMeeting.id);
                        UpSyncCustomerMeeting(customerMeeting);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityContact
            List<OpportunityContact> newOrModifiedOpportunityContactList = OpportunityContactDataHandler.GetOpportunityContactUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityContactList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityContacts - " + String.valueOf(newOrModifiedOpportunityContactList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityContactList.length;
            }
            for (OpportunityContact opportunityContact in newOrModifiedOpportunityContactList) {
                try {
                    if (!upSyncList.contains("OpportunityContact-" + opportunityContact.id)) {
                        upSyncList.add("OpportunityContact-" + opportunityContact.id);
                        UpSyncOpportunityContact(opportunityContact);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountAddress
            List<AccountAddress> newOrModifiedAccountAddressList = AccountAddressDataHandler.GetAccountAddressUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountAddressList.length > 0) {
                Logger.d("New Or Modified AccountAddresses - " + String.valueOf(newOrModifiedAccountAddressList.length));
                totalRecordsToUpsync += newOrModifiedAccountAddressList.length;
            }
            for (AccountAddress accountAddress in newOrModifiedAccountAddressList) {
                try {
                    if (!upSyncList.contains("AccountAddress-" + accountAddress.id)) {
                        upSyncList.add("AccountAddress-" + accountAddress.id);
                        UpSyncAccountAddress(accountAddress);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountPhone
            List<AccountPhone> newOrModifiedAccountPhoneList = AccountPhoneDataHandler.GetAccountPhoneUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountPhoneList.length > 0) {
                Logger.d("New Or Modified AccountPhones - " + String.valueOf(newOrModifiedAccountPhoneList.length));
                totalRecordsToUpsync += newOrModifiedAccountPhoneList.length;
            }
            for (AccountPhone accountPhone in newOrModifiedAccountPhoneList) {
                try {
                    if (!upSyncList.contains("AccountPhone-" + accountPhone.id)) {
                        upSyncList.add("AccountPhone-" + accountPhone.id);
                        UpSyncAccountPhone(accountPhone);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountBuyingProcess
            List<AccountBuyingProcess> newOrModifiedAccountBuyingProcessList = AccountBuyingProcessDataHandler.GetAccountBuyingProcessUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBuyingProcessList.length > 0) {
                Logger.d("New Or Modified AccountBuyingProcesses - " + String.valueOf(newOrModifiedAccountBuyingProcessList.length));
                totalRecordsToUpsync += newOrModifiedAccountBuyingProcessList.length;
            }
            for (AccountBuyingProcess accountBuyingProcess in newOrModifiedAccountBuyingProcessList) {
                try {
                    if (!upSyncList.contains("AccountBuyingProcess-" + accountBuyingProcess.id)) {
                        upSyncList.add("AccountBuyingProcess-" + accountBuyingProcess.id);
                        UpSyncAccountBuyingProcess(accountBuyingProcess);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountBusinessPlan
            List<AccountBusinessPlan> newOrModifiedAccountBusinessPlanList = AccountBusinessPlanDataHandler.GetAccountBusinessPlanUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessPlanList.length > 0) {
                Logger.d("New Or Modified AccountBusinessPlans - " + String.valueOf(newOrModifiedAccountBusinessPlanList.length));
                totalRecordsToUpsync += newOrModifiedAccountBusinessPlanList.length;
            }
            for (AccountBusinessPlan accountBusinessPlan in newOrModifiedAccountBusinessPlanList) {
                try {
                    if (!upSyncList.contains("AccountBusinessPlan-" + accountBusinessPlan.id)) {
                        upSyncList.add("AccountBusinessPlan-" + accountBusinessPlan.id);
                        UpSyncAccountBusinessPlan(accountBusinessPlan);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountCompetitionActivity
            List<AccountCompetitionActivity> newOrModifiedAccountCompetitionActivityList = AccountCompetitionActivityDataHandler.GetAccountCompetitionActivityUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountCompetitionActivityList.length > 0) {
                Logger.d("New Or Modified AccountCompetitionActivities - " + String.valueOf(newOrModifiedAccountCompetitionActivityList.length));
                totalRecordsToUpsync += newOrModifiedAccountCompetitionActivityList.length;
            }
            for (AccountCompetitionActivity accountCompetitionActivity in newOrModifiedAccountCompetitionActivityList) {
                try {
                    if (!upSyncList.contains("AccountCompetitionActivity-" + accountCompetitionActivity.id)) {
                        upSyncList.add("AccountCompetitionActivity-" + accountCompetitionActivity.id);
                        UpSyncAccountCompetitionActivity(accountCompetitionActivity);
                    }
                } catch ( e) {
                }
                return;
            }

            //Note
            List<Note> newOrModifiedNoteList = NoteDataHandler.GetNoteUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteList.length > 0) {
                Logger.d("New Or Modified Notes - " + String.valueOf(newOrModifiedNoteList.length));
                totalRecordsToUpsync += newOrModifiedNoteList.length;
            }
            for (Note note in newOrModifiedNoteList) {
                try {
                    if (!upSyncList.contains("Note-" + note.id)) {
                        upSyncList.add("Note-" + note.id);
                        UpSyncNote(note);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravel
            List<ActivityTravel> newOrModifiedActivityTravelList = ActivityTravelDataHandler.GetActivityTravelUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelList.length > 0) {
                Logger.d("New Or Modified ActivityTravels - " + String.valueOf(newOrModifiedActivityTravelList.length));
                totalRecordsToUpsync += newOrModifiedActivityTravelList.length;
            }
            for (ActivityTravel activityTravel in newOrModifiedActivityTravelList) {
                try {
                    if (!upSyncList.contains("ActivityTravel-" + activityTravel.id)) {
                        upSyncList.add("ActivityTravel-" + activityTravel.id);
                        UpSyncActivityTravel(activityTravel);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountMedia
            List<AccountMedia> newOrModifiedAccountMediaList = AccountMediaDataHandler.GetAccountMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaList.length > 0) {
                Logger.d("New Or Modified AccountMedia - " + String.valueOf(newOrModifiedAccountMediaList.length));
                totalRecordsToUpsync += newOrModifiedAccountMediaList.length;
            }
            for (AccountMedia accountMedia in newOrModifiedAccountMediaList) {
                try {
                    if (!upSyncList.contains("AccountMedia-" + accountMedia.id)) {
                        upSyncList.add("AccountMedia-" + accountMedia.id);
                        UpSyncAccountMedia(accountMedia);
                    }
                } catch ( e) {
                }
                return;
            }


            //ContactMedia
            List<ContactMedia> newOrModifiedContactMediaList = ContactMediaDataHandler.GetContactMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaList.length > 0) {
                Logger.d("New Or Modified ContactMedia - " + String.valueOf(newOrModifiedContactMediaList.length));
                totalRecordsToUpsync += newOrModifiedContactMediaList.length;
            }
            for (ContactMedia contactMedia in newOrModifiedContactMediaList) {
                try {
                    if (!upSyncList.contains("ContactMedia-" + contactMedia.id)) {
                        upSyncList.add("ContactMedia-" + contactMedia.id);
                        UpSyncContactMedia(contactMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityMedia
            List<OpportunityMedia> newOrModifiedOpportunityMediaList = OpportunityMediaDataHandler.GetOpportunityMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaList.length > 0) {
                Logger.d("New Or Modified OpportunityMedia - " + String.valueOf(newOrModifiedOpportunityMediaList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityMediaList.length;
            }
            for (OpportunityMedia opportunityMedia in newOrModifiedOpportunityMediaList) {
                try {
                    if (!upSyncList.contains("OpportunityMedia-" + opportunityMedia.id)) {
                        upSyncList.add("OpportunityMedia-" + opportunityMedia.id);
                        UpSyncOpportunityMedia(opportunityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityMedia
            List<ActivityMedia> newOrModifiedActivityMediaList = ActivityMediaDataHandler.GetActivityMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaList.length > 0) {
                Logger.d("New Or Modified ActivityMedia - " + String.valueOf(newOrModifiedActivityMediaList.length));
                totalRecordsToUpsync += newOrModifiedActivityMediaList.length;
            }
            for (ActivityMedia activityMedia in newOrModifiedActivityMediaList) {
                try {
                    if (!upSyncList.contains("ActivityMedia-" + activityMedia.id)) {
                        upSyncList.add("ActivityMedia-" + activityMedia.id);
                        UpSyncActivityMedia(activityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //NoteMedia
            List<NoteMedia> newOrModifiedNoteMediaList = NoteMediaDataHandler.GetNoteMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaList.length > 0) {
                Logger.d("New Or Modified NoteMedia - " + String.valueOf(newOrModifiedNoteMediaList.length));
                totalRecordsToUpsync += newOrModifiedNoteMediaList.length;
            }
            for (NoteMedia noteMedia in newOrModifiedNoteMediaList) {
                try {
                    if (!upSyncList.contains("NoteMedia-" + noteMedia.id)) {
                        upSyncList.add("NoteMedia-" + noteMedia.id);
                        UpSyncNoteMedia(noteMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelMedia
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaList = ActivityTravelMediaDataHandler.GetActivityTravelMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaList.length > 0) {
                Logger.d("New Or Modified ActivityTravelMedia - " + String.valueOf(newOrModifiedActivityTravelMediaList.length));
                totalRecordsToUpsync += newOrModifiedActivityTravelMediaList.length;
            }
            for (ActivityTravelMedia activityMedia in newOrModifiedActivityTravelMediaList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMedia-" + activityMedia.id)) {
                        upSyncList.add("ActivityTravelMedia-" + activityMedia.id);
                        UpSyncActivityTravelMedia(activityMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelExpense
            List<ActivityTravelExpense> newOrModifiedActivityTravelExpenseList = ActivityTravelExpenseDataHandler.GetActivityTravelExpenseUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelExpenseList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelExpenses - " + String.valueOf(newOrModifiedActivityTravelExpenseList.length));
                totalRecordsToUpsync += newOrModifiedActivityTravelExpenseList.length;
            }
            for (ActivityTravelExpense activityTravelExpense in newOrModifiedActivityTravelExpenseList) {
                try {
                    if (!upSyncList.contains("ActivityTravelExpense-" + activityTravelExpense.id)) {
                        upSyncList.add("ActivityTravelExpense-" + activityTravelExpense.id);
                        UpSyncActivityTravelExpense(activityTravelExpense);
                    }
                } catch ( e) {
                }
                return;
            }

            //FieldAttendance
            List<FieldAttendance> newOrModifiedFieldAttendanceList = FieldAttendanceDataHandler.GetFieldAttendanceUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedFieldAttendanceList.length > 0) {
                Logger.d("New Or Modified FieldAttendances - " + String.valueOf(newOrModifiedFieldAttendanceList.length));
                totalRecordsToUpsync += newOrModifiedFieldAttendanceList.length;
            }
            for (FieldAttendance fieldAttendance in newOrModifiedFieldAttendanceList) {
                try {
                    if (!upSyncList.contains("FieldAttendance-" + fieldAttendance.id)) {
                        upSyncList.add("FieldAttendance-" + fieldAttendance.id);
                        //Get Address for PunchIn Location
                        if (!Globals.IsNullOrEmpty(fieldAttendance.getPunchInLocation())) {
                            JSONObject obj = new JSONObject(fieldAttendance.getPunchInLocation());
                            if (Globals.IsNullOrEmpty(obj.getString("address"))) {
                                if (!Globals.IsNullOrEmpty(Globals.GetLocationAddress( Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude"))))) {
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
                        if (!Globals.IsNullOrEmpty(fieldAttendance.getPunchOutLocation())) {
                            JSONObject jsonObjectPunchOut = new JSONObject(fieldAttendance.getPunchOutLocation());
                            if (Globals.IsNullOrEmpty(jsonObjectPunchOut.getString("address"))) {
                                if (!Globals.IsNullOrEmpty(Globals.GetLocationAddress( Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude"))))) {
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

                        UpSyncFieldAttendance(fieldAttendance);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserRemark
            List<AppUserRemark> newOrModifiedAppUserRemarkList = AppUserRemarkDataHandler.GetAppUserRemarkUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserRemarkList.length > 0) {
                Logger.d("New Or Modified AppUserRemarks - " + String.valueOf(newOrModifiedAppUserRemarkList.length));
                totalRecordsToUpsync += newOrModifiedAppUserRemarkList.length;
            }
            for (AppUserRemark appUserRemark in newOrModifiedAppUserRemarkList) {
                try {
                    if (!upSyncList.contains("AppUserRemark-" + appUserRemark.id)) {
                        upSyncList.add("AppUserRemark-" + appUserRemark.id);
                        UpSyncAppUserRemark(appUserRemark);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountForm
            List<AccountForm> newOrModifiedAccountFormList = AccountFormDataHandler.GetAccountFormUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountFormList.length > 0) {
                Logger.d("New Or Modified AccountForms - " + String.valueOf(newOrModifiedAccountFormList.length));
                totalRecordsToUpsync += newOrModifiedAccountFormList.length;
            }
            for (AccountForm accountForm in newOrModifiedAccountFormList) {
                try {
                    if (!upSyncList.contains("AccountForm-" + accountForm.id)) {
                        upSyncList.add("AccountForm-" + accountForm.id);
                        UpSyncAccountForm(accountForm);
                    }
                } catch ( e) {
                }
                return;
            }


            //AccountFormValue
            List<AccountForm> newOrModifiedAccountFormListForValuesUpSync = AccountFormDataHandler.GetMasterAccountFormRecordsForValuesUpSync(dbHandler, context);
            if (newOrModifiedAccountFormListForValuesUpSync.length > 0) {
                Logger.d("New Or Modified AccountFormValues - " + String.valueOf(newOrModifiedAccountFormListForValuesUpSync.length));
                totalRecordsToUpsync += newOrModifiedAccountFormListForValuesUpSync.length;
            }
            for (AccountForm accountForm in newOrModifiedAccountFormListForValuesUpSync) {
                try {
                    if (!upSyncList.contains("AccountFormValue-" + accountForm.id)) {
                        upSyncList.add("AccountFormValue-" + accountForm.id);
                        List<AccountFormValue> accountFormValuesOriginal = AccountFormValueDataHandler.GetAccountFormValueUpSyncRecordsByAccountFormId(dbHandler,  accountForm.id);
                        List<AccountFormValue> accountFormValues = AccountFormValueDataHandler.GetAccountFormValueUpSyncRecordsByAccountFormId(dbHandler,  accountForm.id);
                        for (AccountFormValue accountFormValue in accountFormValues) {
                            accountFormValue.setAccountFormID(AccountFormDataHandler.GetServerId(dbHandler,  accountFormValue.getAccountFormID()));
                            accountFormValue.setFormCellElementID(FormCellElementDataHandler.GetServerId(dbHandler,  accountFormValue.getFormCellElementID()));
                        }
                        UpSyncAccountFormValue(accountForm.id, accountFormValuesOriginal, accountFormValues);
                    }
                } catch ( e) {
                }
                return;
            }

            //Reimbursement
            List<Reimbursement> newOrModifiedReimbursementList = ReimbursementDataHandler.GetReimbursementUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementList.length > 0) {
                Logger.d("New Or Modified Reimbursements - " + String.valueOf(newOrModifiedReimbursementList.length));
                totalRecordsToUpsync += newOrModifiedReimbursementList.length;
            }
            for (Reimbursement reimbursement in newOrModifiedReimbursementList) {
                try {
                    if (!upSyncList.contains("Reimbursement-" + reimbursement.id)) {
                        upSyncList.add("Reimbursement-" + reimbursement.id);
                        UpSyncReimbursement(reimbursement);
                    }
                } catch ( e) {
                }
                return;
            }

            //ReimbursementDetail
            List<ReimbursementDetail> newOrModifiedReimbursementDetailList = ReimbursementDetailDataHandler.GetReimbursementDetailUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementDetailList.length > 0) {
                Logger.d("New Or Modified ReimbursementDetails - " + String.valueOf(newOrModifiedReimbursementDetailList.length));
                totalRecordsToUpsync += newOrModifiedReimbursementDetailList.length;
            }
            for (ReimbursementDetail reimbursementDetail in newOrModifiedReimbursementDetailList) {
                try {
                    if (!upSyncList.contains("ReimbursementDetail-" + reimbursementDetail.id)) {
                        upSyncList.add("ReimbursementDetail-" + reimbursementDetail.id);
                        UpSyncReimbursementDetail(reimbursementDetail);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityPermission
            List<ActivityPermission> newOrModifiedActivityPermissionList = ActivityPermissionDataHandler.GetActivityPermissionUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityPermissionList.length > 0) {
                Logger.d("New Or Modified ActivityPermissions - " + String.valueOf(newOrModifiedActivityPermissionList.length));
                totalRecordsToUpsync += newOrModifiedActivityPermissionList.length;
            }
            for (ActivityPermission activityPermission in newOrModifiedActivityPermissionList) {
                try {
                    if (!upSyncList.contains("ActivityPermission-" + activityPermission.id)) {
                        upSyncList.add("ActivityPermission-" + activityPermission.id);
                        UpSyncActivityPermission(activityPermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //NotePermission
            List<NotePermission> newOrModifiedNotePermissionList = NotePermissionDataHandler.GetNotePermissionUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNotePermissionList.length > 0) {
                Logger.d("New Or Modified NotePermissions - " + String.valueOf(newOrModifiedNotePermissionList.length));
                totalRecordsToUpsync += newOrModifiedNotePermissionList.length;
            }
            for (NotePermission notePermission in newOrModifiedNotePermissionList) {
                try {
                    if (!upSyncList.contains("NotePermission-" + notePermission.id)) {
                        upSyncList.add("NotePermission-" + notePermission.id);
                        UpSyncNotePermission(notePermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityPermission
            List<OpportunityPermission> newOrModifiedOpportunityPermissionList = OpportunityPermissionDataHandler.GetOpportunityPermissionUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityPermissionList.length > 0) {
                Logger.d("New Or Modified OpportunityPermissions - " + String.valueOf(newOrModifiedOpportunityPermissionList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityPermissionList.length;
            }
            for (OpportunityPermission opportunityPermission in newOrModifiedOpportunityPermissionList) {
                try {
                    if (!upSyncList.contains("OpportunityPermission-" + opportunityPermission.id)) {
                        upSyncList.add("OpportunityPermission-" + opportunityPermission.id);
                        UpSyncOpportunityPermission(opportunityPermission);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTeam
            List<ActivityTeam> newOrModifiedActivityTeamList = ActivityTeamDataHandler.GetActivityTeamUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTeamList.length > 0) {
                Logger.d("New Or Modified ActivityTeams - " + String.valueOf(newOrModifiedActivityTeamList.length));
                totalRecordsToUpsync += newOrModifiedActivityTeamList.length;
            }
            for (ActivityTeam activityTeam in newOrModifiedActivityTeamList) {
                try {
                    if (!upSyncList.contains("ActivityTeam-" + activityTeam.id)) {
                        upSyncList.add("ActivityTeam-" + activityTeam.id);
                        UpSyncActivityTeam(activityTeam);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserMessage
            List<AppUserMessage> newOrModifiedAppUserMessageList = AppUserMessageDataHandler.GetAppUserMessageUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserMessageList.length > 0) {
                Logger.d("New Or Modified AppUserMessages - " + String.valueOf(newOrModifiedAppUserMessageList.length));
                totalRecordsToUpsync += newOrModifiedAppUserMessageList.length;
            }
            for (AppUserMessage appUserMessage in newOrModifiedAppUserMessageList) {
                try {
                    if (!upSyncList.contains("AppUserMessage-" + appUserMessage.id)) {
                        upSyncList.add("AppUserMessage-" + appUserMessage.id);
                        UpSyncAppUserMessage(appUserMessage);
                    }
                } catch ( e) {
                }
                return;
            }


            //OpportunityTeam
            List<OpportunityTeam> newOrModifiedOpportunityTeamList = OpportunityTeamDataHandler.GetOpportunityTeamUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityTeamList.length > 0) {
                Logger.d("New Or Modified OpportunityTeams - " + String.valueOf(newOrModifiedOpportunityTeamList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityTeamList.length;
            }
            for (OpportunityTeam opportunityTeam in newOrModifiedOpportunityTeamList) {
                try {
                    if (!upSyncList.contains("OpportunityTeam-" + opportunityTeam.id)) {
                        upSyncList.add("OpportunityTeam-" + opportunityTeam.id);
                        UpSyncOpportunityTeam(opportunityTeam);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityTravelMapping
            List<ActivityTravelMapping> newOrModifiedActivityTravelMappingList = ActivityTravelMappingDataHandler.GetActivityTravelMappingUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMappingList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelMappings - " + String.valueOf(newOrModifiedActivityTravelMappingList.length));
                totalRecordsToUpsync += newOrModifiedActivityTravelMappingList.length;
            }
            for (ActivityTravelMapping activityTravelMapping in newOrModifiedActivityTravelMappingList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMapping-" + activityTravelMapping.id)) {
                        upSyncList.add("ActivityTravelMapping-" + activityTravelMapping.id);
                        UpSyncActivityTravelMapping(activityTravelMapping);
                    }
                } catch ( e) {
                }
                return;
            }


            //AccountBusinessUnit
            List<AccountBusinessUnit> newOrModifiedAccountBusinessUnitList = AccountBusinessUnitDataHandler.GetAccountBusinessUnitUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified AccountBusinessUnits - " + String.valueOf(newOrModifiedAccountBusinessUnitList.length));
                totalRecordsToUpsync += newOrModifiedAccountBusinessUnitList.length;
            }
            for (AccountBusinessUnit accountBusinessUnit in newOrModifiedAccountBusinessUnitList) {
                try {
                    if (!upSyncList.contains("AccountBusinessUnit-" + accountBusinessUnit.id)) {
                        upSyncList.add("AccountBusinessUnit-" + accountBusinessUnit.id);
                        UpSyncAccountBusinessUnit(accountBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityBusinessUnit
            List<ActivityBusinessunit> newOrModifiedActivityBusinessUnitList = ActivityBusinessUnitDataHandler.GetActivityBusinessUnitUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityBusinessUnits - " + String.valueOf(newOrModifiedActivityBusinessUnitList.length));
                totalRecordsToUpsync += newOrModifiedActivityBusinessUnitList.length;
            }
            for (ActivityBusinessunit activityBusinessUnit in newOrModifiedActivityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("ActivityBusinessUnit-" + activityBusinessUnit.id)) {
                        upSyncList.add("ActivityBusinessUnit-" + activityBusinessUnit.id);
                        UpSyncActivityBusinessUnit(activityBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityBusinessUnit
            List<OpportunityBusinessUnit> newOrModifiedOpportunityBusinessUnitList = OpportunityBusinessUnitDataHandler.GetOpportunityBusinessUnitUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityBusinessUnitList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityBusinessUnits - " + String.valueOf(newOrModifiedOpportunityBusinessUnitList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityBusinessUnitList.length;
            }
            for (OpportunityBusinessUnit opportunityBusinessUnit in newOrModifiedOpportunityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("OpportunityBusinessUnit-" + opportunityBusinessUnit.id)) {
                        upSyncList.add("OpportunityBusinessUnit-" + opportunityBusinessUnit.id);
                        UpSyncOpportunityBusinessUnit(opportunityBusinessUnit);
                    }
                } catch ( e) {
                }
                return;
            }

            //ActivityApproval
            List<ActivityApproval> newOrModifiedActivityApprovalList = ActivityApprovalDataHandler.GetActivityApprovalUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityApprovalList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityApprovals - " + String.valueOf(newOrModifiedActivityApprovalList.length));
                totalRecordsToUpsync += newOrModifiedActivityApprovalList.length;
            }
            for (ActivityApproval activityApproval in newOrModifiedActivityApprovalList) {
                try {
                    if (!upSyncList.contains("ActivityApproval-" + activityApproval.id)) {
                        upSyncList.add("ActivityApproval-" + activityApproval.id);
                        UpSyncActivityApproval(activityApproval);
                    }
                } catch ( e) {
                }
                return;
            }

            //OpportunityApproval
            List<OpportunityApproval> newOrModifiedOpportunityApprovalList = OpportunityApprovalDataHandler.GetOpportunityApprovalUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityApprovalList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityApprovals - " + String.valueOf(newOrModifiedOpportunityApprovalList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityApprovalList.length;
            }
            for (OpportunityApproval opportunityApproval in newOrModifiedOpportunityApprovalList) {
                try {
                    if (!upSyncList.contains("OpportunityApproval-" + opportunityApproval.id)) {
                        upSyncList.add("OpportunityApproval-" + opportunityApproval.id);
                        UpSyncOpportunityApproval(opportunityApproval);
                    }
                } catch ( e) {
                }
                return;
            }

            //AccountMedia Files
            List<AccountMedia> newOrModifiedAccountMediaFilesList = AccountMediaDataHandler.GetAccountMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaFilesList.length > 0) {
                Logger.d("New Or Modified AccountMedia Files - " + String.valueOf(newOrModifiedAccountMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedAccountMediaFilesList.length;
            }
            for (AccountMedia accountMedia in newOrModifiedAccountMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("AccountMedia-" + accountMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = accountMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            File localFile = new File(mediaPath);
                            if (localFile.isFile()) {
                                byte bytes[] = GetFileAsBytes(localFile.getAbsolutePath());
                                if (bytes.length > 0) {
                                    Globals.UpSyncList.add("AccountMedia-" + accountMedia.id);
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
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //Account Logo
            List<Account> newOrModifiedAccountLogoList = AccountDataHandlerBase.GetAccountLogoUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountLogoList.length > 0) {
                Logger.d("New Or Modified Account Logo Files - " + String.valueOf(newOrModifiedAccountLogoList.length));
                totalRecordsToUpsync += newOrModifiedAccountLogoList.length;
            }
            for (Account account in newOrModifiedAccountLogoList) {
                try {
                    if (!Globals.UpSyncList.contains("AccountLogo-" + account.id)) {
                        boolean isQueued = false;
                        String mediaPath = account.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            Globals.UpSyncList.add("AccountLogo-" + account.id);
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
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //ContactMedia Files
            List<ContactMedia> newOrModifiedContactMediaFilesList = ContactMediaDataHandler.GetContactMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaFilesList.length > 0) {
                Logger.d("New Or Modified ContactMedia Files - " + String.valueOf(newOrModifiedContactMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedContactMediaFilesList.length;
            }
            for (ContactMedia contactMedia in newOrModifiedContactMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ContactMedia-" + contactMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = contactMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ContactMedia-" + contactMedia.id);
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
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //ActivityMedia Files
            List<ActivityMedia> newOrModifiedActivityMediaFilesList = ActivityMediaDataHandler.GetActivityMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaFilesList.length > 0) {
                Logger.d("New Or Modified ActivityMedia Files - " + String.valueOf(newOrModifiedActivityMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedActivityMediaFilesList.length;
            }
            for (ActivityMedia activityMedia in newOrModifiedActivityMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ActivityMedia-" + activityMedia.id)) {
                        String mediaPath = activityMedia.getLocalMediaPath();
                        boolean isQueued = false;
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ActivityMedia-" + activityMedia.id);
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
                    logger.e("UploadErrorin " + e.getMessage());
                }
                return;
            }

            //OpportunityMedia Files
            List<OpportunityMedia> newOrModifiedOpportunityMediaFilesList = OpportunityMediaDataHandler.GetOpportunityMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaFilesList.length > 0) {
                Logger.d("New Or Modified OpportunityMedia Files - " + String.valueOf(newOrModifiedOpportunityMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedOpportunityMediaFilesList.length;
            }
            for (OpportunityMedia opportunityMedia in newOrModifiedOpportunityMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("OpportunityMedia-" + opportunityMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = opportunityMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("OpportunityMedia-" + opportunityMedia.id);
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
                    logger.e("UploadErrorin " + e.getMessage());
                }
                return;
            }

            //NoteMedia Files
            List<NoteMedia> newOrModifiedNoteMediaFilesList = NoteMediaDataHandler.GetNoteMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaFilesList.length > 0) {
                Logger.d("New Or Modified NoteMedia Files - " + String.valueOf(newOrModifiedNoteMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedNoteMediaFilesList.length;
            }
            for (NoteMedia noteMedia in newOrModifiedNoteMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("NoteMedia-" + noteMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = noteMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("NoteMedia-" + noteMedia.id);
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
                    logger.e("UploadErrorin " + e.getMessage());
                }
                return;
            }

            //ActivityTravelMedia Files
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaFilesList = ActivityTravelMediaDataHandler.GetActivityTravelMediaUploadRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaFilesList.length > 0) {
                Logger.d("New Or Modified ActivityTravelMedia Files - " + String.valueOf(newOrModifiedActivityTravelMediaFilesList.length));
                totalRecordsToUpsync += newOrModifiedActivityTravelMediaFilesList.length;
            }
            for (ActivityTravelMedia activityTravelMedia in newOrModifiedActivityTravelMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ActivityTravelMedia-" + activityTravelMedia.id)) {
                        boolean isQueued = false;
                        String mediaPath = activityTravelMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ActivityTravelMedia-" + activityTravelMedia.id);
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = activityTravelMedia.getActivityTravelMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadActivityTravelMediaFile( fileName, bytes, activityTravelMedia.id);
                            }
                        }
                        if (!isQueued) {
                            activityTravelMedia.setIsDeleted1("true");
                            ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler,  activityTravelMedia.id, activityTravelMedia);
                        }
                    }
                } catch ( e) {
                    logger.e("UploadErrorin " + e.getMessage());
                }
                return;
            }

            //ChatMessage
            List<ChatMessage> newOrModifiedChatMessageList = ChatMessageDataHandler.GetChatMessageUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedChatMessageList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified ChatMessages - " + String.valueOf(newOrModifiedChatMessageList.length));
                totalRecordsToUpsync += newOrModifiedChatMessageList.length;
            }
            for (ChatMessage chatMessage in newOrModifiedChatMessageList) {
                try {
                    if (!upSyncList.contains("ChatMessage-" + chatMessage.id)) {
                        upSyncList.add("ChatMessage-" + chatMessage.id);
                        UpSyncChatMessage(chatMessage);
                    }
                } catch ( e) {
                }
                return;
            }

            //AppUserLocation
            List<AppUserLocation> newOrModifiedAppUserLocationList = AppUserLocationDataHandler.GetAppUserLocationUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserLocationList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified AppUserLocations - " + String.valueOf(newOrModifiedAppUserLocationList.length));
                totalRecordsToUpsync += newOrModifiedAppUserLocationList.length;
            }
            for (AppUserLocation appUserLocation in newOrModifiedAppUserLocationList) {
                try {
                    if (!upSyncList.contains("AppUserLocation-" + appUserLocation.id)) {
                        upSyncList.add("AppUserLocation-" + appUserLocation.id);

                        UpSyncAppUserLocation(appUserLocation);
                    }
                } catch ( e) {
                }
                return;
            }

            //HSSupportTicket
            List<HSSupportTicket> newOrModifiedHSSupportTicketList = HSSupportTicketDataHandler.GetHSSupportTicketUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTickets - " + String.valueOf(newOrModifiedHSSupportTicketList.length));
                totalRecordsToUpsync += newOrModifiedHSSupportTicketList.length;
            }
            for (HSSupportTicket hSSupportTicket in newOrModifiedHSSupportTicketList) {
                try {
                    if (!upSyncList.contains("HSSupportTicket-" + hSSupportTicket.id)) {
                        upSyncList.add("HSSupportTicket-" + hSSupportTicket.id);
                        UpSyncHSSupportTicket(hSSupportTicket);
                    }
                } catch ( e) {
                }
                return;
            }

            //HSSupportTicketMedia
            List<HSSupportTicketMedia> newOrModifiedHSSupportTicketMediaList = HSSupportTicketMediaDataHandler.GetHSSupportTicketMediaUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketMediaList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTicketMedia - " + String.valueOf(newOrModifiedHSSupportTicketMediaList.length));
                totalRecordsToUpsync += newOrModifiedHSSupportTicketMediaList.length;
            }
            for (HSSupportTicketMedia hSSupportTicketMedia in newOrModifiedHSSupportTicketMediaList) {
                try {
                    if (!upSyncList.contains("HSSupportTicketMedia-" + hSSupportTicketMedia.id)) {
                        upSyncList.add("HSSupportTicketMedia-" + hSSupportTicketMedia.id);
                        UpSyncHSSupportTicketMedia(hSSupportTicketMedia);
                    }
                } catch ( e) {
                }
                return;
            }

            //Reminder
            List<Reminder> newOrModifiedReminderList = ReminderDataHandler.GetReminderUpSyncRecords(dbHandler,  AppConstants.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReminderList.length > 0) {
                Log.d(LOG_TAG, "New Or Modified Reminders - " + String.valueOf(newOrModifiedReminderList.length));
                totalRecordsToUpsync += newOrModifiedReminderList.length;
            }
            for (Reminder reminder in newOrModifiedReminderList) {
                try {
                    if (!upSyncList.contains("Reminder-" + reminder.id)) {
                        upSyncList.add("Reminder-" + reminder.id);
                        UpSyncReminder(reminder);
                    }
                } catch ( e) {
                }
                return;
            }

            Globals.SyncIndex++;

            if (Globals.SyncIndex > Globals.MAX_UPSYNC_INDEX) {
                Globals.SyncIndex = 0;
            }

            if (totalRecordsToUpsync == 0) {
                LogMessage("Reseting failed upsyncindexesin ");
                DatabaseHandler.getInstance(context).ResetPendingUpSyncIndexes();
            }

            logger.d("UPSYNC - Completed");

        } catch ( ex) {
            Globals.handleException( "SyncServiceinRunUpSync()", ex);
        }

    }


    void upSyncAccountCategoryMapping(AccountCategoryMapping accountCategoryMapping) async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstants.API_VERSION_URL + '/accountcategorymapping';

      Map<String, dynamic> postData = {
        'AccountCategoryMappingID': Globals.isNullOrEmpty(accountCategoryMapping.accountCategoryMappingID!) ? '-1' : accountCategoryMapping.accountCategoryMappingID,
        'AccountCategoryMappingCode': Globals.isNullOrEmpty(accountCategoryMapping.accountCategoryMappingCode!) ? '' : accountCategoryMapping.accountCategoryMappingCode,
        'AccountID': AccountDataHandlerBase.getServerId(dbHandler,  accountCategoryMapping.accountID!),
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
            logger.e('Error: SyncService:UpSyncAccountCategoryMapping() 1-> ${ex.toString()}');
          }
        } else {
          logger.e('VolleyError: SyncService:UpSyncAccountCategoryMapping() 2-> ${accountCategoryMapping.id} : Object not returned.');
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
        logger.e('VolleyError: SyncService:UpSyncAccountCategoryMapping() 3-> $postError');
      }
    }
  } catch (e) {
    logger.e('Error: SyncService:UpSyncAccountCategoryMapping() 4-> ${e.toString()}');
  }
}

void upSyncContact(Contact contact) async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
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
  "AccountID": AccountDataHandlerBase.getServerId(dbHandler, contact.accountID!),
  "ContactCategoryID": ContactCategoryDataHandlerBase.GetServerId(dbHandler, contact.contactCategoryID!),
  "DepartmentName": contact.departmentName,
  "Designation": contact.designation,
  "RolesAndResponsibilities": contact.rolesAndResponsibilities,
  "ReportingManager": contact.reportingManager,
  "ReportingContactID": ContactHandlerDataBase.getServerId(dbHandler, contact.reportingContactID!),
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
  // "MarketingContactID": MarketingContactDataHandler.GetServerId(dbHandler,  contact.marketingContactID),
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
            ContactHandlerDataBase.UpdateContactRecord(dbHandler, contact.id!, contactReturn);
            logger.d("Contact - Saved successfully.");
          } catch ( ex) {
            logger.e("Error: SyncService:UpSyncContact() 1-> ${ex.toString()}");
          }
        } else {
          logger.e("VolleyError: SyncService:UpSyncContact() 2-> ${contact.id} : Object not returned.");
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
          logger.e("VolleyError: SyncService:UpSyncContact() 3-> $posterror");
          contact.upSyncMessage = "FAIL: $posterror";
          contact.upSyncIndex = Globals.SyncIndex.toString();
          ContactDataHandler.UpdateContactRecord(dbHandler,  contact.id, contact);
        }
        upSyncList.remove("Contact-${contact.id}");
      }
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncContact() 4-> ${e.toString()}");
  }
}

void upSyncActivity(Activity activity) {
  if (Utility.isNetworkConnected(context) && Globals.USER_TOKEN != "") {
    String url = AppConstant.API_VERSION_URL + "/activity";

    Map<String, dynamic> postData = {
      "ActivityID": !Globals.IsNullOrEmpty(activity.activityID) ? activity.activityID : "-1",
      "ActivityCode": !Globals.IsNullOrEmpty(activity.activityCode) ? activity.activityCode : "",
      "ActivityTitle": activity.activityTitle,
      "ActivityTypeID": ActivityTypeDataHandler.GetServerId(dbHandler,  activity.activityTypeID),
      "LeadSource": activity.leadSource,
      "AccountID": AccountDataHandler.GetServerId(dbHandler,  activity.accountID),
      "ContactID": ContactDataHandler.GetServerId(dbHandler,  activity.contactID),
      "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  activity.opportunityID),
      "ActivityMeasure": activity.activityMeasure,
      "ActivityDate": activity.activityDate,
      "ActivityEndDate": activity.activityEndDate,
      "ActivityDetails": activity.activityDetails,
      "ActivityPriorityID": ActivityPriorityDataHandler.GetServerId(dbHandler,  activity.activityPriorityID),
      "TotalAmount": activity.totalAmount,
      "AmountCollected": activity.amountCollected,
      "CurrencyID": CurrencyDataHandler.GetServerId(dbHandler,  activity.currencyID),
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
            logger.e("Error: SyncService:UpSyncActivity() 1-> $ex");
          }
        } else {
          logger.e("VolleyError: SyncService:UpSyncActivity() 2-> ${activity.id} : Object not returned.");
          activity.upSyncMessage = "FAIL: Object not returned";
          activity.upSyncIndex = Globals.SyncIndex.toString();
          ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        }
        upSyncList.remove("Activity-${activity.id}");
      } 
      
      else {
        String postError = response.body;
        logger.e("VolleyError: SyncService:UpSyncActivity() 3-> $postError");
        activity.upSyncMessage = "FAIL: $postError";
        activity.upSyncIndex = Globals.SyncIndex.toString();
        ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        upSyncList.remove("Activity-${activity.id}");
      }
    }).catchError((error) {
      if (error is http.ClientException) {
        Globals.USER_TOKEN_ALT = "";
      } else {
        String postError = error.toString();
        logger.e("VolleyError: SyncService:UpSyncActivity() 4-> $postError");
        activity.upSyncMessage = "FAIL: $postError";
        activity.upSyncIndex = Globals.SyncIndex.toString();
        ActivityDataHandler.UpdateActivityRecord(dbHandler,  activity.id, activity);
        upSyncList.remove("Activity-${activity.id}");
      }
    });
  }

}

void upSyncOpportunity(Opportunity opportunity) {
  try {
    if (Utility.isNetworkConnected(context) && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/opportunity";

      Map<String, dynamic> postData = {
        "OpportunityID": !Globals.IsNullOrEmpty(opportunity.opportunityID) ? opportunity.opportunityID : "-1",
        "OpportunityCode": !Globals.IsNullOrEmpty(opportunity.opportunityCode) ? opportunity.opportunityCode : "",
        "OpportunityName": opportunity.opportunityName,
        "OpportunityDetail": opportunity.opportunityDetail,
        "LeadSource": opportunity.leadSource,
        "OpportunityTypeID": OpportunityTypeDataHandler.GetServerId(dbHandler, context, opportunity.opportunityTypeID),
        "AccountID": AccountDataHandler.GetServerId(dbHandler, context, opportunity.accountID),
        "ContactID": ContactDataHandler.GetServerId(dbHandler, context, opportunity.contactID),
        "OpportunityMeasure": opportunity.opportunityMeasure,
        "OpportunityValue": opportunity.opportunityValue,
        "CurrencyID": CurrencyDataHandler.GetServerId(dbHandler, context, opportunity.currencyID),
        "GrossProfit": opportunity.grossProfit,
        "DealRegistrationNumber": opportunity.dealRegistrationNumber,
        "ClosureDate": opportunity.closureDate,
        "Probability": opportunity.probability,
        "OpportunityPriorityID": OpportunityPriorityDataHandler.GetServerId(dbHandler, context, opportunity.opportunityPriorityID),
        "OpportunityStageID": OpportunityStageDataHandler.GetServerId(dbHandler, context, opportunity.opportunityStageID),
        "OpportunityStatusID": OpportunityStatusDataHandler.GetServerId(dbHandler, context, opportunity.opportunityStatusID),
        "ActualOpportunityValue": opportunity.actualOpportunityValue,
        "LostToCompetitor": opportunity.lostToCompetitor,
        "ReasonForOpportunityStatus": opportunity.reasonForOpportunityStatus,
        "OpportunityIdentifier": opportunity.opportunityIdentifier,
        "PurchaseOrderNumber": opportunity.purchaseOrderNumber,
        "QuotationNumber": opportunity.quotationNumber,
        "IsFinanceRequired": Globals.TryParseBoolean(opportunity.isFinanceRequired),
        "FinanceBy": opportunity.financeBy,
        "FinanceRemarks": opportunity.financeRemarks,
        "IsApprovalRequired": Globals.TryParseBoolean(opportunity.isApprovalRequired),
        "ParentOpportunityID": OpportunityDataHandler.GetServerId(dbHandler, context, opportunity.parentOpportunityID),
        "IsRecurringOpportunity": Globals.TryParseBoolean(opportunity.isRecurringOpportunity),
        "RecurrenceIntervalInDays": opportunity.recurrenceIntervalInDays,
        "RecurrenceCount": opportunity.recurrenceCount,
        "RecurringOpportunityID": OpportunityDataHandler.GetServerId(dbHandler, context, opportunity.recurringOpportunityID),
        "DateGeneratedForRecurring": opportunity.dateGeneratedForRecurring,
        "RequestedDeliveryDate": opportunity.requestedDeliveryDate,
        "PlannedDeliveryDate": opportunity.plannedDeliveryDate,
        "ActualDeliveryDate": opportunity.actualDeliveryDate,
        "SupplierAccountID": AccountDataHandler.GetServerId(dbHandler, context, opportunity.supplierAccountID),
        "Tags": opportunity.tags,
        "OpportunityCodeInternal": opportunity.opportunityCodeInternal,
        "FreeTextField1": opportunity.freeTextField1,
        "FreeTextField2": opportunity.freeTextField2,
        "FreeTextField3": opportunity.freeTextField3,
        "IsAssigned": Globals.TryParseBoolean(opportunity.isAssigned),
        "AssignedDate": opportunity.assignedDate,
        "AssignedByAppUserID": opportunity.assignedByAppUserID,
        "AssignmentRemarks": opportunity.assignmentRemarks,
        "OpportunityFulfillmentStatus": opportunity.opportunityFulfillmentStatus,
        "IsOpportunityFulfilled": Globals.TryParseBoolean(opportunity.isOpportunityFulfilled),
        "CreatedBy": opportunity.createdBy,
        "CreatedOn": opportunity.createdOn,
        "ModifiedBy": opportunity.modifiedBy,
        "ModifiedOn": opportunity.modifiedOn,
        "IsWonAlerted": Globals.TryParseBoolean(opportunity.isWonAlerted),
        "IsNewAlerted": Globals.TryParseBoolean(opportunity.isNewAlerted),
        "IsActive": Globals.TryParseBoolean(opportunity.isActive),
        "IsLocked": Globals.TryParseBoolean(opportunity.isLocked),
        "IsApproved": Globals.TryParseBoolean(opportunity.isApproved),
        "Uid": opportunity.uid,
        "AppUserID": opportunity.appUserID,
        "AppUserGroupID": opportunity.appUserGroupID,
        "IsArchived": Globals.TryParseBoolean(opportunity.isArchived),
        "IsDeleted": Globals.TryParseBoolean(opportunity.isDeleted),
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
              JSONCopier.CopyJsonDataToOpportunity(context, dbHandler, json.decode(response.body), opportunityReturn, false);
              opportunityReturn.isDirty = false.toString();
              opportunityReturn.upSyncMessage = "SUCCESS";
              opportunityReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityDataHandler.UpdateOpportunityRecord(dbHandler, context, opportunity.id, opportunityReturn);
              LogUpSyncItemMessage("Opportunity - Saved successfully.");
            } catch (ex) {
              LogError("Error: SyncService:UpSyncOpportunity() 1-> $ex");
            }
          } else {
            LogError("VolleyError: SyncService:UpSyncOpportunity() 2-> ${opportunity.id} : Object not returned.");
            opportunity.upSyncMessage = "FAIL: Object not returned";
            opportunity.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityDataHandler.UpdateOpportunityRecord(dbHandler, context, opportunity.id, opportunity);
          }
          upSyncList.remove("Opportunity-${opportunity.id}");
        } else {
          String postError = response.body;
          LogError("VolleyError: SyncService:UpSyncOpportunity() 3-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandler.UpdateOpportunityRecord(dbHandler, context, opportunity.id, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          Globals.USER_TOKEN_ALT = "";
        } else {
          String postError = error.toString();
          LogError("VolleyError: SyncService:UpSyncOpportunity() 4-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandler.UpdateOpportunityRecord(dbHandler, context, opportunity.id, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      });
    }
  } catch (e) {
    LogError("Error: SyncService:UpSyncOpportunity() 4-> $e");
  }
}




void upSyncCustomerMeeting(CustomerMeeting customerMeeting) async {
  try {
    if (Utility.isNetworkConnected(context) && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstant.API_VERSION_URL}/customermeeting';

      Map<String, dynamic> postData = {
        'CustomerMeetingID': customerMeeting.customerMeetingID != null && customerMeeting.customerMeetingID.isNotEmpty ? customerMeeting.customerMeetingID : '-1',
        'CustomerMeetingCode': customerMeeting.customerMeetingCode != null && customerMeeting.customerMeetingCode.isNotEmpty ? customerMeeting.customerMeetingCode : '',
        'CustomerMeetingTitle': customerMeeting.customerMeetingTitle,
        'ActivityID': ActivityDataHandler.GetServerId(dbHandler, context, customerMeeting.activityID),
        'AccountID': AccountDataHandler.GetServerId(dbHandler, context, customerMeeting.accountID),
        'ContactID': ContactDataHandler.GetServerId(dbHandler, context, customerMeeting.contactID),
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
        'IsActive': Globals.TryParseBoolean(customerMeeting.isActive),
        'Uid': customerMeeting.uid,
        'AppUserID': customerMeeting.appUserID,
        'AppUserGroupID': customerMeeting.appUserGroupID,
        'IsArchived': Globals.TryParseBoolean(customerMeeting.isArchived),
        'IsDeleted': Globals.TryParseBoolean(customerMeeting.isDeleted),
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
            JSONCopier.CopyJsonDataToCustomerMeeting(context, dbHandler, jsonObject, customerMeetingReturn, false);
            customerMeetingReturn.isDirty = false;
            customerMeetingReturn.upSyncMessage = 'SUCCESS';
            customerMeetingReturn.upSyncIndex = Globals.SyncIndex.toString();
            CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler, context, customerMeeting.id, customerMeetingReturn);
            LogUpSyncItemMessage('CustomerMeeting - Saved successfully.');
          } catch ( ex) {
            LogError('Error: SyncService:UpSyncCustomerMeeting() 1-> ${ex.toString()}');
          }
        } else {
          LogError('VolleyError: SyncService:UpSyncCustomerMeeting() 2-> ${customerMeeting.id}: Object not returned.');
          customerMeeting.upSyncMessage = 'FAIL: Object not returned';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler, context, customerMeeting.id, customerMeeting);
        }
      } else {
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          String postError = response.body;
          LogError('VolleyError: SyncService:UpSyncCustomerMeeting() 3-> $postError');
          customerMeeting.upSyncMessage = 'FAIL: $postError';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler, context, customerMeeting.id, customerMeeting);
        }
      }
      upSyncList.remove('CustomerMeeting-${customerMeeting.id}');
    }
  } catch (e) {
    LogError('Error: SyncService:UpSyncCustomerMeeting() 4-> ${e.toString()}');
  }
}


void upSyncActivityProduct(String activityId, List<ActivityProduct> activityProductListOriginal, List<ActivityProductDetail> activityProductDetailListOriginal, List<ActivityProduct> activityProductList, List<ActivityProductDetail> activityProductDetailList) async {
  try {
    if (Utility.isNetworkConnected(context) && Globals.USER_TOKEN != '') {
      String url = AppConstant.API_VERSION_URL + '/activityproduct/savecollection';
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
              var activityProduct = ActivityProductDataHandler.GetActivityProductRecord(dbHandler, context, cid);
              if (activityProduct != null) {
                activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
                activityProduct.setActivityProductID(sid);
                activityProduct.setIsDirty('false');
                activityProduct.setUpSyncMessage('SUCCESS');
                var rid = ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler, context, activityProduct.getId(), activityProduct);
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
              var activityProductDetail = ActivityProductDetailDataHandler.GetActivityProductDetailRecord(dbHandler, context, cid);
              if (activityProductDetail != null) {
                activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
                activityProductDetail.setActivityProductDetailID(sid);
                activityProductDetail.setIsDirty('false');
                activityProductDetail.setUpSyncMessage('SUCCESS');
                var rid = ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler, context, activityProductDetail.getId(), activityProductDetail);
              }
            }
          }

          LogUpSyncItemMessage('ActivityProduct - Saved successfully.');
        } else {
          LogError('VolleyError: SyncService:UpSyncActivityProduct() 1-> $activityId : Object not returned.');

          for (var activityProduct in activityProductListOriginal) {
            activityProduct.setUpSyncMessage('FAIL: Object not returned');
            activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler, context, activityProduct.getId(), activityProduct);
          }

          for (var activityProductDetail in activityProductDetailListOriginal) {
            activityProductDetail.setUpSyncMessage('FAIL: Object not returned');
            activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler, context, activityProductDetail.getId(), activityProductDetail);
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

        LogError('Error: SyncService:UpSyncActivityProduct() 3-> $postError');

        for (var activityProduct in activityProductListOriginal) {
          activityProduct.setUpSyncMessage('FAIL: $postError');
          activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDataHandlerBase.UpdateActivityProductRecord(dbHandler, context, activityProduct.id, activityProduct);
        }

        for (var activityProductDetail in activityProductDetailListOriginal) {
          activityProductDetail.setUpSyncMessage('FAIL: $postError');
          activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler, context, activityProductDetail.id, activityProductDetail);
        }

        upSyncList.remove('ActivityProduct-$activityId');
      }
    }
  } catch (e) {
    LogError('Error: SyncService:UpSyncActivityProduct() 4-> ${e.toString()}');
  }
}

 
   void UpSyncOpportunityProduct(
    String opportunityId,
     List<OpportunityProduct> opportunityProductListOriginal, 
     List<OpportunityProductDetail> opportunityProductDetailListOriginal, 
     List<OpportunityProduct> opportunityProductList, 
     List<OpportunityProductDetail> opportunityProductDetailList) {

     try{
            
            if (Utility.isNetworkConnected(context) && !Globals.USER_TOKEN.equals("")) {

              
            }
     }catch(e){
       LogError('Error: SyncService:UpSyncOpportunityProduct() 4-> ${e.toString()}');
     }

   }
}