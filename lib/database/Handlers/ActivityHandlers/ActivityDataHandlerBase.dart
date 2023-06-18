import 'dart:js';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/Activity.dart';
import '../DataBaseHandler.dart';

class ActivityDataHandlerBase {
  static Future<List<Activity>> GetActivityRecordsPaged(
      DatabaseHandler databaseHandler,
      String searchString,
      String sortColumn,
      String sortDirection,
      Map<String, String> filterHashMap,
      int pageIndex,
      int pageSize) async {
    List<Activity> dataList = [];
    try {
      int startRowIndex = ((pageIndex - 1) * pageSize);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME} LIKE '%${searchString.replaceAll("'", "''")}%'";

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
          "ActivityDataHandlerBase:GetActivityRecordsPaged()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<Activity>> GetActivityRecords(
      DatabaseHandler databaseHandler, String searchString) async {
    List<Activity> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITY_ISACTIVE},'true')) = 'true' ";
      if (searchString.trim().length > 0)
        selectQuery +=
            " AND A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} LIKE '${searchString.replaceAll("'", "''")}%'";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} COLLATE NOCASE ASC ";

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
          "ActivityDataHandlerBase:GetActivityRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Activity?> GetActivityRecord(
      DatabaseHandler databaseHandler, String id) async {
    Activity? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},F.${ColumnsBase.KEY_ACTIVITYTYPE_ISAPPROVALREQUIREDONCOMPLETION},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
          "ActivityDataHandlerBase:GetActivityRecords()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<Activity?> GetMasterActivityRecord(
      DatabaseHandler databaseHandler, String id) async {
    Activity? dataItem;
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYID} = $id";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
          "ActivityDataHandlerBase:GetActivityRecords()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<int> AddActivityRecord(
      DatabaseHandler databaseHandler, Activity dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.activityID != null && dataItem.activityID != ("null"))
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYID] = dataItem.activityID;

      if (dataItem.activityCode != null && dataItem.activityCode != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE] = dataItem.activityCode;

      if (dataItem.activityTitle != null && dataItem.activityTitle != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE] = dataItem.activityTitle;

      if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID] =
            dataItem.activityTypeID;

      if (dataItem.leadSource != null && dataItem.leadSource != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADSOURCE] = dataItem.leadSource;

      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACCOUNTID] = dataItem.accountID;

      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CONTACTID] = dataItem.contactID;

      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID] = dataItem.opportunityID;

      if (dataItem.activityMeasure != null &&
          dataItem.activityMeasure != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE] =
            dataItem.activityMeasure;

      if (dataItem.activityDate != null && dataItem.activityDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE] = dataItem.activityDate;

      if (dataItem.activityEndDate != null &&
          dataItem.activityEndDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE] =
            dataItem.activityEndDate;

      if (dataItem.assignmentDetails != null &&
          dataItem.assignmentDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS] =
            dataItem.assignmentDetails;

      if (dataItem.activityDetails != null &&
          dataItem.activityDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS] =
            dataItem.activityDetails;

      if (dataItem.activityPriorityID != null &&
          dataItem.activityPriorityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID] =
            dataItem.activityPriorityID;

      if (dataItem.totalAmount != null && dataItem.totalAmount != "null")
        values[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT] = dataItem.totalAmount;

      if (dataItem.amountCollected != null &&
          dataItem.amountCollected != "null")
        values[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED] =
            dataItem.amountCollected;

      if (dataItem.currencyID != null && dataItem.currencyID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CURRENCYID] = dataItem.currencyID;

      if (dataItem.collectionDetails != null &&
          dataItem.collectionDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS] =
            dataItem.collectionDetails;

      if (dataItem.isTravelled != null && dataItem.isTravelled != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED] = dataItem.isTravelled;

      if (dataItem.travelPurposeName != null &&
          dataItem.travelPurposeName != "null")
        values[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME] =
            dataItem.travelPurposeName;

      if (dataItem.activityStatusID != null &&
          dataItem.activityStatusID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID] =
            dataItem.activityStatusID;

      if (dataItem.needFollowUpActivity != null &&
          dataItem.needFollowUpActivity != "null")
        values[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY] =
            dataItem.needFollowUpActivity;

      if (dataItem.activityCode != null && dataItem.activityCode != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE] = dataItem.activityCode;

