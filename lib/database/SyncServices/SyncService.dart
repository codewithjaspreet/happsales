import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:happsales_crm/database/AppTables/ColumnsBase.dart';
import 'package:happsales_crm/database/AppTables/TablesBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountFormValueDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityProductDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ActivityHandlers/ActivityTravelMappingDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactAlignmentDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/ContactHandlers/ContactCategoryDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityProductDetailDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityStageDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityStatusDataHandlerBase.dart';
import 'package:happsales_crm/database/Handlers/OpportunityHandlers/OpportunityTypeDataHandlerBase.dart';
import 'package:happsales_crm/database/models/ActivityModels/ActivityBusinessUnit.dart';
import 'package:logger/logger.dart';

import '../Handlers/AccountHandlers/AccountMappingDataHandler.dart';
import '../Handlers/AccountHandlers/AccountMappingDataHandlerBase.dart';
import '../Handlers/ActivityHandlers/ActivityDataHandlerBase.dart';
import '../Handlers/ContactHandlers/ContactDataHandlerBase.dart';
import '../Handlers/OpportunityHandlers/OpportunityDataHandlerBase.dart';
import '../models/OpportunityModels/OpportunityProductDetailAttribute.dart';
import '../models/OtherModels/AppLog.dart';
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

    //  static Context ;
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
            List<AccountForm> newOrModifiedAccountFormListForValuesUpSync = AccountFormDataHandler.GetMasterAccountFormRecordsForValuesUpSync(dbHandler, );
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
                        upSyncActivityBusinessUnit(activityBusinessUnit);
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
                        upSyncOpportunityBusinessUnit(opportunityBusinessUnit);
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
                        upSyncActivityApproval(activityApproval);
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                        if (!Globals.isNullOrEmpty(mediaPath)) {
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
                DatabaseHandler.getInstance().ResetPendingUpSyncIndexes();
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
  if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
    String url = AppConstants.API_VERSION_URL + "/activity";

    Map<String, dynamic> postData = {
      "ActivityID": !Globals.isNullOrEmpty(activity.activityID) ? activity.activityID : "-1",
      "ActivityCode": !Globals.isNullOrEmpty(activity.activityCode) ? activity.activityCode : "",
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
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/opportunity";

      Map<String, dynamic> postData = {
        "OpportunityID": !Globals.isNullOrEmpty(opportunity.opportunityID!) ? opportunity.opportunityID : "-1",
        "OpportunityCode": !Globals.isNullOrEmpty(opportunity.opportunityCode!) ? opportunity.opportunityCode : "",
        "OpportunityName": opportunity.opportunityName,
        "OpportunityDetail": opportunity.opportunityDetail,
        "LeadSource": opportunity.leadSource,
        "OpportunityTypeID": OpportunityTypeDataHandlerBase.getServerId(dbHandler,  opportunity.opportunityTypeID),
        "AccountID": AccountDataHandler.GetServerId(dbHandler,  opportunity.accountID),
        "ContactID": ContactDataHandlerBase.GetServerId(dbHandler,  opportunity.contactID),
        "OpportunityMeasure": opportunity.opportunityMeasure,
        "OpportunityValue": opportunity.opportunityValue,
        "CurrencyID": CurrencyDataHandler.GetServerId(dbHandler,  opportunity.currencyID),
        "GrossProfit": opportunity.grossProfit,
        "DealRegistrationNumber": opportunity.dealRegistrationNumber,
        "ClosureDate": opportunity.closureDate,
        "Probability": opportunity.probability,
        "OpportunityPriorityID": OpportunityPriorityDataHandler.GetServerId(dbHandler,  opportunity.opportunityPriorityID),
        "OpportunityStageID": OpportunityStageDataHandlerBase.GetServerId(dbHandler,  opportunity.opportunityStageID!),
        "OpportunityStatusID": OpportunityStatusDataHandlerBase.GetServerId(dbHandler,  opportunity.opportunityStatusID),
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
              LogUpSyncItemMessage("Opportunity - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncOpportunity() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncOpportunity() 2-> ${opportunity.id} : Object not returned.");
            opportunity.upSyncMessage = "FAIL: Object not returned";
            opportunity.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          }
          upSyncList.remove("Opportunity-${opportunity.id}");
        } else {
          String postError = response.body;
          logger.e("VolleyError: SyncService:UpSyncOpportunity() 3-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          Globals.USER_TOKEN_ALT = "";
        } else {
          String postError = error.toString();
          logger.e("VolleyError: SyncService:UpSyncOpportunity() 4-> $postError");
          opportunity.upSyncMessage = "FAIL: $postError";
          opportunity.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityDataHandlerBase.UpdateOpportunityRecord(dbHandler,  opportunity.id!, opportunity);
          upSyncList.remove("Opportunity-${opportunity.id}");
        }
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncOpportunity() 4-> $e");
  }
}




void upSyncCustomerMeeting(CustomerMeeting customerMeeting) async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstants.API_VERSION_URL}/customermeeting';

      Map<String, dynamic> postData = {
        'CustomerMeetingID': customerMeeting.customerMeetingID != null && customerMeeting.customerMeetingID.isNotEmpty ? customerMeeting.customerMeetingID : '-1',
        'CustomerMeetingCode': customerMeeting.customerMeetingCode != null && customerMeeting.customerMeetingCode.isNotEmpty ? customerMeeting.customerMeetingCode : '',
        'CustomerMeetingTitle': customerMeeting.customerMeetingTitle,
        'ActivityID': ActivityDataHandler.GetServerId(dbHandler,  customerMeeting.activityID),
        'AccountID': AccountDataHandler.GetServerId(dbHandler,  customerMeeting.accountID),
        'ContactID': ContactDataHandler.GetServerId(dbHandler,  customerMeeting.contactID),
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
            LogUpSyncItemMessage('CustomerMeeting - Saved successfully.');
          } catch ( ex) {
            logger.e('Error: SyncService:UpSyncCustomerMeeting() 1-> ${ex.toString()}');
          }
        } else {
          logger.e('VolleyError: SyncService:UpSyncCustomerMeeting() 2-> ${customerMeeting.id}: Object not returned.');
          customerMeeting.upSyncMessage = 'FAIL: Object not returned';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeeting);
        }
      } else {
        if (response.statusCode == 401) {
          Globals.USER_TOKEN_ALT = '';
        } else {
          String postError = response.body;
          logger.e('VolleyError: SyncService:UpSyncCustomerMeeting() 3-> $postError');
          customerMeeting.upSyncMessage = 'FAIL: $postError';
          customerMeeting.upSyncIndex = Globals.SyncIndex.toString();
          CustomerMeetingDataHandler.UpdateCustomerMeetingRecord(dbHandler,  customerMeeting.id, customerMeeting);
        }
      }
      upSyncList.remove('CustomerMeeting-${customerMeeting.id}');
    }
  } catch (e) {
    logger.e('Error: SyncService:UpSyncCustomerMeeting() 4-> ${e.toString()}');
  }
}


