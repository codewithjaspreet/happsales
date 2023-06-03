/*************************************************************************
 *
 * HAPPSALES CONFIDENTIAL
 * ____________________________________
 *
 *  [2019-23] HappSales Private Limited
 *  www.happsales.com
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains the property of HappSales Private Limited.
 * The intellectual and technical concepts contained herein are proprietary to HappSales Private Limited
 * and  are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material is strictly forbidden unless prior
 * written permission is obtained from HappSales Private Limited.
 */
//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : TablesBase
// Created By    : Vijay Kumar Vettath
// Created Date  : Nov-2019
// Purpose       : Class for defining the database tables
// Details       : This class contains the table names used by the app
// Change History:- 
// Date:      
// Author:
// Change: 
//////////////////////////////////////////////////////////////////////////////////////////////////


 class TablesBase {

    //Tables
     static  const String TABLE_CONFIGURATION = "AmiConfiguration";
     static const String TABLE_APPSYNC = "AppSync";
     static const String TABLE_DESIGNATION_BC = "Designationbc";

     static const String TABLE_ACCOUNT = "Account";
     static const String TABLE_ACCOUNTADDRESS = "AccountAddress";
     static const String TABLE_ACCOUNTBUSINESSPLAN = "AccountBusinessPlan";
     static const String TABLE_ACCOUNTBUSINESSUNIT = "AccountBusinessUnit";
     static const String TABLE_ACCOUNTBUYINGPROCESS = "AccountBuyingProcess";
     static const String TABLE_ACCOUNTCATEGORY = "AccountCategory";
     static const String TABLE_ACCOUNTCATEGORYMAPPING = "AccountCategoryMapping";
     static const String TABLE_ACCOUNTCOMPETITIONACTIVITY = "AccountCompetitionActivity";
     static const String TABLE_ACCOUNTFORM = "AccountForm";
     static const String TABLE_ACCOUNTFORMVALUE = "AccountFormValue";
     static const String TABLE_ACCOUNTMEDIA = "AccountMedia";
     static const String TABLE_ACCOUNTPHONE = "AccountPhone";
     static const String TABLE_ACCOUNTSEGMENT = "AccountSegment";
     static const String TABLE_ACCOUNTSTATUS = "AccountStatus";
    // static const String TABLE_ACCOUNTTAG = "AccountTag";
     static const String TABLE_ACCOUNTTERRITORY = "AccountTerritory";
     static const String TABLE_ACCOUNTTYPE = "AccountType";
     static const String TABLE_ACTIVITY = "Activity";
     static const String TABLE_ACTIVITYAPPROVAL = "ActivityApproval";
     static const String TABLE_ACTIVITYAPPROVALTYPE = "ActivityApprovalType";
     static const String TABLE_ACTIVITYBUSINESSUNIT = "ActivityBusinessUnit";
     static const String TABLE_ACTIVITYMEASURE = "ActivityMeasure";
     static const String TABLE_ACTIVITYMEDIA = "ActivityMedia";
     static const String TABLE_ACTIVITYPERMISSION = "ActivityPermission";
     static const String TABLE_ACTIVITYPRIORITY = "ActivityPriority";
     static const String TABLE_ACTIVITYPRODUCT = "ActivityProduct";
     static const String TABLE_ACTIVITYPRODUCTDETAIL = "ActivityProductDetail";
     static const String TABLE_ACTIVITYSTATUS = "ActivityStatus";
    // static const String TABLE_ACTIVITYTAG = "ActivityTag";
     static const String TABLE_ACTIVITYTEAM = "ActivityTeam";
     static const String TABLE_ACTIVITYTRAVEL = "ActivityTravel";
     static const String TABLE_ACTIVITYTRAVELEXPENSE = "ActivityTravelExpense";
     static const String TABLE_ACTIVITYTRAVELMAPPING = "ActivityTravelMapping";
     static const String TABLE_ACTIVITYTRAVELMEDIA = "ActivityTravelMedia";
     static const String TABLE_ACTIVITYTYPE = "ActivityType";
     static const String TABLE_ADDRESSTYPE = "AddressType";
     static const String TABLE_APPCHECK = "AppCheck";
     static const String TABLE_APPFEATURE = "AppFeature";
     static const String TABLE_APPFEATUREFIELD = "AppFeatureField";
     static const String TABLE_APPFEATUREGROUP = "AppFeatureGroup";
     static const String TABLE_APPLOG = "AppLog";
     static const String TABLE_APPREPORT = "AppReport";
     static const String TABLE_APPUSAGE = "AppUsage";
     static const String TABLE_APPUSER = "AppUser";
     static const String TABLE_APPUSERLOCATION = "AppUserLocation";
     static const String TABLE_APPUSERMESSAGE = "AppUserMessage";
     static const String TABLE_APPUSERPRODUCT = "AppUserProduct";
     static const String TABLE_APPUSERREMARK = "AppUserRemark";
     static const String TABLE_APPUSERROLE = "AppUserRole";
     static const String TABLE_APPUSERTEAM = "AppUserTeam";
     static const String TABLE_APPUSERTEAMMEMBER = "AppUserTeamMember";
     static const String TABLE_APPUSERTERRITORY = "AppUserTerritory";
     static const String TABLE_APPUSERTYPE = "AppUserType";
     static const String TABLE_ATTRIBUTE = "Attribute";
     static const String TABLE_ATTRIBUTEVALUE = "AttributeValue";
     static const String TABLE_BUSINESSEMAIL = "BusinessEmail";
     static const String TABLE_BUSINESSFEATURE = "BusinessFeature";
     static const String TABLE_BUSINESSUNIT = "BusinessUnit";
     static const String TABLE_CHATMESSAGE = "ChatMessage";
     static const String TABLE_CHATUSERANDGROUP = "ChatUserAndGroup";
     static const String TABLE_CHATUSERGROUPMEMBER = "ChatUserGroupMember";
     static const String TABLE_COMPETITOR = "Competitor";
     static const String TABLE_CONTACT = "Contact";
     static const String TABLE_CONTACTALIGNMENT = "ContactAlignment";
     static const String TABLE_CONTACTCATEGORY = "ContactCategory";
     static const String TABLE_CONTACTMEDIA = "ContactMedia";
    // static const String TABLE_CONTACTTAG = "ContactTag";
     static const String TABLE_CONTACTTITLE = "ContactTitle";
     static const String TABLE_CONTENTTYPE = "ContentType";
     static const String TABLE_COUNTRY = "Country";
     static const String TABLE_CREDITRATING = "CreditRating";
     static const String TABLE_CURRENCY = "Currency";
     static const String TABLE_CUSTOMERMEETING = "CustomerMeeting";
     static const String TABLE_DEPARTMENT = "Department";
     static const String TABLE_DESIGNATION = "Designation";
     static const String TABLE_EMAILMANUALTEMPLATE = "EmailManualTemplate";
     static const String TABLE_EXPENSETYPE = "ExpenseType";
     static const String TABLE_FIELDATTENDANCE = "FieldAttendance";
     static const String TABLE_FINANCIALINSTITUTION = "FinancialInstitution";
     static const String TABLE_FINANCIALYEAR = "FinancialYear";
     static const String TABLE_FORM = "Form";
     static const String TABLE_FORMCELL = "FormCell";
     static const String TABLE_FORMCELLELEMENT = "FormCellElement";
     static const String TABLE_FORMSECTION = "FormSection";
     static const String TABLE_HSSUPPORTTICKET = "HSSupportTicket";
     static const String TABLE_HSSUPPORTTICKETMEDIA = "HSSupportTicketMedia";
     static const String TABLE_INDUSTRY = "Industry";
     static const String TABLE_LEADSOURCE = "LeadSource";
     static const String TABLE_MODEOFTRAVEL = "ModeOfTravel";
     static const String TABLE_NOTE = "Note";
     static const String TABLE_NOTEMEDIA = "NoteMedia";
     static const String TABLE_NOTEPERMISSION = "NotePermission";
    // static const String TABLE_NOTETAG = "NoteTag";
     static const String TABLE_NOTIFICATION = "Notification";
     static const String TABLE_NOTIFICATIONASSIGNMENT = "NotificationAssignment";
     static const String TABLE_OPPORTUNITY = "Opportunity";
     static const String TABLE_OPPORTUNITYAPPROVAL = "OpportunityApproval";
     static const String TABLE_OPPORTUNITYAPPROVALTYPE = "OpportunityApprovalType";
     static const String TABLE_OPPORTUNITYBUSINESSUNIT = "OpportunityBusinessUnit";
     static const String TABLE_OPPORTUNITYCONTACT = "OpportunityContact";
     static const String TABLE_OPPORTUNITYMEASURE = "OpportunityMeasure";
     static const String TABLE_OPPORTUNITYFULFILLMENTSTATUS = "OpportunityFulfillmentStatus";
     static const String TABLE_OPPORTUNITYMEDIA = "OpportunityMedia";
     static const String TABLE_OPPORTUNITYNAME = "OpportunityName";
     static const String TABLE_OPPORTUNITYPERMISSION = "OpportunityPermission";
     static const String TABLE_OPPORTUNITYPRIORITY = "OpportunityPriority";
     static const String TABLE_OPPORTUNITYPRODUCT = "OpportunityProduct";
     static const String TABLE_OPPORTUNITYPRODUCTDETAIL = "OpportunityProductDetail";
     static const String TABLE_OPPORTUNITYPRODUCTDETAILATTRIBUTE = "OpportunityProductDetailAttribute";
     static const String TABLE_OPPORTUNITYSTAGE = "OpportunityStage";
     static const String TABLE_OPPORTUNITYSTAGETYPE = "OpportunityStageType";
     static const String TABLE_OPPORTUNITYSTATUS = "OpportunityStatus";
    // static const String TABLE_OPPORTUNITYTAG = "OpportunityTag";
     static const String TABLE_OPPORTUNITYTEAM = "OpportunityTeam";
     static const String TABLE_OPPORTUNITYTYPE = "OpportunityType";
     static const String TABLE_PERFORMANCESUMMARY = "PerformanceSummary";
     static const String TABLE_PHONETYPE = "PhoneType";
     static const String TABLE_PRODUCT = "Product";
     static const String TABLE_PRODUCTAUXILIARY = "ProductAuxiliary";
     static const String TABLE_PRODUCTCATEGORY = "ProductCategory";
     static const String TABLE_PRODUCTINSTALLATION = "ProductInstallation";
     static const String TABLE_PRODUCTINSTALLATIONDETAIL = "ProductInstallationDetail";
     static const String TABLE_PRODUCTMEDIA = "ProductMedia";
     static const String TABLE_REIMBURSEMENT = "Reimbursement";
     static const String TABLE_REIMBURSEMENTDETAIL = "ReimbursementDetail";
     static const String TABLE_REIMBURSEMENTTYPE = "ReimbursementType";
     static const String TABLE_REMINDER = "Reminder";
     static const String TABLE_RESOURCE = "Resource";
     static const String TABLE_SERVICEINVOICE = "ServiceInvoice";
     static const String TABLE_SERVICEINVOICEDETAIL = "ServiceInvoiceDetail";
     static const String TABLE_TAG = "Tag";
     static const String TABLE_TAGGROUP = "TagGroup";
     static const String TABLE_TERRITORY = "Territory";
     static const String TABLE_TIMEZONE = "TimeZone";
     static const String TABLE_TRAVELPURPOSE = "TravelPurpose";
     static const String TABLE_USERROLE = "UserRole";
     static const String TABLE_UNIT = "Unit";

	/*-------------------HAPPSALES-------------------*/

}