// Continue adding more fields as needed
      if (dataItem.activityTitle != null && dataItem.activityTitle != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE] = dataItem.activityTitle;
      if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID] =
            dataItem.activityTypeID;
      if (dataItem.leadSource != null && dataItem.leadSource != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADSOURCE] = dataItem.leadSource;
      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACCOUNTID] = dataItem.accountID;
      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CONTACTID] = dataItem.contactID;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID] = dataItem.opportunityID;
      if (dataItem.activityMeasure != null &&
          dataItem.activityMeasure != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE] =
            dataItem.activityMeasure;
      if (dataItem.activityDate != null && dataItem.activityDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE] = dataItem.activityDate;
// Add more fields as needed
      if (dataItem.activityEndDate != null &&
          dataItem.activityEndDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE] =
            dataItem.activityEndDate;
      if (dataItem.assignmentDetails != null &&
          dataItem.assignmentDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS] =
            dataItem.assignmentDetails;
      if (dataItem.activityDetails != null &&
          dataItem.activityDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS] =
            dataItem.activityDetails;
      if (dataItem.activityPriorityID != null &&
          dataItem.activityPriorityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID] =
            dataItem.activityPriorityID;
      if (dataItem.totalAmount != null && dataItem.totalAmount != "null")
        values[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT] = dataItem.totalAmount;
      if (dataItem.amountCollected != null &&
          dataItem.amountCollected != "null")
        values[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED] =
            dataItem.amountCollected;
      if (dataItem.currencyID != null && dataItem.currencyID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CURRENCYID] = dataItem.currencyID;
      if (dataItem.collectionDetails != null &&
          dataItem.collectionDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS] =
            dataItem.collectionDetails;
      if (dataItem.isTravelled != null && dataItem.isTravelled != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED] = dataItem.isTravelled;
// Add more fields as needed
      if (dataItem.travelPurposeName != null &&
          dataItem.travelPurposeName != "null")
        values[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME] =
            dataItem.travelPurposeName;
      if (dataItem.activityStatusID != null &&
          dataItem.activityStatusID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID] =
            dataItem.activityStatusID;
      if (dataItem.needFollowUpActivity != null &&
          dataItem.needFollowUpActivity != "null")
        values[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY] =
            dataItem.needFollowUpActivity;
      if (dataItem.parentActivityID != null &&
          dataItem.parentActivityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID] =
            dataItem.parentActivityID;
      if (dataItem.activityAssignmentID != null &&
          dataItem.activityAssignmentID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID] =
            dataItem.activityAssignmentID;
      if (dataItem.expectedCompletionDate != null &&
          dataItem.expectedCompletionDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE] =
            dataItem.expectedCompletionDate;
      if (dataItem.productInstallationDetailID != null &&
          dataItem.productInstallationDetailID != "null")
        values[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID] =
            dataItem.productInstallationDetailID;
      if (dataItem.invoiceID != null && dataItem.invoiceID != "null")
        values[ColumnsBase.KEY_ACTIVITY_INVOICEID] = dataItem.invoiceID;

      if (dataItem.workflowProgressID != null &&
          dataItem.workflowProgressID != "null")
        values[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID] =
            dataItem.workflowProgressID;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_ACTIVITY_TAGS] = dataItem.tags;
      if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1] =
            dataItem.freeTextField1;
      if (dataItem.isApprovalRequired != null &&
          dataItem.isApprovalRequired != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED] =
            dataItem.isApprovalRequired;
      if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2] =
            dataItem.freeTextField2;
      if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3] =
            dataItem.freeTextField3;
      if (dataItem.isApproved != null && dataItem.isApproved != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISAPPROVED] = dataItem.isApproved;
      if (dataItem.marketingContactID != null &&
          dataItem.marketingContactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID] =
            dataItem.marketingContactID;
// Add more fields as needed
      if (dataItem.workflowStageID != null &&
          dataItem.workflowStageID != "null")
        values[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID] =
            dataItem.workflowStageID;
      if (dataItem.isWorkflowStageUpdated != null &&
          dataItem.isWorkflowStageUpdated != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED] =
            dataItem.isWorkflowStageUpdated;
      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_ACTIVITY_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_ACTIVITY_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_ACTIVITY_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