void upSyncActivityProduct(String activityId, List<ActivityProduct> activityProductListOriginal, List<ActivityProductDetail> activityProductDetailListOriginal, List<ActivityProduct> activityProductList, List<ActivityProductDetail> activityProductDetailList) async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != '') {
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
                activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
                activityProduct.setActivityProductID(sid);
                activityProduct.setIsDirty('false');
                activityProduct.setUpSyncMessage('SUCCESS');
                var rid = ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler,  activityProduct.getId(), activityProduct);
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
                activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
                activityProductDetail.setActivityProductDetailID(sid);
                activityProductDetail.setIsDirty('false');
                activityProductDetail.setUpSyncMessage('SUCCESS');
                var rid = ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.getId(), activityProductDetail);
              }
            }
          }

          LogUpSyncItemMessage('ActivityProduct - Saved successfully.');
        } else {
          logger.e('VolleyError: SyncService:UpSyncActivityProduct() 1-> $activityId : Object not returned.');

          for (var activityProduct in activityProductListOriginal) {
            activityProduct.setUpSyncMessage('FAIL: Object not returned');
            activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDataHandler.UpdateActivityProductRecord(dbHandler,  activityProduct.getId(), activityProduct);
          }

          for (var activityProductDetail in activityProductDetailListOriginal) {
            activityProductDetail.setUpSyncMessage('FAIL: Object not returned');
            activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
            ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.getId(), activityProductDetail);
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

        logger.e('Error: SyncService:UpSyncActivityProduct() 3-> $postError');

        for (var activityProduct in activityProductListOriginal) {
          activityProduct.setUpSyncMessage('FAIL: $postError');
          activityProduct.setUpSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDataHandlerBase.UpdateActivityProductRecord(dbHandler,  activityProduct.id, activityProduct);
        }

        for (var activityProductDetail in activityProductDetailListOriginal) {
          activityProductDetail.setUpSyncMessage('FAIL: $postError');
          activityProductDetail.setUpSyncIndex(Globals.SyncIndex.toString());
          ActivityProductDetailDataHandler.UpdateActivityProductDetailRecord(dbHandler,  activityProductDetail.id, activityProductDetail);
        }

        upSyncList.remove('ActivityProduct-$activityId');
      }
    }
  } catch (e) {
    logger.e('Error: SyncService:UpSyncActivityProduct() 4-> ${e.toString()}');
  }
}

 
  void upSyncOpportunityProduct(String opportunityId, List<OpportunityProduct> opportunityProductListOriginal, List<OpportunityProductDetail> opportunityProductDetailListOriginal, List<OpportunityProduct> opportunityProductList, List<OpportunityProductDetail> opportunityProductDetailList) {
  try {
    if (Utility.isNetworkConnected(opportunityProductList) && Globals.USER_TOKEN != "") {
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
              var opportunityProduct = OpportunityProductDataHandler.getOpportunityProductRecord(dbHandler,  cid);
              if (opportunityProduct != null) {
                opportunityProduct.upSyncIndex = Globals.SyncIndex.toString();
                opportunityProduct.opportunityProductID = sid;
                opportunityProduct.isDirty = "false";
                opportunityProduct.upSyncMessage = "SUCCESS";
                var rid = OpportunityProductDataHandler.updateOpportunityProductRecord(dbHandler,  opportunityProduct.id, opportunityProduct);
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
                var rid = OpportunityProductDetailDataHandler.updateOpportunityProductDetailRecord(dbHandler,  opportunityProductDetail.id, opportunityProductDetail);
              }
            }
          }

          logUpSyncItemMessage("OpportunityProduct - Saved successfully.");
        } else {
          logger.e("VolleyError: SyncService:UpSyncOpportunityProduct() 1-> $opportunityId : Object not returned.");

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
        logger.e("Error: SyncService:UpSyncOpportunityProduct() 2-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncOpportunityProduct() 4-> $e");
  }
}


void upSyncOpportunityProductDetailAttribute(OpportunityProductDetailAttribute opportunityProductDetailAttribute) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              logger.e("Error: SyncService:UpSyncOpportunityProductDetailAttribute() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncOpportunityProductDetailAttribute() 2-> ${opportunityProductDetailAttribute.id} : Object not returned.");
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
          logger.e("VolleyError: SyncService:UpSyncOpportunityProductDetailAttribute() 3-> $posterror");
        }

        upSyncList.remove("OpportunityProductDetailAttribute-${opportunityProductDetailAttribute.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncOpportunityProductDetailAttribute() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncOpportunityProductDetailAttribute() 4-> $e");
  }
}



