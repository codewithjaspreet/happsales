import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/Activity.dart';
import '../DataBaseHandler.dart';
import 'ActivityDataHandlerBase.dart';

class ActivityDataHandler extends ActivityDataHandlerBase {
  static Future<Activity?> GetFollowUpActivityRecord(
      DatabaseHandler databaseHandler, String id) async {
    Activity? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = $id";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetFollowUpActivityRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<List<Activity>> GetActivityRecordsForActivityTravel(
      DatabaseHandler databaseHandler, String activityTravelId) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} IN (";
      selectQuery += " SELECT IQ.${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID} FROM ${TablesBase.TABLE_ACTIVITYTRAVELMAPPING} IQ ";
      selectQuery += " WHERE IQ.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND IQ.${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND IQ.${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID} = $activityTravelId";
      selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(IQ.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false')";
      selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsForActivityTravel()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsForTheDate(
      DatabaseHandler databaseHandler,
      String activityDate,
      String accountId,
      String opportunityId,
      String contactId) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$activityDate'";
      if (accountId.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $accountId";

      if (opportunityId.trim().length > 0)
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      if (contactId.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsForTheDate()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPending(
      DatabaseHandler databaseHandler, String activityDate) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$activityDate'";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed')";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE} DESC";
      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsPending()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsForFuture(
      DatabaseHandler databaseHandler, String activityDate) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) > '$activityDate'";
      selectQuery += " AND D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} NOT IN ('Completed','Failed')";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE} ASC";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsForFuture()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecords(
      DatabaseHandler databaseHandler,
      String accountId,
      String searchString) async {
    //accountId = Globals.TryParseLongForDBId(accountId);

    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '${searchString.replaceAll("'", "''")}%'";
      if (accountId.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $accountId";
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetActivityRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForPlanned(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'UNKNOWN')  IN ('Planned','UNKNOWN')";

      //NLP Filter
      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}')) AND (date(A.ActivityDate) <= date('${endDates[0]}'))";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND (date(A.ActivityDate) = date('${dates[0]}'))";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND (E.ActivityTypeName = '$activityType')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Activity_Columns.KEY_ACTIVITY_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/
      if (sortColumn.toLowerCase().contains("date"))
        selectQuery += " ORDER BY date(A.$sortColumn) COLLATE NOCASE $sortDirection";
      else
        selectQuery +=
            " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";

      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForPlanned()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForInProcess(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('In-Process')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND E.ActivityTypeName = '$activityType'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Activity_Columns.KEY_ACTIVITY_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;

      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForInProcess()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForCompleted(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Completed','Cancelled','Failed')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND E.ActivityTypeName = '$activityType'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Activity_Columns.KEY_ACTIVITY_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForCompleted()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForOthers(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Cancelled','Failed')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND E.ActivityTypeName = '$activityType'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Activity_Columns.KEY_ACTIVITY_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForOthers()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivitiesForDateRange(
      DatabaseHandler databaseHandler,
      String dateString1,
      String dateString2,
      String activityType,
      int recordsCount) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} B ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} C ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} D ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      //selectQuery += " AND IFNULL(A." + KEY_ISACTIVE + ",'true') <> 'false' "; //Filter accessible records
      //selectQuery += " AND IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' ";  //Filter accessible records
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (dateString1.isNotEmpty) {
        selectQuery +=
            " AND (date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) >= '$dateString1' OR  date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) >= '$dateString1') ";
      }
      if (dateString2.isNotEmpty) {
        selectQuery +=
            " AND (date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$dateString2' OR  date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$dateString2') ";
      }
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}";
      if (recordsCount > 0) {
        selectQuery += " LIMIT $recordsCount";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivitiesForDateRange()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsForCopy(
      DatabaseHandler databaseHandler,
      String searchString,
      bool isPlanned,
      bool isInProcess,
      bool isCompleted,
      bool isOthers) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'"
            " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      String addnlFilter = "";
      if (isPlanned && isInProcess && isCompleted && isOthers) {
        addnlFilter += "";
      } else {
        if (isPlanned) {
          addnlFilter +=
              " COALESCE(E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Planned')";
        }
        if (isInProcess) {
          if (addnlFilter.isNotEmpty) addnlFilter += " OR ";
          addnlFilter +=
              " COALESCE(E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('In-Process')";
        }
        if (isCompleted) {
          if (addnlFilter.isNotEmpty) addnlFilter += " OR ";
          addnlFilter +=
              " COALESCE(E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Completed')";
        }
        if (isOthers) {
          if (addnlFilter.isNotEmpty) addnlFilter += " OR ";
          addnlFilter +=
              " COALESCE(E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Cancelled','Failed')";
        }
      }
      if (addnlFilter.isNotEmpty) {
        selectQuery += " AND ($addnlFilter)";
      }

      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}";

      //Log.d("SQL", selectQuery);

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsForCopy()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetParentActivityCompletedRecords(
      DatabaseHandler databaseHandler,
      String contactId,
      String accountId,
      String opportunityId,
      String searchString,
      String sortString,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},P.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE} FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYTYPE} B ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYSTATUS} C ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} D ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";

      //selectQuery += " LEFT JOIN " + TABLE_REMINDER + " R ON A." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + " = R." + ColumnsBase.KEY_REMINDER_TITLE;
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_APPUSERID} = ${Globals.AppUserID}";
      //selectQuery += " AND (A." + KEY_ACTIVITY_ISCOMPLETED + " <> 'true' " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " IS NULL " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " = ''" + ")";
      //selectQuery += " AND A." + KEY_ACTIVITY_ACTIVITYDATE + " IS NOT NULL ";
      //selectQuery += " AND IFNULL(A." + KEY_ISACTIVE + ",'true') <> 'false' "; //Filter accessible records
      //selectQuery += " AND IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' ";  //Filter accessible records
      //selectQuery += " AND (IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' OR IFNULL(A." + KEY_ISDELETED + ",'0') = '0') ";  //Filter accessible records
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString != null && searchString.isNotEmpty) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%') ";
      }
      if (accountId != null && accountId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }
      if (contactId != null && contactId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";
      }
      if (opportunityId != null && opportunityId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      selectQuery += " AND (C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} = 'Completed')"; //TODO

      /*if(filterActivityStatus == null || filterActivityStatus.trim().equals("") || filterActivityStatus.trim().equalsIgnoreCase("null")) {

                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = 'Completed')";  //TODO
            } else {
                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = '"+filterActivityStatus+"')";  //TODO
            }*/

      selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} IS NULL OR A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = '')";
      //selectQuery += " ORDER BY " + KEY_ACTIVITY_ACTIVITYDATE + " ASC ";
      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND B.ActivityTypeName = '$activityType'";
      }

      if (sortString.isNotEmpty) {
        selectQuery += " ORDER BY A.$sortString";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetParentActivityCompletedRecords()", ex);
    }
    return dataList;
  }

  static Future<List<Activity>> GetParentActivityInProcessRecords(
      DatabaseHandler databaseHandler,
      String contactId,
      String accountId,
      String opportunityId,
      String searchString,
      String sortString,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},P.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYTYPE} B ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYSTATUS} C ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} D ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      // selectQuery += " LEFT JOIN " + TABLE_REMINDER + " R ON A." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE + " = R." + ColumnsBase.KEY_REMINDER_TITLE;
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_APPUSERID} = ${Globals.AppUserID}";
      //selectQuery += " AND (A." + KEY_ACTIVITY_ISCOMPLETED + " <> 'true' " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " IS NULL " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " = ''" + ")";
      //selectQuery += " AND A." + KEY_ACTIVITY_ACTIVITYDATE + " IS NOT NULL ";
      //selectQuery += " AND IFNULL(A." + KEY_ISACTIVE + ",'true') <> 'false' ";  //Filter accessible records
      //selectQuery += " AND IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' ";  //Filter accessible records
      //selectQuery += " AND (IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' OR IFNULL(A." + KEY_ISDELETED + ",'0') = '0') ";  //Filter accessible records
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString != null && searchString.isNotEmpty) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%') ";
      }
      if (accountId != null && accountId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = '$accountId'";
      }
      if (contactId != null && contactId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = '$contactId'";
      }
      if (opportunityId != null && opportunityId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = '$opportunityId'";
      }

      selectQuery += " AND (C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} = 'In-Process')"; //TODO

      /*if(filterActivityStatus == null || filterActivityStatus.trim().equals("") || filterActivityStatus.trim().equalsIgnoreCase("null")) {
                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = 'In-Process')";  //TODO
            } else {
                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = '"+filterActivityStatus+"')";  //TODO
            }*/
      selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} IS NULL OR A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = '')";
      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND B.ActivityTypeName = '$activityType'";
      }

      if (sortString.isNotEmpty) {
        selectQuery += " ORDER BY A.$sortString";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetParentActivityInProcessRecords()", ex);
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityPlannedRecords(
      DatabaseHandler databaseHandler,
      String contactId,
      String accountId,
      String opportunityId,
      String searchString,
      String sortString,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},P.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE} FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYTYPE} B ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYSTATUS} C ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} D ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      //selectQuery += " LEFT JOIN " + TABLE_REMINDER + " R ON A." + KEY_ID + " = R." + KEY_REMINDER_ACTIVITYID;
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_APPUSERID} = ${Globals.AppUserID}";
      //selectQuery += " AND (A." + KEY_ACTIVITY_ISCOMPLETED + " <> 'true' " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " IS NULL " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " = ''" + ")";
      //selectQuery += " AND A." + KEY_ACTIVITY_ACTIVITYDATE + " IS NOT NULL ";
      //selectQuery += " AND IFNULL(A." + KEY_ISACTIVE + ",'true') <> 'false' "; //Filter accessible records
      //selectQuery += " AND IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' ";  //Filter accessible records
      //selectQuery += " AND (IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' OR IFNULL(A." + KEY_ISDELETED + ",'0') = '0') ";  //Filter accessible records
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.isNotEmpty) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            "OR A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            "OR D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%') ";
      }

      if (accountId != null && accountId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }

      if (contactId != null && contactId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";
      }

      if (opportunityId != null && opportunityId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      selectQuery +=
          " AND (C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} = 'Planned' OR C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} IS NULL)";

      /*if(filterActivityStatus == null || filterActivityStatus.trim().equals("") || filterActivityStatus.trim().equalsIgnoreCase("null")) {
                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = 'Planned' OR C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " IS NULL)";
            } else {
                selectQuery += " AND (C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = '" + filterActivityStatus + "' OR C." + KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " IS NULL)";
            }*/
      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND B.ActivityTypeName = '$activityType'";
      }

      if (sortString.isNotEmpty) {
        selectQuery += " ORDER BY A.$sortString";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityPlannedRecords()", ex);
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityOthersRecords(
      DatabaseHandler databaseHandler,
      String contactId,
      String accountId,
      String opportunityId,
      String searchString,
      String sortString,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},E.${ColumnsBase.KEY_CONTACT_CONTACTNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},P.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE} FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYTYPE} B ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN  ${TablesBase.TABLE_ACTIVITYSTATUS} C ON  A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = C.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} D ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} E ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      //selectQuery += " LEFT JOIN " + TABLE_REMINDER + " R ON A." + KEY_ID + " = R." + KEY_REMINDER_ACTIVITYID;
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_APPUSERID} = ${Globals.AppUserID}";
      //selectQuery += " AND (A." + KEY_ACTIVITY_ISCOMPLETED + " <> 'true' " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " IS NULL " + " OR A." + KEY_ACTIVITY_ISCOMPLETED + " = ''" + ")";
      //selectQuery += " AND A." + KEY_ACTIVITY_ACTIVITYDATE + " IS NOT NULL ";
      //selectQuery += " AND IFNULL(A." + KEY_ISACTIVE + ",'true') <> 'false' "; //Filter accessible records
      //selectQuery += " AND IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' ";  //Filter accessible records
      //selectQuery += " AND (IFNULL(A." + KEY_ISDELETED + ",'false') = 'false' OR IFNULL(A." + KEY_ISDELETED + ",'0') = '0') ";  //Filter accessible records
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.isNotEmpty) {
        selectQuery +=
            " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS} LIKE '%${searchString.replaceAll("'", "''")}%' ";
        selectQuery +=
            " OR D.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%') ";
      }

      if (accountId != null && accountId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }

      if (contactId != null && contactId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";
      }

      if (opportunityId != null && opportunityId.isNotEmpty) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      selectQuery +=
          " AND COALESCE(C.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') IN ('Cancelled','Failed')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND B.ActivityTypeName = '$activityType'";
      }

      if (sortString.isNotEmpty) {
        selectQuery += " ORDER BY A.$sortString";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityOthersRecords()", ex);
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForPending(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime,
      String todayDate) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND E.ActivityTypeName = '$activityType'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Activity_Columns.KEY_ACTIVITY_TRAVELPURPOSENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/
      //selectQuery += " AND date(A." + ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE + ") < date('now')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) < '$todayDate'";

      selectQuery +=
          " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery +=
          " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForCompleted()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsForSearching(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";

      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
        selectQuery += " OR D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} LIKE '%${searchString.replaceAll("'", "''")}%'";
        String dateFilter = " STRFTIME('%d', date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE})) || ' ' ||  SUBSTR('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*STRFTIME('%m', date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE})), -3)  || ' ' || STRFTIME('%Y', date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE})) ";
        selectQuery += " OR ($dateFilter) LIKE '%${searchString.replaceAll("'", "''")}%'";

        //selectQuery += " OR A." + ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE + " LIKE '%" + searchString.replaceAll("'","''") + "%'";
        /*     selectQuery += " OR ("  ") LIKE '%" + searchString.replaceAll("'","''") + "%'";

                SELECT STRFTIME('%d', date("A.")) || ' ' ||  substr('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*strftime('%m', date('now')), -3)  || ' ' ||
                        STRFTIME('%Y', date())*/
      }

      // selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForCompleted()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<int> GetCompletedActivityForTodayCount(
      DatabaseHandler databaseHandler, String activityDate) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*)";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      //selectQuery += " AND D." + ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " = " + "'Completed'";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'')  IN ('Completed','Cancelled','Failed')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$activityDate'";
      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        itemCount = result[0]["COUNT(*)"];
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityCompleteCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  static Future<int> GetActivityRecordsByContactID(
      DatabaseHandler databaseHandler,
      String contactId,
      String searchString) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*)";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      if (searchString.trim().length > 0)
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '${searchString.replaceAll("'", "''")}%'";
      if (contactId.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_CONTACT_CONTACTID} = $contactId";
      selectQuery += " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result != null && result.length > 0) {
        itemCount = result[0]["COUNT(*)"];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityCompleteCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  static Future<List<Activity>> GetActivityRecordsForTheReminderDate(
      DatabaseHandler databaseHandler, String activityDate) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$activityDate'";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsForTheDate()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecordsPagedForWeek(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize,
      String accountId,
      String contactId,
      String opportunityId,
      String activityDateTime,
      String activityType,
      String filterActivityStatus,
      String filterActivityStartDateTime,
      String filterActivityEndDateTime,
      String weekStartDate,
      String weekEndDate) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISACTIVE + ",'true')) = 'true' ";
      //selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITY_ISARCHIVED + ",'false')) = 'false' ";
      if (searchString.trim().length > 0) {
        selectQuery += " AND (A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '%${searchString.replaceAll("'", "''")}%'";
        selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'", "''")}%')";
      }
      if (Globals.isIntegerString(accountId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(contactId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = $contactId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";

      if (filterActivityStartDateTime != null &&
          filterActivityStartDateTime.trim().isNotEmpty &&
          filterActivityEndDateTime != null &&
          filterActivityEndDateTime.trim().isNotEmpty) {
        List<String> startDates = filterActivityStartDateTime.split("T");
        List<String> endDates = filterActivityEndDateTime.split("T");

        if (startDates.length > 1 && endDates.length > 1) {
          selectQuery +=
              " AND (date(A.ActivityDate) >= date('${startDates[0]}') AND date(A.ActivityDate) <= date('${endDates[0]}')) ";
        }
      } else if (activityDateTime != null &&
          activityDateTime.trim().isNotEmpty) {
        List<String> dates = activityDateTime.split("T");
        if (dates.length > 1) {
          selectQuery += " AND date(A.ActivityDate) = date('${dates[0]}')";
        }
      }

      if (activityType != null && activityType.trim().isNotEmpty) {
        selectQuery += " AND E.ActivityTypeName = '$activityType'";
      }

      selectQuery +=
          " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) >= '$weekStartDate'";
      selectQuery +=
          " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$weekEndDate'";
      selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
      selectQuery += " LIMIT $startRowIndex,$pageSize";

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordsPagedForInProcess()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<int> GetOverDueActivityCount(
      DatabaseHandler databaseHandler, String todayDate) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) < '$todayDate'";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        itemCount = result[0]["COUNT(*)"];
      }
    } catch (ex) {
      Globals.handleException(
          "OpportunityDataHandler:GetDueAllOpportunityCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  static Future<int> GetTodayActivityCount(
      DatabaseHandler databaseHandler, String todayDate) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$todayDate'";

      final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        itemCount = result[0]["COUNT(*)"];
      }

      // if (cursor.moveToFirst()) {
      //     itemCount = cursor.getInt(0);
      // }
      // cursor.close();
      // //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityDataHandler:GetTodayActivityCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  static Future<int> GetWeekActivityCount(DatabaseHandler databaseHandler,
      String weekStartDate, String weekEndDate) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) >= '$weekStartDate'";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$weekEndDate'";

      final db = await databaseHandler.database;
      List<Map> result = await db.rawQuery(selectQuery, null);

      if (result.length > 0) {
        itemCount = result[0]["COUNT(*)"];
      }
      // if (cursor.moveToFirst()) {
      //     itemCount = cursor.getInt(0);
      // }
      // cursor.close();
      // //db.close();
    } catch (ex) {
      Globals.handleException(
          "OpportunityDataHandler:GetTodayActivityCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  static Future<int> GetAllActivityCount(
      DatabaseHandler databaseHandler, String accountId) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      //selectQuery += " AND COALESCE(D." + ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + ",'') NOT IN ('Completed','Failed','Cancelled')";

      if (Globals.isIntegerString(accountId)) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }

      final db = await databaseHandler.database;

      List<Map> list = await db.rawQuery(selectQuery, null);

      if (list.length > 0) {
        itemCount = list[0]["COUNT(*)"];
      }

      // Cursor cursor = db.rawQuery(selectQuery, null);
      // if (cursor.moveToFirst()) {
      //     itemCount = cursor.getInt(0);
      // }

      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetAllActivityCount()", ex);
      throw ex;
    }
    return itemCount;
  }

  Future<int> getPendingActivityCountByOpportunityId(
      DatabaseHandler databaseHandler,
      String todayDate,
      String accountId,
      String opportunityId) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += "FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += "WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += "AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += "AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";

      if (Globals.isIntegerString(accountId)) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }

      if (Globals.isIntegerString(opportunityId)) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) < '$todayDate'";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        itemCount = result[0].values.first as int;
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetAllActivityCount()", ex);
      rethrow;
    }
    return itemCount;
  }

  Future<int> getTodayActivityCountByOpportunityId(
      DatabaseHandler databaseHandler,
      String todayDate,
      String opportunityId) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += "FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += "WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += "AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += "AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += "AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += "AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      selectQuery += "AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += "AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$todayDate'";

      if (opportunityId.trim().length > 0) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        itemCount = result[0].values.first as int;
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetAllActivityCount()", ex);
      rethrow;
    }
    return itemCount;
  }

  Future<int> getWeekActivityCountByOpportunityId(
      DatabaseHandler databaseHandler,
      String accountId,
      String opportunityId,
      String weekStartDate,
      String weekEndDate) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*) ";
      selectQuery += "FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += "LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += "WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += "AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += "AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";

      if (Globals.isIntegerString(accountId)) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";
      }

      if (Globals.isIntegerString(opportunityId)) {
        selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      selectQuery += " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) >= '$weekStartDate'";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) <= '$weekEndDate'";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery);
      if (result.isNotEmpty) {
        itemCount = result[0].values.first as int;
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetAllActivityCount()", ex);
      rethrow;
    }
    return itemCount;
  }

  static Future<int> getCompletedActivityCountByOpportunityId(
      DatabaseHandler databaseHandler,
      String accountId,
      String opportunityId) async {
    int itemCount = 0;
    try {
      String selectQuery = "SELECT COUNT(*)";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID.toString().toString()}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID.toString().toString()}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false'";

      if (Globals.isIntegerString(accountId))
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = $accountId";

      if (Globals.isIntegerString(opportunityId))
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";

      selectQuery +=
          " AND COALESCE(D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},'') IN ('Completed','Cancelled','Failed')";

      final db = await databaseHandler.database;
      var result = await db.rawQuery(selectQuery, null);
      if (result.isNotEmpty) {
        itemCount = result.first.values.first as int;
      }
    } catch (ex) {
      Globals.handleException("ActivityDataHandler:GetAllActivityCount()", ex);
      rethrow;
    }
    return itemCount;
  }

  static Future<List<Activity>> GetActivityRecordsForTodayDate(
      DatabaseHandler databaseHandler,
      String activityDate,
      String accountId,
      String opportunityId) async {
    List<Activity> dataList = [];
    try {
      String selectQuery = "SELECT A.* ,E.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},H.${ColumnsBase.KEY_CONTACT_CONTACTNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},I.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},D.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},M.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},N.${ColumnsBase
              .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = E.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} H ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = H.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} I ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = I.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} M ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = M.${ColumnsBase.KEY_ID}";
      selectQuery += " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} N ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = N.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISARCHIVED},'false')) = 'false' ";
      //selectQuery += " AND COALESCE(D." + ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + ",'') NOT IN ('Completed','Failed','Cancelled')";
      selectQuery += " AND date(A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE}) = '$activityDate'";
      if (accountId.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACCOUNT_ACCOUNTID} = $accountId";
      }

      if (opportunityId.trim().length > 0) {
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = $opportunityId";
      }

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        Activity dataItem = Activity();
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
        dataItem.activityCode = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

        dataItem.activityTypeID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID];
        dataItem.leadSource = element[ColumnsBase.KEY_ACTIVITY_LEADSOURCE];
        dataItem.accountID = element[ColumnsBase.KEY_ACTIVITY_ACCOUNTID];
        dataItem.contactID = element[ColumnsBase.KEY_ACTIVITY_CONTACTID];
        dataItem.opportunityID =
            element[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID];
        dataItem.activityMeasure =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE];
        dataItem.activityDate = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE];
        dataItem.activityEndDate =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE];
        dataItem.assignmentDetails =
            element[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS];
        dataItem.activityDetails =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS];
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID];
        dataItem.totalAmount = element[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT];
        dataItem.amountCollected =
            element[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED];
        dataItem.currencyID = element[ColumnsBase.KEY_ACTIVITY_CURRENCYID];
        dataItem.collectionDetails =
            element[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS];
        dataItem.isTravelled = element[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME];
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID];
        dataItem.needFollowUpActivity =
            element[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY];
        dataItem.parentActivityID =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.activityAssignmentID =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID];
        dataItem.expectedCompletionDate =
            element[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE];
        dataItem.productInstallationDetailID =
            element[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID];
        dataItem.invoiceID = element[ColumnsBase.KEY_ACTIVITY_INVOICEID];
        dataItem.workflowProgressID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITY_TAGS];
        dataItem.freeTextField1 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1];
        dataItem.freeTextField2 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2];
        dataItem.freeTextField3 =
            element[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3];
        dataItem.isApprovalRequired =
            element[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED];
        dataItem.isApproved = element[ColumnsBase.KEY_ACTIVITY_ISAPPROVED];
        dataItem.marketingContactID =
            element[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID];
        dataItem.workflowStageID =
            element[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID];
        dataItem.isWorkflowStageUpdated =
            element[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED];
        dataItem.leadQualificationID =
            element[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITY_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITY_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITY_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITY_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITY_ISACTIVE];
        dataItem.isLocked = element[ColumnsBase.KEY_ACTIVITY_ISLOCKED];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITY_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITY_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITY_ISDELETED];
        dataItem.successAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE];
        dataItem.failureAlertMessage =
            element[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS];
        dataItem.approvalDetails =
            element[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS];

        dataItem.activityTypeName =
            element[ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME];
        dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
        dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
        dataItem.opportunityName =
            element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.parentActivityTitle =
            element[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE];
        dataItem.productInstallationDetailCode = element[ColumnsBase
            .KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE];

        dataItem.id = element[ColumnsBase.KEY_ID];
        dataItem.isDirty = element[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = element[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = element[ColumnsBase.KEY_UPSYNCMESSAGE];
        dataItem.downSyncMessage = element[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = element[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = element[ColumnsBase.KEY_SMODIFIEDON];
        dataItem.createdByUser = element[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = element[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = element[ColumnsBase.KEY_OWNERUSERID];

        // Add more properties if needed

        // Use the dataItem object as needed

        dataList.add(dataItem);
      }
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandler:GetActivityRecordsForTheDate()", ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