// Add more fields as needed
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.location != null && dataItem.location != "null")
        values[ColumnsBase.KEY_ACTIVITY_LOCATION] = dataItem.location;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISACTIVE] = dataItem.isActive;
      if (dataItem.isLocked != null && dataItem.isLocked != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISLOCKED] = dataItem.isLocked;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_ACTIVITY_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISARCHIVED] = dataItem.isArchived;
// Add more fields as needed

// Add more fields as needed
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISDELETED] = dataItem.isDeleted;
      if (dataItem.successAlertMessage != null &&
          dataItem.successAlertMessage != "null")
        values[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE] =
            dataItem.successAlertMessage;
      if (dataItem.failureAlertMessage != null &&
          dataItem.failureAlertMessage != "null")
        values[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE] =
            dataItem.failureAlertMessage;
      if (dataItem.approvalStatus != null && dataItem.approvalStatus != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS] =
            dataItem.approvalStatus;
      if (dataItem.approvalDetails != null &&
          dataItem.approvalDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS] =
            dataItem.approvalDetails;
      if (dataItem.completedDate != null && dataItem.completedDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_COMPLETEDDATE] = dataItem.completedDate;
// Add more fields as needed
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";
// Add more fields as needed

      id = await db.insert(TablesBase.TABLE_ACTIVITY, values);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:AddActivityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> UpdateActivityRecord(
      DatabaseHandler databaseHandler, String id1, Activity dataItem) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();

      if (dataItem.activityID != null && dataItem.activityID != ("null"))
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYID] = dataItem.activityID;

      if (dataItem.activityCode != null && dataItem.activityCode != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE] = dataItem.activityCode;

      if (dataItem.activityTitle != null && dataItem.activityTitle != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE] = dataItem.activityTitle;

      if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID] =
            dataItem.activityTypeID;

      if (dataItem.leadSource != null && dataItem.leadSource != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADSOURCE] = dataItem.leadSource;

      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACCOUNTID] = dataItem.accountID;

      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CONTACTID] = dataItem.contactID;

      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID] = dataItem.opportunityID;

      if (dataItem.activityMeasure != null &&
          dataItem.activityMeasure != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE] =
            dataItem.activityMeasure;

      if (dataItem.activityDate != null && dataItem.activityDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE] = dataItem.activityDate;

      if (dataItem.activityEndDate != null &&
          dataItem.activityEndDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE] =
            dataItem.activityEndDate;

      if (dataItem.assignmentDetails != null &&
          dataItem.assignmentDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS] =
            dataItem.assignmentDetails;

      if (dataItem.activityDetails != null &&
          dataItem.activityDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS] =
            dataItem.activityDetails;

      if (dataItem.activityPriorityID != null &&
          dataItem.activityPriorityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID] =
            dataItem.activityPriorityID;

      if (dataItem.totalAmount != null && dataItem.totalAmount != "null")
        values[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT] = dataItem.totalAmount;

      if (dataItem.amountCollected != null &&
          dataItem.amountCollected != "null")
        values[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED] =
            dataItem.amountCollected;

      if (dataItem.currencyID != null && dataItem.currencyID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CURRENCYID] = dataItem.currencyID;

      if (dataItem.collectionDetails != null &&
          dataItem.collectionDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS] =
            dataItem.collectionDetails;

      if (dataItem.isTravelled != null && dataItem.isTravelled != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED] = dataItem.isTravelled;

      if (dataItem.travelPurposeName != null &&
          dataItem.travelPurposeName != "null")
        values[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME] =
            dataItem.travelPurposeName;

      if (dataItem.activityStatusID != null &&
          dataItem.activityStatusID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID] =
            dataItem.activityStatusID;

      if (dataItem.needFollowUpActivity != null &&
          dataItem.needFollowUpActivity != "null")
        values[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY] =
            dataItem.needFollowUpActivity;

      if (dataItem.activityCode != null && dataItem.activityCode != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYCODE] = dataItem.activityCode;

// Continue adding more fields as needed
      if (dataItem.activityTitle != null && dataItem.activityTitle != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE] = dataItem.activityTitle;
      if (dataItem.activityTypeID != null && dataItem.activityTypeID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID] =
            dataItem.activityTypeID;
      if (dataItem.leadSource != null && dataItem.leadSource != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADSOURCE] = dataItem.leadSource;
      if (dataItem.accountID != null && dataItem.accountID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACCOUNTID] = dataItem.accountID;
      if (dataItem.contactID != null && dataItem.contactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CONTACTID] = dataItem.contactID;
      if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID] = dataItem.opportunityID;
      if (dataItem.activityMeasure != null &&
          dataItem.activityMeasure != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYMEASURE] =
            dataItem.activityMeasure;
      if (dataItem.activityDate != null && dataItem.activityDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDATE] = dataItem.activityDate;