void upSyncAccountAddress(AccountAddress accountAddress) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
        "ContactID": ContactDataHandler.GetServerId(dbHandler,  accountAddress.contactID),
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
              logUpSyncItemMessage("AccountAddress - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountAddress() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountAddress() 2-> ${accountAddress.id} : Object not returned.");
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

          logger.e("VolleyError: SyncService:UpSyncAccountAddress() 3-> $posterror");
          accountAddress.upSyncMessage = "FAIL: $posterror";
          accountAddress.upSyncIndex = Globals.SyncIndex.toString();
          AccountAddressDataHandler.UpdateAccountAddressRecord(dbHandler,  accountAddress.id, accountAddress);
        }

        upSyncList.remove("AccountAddress-${accountAddress.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncAccountAddress() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountAddress() 4-> $e");
  }
}


void upSyncOpportunityContact(OpportunityContact opportunityContact) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/opportunitycontact";

      var postData = {
        "OpportunityContactID": Globals.isNullOrEmpty(opportunityContact.opportunityContactID) ? "-1" : opportunityContact.opportunityContactID,
        "OpportunityContactCode": Globals.isNullOrEmpty(opportunityContact.opportunityContactCode) ? "" : opportunityContact.opportunityContactCode,
        "OpportunityID": OpportunityDataHandler.GetServerId(dbHandler,  opportunityContact.opportunityID),
        "ContactID": ContactDataHandler.GetServerId(dbHandler,  opportunityContact.contactID),
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
              OpportunityContactDataHandler.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContactReturn);
              logMessage("OpportunityContact - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncOpportunityContact() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncOpportunityContact() 2-> ${opportunityContact.id} : Object not returned.");
            opportunityContact.upSyncMessage = "FAIL: Object not returned";
            opportunityContact.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityContactDataHandler.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContact);
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
          OpportunityContactDataHandler.UpdateOpportunityContactRecord(dbHandler,  opportunityContact.id, opportunityContact);
          logger.e("VolleyError: SyncService:UpSyncOpportunityContact() 3-> $posterror");
        }

        upSyncList.remove("OpportunityContact-${opportunityContact.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncOpportunityContact() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncOpportunityContact() 4-> $e");
  }
}


void upSyncAccountPhone(AccountPhone accountPhone) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              logUpSyncItemMessage("AccountPhone - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountPhone() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountPhone() 2-> ${accountPhone.id} : Object not returned.");
            accountPhone.upSyncMessage = "FAIL: Object not returned";
            accountPhone.upSyncIndex = Globals.SyncIndex.toString();
            AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhone);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:UpSyncAccountPhone() 3-> $posterror");
          accountPhone.upSyncMessage = "FAIL: $posterror";
          accountPhone.upSyncIndex = Globals.SyncIndex.toString();
          AccountPhoneDataHandler.UpdateAccountPhoneRecord(dbHandler,  accountPhone.id, accountPhone);
        }

        upSyncList.remove("AccountPhone-${accountPhone.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncAccountPhone() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountPhone() 4-> $e");
  }
}


void upSyncAccountBuyingProcess(AccountBuyingProcess accountBuyingProcess) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              logUpSyncItemMessage("AccountBuyingProcess - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountBuyingProcess() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountBuyingProcess() 2-> ${accountBuyingProcess.id} : Object not returned.");
            accountBuyingProcess.upSyncMessage = "FAIL: Object not returned";
            accountBuyingProcess.upSyncIndex = Globals.SyncIndex.toString();
            AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:UpSyncAccountBuyingProcess() 3-> $posterror");
          accountBuyingProcess.upSyncMessage = "FAIL: $posterror";
          accountBuyingProcess.upSyncIndex = Globals.SyncIndex.toString();
          AccountBuyingProcessDataHandler.UpdateAccountBuyingProcessRecord(dbHandler,  accountBuyingProcess.id, accountBuyingProcess);
        }

        upSyncList.remove("AccountBuyingProcess-${accountBuyingProcess.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncAccountBuyingProcess() 4-> $error");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountBuyingProcess() 4-> $e");
  }
}


void upSyncAccountBusinessPlan(AccountBusinessPlan accountBusinessPlan) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToAccountBusinessPlan(, dbHandler, jsonResponse, accountBusinessPlanReturn, false);
              accountBusinessPlanReturn.isDirty = "false";
              accountBusinessPlanReturn.upSyncMessage = "SUCCESS";
              accountBusinessPlanReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlanReturn);
              logUpSyncItemMessage("AccountBusinessPlan - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountBusinessPlan() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountBusinessPlan() 2-> ${accountBusinessPlan.id} : Object not returned.");
            accountBusinessPlan.upSyncMessage = "FAIL: Object not returned";
            accountBusinessPlan.upSyncIndex = Globals.SyncIndex.toString();
            AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlan);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:UpSyncAccountBusinessPlan() 3-> $posterror");
          accountBusinessPlan.upSyncMessage = "FAIL: $posterror";
          accountBusinessPlan.upSyncIndex = Globals.SyncIndex.toString();
          AccountBusinessPlanDataHandler.UpdateAccountBusinessPlanRecord(dbHandler, accountBusinessPlan.id, accountBusinessPlan);
        }

        upSyncList.remove("AccountBusinessPlan-${accountBusinessPlan.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncAccountBusinessPlan() 4-> $error");
        upSyncList.remove("AccountBusinessPlan-${accountBusinessPlan.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountBusinessPlan() 4-> $e");
  }
}


void upSyncAccountCompetitionActivity(AccountCompetitionActivity accountCompetitionActivity) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToAccountCompetitionActivity(, dbHandler, jsonResponse, accountCompetitionActivityReturn, false);
              accountCompetitionActivityReturn.isDirty = "false";
              accountCompetitionActivityReturn.upSyncMessage = "SUCCESS";
              accountCompetitionActivityReturn.upSyncIndex = Globals.SyncIndex.toString();
              AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivityReturn);
              logUpSyncItemMessage("AccountCompetitionActivity - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountCompetitionActivity() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountCompetitionActivity() 2-> ${accountCompetitionActivity.id} : Object not returned.");
            accountCompetitionActivity.upSyncMessage = "FAIL: Object not returned";
            accountCompetitionActivity.upSyncIndex = Globals.SyncIndex.toString();
            AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivity);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:UpSyncAccountCompetitionActivity() 3-> $posterror");
          accountCompetitionActivity.upSyncMessage = "FAIL: $posterror";
          accountCompetitionActivity.upSyncIndex = Globals.SyncIndex.toString();
          AccountCompetitionActivityDataHandler.UpdateAccountCompetitionActivityRecord(dbHandler, accountCompetitionActivity.id, accountCompetitionActivity);
        }
        upSyncList.remove("AccountCompetitionActivity-${accountCompetitionActivity.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncAccountCompetitionActivity() 4-> $error");
        upSyncList.remove("AccountCompetitionActivity-${accountCompetitionActivity.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountCompetitionActivity() 4-> $e");
  }
}


