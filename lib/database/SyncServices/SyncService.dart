import 'dart:ffi';

import 'package:happsales_crm/database/AppConstants.dart';
import 'package:happsales_crm/database/Handlers/AccountHandlers/AccountDataHandlerBase.dart';

import '../Handlers/AccountHandlers/AccountDataHandler.dart';
import '../Handlers/DataBaseHandler.dart';
import '../models/AccountModels/Account.dart';

class SyncService{

    // Handler handler;

     static Long DEFAULT_SYNC_INTERVAL = (5 * 1000) as Long;
     static final String LOG_TAG = "HS_SYNC";
     static DatabaseHandler? dbHandler;

     static var logger = ;

     
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
  LogUpSyncMessage("New Or Modified Accounts - ${newOrModifiedAccountList.length}");
  totalRecordsToUpsync += newOrModifiedAccountList.length;
}

for (Account account in newOrModifiedAccountList) {
  try {
    if (!upSyncList.contains("Account-${account.id}")) {
      upSyncList.add("Account-${account.id}");
      UpSyncAccount(account);
    }
  } catch (e) {
    // Exception handling code goes here
  }
  return; // Assuming this is intended to exit the loop after the first iteration
}


            //AccountCategoryMapping
            List<AccountCategoryMapping> newOrModifiedAccountCategoryMappingList = AccountCategoryMappingDataHandler.GetAccountCategoryMappingUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountCategoryMappingList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified AccountCategoryMappings - " + String.valueOf(newOrModifiedAccountCategoryMappingList.size()));
                totalRecordsToUpsync += newOrModifiedAccountCategoryMappingList.size();
            }
            for (AccountCategoryMapping accountCategoryMapping : newOrModifiedAccountCategoryMappingList) {
                try {
                    if (!upSyncList.contains("AccountCategoryMapping-" + accountCategoryMapping.getId())) {
                        upSyncList.add("AccountCategoryMapping-" + accountCategoryMapping.getId());
                        UpSyncAccountCategoryMapping(accountCategoryMapping);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Contact
            List<Contact> newOrModifiedContactList = ContactDataHandler.GetContactUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactList.size() > 0) {
                LogUpSyncMessage("New Or Modified Contacts - " + String.valueOf(newOrModifiedContactList.size()));
                totalRecordsToUpsync += newOrModifiedContactList.size();
            }
            for (Contact contact : newOrModifiedContactList) {
                try {
                    if (!upSyncList.contains("Contact-" + contact.getId())) {
                        upSyncList.add("Contact-" + contact.getId());
                        UpSyncContact(contact);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Activity
            List<Activity> newOrModifiedActivityList = ActivityDataHandler.GetActivityUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityList.size() > 0) {
                LogUpSyncMessage("New Or Modified Activities - " + String.valueOf(newOrModifiedActivityList.size()));
                totalRecordsToUpsync += newOrModifiedActivityList.size();
            }
            for (Activity activity : newOrModifiedActivityList) {
                try {
                    if (!upSyncList.contains("Activity-" + activity.getId())) {
                        upSyncList.add("Activity-" + activity.getId());
                        UpSyncActivity(activity);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Opportunity
            List<Opportunity> newOrModifiedOpportunityList = OpportunityDataHandler.GetOpportunityUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityList.size() > 0) {
                LogUpSyncMessage("New Or Modified Opportunities - " + String.valueOf(newOrModifiedOpportunityList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityList.size();
            }
            for (Opportunity opportunity : newOrModifiedOpportunityList) {
                try {
                    if (!upSyncList.contains("Opportunity-" + opportunity.getId())) {
                        upSyncList.add("Opportunity-" + opportunity.getId());
                        UpSyncOpportunity(opportunity);
                    }
                } catch (Exception e) {
                }
                return;
            }


            //ActivityProduct
            List<String> newOrModifiedActivityIdList = ActivityProductDataHandler.GetActivityProductUpSyncRecordsActivityIds(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityIdList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityProducts - " + String.valueOf(newOrModifiedActivityIdList.size()));
                totalRecordsToUpsync += newOrModifiedActivityIdList.size();
            }
            for (String activityId : newOrModifiedActivityIdList) {
                try {

                    String masterActivityId = ActivityDataHandler.GetServerId(dbHandler, context, activityId);

                    if (!masterActivityId.equals("") && !upSyncList.contains("ActivityProduct-" + masterActivityId)) {

                        List<ActivityProduct> activityProductListOriginal = ActivityProductDataHandler.GetActivityProductUpSyncRecordsByActivityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailListOriginal = ActivityProductDetailDataHandler.GetActivityProductDetailUpSyncRecordsByActivityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        List<ActivityProduct> activityProductList = ActivityProductDataHandler.GetActivityProductUpSyncRecordsByActivityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, activityId);
                        List<ActivityProductDetail> activityProductDetailList = ActivityProductDetailDataHandler.GetActivityProductDetailUpSyncRecordsByActivityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, activityId);

                        //String serverActivityId = ActivityDataHandler.GetServerId(dbHandler, context, activityId);

                        for (ActivityProduct activityProduct : activityProductList) {
                            activityProduct.setActivityID(masterActivityId);
                            activityProduct.setProductID(ProductDataHandler.GetServerId(dbHandler, context, activityProduct.getProductID()));
                        }

                        for (ActivityProductDetail activityProductDetail : activityProductDetailList) {
                            activityProductDetail.setActivityProductID("-1");
                            activityProductDetail.setSupplierAccountID(AccountDataHandler.GetServerId(dbHandler, context, activityProductDetail.getSupplierAccountID()));
                        }

                        upSyncList.add("ActivityProduct-" + masterActivityId);
                        UpSyncActivityProduct(masterActivityId, activityProductListOriginal, activityProductDetailListOriginal, activityProductList, activityProductDetailList);
                    }

                } catch (Exception e) {
                }
                return;
            }

            //OpportunityProduct
            List<String> newOrModifiedOpportunityIdList = OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsOpportunityIds(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityIdList.size() > 0) {
                LogUpSyncMessage("New Or Modified OpportunityProducts - " + String.valueOf(newOrModifiedOpportunityIdList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityIdList.size();
            }
            for (String opportunityId : newOrModifiedOpportunityIdList) {
                try {

                    String masterOpportunityId = OpportunityDataHandler.GetServerId(dbHandler, context, opportunityId);

                    if (!masterOpportunityId.equals("") && !upSyncList.contains("OpportunityProduct-" + masterOpportunityId)) {

                        List<OpportunityProduct> opportunityProductListOriginal = OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsByOpportunityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailListOriginal = OpportunityProductDetailDataHandler.GetOpportunityProductDetailUpSyncRecordsByOpportunityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        List<OpportunityProduct> opportunityProductList = OpportunityProductDataHandler.GetOpportunityProductUpSyncRecordsByOpportunityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, opportunityId);
                        List<OpportunityProductDetail> opportunityProductDetailList = OpportunityProductDetailDataHandler.GetOpportunityProductDetailUpSyncRecordsByOpportunityId(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED, opportunityId);

                        //String serverOpportunityId = OpportunityDataHandler.GetServerId(dbHandler, context, opportunityId);

                        for (OpportunityProduct opportunityProduct : opportunityProductList) {
                            opportunityProduct.setOpportunityID(masterOpportunityId);
                            opportunityProduct.setProductID(ProductDataHandler.GetServerId(dbHandler, context, opportunityProduct.getProductID()));
                        }

                        for (OpportunityProductDetail opportunityProductDetail : opportunityProductDetailList) {
                            opportunityProductDetail.setOpportunityProductID("-1");
                            opportunityProductDetail.setSupplierAccountID(AccountDataHandler.GetServerId(dbHandler, context, opportunityProductDetail.getSupplierAccountID()));
                        }

                        upSyncList.add("OpportunityProduct-" + masterOpportunityId);
                        UpSyncOpportunityProduct(masterOpportunityId, opportunityProductListOriginal, opportunityProductDetailListOriginal, opportunityProductList, opportunityProductDetailList);
                    }
                } catch (Exception e) {
                }
                return;
            }

           /* //OpportunityProductDetailAttribute
            List<OpportunityProductDetailAttribute> newOrModifiedOpportunityProductDetailAttributeList = OpportunityProductDetailAttributeDataHandler.GetOpportunityProductDetailAttributeUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            Log.d(LOG_TAG, "New Or Modified OpportunityProductDetailAttributes - " + String.valueOf(newOrModifiedOpportunityProductDetailAttributeList.size()));
            for (OpportunityProductDetailAttribute opportunityProductDetailAttribute : newOrModifiedOpportunityProductDetailAttributeList) {
                try {
                    if(!upSyncList.contains("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.getId())) {
                        upSyncList.add("OpportunityProductDetailAttribute-" + opportunityProductDetailAttribute.getId());
                        UpSyncOpportunityProductDetailAttribute(opportunityProductDetailAttribute);
                    }
                } catch (Exception e) {
                }
                return;
            }*/

            //CustomerMeeting
            List<CustomerMeeting> newOrModifiedCustomerMeetingList = CustomerMeetingDataHandler.GetCustomerMeetingUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedCustomerMeetingList.size() > 0) {
                LogUpSyncMessage("New Or Modified CustomerMeetings - " + String.valueOf(newOrModifiedCustomerMeetingList.size()));
                totalRecordsToUpsync += newOrModifiedCustomerMeetingList.size();
            }
            for (CustomerMeeting customerMeeting : newOrModifiedCustomerMeetingList) {
                try {
                    if (!upSyncList.contains("CustomerMeeting-" + customerMeeting.getId())) {
                        upSyncList.add("CustomerMeeting-" + customerMeeting.getId());
                        UpSyncCustomerMeeting(customerMeeting);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //OpportunityContact
            List<OpportunityContact> newOrModifiedOpportunityContactList = OpportunityContactDataHandler.GetOpportunityContactUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityContactList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityContacts - " + String.valueOf(newOrModifiedOpportunityContactList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityContactList.size();
            }
            for (OpportunityContact opportunityContact : newOrModifiedOpportunityContactList) {
                try {
                    if (!upSyncList.contains("OpportunityContact-" + opportunityContact.getId())) {
                        upSyncList.add("OpportunityContact-" + opportunityContact.getId());
                        UpSyncOpportunityContact(opportunityContact);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountAddress
            List<AccountAddress> newOrModifiedAccountAddressList = AccountAddressDataHandler.GetAccountAddressUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountAddressList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountAddresses - " + String.valueOf(newOrModifiedAccountAddressList.size()));
                totalRecordsToUpsync += newOrModifiedAccountAddressList.size();
            }
            for (AccountAddress accountAddress : newOrModifiedAccountAddressList) {
                try {
                    if (!upSyncList.contains("AccountAddress-" + accountAddress.getId())) {
                        upSyncList.add("AccountAddress-" + accountAddress.getId());
                        UpSyncAccountAddress(accountAddress);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountPhone
            List<AccountPhone> newOrModifiedAccountPhoneList = AccountPhoneDataHandler.GetAccountPhoneUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountPhoneList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountPhones - " + String.valueOf(newOrModifiedAccountPhoneList.size()));
                totalRecordsToUpsync += newOrModifiedAccountPhoneList.size();
            }
            for (AccountPhone accountPhone : newOrModifiedAccountPhoneList) {
                try {
                    if (!upSyncList.contains("AccountPhone-" + accountPhone.getId())) {
                        upSyncList.add("AccountPhone-" + accountPhone.getId());
                        UpSyncAccountPhone(accountPhone);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountBuyingProcess
            List<AccountBuyingProcess> newOrModifiedAccountBuyingProcessList = AccountBuyingProcessDataHandler.GetAccountBuyingProcessUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBuyingProcessList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountBuyingProcesses - " + String.valueOf(newOrModifiedAccountBuyingProcessList.size()));
                totalRecordsToUpsync += newOrModifiedAccountBuyingProcessList.size();
            }
            for (AccountBuyingProcess accountBuyingProcess : newOrModifiedAccountBuyingProcessList) {
                try {
                    if (!upSyncList.contains("AccountBuyingProcess-" + accountBuyingProcess.getId())) {
                        upSyncList.add("AccountBuyingProcess-" + accountBuyingProcess.getId());
                        UpSyncAccountBuyingProcess(accountBuyingProcess);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountBusinessPlan
            List<AccountBusinessPlan> newOrModifiedAccountBusinessPlanList = AccountBusinessPlanDataHandler.GetAccountBusinessPlanUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessPlanList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountBusinessPlans - " + String.valueOf(newOrModifiedAccountBusinessPlanList.size()));
                totalRecordsToUpsync += newOrModifiedAccountBusinessPlanList.size();
            }
            for (AccountBusinessPlan accountBusinessPlan : newOrModifiedAccountBusinessPlanList) {
                try {
                    if (!upSyncList.contains("AccountBusinessPlan-" + accountBusinessPlan.getId())) {
                        upSyncList.add("AccountBusinessPlan-" + accountBusinessPlan.getId());
                        UpSyncAccountBusinessPlan(accountBusinessPlan);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountCompetitionActivity
            List<AccountCompetitionActivity> newOrModifiedAccountCompetitionActivityList = AccountCompetitionActivityDataHandler.GetAccountCompetitionActivityUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountCompetitionActivityList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountCompetitionActivities - " + String.valueOf(newOrModifiedAccountCompetitionActivityList.size()));
                totalRecordsToUpsync += newOrModifiedAccountCompetitionActivityList.size();
            }
            for (AccountCompetitionActivity accountCompetitionActivity : newOrModifiedAccountCompetitionActivityList) {
                try {
                    if (!upSyncList.contains("AccountCompetitionActivity-" + accountCompetitionActivity.getId())) {
                        upSyncList.add("AccountCompetitionActivity-" + accountCompetitionActivity.getId());
                        UpSyncAccountCompetitionActivity(accountCompetitionActivity);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Note
            List<Note> newOrModifiedNoteList = NoteDataHandler.GetNoteUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteList.size() > 0) {
                LogUpSyncMessage("New Or Modified Notes - " + String.valueOf(newOrModifiedNoteList.size()));
                totalRecordsToUpsync += newOrModifiedNoteList.size();
            }
            for (Note note : newOrModifiedNoteList) {
                try {
                    if (!upSyncList.contains("Note-" + note.getId())) {
                        upSyncList.add("Note-" + note.getId());
                        UpSyncNote(note);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityTravel
            List<ActivityTravel> newOrModifiedActivityTravelList = ActivityTravelDataHandler.GetActivityTravelUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityTravels - " + String.valueOf(newOrModifiedActivityTravelList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTravelList.size();
            }
            for (ActivityTravel activityTravel : newOrModifiedActivityTravelList) {
                try {
                    if (!upSyncList.contains("ActivityTravel-" + activityTravel.getId())) {
                        upSyncList.add("ActivityTravel-" + activityTravel.getId());
                        UpSyncActivityTravel(activityTravel);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountMedia
            List<AccountMedia> newOrModifiedAccountMediaList = AccountMediaDataHandler.GetAccountMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountMedia - " + String.valueOf(newOrModifiedAccountMediaList.size()));
                totalRecordsToUpsync += newOrModifiedAccountMediaList.size();
            }
            for (AccountMedia accountMedia : newOrModifiedAccountMediaList) {
                try {
                    if (!upSyncList.contains("AccountMedia-" + accountMedia.getId())) {
                        upSyncList.add("AccountMedia-" + accountMedia.getId());
                        UpSyncAccountMedia(accountMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }


            //ContactMedia
            List<ContactMedia> newOrModifiedContactMediaList = ContactMediaDataHandler.GetContactMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified ContactMedia - " + String.valueOf(newOrModifiedContactMediaList.size()));
                totalRecordsToUpsync += newOrModifiedContactMediaList.size();
            }
            for (ContactMedia contactMedia : newOrModifiedContactMediaList) {
                try {
                    if (!upSyncList.contains("ContactMedia-" + contactMedia.getId())) {
                        upSyncList.add("ContactMedia-" + contactMedia.getId());
                        UpSyncContactMedia(contactMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //OpportunityMedia
            List<OpportunityMedia> newOrModifiedOpportunityMediaList = OpportunityMediaDataHandler.GetOpportunityMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified OpportunityMedia - " + String.valueOf(newOrModifiedOpportunityMediaList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityMediaList.size();
            }
            for (OpportunityMedia opportunityMedia : newOrModifiedOpportunityMediaList) {
                try {
                    if (!upSyncList.contains("OpportunityMedia-" + opportunityMedia.getId())) {
                        upSyncList.add("OpportunityMedia-" + opportunityMedia.getId());
                        UpSyncOpportunityMedia(opportunityMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityMedia
            List<ActivityMedia> newOrModifiedActivityMediaList = ActivityMediaDataHandler.GetActivityMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityMedia - " + String.valueOf(newOrModifiedActivityMediaList.size()));
                totalRecordsToUpsync += newOrModifiedActivityMediaList.size();
            }
            for (ActivityMedia activityMedia : newOrModifiedActivityMediaList) {
                try {
                    if (!upSyncList.contains("ActivityMedia-" + activityMedia.getId())) {
                        upSyncList.add("ActivityMedia-" + activityMedia.getId());
                        UpSyncActivityMedia(activityMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //NoteMedia
            List<NoteMedia> newOrModifiedNoteMediaList = NoteMediaDataHandler.GetNoteMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified NoteMedia - " + String.valueOf(newOrModifiedNoteMediaList.size()));
                totalRecordsToUpsync += newOrModifiedNoteMediaList.size();
            }
            for (NoteMedia noteMedia : newOrModifiedNoteMediaList) {
                try {
                    if (!upSyncList.contains("NoteMedia-" + noteMedia.getId())) {
                        upSyncList.add("NoteMedia-" + noteMedia.getId());
                        UpSyncNoteMedia(noteMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityTravelMedia
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaList = ActivityTravelMediaDataHandler.GetActivityTravelMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityTravelMedia - " + String.valueOf(newOrModifiedActivityTravelMediaList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTravelMediaList.size();
            }
            for (ActivityTravelMedia activityMedia : newOrModifiedActivityTravelMediaList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMedia-" + activityMedia.getId())) {
                        upSyncList.add("ActivityTravelMedia-" + activityMedia.getId());
                        UpSyncActivityTravelMedia(activityMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityTravelExpense
            List<ActivityTravelExpense> newOrModifiedActivityTravelExpenseList = ActivityTravelExpenseDataHandler.GetActivityTravelExpenseUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelExpenseList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelExpenses - " + String.valueOf(newOrModifiedActivityTravelExpenseList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTravelExpenseList.size();
            }
            for (ActivityTravelExpense activityTravelExpense : newOrModifiedActivityTravelExpenseList) {
                try {
                    if (!upSyncList.contains("ActivityTravelExpense-" + activityTravelExpense.getId())) {
                        upSyncList.add("ActivityTravelExpense-" + activityTravelExpense.getId());
                        UpSyncActivityTravelExpense(activityTravelExpense);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //FieldAttendance
            List<FieldAttendance> newOrModifiedFieldAttendanceList = FieldAttendanceDataHandler.GetFieldAttendanceUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedFieldAttendanceList.size() > 0) {
                LogUpSyncMessage("New Or Modified FieldAttendances - " + String.valueOf(newOrModifiedFieldAttendanceList.size()));
                totalRecordsToUpsync += newOrModifiedFieldAttendanceList.size();
            }
            for (FieldAttendance fieldAttendance : newOrModifiedFieldAttendanceList) {
                try {
                    if (!upSyncList.contains("FieldAttendance-" + fieldAttendance.getId())) {
                        upSyncList.add("FieldAttendance-" + fieldAttendance.getId());
                        //Get Address for PunchIn Location
                        if (!Globals.IsNullOrEmpty(fieldAttendance.getPunchInLocation())) {
                            JSONObject obj = new JSONObject(fieldAttendance.getPunchInLocation());
                            if (Globals.IsNullOrEmpty(obj.getString("address"))) {
                                if (!Globals.IsNullOrEmpty(Globals.GetLocationAddress(context, Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude"))))) {
                                    AddressEntry addressEntry = new AddressEntry(obj.getString("timeId"), GetLocationAddress(context, Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude"))), Double.parseDouble(obj.getString("latitude")), Double.parseDouble(obj.getString("longitude")));
                                    Gson gson = new Gson();
                                    String addressString = gson.toJson(addressEntry);
                                    fieldAttendance.setPunchInLocation(addressString);
                                    fieldAttendance.setIsDirty("true");
                                    long rid = FieldAttendanceDataHandler.UpdateFieldAttendanceRecord(dbHandler, context, fieldAttendance.getId(), fieldAttendance);
                                    //Log.d("Missed-PunchIn", "Sucessfully Updated");
                                }

                            }
                        }

                        //Get Address for punchOut Location
                        if (!Globals.IsNullOrEmpty(fieldAttendance.getPunchOutLocation())) {
                            JSONObject jsonObjectPunchOut = new JSONObject(fieldAttendance.getPunchOutLocation());
                            if (Globals.IsNullOrEmpty(jsonObjectPunchOut.getString("address"))) {
                                if (!Globals.IsNullOrEmpty(Globals.GetLocationAddress(context, Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude"))))) {
                                    AddressEntry addressEntry = new AddressEntry(jsonObjectPunchOut.getString("timeId"), GetLocationAddress(context, Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude"))), Double.parseDouble(jsonObjectPunchOut.getString("latitude")), Double.parseDouble(jsonObjectPunchOut.getString("longitude")));
                                    Gson gson = new Gson();
                                    String addressString = gson.toJson(addressEntry);
                                    fieldAttendance.setPunchOutLocation(addressString);
                                    fieldAttendance.setIsDirty("true");
                                    fieldAttendance.setModifiedBy(Globals.AppUserLoginName);
                                    fieldAttendance.setModifiedOn(Globals.GetDateTimeNowDBFormat());
                                    long rid = FieldAttendanceDataHandler.UpdateFieldAttendanceRecord(dbHandler, context, fieldAttendance.getId(), fieldAttendance);
                                    //Log.d("Missed-PunchOut", "Sucessfully Updated");
                                }
                            }
                        }

                        UpSyncFieldAttendance(fieldAttendance);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AppUserRemark
            List<AppUserRemark> newOrModifiedAppUserRemarkList = AppUserRemarkDataHandler.GetAppUserRemarkUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserRemarkList.size() > 0) {
                LogUpSyncMessage("New Or Modified AppUserRemarks - " + String.valueOf(newOrModifiedAppUserRemarkList.size()));
                totalRecordsToUpsync += newOrModifiedAppUserRemarkList.size();
            }
            for (AppUserRemark appUserRemark : newOrModifiedAppUserRemarkList) {
                try {
                    if (!upSyncList.contains("AppUserRemark-" + appUserRemark.getId())) {
                        upSyncList.add("AppUserRemark-" + appUserRemark.getId());
                        UpSyncAppUserRemark(appUserRemark);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountForm
            List<AccountForm> newOrModifiedAccountFormList = AccountFormDataHandler.GetAccountFormUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountFormList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountForms - " + String.valueOf(newOrModifiedAccountFormList.size()));
                totalRecordsToUpsync += newOrModifiedAccountFormList.size();
            }
            for (AccountForm accountForm : newOrModifiedAccountFormList) {
                try {
                    if (!upSyncList.contains("AccountForm-" + accountForm.getId())) {
                        upSyncList.add("AccountForm-" + accountForm.getId());
                        UpSyncAccountForm(accountForm);
                    }
                } catch (Exception e) {
                }
                return;
            }


            //AccountFormValue
            List<AccountForm> newOrModifiedAccountFormListForValuesUpSync = AccountFormDataHandler.GetMasterAccountFormRecordsForValuesUpSync(dbHandler, context);
            if (newOrModifiedAccountFormListForValuesUpSync.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountFormValues - " + String.valueOf(newOrModifiedAccountFormListForValuesUpSync.size()));
                totalRecordsToUpsync += newOrModifiedAccountFormListForValuesUpSync.size();
            }
            for (AccountForm accountForm : newOrModifiedAccountFormListForValuesUpSync) {
                try {
                    if (!upSyncList.contains("AccountFormValue-" + accountForm.getId())) {
                        upSyncList.add("AccountFormValue-" + accountForm.getId());
                        List<AccountFormValue> accountFormValuesOriginal = AccountFormValueDataHandler.GetAccountFormValueUpSyncRecordsByAccountFormId(dbHandler, context, accountForm.getId());
                        List<AccountFormValue> accountFormValues = AccountFormValueDataHandler.GetAccountFormValueUpSyncRecordsByAccountFormId(dbHandler, context, accountForm.getId());
                        for (AccountFormValue accountFormValue : accountFormValues) {
                            accountFormValue.setAccountFormID(AccountFormDataHandler.GetServerId(dbHandler, context, accountFormValue.getAccountFormID()));
                            accountFormValue.setFormCellElementID(FormCellElementDataHandler.GetServerId(dbHandler, context, accountFormValue.getFormCellElementID()));
                        }
                        UpSyncAccountFormValue(accountForm.getId(), accountFormValuesOriginal, accountFormValues);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Reimbursement
            List<Reimbursement> newOrModifiedReimbursementList = ReimbursementDataHandler.GetReimbursementUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementList.size() > 0) {
                LogUpSyncMessage("New Or Modified Reimbursements - " + String.valueOf(newOrModifiedReimbursementList.size()));
                totalRecordsToUpsync += newOrModifiedReimbursementList.size();
            }
            for (Reimbursement reimbursement : newOrModifiedReimbursementList) {
                try {
                    if (!upSyncList.contains("Reimbursement-" + reimbursement.getId())) {
                        upSyncList.add("Reimbursement-" + reimbursement.getId());
                        UpSyncReimbursement(reimbursement);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ReimbursementDetail
            List<ReimbursementDetail> newOrModifiedReimbursementDetailList = ReimbursementDetailDataHandler.GetReimbursementDetailUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReimbursementDetailList.size() > 0) {
                LogUpSyncMessage("New Or Modified ReimbursementDetails - " + String.valueOf(newOrModifiedReimbursementDetailList.size()));
                totalRecordsToUpsync += newOrModifiedReimbursementDetailList.size();
            }
            for (ReimbursementDetail reimbursementDetail : newOrModifiedReimbursementDetailList) {
                try {
                    if (!upSyncList.contains("ReimbursementDetail-" + reimbursementDetail.getId())) {
                        upSyncList.add("ReimbursementDetail-" + reimbursementDetail.getId());
                        UpSyncReimbursementDetail(reimbursementDetail);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityPermission
            List<ActivityPermission> newOrModifiedActivityPermissionList = ActivityPermissionDataHandler.GetActivityPermissionUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityPermissionList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityPermissions - " + String.valueOf(newOrModifiedActivityPermissionList.size()));
                totalRecordsToUpsync += newOrModifiedActivityPermissionList.size();
            }
            for (ActivityPermission activityPermission : newOrModifiedActivityPermissionList) {
                try {
                    if (!upSyncList.contains("ActivityPermission-" + activityPermission.getId())) {
                        upSyncList.add("ActivityPermission-" + activityPermission.getId());
                        UpSyncActivityPermission(activityPermission);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //NotePermission
            List<NotePermission> newOrModifiedNotePermissionList = NotePermissionDataHandler.GetNotePermissionUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNotePermissionList.size() > 0) {
                LogUpSyncMessage("New Or Modified NotePermissions - " + String.valueOf(newOrModifiedNotePermissionList.size()));
                totalRecordsToUpsync += newOrModifiedNotePermissionList.size();
            }
            for (NotePermission notePermission : newOrModifiedNotePermissionList) {
                try {
                    if (!upSyncList.contains("NotePermission-" + notePermission.getId())) {
                        upSyncList.add("NotePermission-" + notePermission.getId());
                        UpSyncNotePermission(notePermission);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //OpportunityPermission
            List<OpportunityPermission> newOrModifiedOpportunityPermissionList = OpportunityPermissionDataHandler.GetOpportunityPermissionUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityPermissionList.size() > 0) {
                LogUpSyncMessage("New Or Modified OpportunityPermissions - " + String.valueOf(newOrModifiedOpportunityPermissionList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityPermissionList.size();
            }
            for (OpportunityPermission opportunityPermission : newOrModifiedOpportunityPermissionList) {
                try {
                    if (!upSyncList.contains("OpportunityPermission-" + opportunityPermission.getId())) {
                        upSyncList.add("OpportunityPermission-" + opportunityPermission.getId());
                        UpSyncOpportunityPermission(opportunityPermission);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityTeam
            List<ActivityTeam> newOrModifiedActivityTeamList = ActivityTeamDataHandler.GetActivityTeamUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTeamList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityTeams - " + String.valueOf(newOrModifiedActivityTeamList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTeamList.size();
            }
            for (ActivityTeam activityTeam : newOrModifiedActivityTeamList) {
                try {
                    if (!upSyncList.contains("ActivityTeam-" + activityTeam.getId())) {
                        upSyncList.add("ActivityTeam-" + activityTeam.getId());
                        UpSyncActivityTeam(activityTeam);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AppUserMessage
            List<AppUserMessage> newOrModifiedAppUserMessageList = AppUserMessageDataHandler.GetAppUserMessageUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserMessageList.size() > 0) {
                LogUpSyncMessage("New Or Modified AppUserMessages - " + String.valueOf(newOrModifiedAppUserMessageList.size()));
                totalRecordsToUpsync += newOrModifiedAppUserMessageList.size();
            }
            for (AppUserMessage appUserMessage : newOrModifiedAppUserMessageList) {
                try {
                    if (!upSyncList.contains("AppUserMessage-" + appUserMessage.getId())) {
                        upSyncList.add("AppUserMessage-" + appUserMessage.getId());
                        UpSyncAppUserMessage(appUserMessage);
                    }
                } catch (Exception e) {
                }
                return;
            }


            //OpportunityTeam
            List<OpportunityTeam> newOrModifiedOpportunityTeamList = OpportunityTeamDataHandler.GetOpportunityTeamUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityTeamList.size() > 0) {
                LogUpSyncMessage("New Or Modified OpportunityTeams - " + String.valueOf(newOrModifiedOpportunityTeamList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityTeamList.size();
            }
            for (OpportunityTeam opportunityTeam : newOrModifiedOpportunityTeamList) {
                try {
                    if (!upSyncList.contains("OpportunityTeam-" + opportunityTeam.getId())) {
                        upSyncList.add("OpportunityTeam-" + opportunityTeam.getId());
                        UpSyncOpportunityTeam(opportunityTeam);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityTravelMapping
            List<ActivityTravelMapping> newOrModifiedActivityTravelMappingList = ActivityTravelMappingDataHandler.GetActivityTravelMappingUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMappingList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityTravelMappings - " + String.valueOf(newOrModifiedActivityTravelMappingList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTravelMappingList.size();
            }
            for (ActivityTravelMapping activityTravelMapping : newOrModifiedActivityTravelMappingList) {
                try {
                    if (!upSyncList.contains("ActivityTravelMapping-" + activityTravelMapping.getId())) {
                        upSyncList.add("ActivityTravelMapping-" + activityTravelMapping.getId());
                        UpSyncActivityTravelMapping(activityTravelMapping);
                    }
                } catch (Exception e) {
                }
                return;
            }


            //AccountBusinessUnit
            List<AccountBusinessUnit> newOrModifiedAccountBusinessUnitList = AccountBusinessUnitDataHandler.GetAccountBusinessUnitUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountBusinessUnitList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified AccountBusinessUnits - " + String.valueOf(newOrModifiedAccountBusinessUnitList.size()));
                totalRecordsToUpsync += newOrModifiedAccountBusinessUnitList.size();
            }
            for (AccountBusinessUnit accountBusinessUnit : newOrModifiedAccountBusinessUnitList) {
                try {
                    if (!upSyncList.contains("AccountBusinessUnit-" + accountBusinessUnit.getId())) {
                        upSyncList.add("AccountBusinessUnit-" + accountBusinessUnit.getId());
                        UpSyncAccountBusinessUnit(accountBusinessUnit);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityBusinessUnit
            List<ActivityBusinessUnit> newOrModifiedActivityBusinessUnitList = ActivityBusinessUnitDataHandler.GetActivityBusinessUnitUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityBusinessUnitList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityBusinessUnits - " + String.valueOf(newOrModifiedActivityBusinessUnitList.size()));
                totalRecordsToUpsync += newOrModifiedActivityBusinessUnitList.size();
            }
            for (ActivityBusinessUnit activityBusinessUnit : newOrModifiedActivityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("ActivityBusinessUnit-" + activityBusinessUnit.getId())) {
                        upSyncList.add("ActivityBusinessUnit-" + activityBusinessUnit.getId());
                        UpSyncActivityBusinessUnit(activityBusinessUnit);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //OpportunityBusinessUnit
            List<OpportunityBusinessUnit> newOrModifiedOpportunityBusinessUnitList = OpportunityBusinessUnitDataHandler.GetOpportunityBusinessUnitUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityBusinessUnitList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityBusinessUnits - " + String.valueOf(newOrModifiedOpportunityBusinessUnitList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityBusinessUnitList.size();
            }
            for (OpportunityBusinessUnit opportunityBusinessUnit : newOrModifiedOpportunityBusinessUnitList) {
                try {
                    if (!upSyncList.contains("OpportunityBusinessUnit-" + opportunityBusinessUnit.getId())) {
                        upSyncList.add("OpportunityBusinessUnit-" + opportunityBusinessUnit.getId());
                        UpSyncOpportunityBusinessUnit(opportunityBusinessUnit);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //ActivityApproval
            List<ActivityApproval> newOrModifiedActivityApprovalList = ActivityApprovalDataHandler.GetActivityApprovalUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityApprovalList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified ActivityApprovals - " + String.valueOf(newOrModifiedActivityApprovalList.size()));
                totalRecordsToUpsync += newOrModifiedActivityApprovalList.size();
            }
            for (ActivityApproval activityApproval : newOrModifiedActivityApprovalList) {
                try {
                    if (!upSyncList.contains("ActivityApproval-" + activityApproval.getId())) {
                        upSyncList.add("ActivityApproval-" + activityApproval.getId());
                        UpSyncActivityApproval(activityApproval);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //OpportunityApproval
            List<OpportunityApproval> newOrModifiedOpportunityApprovalList = OpportunityApprovalDataHandler.GetOpportunityApprovalUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityApprovalList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified OpportunityApprovals - " + String.valueOf(newOrModifiedOpportunityApprovalList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityApprovalList.size();
            }
            for (OpportunityApproval opportunityApproval : newOrModifiedOpportunityApprovalList) {
                try {
                    if (!upSyncList.contains("OpportunityApproval-" + opportunityApproval.getId())) {
                        upSyncList.add("OpportunityApproval-" + opportunityApproval.getId());
                        UpSyncOpportunityApproval(opportunityApproval);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AccountMedia Files
            List<AccountMedia> newOrModifiedAccountMediaFilesList = AccountMediaDataHandler.GetAccountMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified AccountMedia Files - " + String.valueOf(newOrModifiedAccountMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedAccountMediaFilesList.size();
            }
            for (AccountMedia accountMedia : newOrModifiedAccountMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("AccountMedia-" + accountMedia.getId())) {
                        boolean isQueued = false;
                        String mediaPath = accountMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            File localFile = new File(mediaPath);
                            if (localFile.isFile()) {
                                byte bytes[] = GetFileAsBytes(localFile.getAbsolutePath());
                                if (bytes.length > 0) {
                                    Globals.UpSyncList.add("AccountMedia-" + accountMedia.getId());
                                    String fileName = accountMedia.getAccountMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + localFile.getName();
                                    new FileUploadManager().UploadAccountFile(context, fileName, bytes, accountMedia.getId());
                                    isQueued = true;
                                }
                            }
                        }
                        if (!isQueued) {
                            accountMedia.setIsDeleted1("true");
                            AccountMediaDataHandler.UpdateAccountMediaRecord(dbHandler, context, accountMedia.getId(), accountMedia);
                        }
                    }
                } catch (Exception e) {
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //Account Logo
            List<Account> newOrModifiedAccountLogoList = AccountDataHandler.GetAccountLogoUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAccountLogoList.size() > 0) {
                LogUpSyncMessage("New Or Modified Account Logo Files - " + String.valueOf(newOrModifiedAccountLogoList.size()));
                totalRecordsToUpsync += newOrModifiedAccountLogoList.size();
            }
            for (Account account : newOrModifiedAccountLogoList) {
                try {
                    if (!Globals.UpSyncList.contains("AccountLogo-" + account.getId())) {
                        boolean isQueued = false;
                        String mediaPath = account.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            Globals.UpSyncList.add("AccountLogo-" + account.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                String fileName = account.getAccountName().replaceAll("[^a-zA-Z0-9]", "") + "_Logo" + mediaPath.substring(mediaPath.lastIndexOf("."));
                                new FileUploadManager().UploadAccountLogoFile(context, fileName, bytes, account.getId());
                                isQueued = true;
                            }
                        }
                        if (!isQueued) {
                            account.setIsUploaded("true");
                            AccountDataHandler.UpdateAccountRecord(dbHandler, context, account.getId(), account);
                        }
                    }
                } catch (Exception e) {
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //ContactMedia Files
            List<ContactMedia> newOrModifiedContactMediaFilesList = ContactMediaDataHandler.GetContactMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedContactMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified ContactMedia Files - " + String.valueOf(newOrModifiedContactMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedContactMediaFilesList.size();
            }
            for (ContactMedia contactMedia : newOrModifiedContactMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ContactMedia-" + contactMedia.getId())) {
                        boolean isQueued = false;
                        String mediaPath = contactMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ContactMedia-" + contactMedia.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = contactMedia.getContactMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadContactFile(context, fileName, bytes, contactMedia.getId());
                            }
                        }
                        if (!isQueued) {
                            contactMedia.setIsDeleted1("true");
                            ContactMediaDataHandler.UpdateContactMediaRecord(dbHandler, context, contactMedia.getId(), contactMedia);
                        }
                    }
                } catch (Exception e) {
                    Log.d("UploadError", e.getMessage());
                }
                return;
            }

            //ActivityMedia Files
            List<ActivityMedia> newOrModifiedActivityMediaFilesList = ActivityMediaDataHandler.GetActivityMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityMedia Files - " + String.valueOf(newOrModifiedActivityMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedActivityMediaFilesList.size();
            }
            for (ActivityMedia activityMedia : newOrModifiedActivityMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ActivityMedia-" + activityMedia.getId())) {
                        String mediaPath = activityMedia.getLocalMediaPath();
                        boolean isQueued = false;
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ActivityMedia-" + activityMedia.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                String fileName = activityMedia.getActivityMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadActivityFile(context, fileName, bytes, activityMedia.getId());
                                isQueued = true;
                            }
                        }
                        if (!isQueued) {
                            activityMedia.setIsDeleted1("true");
                            ActivityMediaDataHandler.UpdateActivityMediaRecord(dbHandler, context, activityMedia.getId(), activityMedia);
                        }
                    }

                } catch (Exception e) {
                    LogError("UploadError: " + e.getMessage());
                }
                return;
            }

            //OpportunityMedia Files
            List<OpportunityMedia> newOrModifiedOpportunityMediaFilesList = OpportunityMediaDataHandler.GetOpportunityMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedOpportunityMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified OpportunityMedia Files - " + String.valueOf(newOrModifiedOpportunityMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedOpportunityMediaFilesList.size();
            }
            for (OpportunityMedia opportunityMedia : newOrModifiedOpportunityMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("OpportunityMedia-" + opportunityMedia.getId())) {
                        boolean isQueued = false;
                        String mediaPath = opportunityMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("OpportunityMedia-" + opportunityMedia.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = opportunityMedia.getOpportunityMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadOpportunityFile(context, fileName, bytes, opportunityMedia.getId());
                            }
                        }
                        if (!isQueued) {
                            opportunityMedia.setIsDeleted1("true");
                            OpportunityMediaDataHandler.UpdateOpportunityMediaRecord(dbHandler, context, opportunityMedia.getId(), opportunityMedia);
                        }
                    }

                } catch (Exception e) {
                    LogError("UploadError: " + e.getMessage());
                }
                return;
            }

            //NoteMedia Files
            List<NoteMedia> newOrModifiedNoteMediaFilesList = NoteMediaDataHandler.GetNoteMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedNoteMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified NoteMedia Files - " + String.valueOf(newOrModifiedNoteMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedNoteMediaFilesList.size();
            }
            for (NoteMedia noteMedia : newOrModifiedNoteMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("NoteMedia-" + noteMedia.getId())) {
                        boolean isQueued = false;
                        String mediaPath = noteMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("NoteMedia-" + noteMedia.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = noteMedia.getNoteCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadNoteFile(context, fileName, bytes, noteMedia.getId());
                            }
                        }
                        if (!isQueued) {
                            noteMedia.setIsDeleted1("true");
                            NoteMediaDataHandler.UpdateNoteMediaRecord(dbHandler, context, noteMedia.getId(), noteMedia);
                        }
                    }
                } catch (Exception e) {
                    LogError("UploadError: " + e.getMessage());
                }
                return;
            }

            //ActivityTravelMedia Files
            List<ActivityTravelMedia> newOrModifiedActivityTravelMediaFilesList = ActivityTravelMediaDataHandler.GetActivityTravelMediaUploadRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedActivityTravelMediaFilesList.size() > 0) {
                LogUpSyncMessage("New Or Modified ActivityTravelMedia Files - " + String.valueOf(newOrModifiedActivityTravelMediaFilesList.size()));
                totalRecordsToUpsync += newOrModifiedActivityTravelMediaFilesList.size();
            }
            for (ActivityTravelMedia activityTravelMedia : newOrModifiedActivityTravelMediaFilesList) {
                try {
                    if (!Globals.UpSyncList.contains("ActivityTravelMedia-" + activityTravelMedia.getId())) {
                        boolean isQueued = false;
                        String mediaPath = activityTravelMedia.getLocalMediaPath();
                        if (!Globals.IsNullOrEmpty(mediaPath)) {
                            String originalFileName = Globals.GetFileName(mediaPath);
                            Globals.UpSyncList.add("ActivityTravelMedia-" + activityTravelMedia.getId());
                            byte bytes[] = GetFileAsBytes(mediaPath);
                            if (bytes.length > 0) {
                                isQueued = true;
                                String fileName = activityTravelMedia.getActivityTravelMediaCode().replaceAll("[^a-zA-Z0-9]", "") + "_" + originalFileName;
                                new FileUploadManager().UploadActivityTravelMediaFile(context, fileName, bytes, activityTravelMedia.getId());
                            }
                        }
                        if (!isQueued) {
                            activityTravelMedia.setIsDeleted1("true");
                            ActivityTravelMediaDataHandler.UpdateActivityTravelMediaRecord(dbHandler, context, activityTravelMedia.getId(), activityTravelMedia);
                        }
                    }
                } catch (Exception e) {
                    LogError("UploadError: " + e.getMessage());
                }
                return;
            }

            //ChatMessage
            List<ChatMessage> newOrModifiedChatMessageList = ChatMessageDataHandler.GetChatMessageUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedChatMessageList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified ChatMessages - " + String.valueOf(newOrModifiedChatMessageList.size()));
                totalRecordsToUpsync += newOrModifiedChatMessageList.size();
            }
            for (ChatMessage chatMessage : newOrModifiedChatMessageList) {
                try {
                    if (!upSyncList.contains("ChatMessage-" + chatMessage.getId())) {
                        upSyncList.add("ChatMessage-" + chatMessage.getId());
                        UpSyncChatMessage(chatMessage);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //AppUserLocation
            List<AppUserLocation> newOrModifiedAppUserLocationList = AppUserLocationDataHandler.GetAppUserLocationUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedAppUserLocationList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified AppUserLocations - " + String.valueOf(newOrModifiedAppUserLocationList.size()));
                totalRecordsToUpsync += newOrModifiedAppUserLocationList.size();
            }
            for (AppUserLocation appUserLocation : newOrModifiedAppUserLocationList) {
                try {
                    if (!upSyncList.contains("AppUserLocation-" + appUserLocation.getId())) {
                        upSyncList.add("AppUserLocation-" + appUserLocation.getId());

                        UpSyncAppUserLocation(appUserLocation);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //HSSupportTicket
            List<HSSupportTicket> newOrModifiedHSSupportTicketList = HSSupportTicketDataHandler.GetHSSupportTicketUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTickets - " + String.valueOf(newOrModifiedHSSupportTicketList.size()));
                totalRecordsToUpsync += newOrModifiedHSSupportTicketList.size();
            }
            for (HSSupportTicket hSSupportTicket : newOrModifiedHSSupportTicketList) {
                try {
                    if (!upSyncList.contains("HSSupportTicket-" + hSSupportTicket.getId())) {
                        upSyncList.add("HSSupportTicket-" + hSSupportTicket.getId());
                        UpSyncHSSupportTicket(hSSupportTicket);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //HSSupportTicketMedia
            List<HSSupportTicketMedia> newOrModifiedHSSupportTicketMediaList = HSSupportTicketMediaDataHandler.GetHSSupportTicketMediaUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedHSSupportTicketMediaList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified HSSupportTicketMedia - " + String.valueOf(newOrModifiedHSSupportTicketMediaList.size()));
                totalRecordsToUpsync += newOrModifiedHSSupportTicketMediaList.size();
            }
            for (HSSupportTicketMedia hSSupportTicketMedia : newOrModifiedHSSupportTicketMediaList) {
                try {
                    if (!upSyncList.contains("HSSupportTicketMedia-" + hSSupportTicketMedia.getId())) {
                        upSyncList.add("HSSupportTicketMedia-" + hSSupportTicketMedia.getId());
                        UpSyncHSSupportTicketMedia(hSSupportTicketMedia);
                    }
                } catch (Exception e) {
                }
                return;
            }

            //Reminder
            List<Reminder> newOrModifiedReminderList = ReminderDataHandler.GetReminderUpSyncRecords(dbHandler, context, AppConstant.DB_RECORD_NEW_OR_MODIFIED);
            if (newOrModifiedReminderList.size() > 0) {
                Log.d(LOG_TAG, "New Or Modified Reminders - " + String.valueOf(newOrModifiedReminderList.size()));
                totalRecordsToUpsync += newOrModifiedReminderList.size();
            }
            for (Reminder reminder : newOrModifiedReminderList) {
                try {
                    if (!upSyncList.contains("Reminder-" + reminder.getId())) {
                        upSyncList.add("Reminder-" + reminder.getId());
                        UpSyncReminder(reminder);
                    }
                } catch (Exception e) {
                }
                return;
            }

            Globals.SyncIndex++;

            if (Globals.SyncIndex > Globals.MAX_UPSYNC_INDEX) {
                Globals.SyncIndex = 0;
            }

            if (totalRecordsToUpsync == 0) {
                LogMessage("Reseting failed upsyncindexes: ");
                DatabaseHandler.getInstance(context).ResetPendingUpSyncIndexes();
            }

            LogUpSyncMessage("UPSYNC - Completed");

        } catch (Exception ex) {
            Globals.HandleException(context, "SyncService:RunUpSync()", ex);
        }
    }

}