// Add more fields as needed
      if (dataItem.activityEndDate != null &&
          dataItem.activityEndDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYENDDATE] =
            dataItem.activityEndDate;
      if (dataItem.assignmentDetails != null &&
          dataItem.assignmentDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ASSIGNMENTDETAILS] =
            dataItem.assignmentDetails;
      if (dataItem.activityDetails != null &&
          dataItem.activityDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYDETAILS] =
            dataItem.activityDetails;
      if (dataItem.activityPriorityID != null &&
          dataItem.activityPriorityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID] =
            dataItem.activityPriorityID;
      if (dataItem.totalAmount != null && dataItem.totalAmount != "null")
        values[ColumnsBase.KEY_ACTIVITY_TOTALAMOUNT] = dataItem.totalAmount;
      if (dataItem.amountCollected != null &&
          dataItem.amountCollected != "null")
        values[ColumnsBase.KEY_ACTIVITY_AMOUNTCOLLECTED] =
            dataItem.amountCollected;
      if (dataItem.currencyID != null && dataItem.currencyID != "null")
        values[ColumnsBase.KEY_ACTIVITY_CURRENCYID] = dataItem.currencyID;
      if (dataItem.collectionDetails != null &&
          dataItem.collectionDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_COLLECTIONDETAILS] =
            dataItem.collectionDetails;
      if (dataItem.isTravelled != null && dataItem.isTravelled != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISTRAVELLED] = dataItem.isTravelled;
// Add more fields as needed
      if (dataItem.travelPurposeName != null &&
          dataItem.travelPurposeName != "null")
        values[ColumnsBase.KEY_ACTIVITY_TRAVELPURPOSENAME] =
            dataItem.travelPurposeName;
      if (dataItem.activityStatusID != null &&
          dataItem.activityStatusID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID] =
            dataItem.activityStatusID;
      if (dataItem.needFollowUpActivity != null &&
          dataItem.needFollowUpActivity != "null")
        values[ColumnsBase.KEY_ACTIVITY_NEEDFOLLOWUPACTIVITY] =
            dataItem.needFollowUpActivity;
      if (dataItem.parentActivityID != null &&
          dataItem.parentActivityID != "null")
        values[ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID] =
            dataItem.parentActivityID;
      if (dataItem.activityAssignmentID != null &&
          dataItem.activityAssignmentID != "null")
        values[ColumnsBase.KEY_ACTIVITY_ACTIVITYASSIGNMENTID] =
            dataItem.activityAssignmentID;
      if (dataItem.expectedCompletionDate != null &&
          dataItem.expectedCompletionDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_EXPECTEDCOMPLETIONDATE] =
            dataItem.expectedCompletionDate;
      if (dataItem.productInstallationDetailID != null &&
          dataItem.productInstallationDetailID != "null")
        values[ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID] =
            dataItem.productInstallationDetailID;
      if (dataItem.invoiceID != null && dataItem.invoiceID != "null")
        values[ColumnsBase.KEY_ACTIVITY_INVOICEID] = dataItem.invoiceID;

      if (dataItem.workflowProgressID != null &&
          dataItem.workflowProgressID != "null")
        values[ColumnsBase.KEY_ACTIVITY_WORKFLOWPROGRESSID] =
            dataItem.workflowProgressID;
      if (dataItem.tags != null && dataItem.tags != "null")
        values[ColumnsBase.KEY_ACTIVITY_TAGS] = dataItem.tags;
      if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD1] =
            dataItem.freeTextField1;
      if (dataItem.isApprovalRequired != null &&
          dataItem.isApprovalRequired != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISAPPROVALREQUIRED] =
            dataItem.isApprovalRequired;
      if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD2] =
            dataItem.freeTextField2;
      if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null")
        values[ColumnsBase.KEY_ACTIVITY_FREETEXTFIELD3] =
            dataItem.freeTextField3;
      if (dataItem.isApproved != null && dataItem.isApproved != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISAPPROVED] = dataItem.isApproved;
      if (dataItem.marketingContactID != null &&
          dataItem.marketingContactID != "null")
        values[ColumnsBase.KEY_ACTIVITY_MARKETINGCONTACTID] =
            dataItem.marketingContactID;