void upSyncNote(Note note) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/note";

      var postData = {
        "NoteID": Globals.isNullOrEmpty(note.noteID) ? "-1" : note.noteID,
        "NoteCode": Globals.isNullOrEmpty(note.noteCode) ? "" : note.noteCode,
        "AccountID": AccountDataHandler.GetServerId(dbHandler, note.accountID),
        "ContactID": ContactDataHandler.GetServerId(dbHandler, note.contactID),
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
              JSONCopier.CopyJsonDataToNote(, dbHandler, jsonResponse, noteReturn, false);
              noteReturn.isDirty = "false";
              noteReturn.upSyncMessage = "SUCCESS";
              noteReturn.upSyncIndex = Globals.SyncIndex.toString();
              NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, noteReturn);
              logUpSyncItemMessage("Note - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncNote() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncNote() 2-> ${note.id} : Object not returned.");
            note.upSyncMessage = "FAIL: Object not returned";
            note.upSyncIndex = Globals.SyncIndex.toString();
            NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, note);
          }
        } else {
          if (response.statusCode == 401) {
            Globals.USER_TOKEN_ALT = "";
          }

          String posterror = response.body != null ? response.body.toString() : "";
          logger.e("VolleyError: SyncService:UpSyncNote() 3-> $posterror");
          note.upSyncMessage = "FAIL: $posterror";
          note.upSyncIndex = Globals.SyncIndex.toString();
          NoteDataHandler.UpdateNoteRecord(dbHandler, note.id, note);
        }
        upSyncList.remove("Note-${note.id}");
      }).catchError((error) {
        logger.e("Error: SyncService:UpSyncNote() 4-> $error");
        upSyncList.remove("Note-${note.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncNote() 4-> $e");
  }
}

void upSyncActivityTravel(ActivityTravel activityTravel) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToActivityTravel(, dbHandler, jsonResponse, activityTravelReturn, false);
              activityTravelReturn.isDirty = "false";
              activityTravelReturn.upSyncMessage = "SUCCESS";
              activityTravelReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravelReturn);
              logUpSyncItemMessage("ActivityTravel - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncActivityTravel() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncActivityTravel() 2-> ${activityTravel.id} : Object not returned.");
            activityTravel.upSyncMessage = "FAIL: Object not returned";
            activityTravel.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
          }
          upSyncList.remove("ActivityTravel-${activityTravel.id}");
        } else {
          logger.e("VolleyError: SyncService:UpSyncActivityTravel() 3-> ${response.body}");
          activityTravel.upSyncMessage = "FAIL: ${response.body}";
          activityTravel.upSyncIndex = Globals.SyncIndex.toString();
          ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
          upSyncList.remove("ActivityTravel-${activityTravel.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logger.e("VolleyError: SyncService:UpSyncActivityTravel() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:UpSyncActivityTravel() 3-> $error");
        }
        activityTravel.upSyncMessage = "FAIL: $error";
        activityTravel.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelDataHandler.UpdateActivityTravelRecord(dbHandler, activityTravel.id, activityTravel);
        upSyncList.remove("ActivityTravel-${activityTravel.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncActivityTravel() 4-> $e");
  }
}

void upSyncAccountMedia(AccountMedia accountMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/accountmedia";

      var postData = {
        "AccountMediaID": Globals.isNullOrEmpty(accountMedia.accountMediaID) ? "-1" : accountMedia.accountMediaID,
        "AccountMediaCode": Globals.isNullOrEmpty(accountMedia.accountMediaCode) ? "" : accountMedia.accountMediaCode,
        "AccountMediaName": accountMedia.accountMediaName,
        "AccountID": AccountDataHandlerBase.getServerId(dbHandler, accountMedia.accountID!),
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
              logUpSyncItemMessage("AccountMedia - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncAccountMedia() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncAccountMedia() 2-> ${accountMedia.id} : Object not returned.");
            accountMedia.upSyncMessage = "FAIL: Object not returned";
            accountMedia.upSyncIndex = Globals.SyncIndex.toString();
            AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
          }
          upSyncList.remove("AccountMedia-${accountMedia.id}");
        } 
        
        else {
          logger.e("VolleyError: SyncService:UpSyncAccountMedia() 3-> ${response.body}");
          accountMedia.upSyncMessage = "FAIL: ${response.body}";
          accountMedia.upSyncIndex = Globals.SyncIndex.toString();
          AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
          upSyncList.remove("AccountMedia-${accountMedia.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logger.e("VolleyError: SyncService:UpSyncAccountMedia() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:UpSyncAccountMedia() 3-> $error");
        }
        accountMedia.upSyncMessage = "FAIL: $error";
        accountMedia.upSyncIndex = Globals.SyncIndex.toString();
        AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler,  accountMedia.id, accountMedia);
        upSyncList.remove("AccountMedia-${accountMedia.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncAccountMedia() 4-> $e");
  }
}