// Add more fields as needed
      if (dataItem.workflowStageID != null &&
          dataItem.workflowStageID != "null")
        values[ColumnsBase.KEY_ACTIVITY_WORKFLOWSTAGEID] =
            dataItem.workflowStageID;
      if (dataItem.isWorkflowStageUpdated != null &&
          dataItem.isWorkflowStageUpdated != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISWORKFLOWSTAGEUPDATED] =
            dataItem.isWorkflowStageUpdated;
      if (dataItem.leadQualificationID != null &&
          dataItem.leadQualificationID != "null")
        values[ColumnsBase.KEY_ACTIVITY_LEADQUALIFICATIONID] =
            dataItem.leadQualificationID;
      if (dataItem.createdBy != null && dataItem.createdBy != "null")
        values[ColumnsBase.KEY_ACTIVITY_CREATEDBY] = dataItem.createdBy;
      if (dataItem.createdOn != null && dataItem.createdOn != "null")
        values[ColumnsBase.KEY_ACTIVITY_CREATEDON] = dataItem.createdOn;
      if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
        values[ColumnsBase.KEY_ACTIVITY_MODIFIEDBY] = dataItem.modifiedBy;
      if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
        values[ColumnsBase.KEY_ACTIVITY_MODIFIEDON] = dataItem.modifiedOn;
      if (dataItem.deviceIdentifier != null &&
          dataItem.deviceIdentifier != "null")
        values[ColumnsBase.KEY_ACTIVITY_DEVICEIDENTIFIER] =
            dataItem.deviceIdentifier;
// Add more fields as needed
      if (dataItem.referenceIdentifier != null &&
          dataItem.referenceIdentifier != "null")
        values[ColumnsBase.KEY_ACTIVITY_REFERENCEIDENTIFIER] =
            dataItem.referenceIdentifier;
      if (dataItem.location != null && dataItem.location != "null")
        values[ColumnsBase.KEY_ACTIVITY_LOCATION] = dataItem.location;
      if (dataItem.isActive != null && dataItem.isActive != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISACTIVE] = dataItem.isActive;
      if (dataItem.isLocked != null && dataItem.isLocked != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISLOCKED] = dataItem.isLocked;
      if (dataItem.uid != null && dataItem.uid != "null")
        values[ColumnsBase.KEY_ACTIVITY_UID] = dataItem.uid;
      if (dataItem.appUserID != null && dataItem.appUserID != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPUSERID] = dataItem.appUserID;
      if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID] =
            dataItem.appUserGroupID;
      if (dataItem.isArchived != null && dataItem.isArchived != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISARCHIVED] = dataItem.isArchived;
// Add more fields as needed

// Add more fields as needed
      if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
        values[ColumnsBase.KEY_ACTIVITY_ISDELETED] = dataItem.isDeleted;
      if (dataItem.successAlertMessage != null &&
          dataItem.successAlertMessage != "null")
        values[ColumnsBase.KEY_ACTIVITY_SUCCESSALERTMESSAGE] =
            dataItem.successAlertMessage;
      if (dataItem.failureAlertMessage != null &&
          dataItem.failureAlertMessage != "null")
        values[ColumnsBase.KEY_ACTIVITY_FAILUREALERTMESSAGE] =
            dataItem.failureAlertMessage;
      if (dataItem.approvalStatus != null && dataItem.approvalStatus != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPROVALSTATUS] =
            dataItem.approvalStatus;
      if (dataItem.approvalDetails != null &&
          dataItem.approvalDetails != "null")
        values[ColumnsBase.KEY_ACTIVITY_APPROVALDETAILS] =
            dataItem.approvalDetails;
      if (dataItem.completedDate != null && dataItem.completedDate != "null")
        values[ColumnsBase.KEY_ACTIVITY_COMPLETEDDATE] = dataItem.completedDate;