void upSyncContactMedia(ContactMedia contactMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = "${AppConstants.API_VERSION_URL}/contactmedia";

      var postData = {
        "ContactMediaID": Globals.isNullOrEmpty(contactMedia.contactMediaID) ? "-1" : contactMedia.contactMediaID,
        "ContactMediaCode": Globals.isNullOrEmpty(contactMedia.contactMediaCode) ? "" : contactMedia.contactMediaCode,
        "ContactMediaName": contactMedia.contactMediaName,
        "ContactID": ContactDataHandler.GetServerId(dbHandler, contactMedia.contactID),
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
              JSONCopier.CopyJsonDataToContactMedia(, dbHandler, jsonResponse, contactMediaReturn, false);
              contactMediaReturn.isDirty = "false";
              contactMediaReturn.upSyncMessage = "SUCCESS";
              contactMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMediaReturn);
              logUpSyncItemMessage("ContactMedia - Saved successfully.");
            } catch (ex) {
              logger.e("Error: SyncService:UpSyncContactMedia() 1-> $ex");
            }
          } else {
            logger.e("VolleyError: SyncService:UpSyncContactMedia() 2-> ${contactMedia.id} : Object not returned.");
            contactMedia.upSyncMessage = "FAIL: Object not returned";
            contactMedia.upSyncIndex = Globals.SyncIndex.toString();
            ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
          }
          upSyncList.remove("ContactMedia-${contactMedia.id}");
        } else {
          logger.e("VolleyError: SyncService:UpSyncContactMedia() 3-> ${response.body}");
          contactMedia.upSyncMessage = "FAIL: ${response.body}";
          contactMedia.upSyncIndex = Globals.SyncIndex.toString();
          ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
          upSyncList.remove("ContactMedia-${contactMedia.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logger.e("VolleyError: SyncService:UpSyncContactMedia() 3-> ${error.toString()}");
        } else {
          logger.e("VolleyError: SyncService:UpSyncContactMedia() 3-> $error");
        }
        contactMedia.upSyncMessage = "FAIL: $error";
        contactMedia.upSyncIndex = Globals.SyncIndex.toString();
        ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, contactMedia.id, contactMedia);
        upSyncList.remove("ContactMedia-${contactMedia.id}");
      });
    }
  } catch (e) {
    logger.e("Error: SyncService:UpSyncContactMedia() 4-> $e");
  }
}

void upSyncOpportunityMedia(OpportunityMedia opportunityMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToOpportunityMedia(, dbHandler, jsonResponse, opportunityMediaReturn, false);
              opportunityMediaReturn.isDirty = "false";
              opportunityMediaReturn.upSyncMessage = "SUCCESS";
              opportunityMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMediaReturn);
              logUpSyncItemMessage("OpportunityMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncOpportunityMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncOpportunityMedia() 2-> ${opportunityMedia.id} : Object not returned.");
            opportunityMedia.upSyncMessage = "FAIL: Object not returned";
            opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
          }
          upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
        } else {
          logError("VolleyError: SyncService:UpSyncOpportunityMedia() 3-> ${response.body}");
          opportunityMedia.upSyncMessage = "FAIL: ${response.body}";
          opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
          OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
          upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logError("VolleyError: SyncService:UpSyncOpportunityMedia() 3-> $error");
        } else {
          logError("Error: SyncService:UpSyncOpportunityMedia() 4-> $error");
        }
        opportunityMedia.upSyncMessage = "FAIL: $error";
        opportunityMedia.upSyncIndex = Globals.SyncIndex.toString();
        OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, opportunityMedia.id, opportunityMedia);
        upSyncList.remove("OpportunityMedia-${opportunityMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncOpportunityMedia() 4-> $e");
  }
}

void upSyncActivityMedia(ActivityMedia activityMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToActivityMedia(, dbHandler, jsonResponse, activityMediaReturn, false);
              activityMediaReturn.isDirty = "false";
              activityMediaReturn.upSyncMessage = "SUCCESS";
              activityMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMediaReturn);
              logUpSyncItemMessage("ActivityMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncActivityMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityMedia() 2-> ${activityMedia.id} : Object not returned.");
            activityMedia.upSyncMessage = "FAIL: Object not returned";
            activityMedia.upSyncIndex = Globals.SyncIndex.toString();
            ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
          }
          upSyncList.remove("ActivityMedia-${activityMedia.id}");
        } else {
          logError("VolleyError: SyncService:UpSyncActivityMedia() 3-> ${response.body}");
          activityMedia.upSyncMessage = "FAIL: ${response.body}";
          activityMedia.upSyncIndex = Globals.SyncIndex.toString();
          ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
          upSyncList.remove("ActivityMedia-${activityMedia.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logError("VolleyError: SyncService:UpSyncActivityMedia() 3-> ${error.message}");
        } else {
          logError("Error: SyncService:UpSyncActivityMedia() 4-> $error");
        }
        activityMedia.upSyncMessage = "FAIL: $error";
        activityMedia.upSyncIndex = Globals.SyncIndex.toString();
        ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, activityMedia.id, activityMedia);
        upSyncList.remove("ActivityMedia-${activityMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityMedia() 4-> $e");
  }
}


void upSyncNoteMedia(NoteMedia noteMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToNoteMedia(, dbHandler, jsonResponse, noteMediaReturn, false);
              noteMediaReturn.isDirty = "false";
              noteMediaReturn.upSyncMessage = "SUCCESS";
              noteMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMediaReturn);
              logUpSyncItemMessage("NoteMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncNoteMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncNoteMedia() 2-> ${noteMedia.id} : Object not returned.");
            noteMedia.upSyncMessage = "FAIL: Object not returned";
            noteMedia.upSyncIndex = Globals.SyncIndex.toString();
            NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
          }
          upSyncList.remove("NoteMedia-${noteMedia.id}");
        } else {
          logError("VolleyError: SyncService:UpSyncNoteMedia() 3-> ${response.body}");
          noteMedia.upSyncMessage = "FAIL: ${response.body}";
          noteMedia.upSyncIndex = Globals.SyncIndex.toString();
          NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
          upSyncList.remove("NoteMedia-${noteMedia.id}");
        }
      }).catchError((error) {
        if (error is http.ClientException) {
          logError("VolleyError: SyncService:UpSyncNoteMedia() 3-> ${error.message}");
        } else {
          logError("Error: SyncService:UpSyncNoteMedia() 4-> $error");
        }
        noteMedia.upSyncMessage = "FAIL: $error";
        noteMedia.upSyncIndex = Globals.SyncIndex.toString();
        NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, noteMedia.id, noteMedia);
        upSyncList.remove("NoteMedia-${noteMedia.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncNoteMedia() 4-> $e");
  }
}


void upSyncActivityTravelMedia(ActivityTravelMedia activityTravelMedia) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              JSONCopier.CopyJsonDataToActivityTravelMedia(, dbHandler, jsonResponse, activityTravelMediaReturn, false);
              activityTravelMediaReturn.isDirty = "false";
              activityTravelMediaReturn.upSyncMessage = "SUCCESS";
              activityTravelMediaReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMediaReturn);
              logMessage("ActivityTravelMedia - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncActivityTravelMedia() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityTravelMedia() 2-> ${activityTravelMedia.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncActivityTravelMedia() 3-> $posterror");
        }
      }).catchError((error) {
        var posterror = error.toString();
        activityTravelMedia.upSyncMessage = "FAIL: $posterror";
        activityTravelMedia.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, activityTravelMedia.id, activityTravelMedia);
        upSyncList.remove("ActivityTravelMedia-${activityTravelMedia.id}");
        logError("VolleyError: SyncService:UpSyncActivityTravelMedia() 3-> $posterror");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityTravelMedia() 4-> $e");
  }
}


Future<void> upSyncActivityTravelExpense(ActivityTravelExpense activityTravelExpense)async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
             await  JSONCopier.CopyJsonDataToActivityTravelExpense(, dbHandler, jsonResponse, activityTravelExpenseReturn, false);
              activityTravelExpenseReturn.isDirty = "false";
              activityTravelExpenseReturn.upSyncMessage = "SUCCESS";
              activityTravelExpenseReturn.upSyncIndex = Globals.SyncIndex.toString();
              ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpenseReturn);
              logMessage("ActivityTravelExpense - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncActivityTravelExpense() 1-> $ex");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityTravelExpense() 2-> ${activityTravelExpense.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncActivityTravelExpense() 3-> $posterror");
        }
      }).catchError((error) {
        var posterror = error.toString();
        activityTravelExpense.upSyncMessage = "FAIL: $posterror";
        activityTravelExpense.upSyncIndex = Globals.SyncIndex.toString();
        ActivityTravelExpenseDataHandler.UpdateActivityTravelExpenseRecord(dbHandler, activityTravelExpense.id, activityTravelExpense);
        upSyncList.remove("ActivityTravelExpense-${activityTravelExpense.id}");
        logError("VolleyError: SyncService:UpSyncActivityTravelExpense() 3-> $posterror");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityTravelExpense() 4-> $e");
  }
}