// Add more fields as needed
      if (dataItem.id != null && dataItem.id != "null")
        values[ColumnsBase.KEY_ID] = dataItem.id;
      if (dataItem.isDirty != null && dataItem.isDirty != "null")
        values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
      if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
        values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
      if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
        values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
      if (dataItem.downSyncMessage != null &&
          dataItem.downSyncMessage != "null")
        values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
      if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null")
        values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
      if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null")
        values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
      if (dataItem.createdByUser != null && dataItem.createdByUser != "null")
        values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
      if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null")
        values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
      if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null")
        values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
      values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
      values[ColumnsBase.KEY_ISACTIVE] = "true";
      values[ColumnsBase.KEY_ISDELETED] = "false";
// Add more fields as needed

      id = await db.update(TablesBase.TABLE_ACTIVITY, values,
          where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:UpdateActivityRecord()", ex);
      throw ex;
    }
    return id;
  }

  static Future<int> deleteActivityRecord(
      DatabaseHandler databaseHandler, String id1) async {
    int id = 0;
    try {
      final db = await databaseHandler.database;
      id = await db.delete(TablesBase.TABLE_ACTIVITY,
          where: "${ColumnsBase.KEY_ID} = $id1");
      //db.close();
    } catch (ex) {
      Globals.handleException("DatabaseHandler:deleteActivityRecord()", ex);
      rethrow;
    }
    return id;
  }

  static Future<String> getServerId(
      DatabaseHandler databaseHandler, String id) async {
    String serverId = "-1";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYID}"
          " FROM ${TablesBase.TABLE_ACTIVITY} A"
          " WHERE A.${ColumnsBase.KEY_ID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> results = await db.rawQuery(selectQuery);
      if (results.isNotEmpty) {
        serverId = results.first[ColumnsBase.KEY_ACTIVITY_ACTIVITYID];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandlerBase:getServerId()", ex);
      rethrow;
    }
    return serverId;
  }

  static Future<String> getLocalId(
      DatabaseHandler databaseHandler, String id) async {
    String localId = "";
    try {
      id = Globals.tryParseLongForDBId(id);

      String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}"
          " FROM ${TablesBase.TABLE_ACTIVITY} A"
          " WHERE A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYID} = $id";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> results = await db.rawQuery(selectQuery);
      if (results.isNotEmpty) {
        localId = results.first[ColumnsBase.KEY_ID];
      }
      //db.close();
    } catch (ex) {
      Globals.handleException("ActivityDataHandlerBase:getLocalId()", ex);
      rethrow;
    }
    return localId;
  }

  static Future<List<Activity>> GetActivityUpSyncRecords(
      DatabaseHandler databaseHandler, String changeType) async {
    List<Activity> dataList = [];
    try {
      String selectQuery =
          "SELECT * FROM ${TablesBase.TABLE_ACTIVITY} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
      /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
                //selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }
            else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
      selectQuery +=
          " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND ${ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
          "ActivityDataHandlerBase:GetActivityUpSyncRecords()", ex);
      throw ex;
    }
    return dataList;
  }

  static Future<Activity?> GetActivityRecordByUid(
      DatabaseHandler databaseHandler, String uid) async {
    Activity? dataItem;
    try {
      String selectQuery =
          "SELECT A.* ,F.${ColumnsBase.KEY_ACTIVITYTYPE_ACTIVITYTYPENAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},I.${ColumnsBase.KEY_CONTACT_CONTACTNAME},N.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},D.${ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME},J.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},E.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME},O.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE} AS ${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYTITLE},P.${ColumnsBase.KEY_PRODUCTINSTALLATIONDETAIL_PRODUCTINSTALLATIONDETAILCODE}";
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITY} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_ACTIVITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYPRIORITY} D ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYPRIORITYID} = D.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYSTATUS} E ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYSTATUSID} = E.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITYTYPE} F ON A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTYPEID} = F.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CONTACT} I ON A.${ColumnsBase.KEY_ACTIVITY_CONTACTID} = I.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_CURRENCY} J ON A.${ColumnsBase.KEY_ACTIVITY_CURRENCYID} = J.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} N ON A.${ColumnsBase.KEY_ACTIVITY_OPPORTUNITYID} = N.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} O ON A.${ColumnsBase.KEY_ACTIVITY_PARENTACTIVITYID} = O.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_PRODUCTINSTALLATIONDETAIL} P ON A.${ColumnsBase.KEY_ACTIVITY_PRODUCTINSTALLATIONDETAILID} = P.${ColumnsBase.KEY_ID}";
      selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_UID} = '$uid'";
      //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
      //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ActivityDataHandlerBase:GetActivityRecordByUid()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