Future<void> upSyncFieldAttendance(FieldAttendance fieldAttendance) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              await JSONCopier.copyJsonDataToFieldAttendance(, dbHandler, jsonObject, fieldAttendanceReturn, false);
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
                logUpSyncItemMessage("FieldAttendance - Saved successfully.");
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              logUpSyncItemMessage("AppUserRemark - Saved successfully.");
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstants.API_VERSION_URL + "/accountform";

      var postData = {
        "AccountFormID": accountForm.accountFormID != null && accountForm.accountFormID.isNotEmpty ? accountForm.accountFormID : "-1",
        "AccountFormCode": accountForm.accountFormCode != null && accountForm.accountFormCode.isNotEmpty ? accountForm.accountFormCode : "",
        "AccountFormTitle": accountForm.accountFormTitle,
        "FormID": FormDataHandler.getServerId(dbHandler, accountForm.formID),
        "AccountID": AccountDataHandler.getServerId(dbHandler, accountForm.accountID),
        "ActivityID": ActivityDataHandler.getServerId(dbHandler, accountForm.activityID),
        "OpportunityID": OpportunityDataHandler.getServerId(dbHandler, accountForm.opportunityID),
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
              await JSONCopier.copyJsonDataToAccountForm(, dbHandler, jsonObject, accountFormReturn, false);
              accountFormReturn.isDirty = "false";
              accountFormReturn.upSyncMessage = "SUCCESS";
              accountFormReturn.upSyncIndex = Globals.syncIndex.toString();
              AccountFormDataHandler.updateAccountFormRecord(dbHandler, accountForm.id, accountFormReturn);
              logUpSyncItemMessage("AccountForm - Saved successfully.");
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
                    logUpSyncItemMessage("AccountFormValues - Saved successfully of form $accountFormId.");
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/reimbursement";

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
              JSONCopier.copyJsonDataToReimbursement(, dbHandler, jsonObject, reimbursementReturn, false);
              reimbursementReturn.isDirty = "false";
              reimbursementReturn.upSyncMessage = "SUCCESS";
              reimbursementReturn.upSyncIndex = Globals.syncIndex.toString();
              ReimbursementDataHandler.updateReimbursementRecord(dbHandler, reimbursement.id, reimbursementReturn);
              logUpSyncItemMessage("Reimbursement - Saved successfully.");
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/reimbursementdetail";

      var postData = {
        "ReimbursementDetailID": !Globals.isNullOrEmpty(reimbursementDetail.reimbursementDetailID) ? reimbursementDetail.reimbursementDetailID : "-1",
        "ReimbursementDetailCode": !Globals.isNullOrEmpty(reimbursementDetail.reimbursementDetailCode) ? reimbursementDetail.reimbursementDetailCode : "",
        "ReimbursementDetailTitle": reimbursementDetail.reimbursementDetailTitle,
        "BillNumber": reimbursementDetail.billNumber,
        "BillDate": reimbursementDetail.billDate,
        "Amount": reimbursementDetail.amount,
        "ReimbursementID": ReimbursementDataHandler.getServerId(dbHandler, reimbursementDetail.reimbursementID),
        "ReimbursementTypeID": ReimbursementTypeDataHandler.getServerId(dbHandler, reimbursementDetail.reimbursementTypeID),
        "ActivityID": ActivityDataHandler.getServerId(dbHandler, reimbursementDetail.activityID),
        "ActivityTravelID": ActivityTravelDataHandler.getServerId(dbHandler, reimbursementDetail.activityTravelID),
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
              logUpSyncItemMessage("ReimbursementDetail - Saved successfully.");
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
    if ( await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/appuserlocation";

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
                sql1 += "," + Columns.KEY_UPSYNCMESSAGE + " = 'SUCCESS'";
                sql1 += "," + Columns.KEY_UPSYNCINDEX + " = '${Globals.SyncIndex.toString()}'";
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
            sql1 += " " + ColumnsBase.KEY_UPSYNCMESSAGE + " = 'FAIL: Object not returned'";
            sql1 += "," + ColumnsBase.KEY_UPSYNCINDEX + " = '${Globals.SyncIndex.toString()}'";
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
          sql1 += " " + Columns.KEY_UPSYNCMESSAGE + " = 'FAIL: ${postError.replaceAll("'", "''")}'";
          sql1 += "," + Columns.KEY_UPSYNCINDEX + " = '${Globals.SyncIndex.toString()}'";
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
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/activitypermission";

      var postData = {
        "ActivityPermissionID": !Globals.isNullOrEmpty(activityPermission.activityPermissionID) ? activityPermission.activityPermissionID : "-1",
        "ActivityPermissionCode": !Globals.isNullOrEmpty(activityPermission.activityPermissionCode) ? activityPermission.activityPermissionCode : "",
        "ActivityID": ActivityDataHandler.getServerId(dbHandler, activityPermission.activityID),
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
              logUpSyncItemMessage("ActivityPermission - Saved successfully.");
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
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/notepermission";

      var postData = {
        "NotePermissionID": !Globals.isNullOrEmpty(notePermission.notePermissionID) ? notePermission.notePermissionID : "-1",
        "NotePermissionCode": !Globals.isNullOrEmpty(notePermission.notePermissionCode) ? notePermission.notePermissionCode : "",
        "NoteID": NoteDataHandler.getServerId(dbHandler, notePermission.noteID),
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
              logUpSyncItemMessage("NotePermission - Saved successfully.");
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
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/opportunitypermission";

      var postData = {
        "OpportunityPermissionID": !Globals.isNullOrEmpty(opportunityPermission.opportunityPermissionID) ? opportunityPermission.opportunityPermissionID : "-1",
        "OpportunityPermissionCode": !Globals.isNullOrEmpty(opportunityPermission.opportunityPermissionCode) ? opportunityPermission.opportunityPermissionCode : "",
        "OpportunityID": OpportunityDataHandler.getServerId(dbHandler, opportunityPermission.opportunityID),
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
              logUpSyncItemMessage("OpportunityPermission - Saved successfully.");
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
    if (await  Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
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
              logUpSyncItemMessage("ActivityTeam - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncActivityTeam() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityTeam() 2-> ${activityTeam.id} : Object not returned.");
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
            logError("VolleyError: SyncService:UpSyncActivityTeam() 3-> $posterror");
            activityTeam.upSyncMessage = "FAIL: $posterror";
            activityTeam.upSyncIndex = Globals.SyncIndex.toString();
            ActivityTeamDataHandler.UpdateActivityTeamRecord(dbHandler, activityTeam.id, activityTeam);
          }
          upSyncList.remove("ActivityTeam-${activityTeam.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncActivityTeam() 4-> ${error.toString()}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityTeam() 4-> ${e.toString()}");
  }
}



Future<void> upSyncAppUserMessage(AppUserMessage appUserMessage)async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/appusermessage";
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
              logUpSyncItemMessage("AppUserMessage - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncAppUserMessage() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncAppUserMessage() 2-> ${appUserMessage.id} : Object not returned.");
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
            logError("VolleyError: SyncService:UpSyncAppUserMessage() 3-> $posterror");
            appUserMessage.upSyncMessage = "FAIL: $posterror";
            appUserMessage.upSyncIndex = Globals.SyncIndex.toString();
            AppUserMessageDataHandler.UpdateAppUserMessageRecord(dbHandler, appUserMessage.id, appUserMessage);
          }
          upSyncList.remove("AppUserMessage-${appUserMessage.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncAppUserMessage() 3-> ${error.toString()}");
        upSyncList.remove("AppUserMessage-${appUserMessage.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncAppUserMessage() 4-> ${e.toString()}");
  }
}



Future<void> upSyncOpportunityTeam(OpportunityTeam opportunityTeam) async{
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/opportunityteam";
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
              logUpSyncItemMessage("OpportunityTeam - Saved successfully.");
            } catch (ex) {
              logError("Error: SyncService:UpSyncOpportunityTeam() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncOpportunityTeam() 2-> ${opportunityTeam.id} : Object not returned.");
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
            logError("VolleyError: SyncService:UpSyncOpportunityTeam() 3-> $posterror");
            opportunityTeam.upSyncMessage = "FAIL: $posterror";
            opportunityTeam.upSyncIndex = Globals.SyncIndex.toString();
            OpportunityTeamDataHandler.UpdateOpportunityTeamRecord(dbHandler,  opportunityTeam.id, opportunityTeam);
          }
          upSyncList.remove("OpportunityTeam-${opportunityTeam.id}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncOpportunityTeam() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityTeam-${opportunityTeam.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncOpportunityTeam() 4-> ${e.toString()}");
  }
}
Future<void> upSyncActivityTravelMapping(ActivityTravelMapping activityTravelMapping) async{
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = AppConstant.API_VERSION_URL + "/activitytravelmapping";

      var postData = {
        "ActivityTravelMappingID": !Globals.isNullOrEmpty(activityTravelMapping.activityTravelMappingID) ? activityTravelMapping.activityTravelMappingID : "-1",
        "ActivityTravelMappingCode": !Globals.isNullOrEmpty(activityTravelMapping.activityTravelMappingCode) ? activityTravelMapping.activityTravelMappingCode : "",
        "ActivityTravelID": ActivityTravelDataHandler.getServerId(dbHandler,  activityTravelMapping.activityTravelID),
        "ActivityID": ActivityDataHandler.getServerId(dbHandler,  activityTravelMapping.activityID),
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
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/accountbusinessunit";
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
              logError("Error: SyncService:UpSyncAccountBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncAccountBusinessUnit() 2-> ${accountBusinessUnit.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncAccountBusinessUnit() 3-> ${response.statusCode}: $posterror");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncAccountBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("AccountBusinessUnit-${accountBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncAccountBusinessUnit() 4-> ${e.toString()}");
  }
}

void upSyncActivityBusinessUnit(ActivityBusinessunit activityBusinessUnit) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/activitybusinessunit";
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
              logError("Error: SyncService:UpSyncActivityBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityBusinessUnit() 2-> ${activityBusinessUnit.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncActivityBusinessUnit() 3-> ${response.statusCode}: $posterror");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncActivityBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("ActivityBusinessUnit-${activityBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityBusinessUnit() 4-> ${e.toString()}");
  }
}



void upSyncOpportunityBusinessUnit(OpportunityBusinessUnit opportunityBusinessUnit) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/opportunitybusinessunit";
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
              logError("Error: SyncService:UpSyncOpportunityBusinessUnit() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncOpportunityBusinessUnit() 2-> ${opportunityBusinessUnit.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncOpportunityBusinessUnit() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncOpportunityBusinessUnit() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityBusinessUnit-${opportunityBusinessUnit.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncOpportunityBusinessUnit() 4-> ${e.toString()}");
  }
}


Future<void> upSyncActivityApproval(ActivityApproval activityApproval)async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/activityapproval";
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
              logError("Error: SyncService:UpSyncActivityApproval() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncActivityApproval() 2-> ${activityApproval.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncActivityApproval() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncActivityApproval() 3-> ${error.toString()}");
        upSyncList.remove("ActivityApproval-${activityApproval.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncActivityApproval() 4-> ${e.toString()}");
  }
}

Future<void> upSyncOpportunityApproval(OpportunityApproval opportunityApproval)async {
  try {
    if ( await Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/opportunityapproval";
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
              logError("Error: SyncService:UpSyncOpportunityApproval() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncOpportunityApproval() 2-> ${opportunityApproval.id} : Object not returned.");
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
          logError("VolleyError: SyncService:UpSyncOpportunityApproval() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncOpportunityApproval() 3-> ${error.toString()}");
        upSyncList.remove("OpportunityApproval-${opportunityApproval.id}");
      });
    }
  } catch (e) {
    logError("Error: SyncService:UpSyncOpportunityApproval() 4-> ${e.toString()}");
  }
}


void upSyncAppLog(AppLog appLog) {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN != "") {
      String url = AppConstant.API_VERSION_URL + "/applog";
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
              logError("Error: SyncService:UpSyncAppLog() 1-> ${ex.toString()}");
            }
          } else {
            logError("VolleyError: SyncService:UpSyncAppLog() 2-> ${appLog.id} : Object not returned.");
            appLog.upSyncMessage = "FAIL: Object not returned";
            appLog.upSyncIndex = Globals.SyncIndexApplog.toString();
            AppLogDataHandler.UpdateAppLogRecord(dbHandler,  appLog.id, appLog);
          }
          UpSyncListApplog.remove("AppLog-${appLog.id}");
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
          UpSyncListApplog.remove("AppLog-${appLog.id}");
          logError("VolleyError: SyncService:UpSyncAppLog() 3-> ${response.statusCode}: ${response.body}");
        }
      }).catchError((error) {
        logError("Error: SyncService:UpSyncAppLog() 3-> ${error.toString()}");
        UpSyncListApplog.remove("AppLog-${appLog.id}");
      });
    }
  } catch (e) {
    //logError("Error: SyncService:UpSyncAppLog() 4-> ${e.toString()}");
  }
}



Future<void> upSyncHSSupportTicket(HSSupportTicket hSSupportTicket) async {
  try {
    if (await Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstant.API_VERSION_URL}/hssupportticket';

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
            logError('Error: SyncService:UpSyncHSSupportTicket() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:UpSyncHSSupportTicket() 2-> ${hSSupportTicket.id}: Object not returned.');
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
        logError('VolleyError: SyncService:UpSyncHSSupportTicket() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:UpSyncHSSupportTicket() 4-> $e');
  }
}



void upSyncHSSupportTicketMedia(HSSupportTicketMedia hSSupportTicketMedia) async {
  try {
    if (Utility.isNetworkConnected() && Globals.USER_TOKEN.isNotEmpty) {
      String url = '${AppConstant.API_VERSION_URL}/hssupportticketmedia';

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
            logError('Error: SyncService:UpSyncHSSupportTicketMedia() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:UpSyncHSSupportTicketMedia() 2-> ${hSSupportTicketMedia.id}: Object not returned.');
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
        logError('VolleyError: SyncService:UpSyncHSSupportTicketMedia() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:UpSyncHSSupportTicketMedia() 4-> $e');
  }
}



Future<void> upSyncReminder(Reminder reminder) async {
  try {
    if (await Utility.isNetworkConnected() && !Globals.USER_TOKEN.isEmpty) {
      String url = '${AppConstant.API_VERSION_URL}/reminder';

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
            logError('Error: SyncService:UpSyncReminder() 1-> $ex');
          }
        } else {
          logError(
              'VolleyError: SyncService:UpSyncReminder() 2-> ${reminder.id}: Object not returned.');
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
        logError('VolleyError: SyncService:UpSyncReminder() 3-> $posterror');
      }
    }
  } catch (e) {
    logError('Error: SyncService:UpSyncReminder() 4-> $e');
  }
}


    //*************************************DOWN-SYNC***************************************




}