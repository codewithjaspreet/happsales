

 import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/Opportunity.dart';
import '../DataBaseHandler.dart';
import 'OpportunityDataHandlerBase.dart';

class OpportunityDataHandler extends OpportunityDataHandlerBase {

     static Future<List<Opportunity>> GetOpportunityRecordsForCopy(DatabaseHandler databaseHandler,  String accountId, String searchString, bool isOnGoing, bool isClosed, bool isWon) async{
        List<Opportunity> dataList =[];
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            if (accountId.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";
            if (searchString.trim().length > 0) {
                selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} LIKE '%${searchString.replaceAll("'","''")}%')";
            }
            String addnlFilter = "";
            if (isOnGoing && isClosed && isWon) {
                addnlFilter += "";
            } else {
                if (isOnGoing) {
                    addnlFilter += " A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NULL OR A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = ''";
                }
                if (isClosed) {
                    if (addnlFilter != ("")) addnlFilter += " OR ";
                    addnlFilter += " A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NOT NULL AND  J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} <> 'Won'";
                }
                if (isWon) {
                    if (addnlFilter != ("")) addnlFilter += " OR ";
                    addnlFilter += " A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NOT NULL AND J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} = 'Won'";
                }
            }
            if (addnlFilter != ("")) {
                selectQuery += " AND ($addnlFilter)";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} COLLATE NOCASE ASC ";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecordsForCopy()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityIncomingRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId,
                                                                      String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime, String filterOppStage, String probability, String contactId, String quarter,
                                                                      String opportunityStageId, String opportunityStatusId,String maxSequentialOrder)async {
        List<Opportunity> dataList = [];
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";

            //Quarter
            if (quarter != null && quarter.trim() != ("")) {

                bool isQuarter = false;
                int startMonthIndex = 0;
                int endMonthIndex = 0;
if (quarter.trim().toLowerCase() == "q1") {
  isQuarter = true;
  startMonthIndex = 0;
  endMonthIndex = 3;
} else if (quarter.trim().toLowerCase() == "q2") {
  isQuarter = true;
  startMonthIndex = 3;
  endMonthIndex = 6;
} else if (quarter.trim().toLowerCase() == "q3") {
  isQuarter = true;
  startMonthIndex = 6;
  endMonthIndex = 9;
} else if (quarter.trim().toLowerCase() == "q4") {
  isQuarter = true;
  startMonthIndex = 9;
  endMonthIndex = 12;
}

                if (isQuarter) {

                    quarterWhere = " AND cast(strftime('%m', date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})) as integer) BETWEEN cast(strftime('%m', date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE},'+$startMonthIndex month')) as integer)  AND cast(strftime('%m', date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE},'+$endMonthIndex month','-1 day')) as integer)";

                    quarterWhere = " AND Y.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID} $quarterWhere";
                    quarterWhere = " AND Y.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} $quarterWhere";


                    quarterLeftJoin = " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} Y ON ((date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE}) <= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})  AND date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE}) >= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}))) ";
                }
            }


            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CREATEDBY} <> '${Globals.AppUserLoginName}'";
            selectQuery += " AND (I.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} IS NOT NULL AND  I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER} <>'$maxSequentialOrder')";

            if (searchString.trim().length > 0) {
                selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'","''")}%')";
            }
            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

          // Start and End Date
if (filterOppStartDateTime != null &&
    filterOppStartDateTime.trim() != "" &&
    filterOppEndDateTime != null &&
    filterOppEndDateTime.trim() != "") {
  List<String> startDates = filterOppStartDateTime.split("T");
  List<String> endDates = filterOppEndDateTime.split("T");

  if (startDates.length > 1 && endDates.length > 1) {
    selectQuery +=
        " AND (date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) >= date('${startDates[0]}') AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) <= date('${endDates[0]}')) ";
  }
  // Date
} else if (filterOppDateTime != null && filterOppDateTime.trim() != "") {
  List<String> dates = filterOppDateTime.split("T");
  if (dates.length > 1) {
    selectQuery +=
        " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) = date('${dates[0]}')";
  }
}

// Probability
if (probability != null && probability.trim() != "") {
  selectQuery +=
      " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";
}

// Status
if (opportunityStageId != null && opportunityStageId.trim() != "") {
  selectQuery +=
      " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = $opportunityStageId";
}

// Stage
if (opportunityStatusId != null && opportunityStatusId.trim() != "") {
  selectQuery +=
      " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusId";
}


            //Quarter
            selectQuery += quarterWhere;

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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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
dataList.add(dataItem);

            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityDueClosedRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection,
                                                                        int pageIndex, int pageSize, String contactId,String accountId,String opportunityStatusID)async {
        List<Opportunity> dataList =[];
        try {


            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') <> '' ";

            if (opportunityStatusID != null && opportunityStatusID.trim().length > 0)
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusID";

            if (searchString.trim().length> 0) {
                selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'","''")}%')";
            }

            if (Globals.isIntegerString(accountId)) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";
            }
            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //selectQuery += " AND strftime('%W', " + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE +  ", 'localtime', 'weekday 1', '-7 days') = strftime('%W', 'now', 'localtime', 'weekday 1', '-7 days')";
            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityDueAllRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, int pageIndex, int pageSize, String accountId, String contactId) async{
        List<Opportunity> dataList =[];
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";



            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            if (searchString.trim().length> 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }



            //selectQuery += " AND strftime('%W', " + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE +  ", 'localtime', 'weekday 1', '-7 days') = strftime('%W', 'now', 'localtime', 'weekday 1', '-7 days')";
            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


          final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<List<Opportunity>> GetOpportunityDueWeekRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, int pageIndex, int pageSize, String accountId, String contactId, String weekStartDate,String weekEndDate)async {
        List<Opportunity> dataList = [];
        try {


            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            if (searchString.trim().length > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length> 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }



            //selectQuery += " AND strftime('%W', " + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE +  ", 'localtime', 'weekday 1', '-7 days') = strftime('%W', 'now', 'localtime', 'weekday 1', '-7 days')";

            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) >= '$weekStartDate'";
            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) <= '$weekEndDate'";
            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityDueTodayRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, int pageIndex, int pageSize, String accountId,
                                                                      String contactId,String todayDate)async {
        List<Opportunity> dataList = [];
        try {


            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            if (searchString.trim().length > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length> 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }



            //selectQuery += " AND date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ") = date('now')";
            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) = '$todayDate'";


            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityOverDueRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, int pageIndex, int pageSize, String accountId, String contactId, String todayDate) async{
        List<Opportunity> dataList = [];
        try {

            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceAll("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS ${Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = ''";

            if (searchString.trim().length > 0) {
                selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL} LIKE '%${searchString.replaceAll("'","''")}%'";
                selectQuery += " OR B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} LIKE '%${searchString.replaceAll("'","''")}%')";
            }
            if (Globals.isIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length> 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }



            //selectQuery += " AND date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ") < date('now')";
            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) < '$todayDate'";

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityOnGoingRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId,
                                                                      String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime, String filterOppStage, String probability, String contactId, String quarter,
                                                                      String opportunityStageId, String opportunityStatusId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";

            //Quarter
            if (quarter != null && !quarter.trim().equals("")) {

                bool isQuarter = false;
                int startMonthIndex = 0;
                int endMonthIndex = 0;

                if (quarter.trim().equalsIgnoreCase("q1")) {
                    isQuarter = true;
                    startMonthIndex = 0;
                    endMonthIndex = 3;
                } else if (quarter.trim().equalsIgnoreCase("q2")) {
                    isQuarter = true;
                    startMonthIndex = 3;
                    endMonthIndex = 6;
                } else if (quarter.trim().equalsIgnoreCase("q3")) {
                    isQuarter = true;
                    startMonthIndex = 6;
                    endMonthIndex = 9;
                } else if (quarter.trim().equalsIgnoreCase("q4")) {
                    isQuarter = true;
                    startMonthIndex = 9;
                    endMonthIndex = 12;
                }

                if (isQuarter) {

                    quarterWhere = "${" AND cast(strftime('%m', date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ")) as integer) BETWEEN cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + startMonthIndex + " month')) as integer) " +
                            " AND cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + endMonthIndex} month','-1 day')) as integer)";

                    quarterWhere = " AND Y.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID} $quarterWhere";
                    quarterWhere = " AND Y.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} $quarterWhere";


                    quarterLeftJoin = " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} Y ON ((date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE}) <= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})  AND date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE}) >= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}))) ";
                }
            }


            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.IsIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ") >= date('" + startDates[0] + "') AND date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ") <= date('" + endDates[0]}')) ";
                }
                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ") = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            //Status
            if (opportunityStageId != null && !opportunityStageId.trim()("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = $opportunityStageId";
            }

            //Stage
            if (opportunityStatusId != null && !opportunityStatusId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusId";
            }

            //Quarter
            selectQuery += quarterWhere;

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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityClosedRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId,
                                                                     String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime,
                                                                     String filterOppStage, String probability, String contactId, String quarter,
                                                                     String opportunityStageId, String opportunityStatusId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";

//Quarter
            if (quarter != null && !quarter.trim().equals("")) {

                bool isQuarter = false;
                int startMonthIndex = 0;
                int endMonthIndex = 0;

                if (quarter.trim().equalsIgnoreCase("q1")) {
                    isQuarter = true;
                    startMonthIndex = 0;
                    endMonthIndex = 3;
                } else if (quarter.trim().equalsIgnoreCase("q2")) {
                    isQuarter = true;
                    startMonthIndex = 3;
                    endMonthIndex = 6;
                } else if (quarter.trim().equalsIgnoreCase("q3")) {
                    isQuarter = true;
                    startMonthIndex = 6;
                    endMonthIndex = 9;
                } else if (quarter.trim().equalsIgnoreCase("q4")) {
                    isQuarter = true;
                    startMonthIndex = 9;
                    endMonthIndex = 12;
                }

                if (isQuarter) {

                    quarterWhere = "${" AND cast(strftime('%m', date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ")) as integer) BETWEEN cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + startMonthIndex + " month')) as integer) " +
                            " AND cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + endMonthIndex} month','-1 day')) as integer)";

                    quarterWhere = " AND Y.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID} $quarterWhere";
                    quarterWhere = " AND Y.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} $quarterWhere";


                    quarterLeftJoin = " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} Y ON ((date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE}) <= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})  AND date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE}) >= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}))) ";
                }
            }

            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') <> '' AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) <> 'won'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.IsIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }

                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            //Status
            if (opportunityStageId != null && !opportunityStageId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = $opportunityStageId";
            }

            //Stage
            if (opportunityStatusId != null && !opportunityStatusId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusId";
            }

            //Quarter
            selectQuery += quarterWhere;


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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityClosedRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityWonRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId,
                                                                  String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime, String filterOppStage, String probability, String contactId, String quarter,
                                                                  String opportunityStageId, String opportunityStatusId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";

//Quarter
            if (quarter != null && !quarter.trim().equals("")) {

                bool isQuarter = false;
                int startMonthIndex = 0;
                int endMonthIndex = 0;

                if (quarter.trim().equalsIgnoreCase("q1")) {
                    isQuarter = true;
                    startMonthIndex = 0;
                    endMonthIndex = 3;
                } else if (quarter.trim().equalsIgnoreCase("q2")) {
                    isQuarter = true;
                    startMonthIndex = 3;
                    endMonthIndex = 6;
                } else if (quarter.trim().equalsIgnoreCase("q3")) {
                    isQuarter = true;
                    startMonthIndex = 6;
                    endMonthIndex = 9;
                } else if (quarter.trim().equalsIgnoreCase("q4")) {
                    isQuarter = true;
                    startMonthIndex = 9;
                    endMonthIndex = 12;
                }

                if (isQuarter) {

                    quarterWhere = "${" AND cast(strftime('%m', date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ")) as integer) BETWEEN cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + startMonthIndex + " month')) as integer) " +
                            " AND cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + endMonthIndex} month','-1 day')) as integer)";

                    quarterWhere = " AND Y.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID} $quarterWhere";
                    quarterWhere = " AND Y.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} $quarterWhere";


                    quarterLeftJoin = " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} Y ON ((date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE}) <= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})  AND date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE}) >= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}))) ";
                }
            }

            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) = 'won' AND LOWER(COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED},'false')) = 'false'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.IsIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }
                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            //Status
            if (opportunityStageId != null && !opportunityStageId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = $opportunityStageId";
            }

            //Stage
            if (opportunityStatusId != null && !opportunityStatusId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusId";
            }

            //Quarter
            selectQuery += quarterWhere;


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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


       final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityWonRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityWorkflowCompletedRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize, String accountId,
                                                                                String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime,
                                                                                String filterOppStage, String probability, String contactId, String quarter,
                                                                                String opportunityStageId, String opportunityStatusId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String quarterWhere = "";
            String quarterLeftJoin = "";

//Quarter
            if (quarter != null && !quarter.trim().equals("")) {

                bool isQuarter = false;
                int startMonthIndex = 0;
                int endMonthIndex = 0;

                if (quarter.trim().equalsIgnoreCase("q1")) {
                    isQuarter = true;
                    startMonthIndex = 0;
                    endMonthIndex = 3;
                } else if (quarter.trim().equalsIgnoreCase("q2")) {
                    isQuarter = true;
                    startMonthIndex = 3;
                    endMonthIndex = 6;
                } else if (quarter.trim().equalsIgnoreCase("q3")) {
                    isQuarter = true;
                    startMonthIndex = 6;
                    endMonthIndex = 9;
                } else if (quarter.trim().equalsIgnoreCase("q4")) {
                    isQuarter = true;
                    startMonthIndex = 9;
                    endMonthIndex = 12;
                }

                if (isQuarter) {

                    quarterWhere = "${" AND cast(strftime('%m', date(A." + ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE + ")) as integer) BETWEEN cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + startMonthIndex + " month')) as integer) " +
                            " AND cast(strftime('%m', date(Y." + ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE + ",'+" + endMonthIndex} month','-1 day')) as integer)";

                    quarterWhere = " AND Y.${ColumnsBase.KEY_FINANCIALYEAR_APPUSERGROUPID} = ${Globals.AppUserGroupID} $quarterWhere";
                    quarterWhere = " AND Y.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID} $quarterWhere";


                    quarterLeftJoin = " LEFT JOIN ${TablesBase.TABLE_FINANCIALYEAR} Y ON ((date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARSTARTDATE}) <= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE})  AND date(Y.${ColumnsBase.KEY_FINANCIALYEAR_FINANCIALYEARENDDATE}) >= date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}))) ";
                }
            }

            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += quarterLeftJoin;
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) = 'won' AND LOWER(COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED},'false')) = 'true'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }
            if (Globals.IsIntegerString(accountId))
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //NLP Filter
            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }
                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            //Status
            if (opportunityStageId != null && !opportunityStageId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = $opportunityStageId";
            }

            //Stage
            if (opportunityStatusId != null && !opportunityStatusId.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = $opportunityStatusId";
            }

            //Quarter
            selectQuery += quarterWhere;


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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


           final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityWorkflowCompletedRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityOnGoingRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityOnGoingRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityClosedRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') <> '' AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) <> 'won'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityClosedRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityWonRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) = 'won' AND LOWER(COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED},'false')) = 'false'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityWonRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityWorkflowCompletedRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            searchString = searchString.replaceall("'", "''");

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND LOWER(COALESCE(J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},'')) = 'won' AND LOWER(COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED},'false')) = 'true'";
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
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
				selectQuery += " AND A." + ColumnsBase.KEY_Opportunity_ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex}," + pageSize;


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityWorkflowCompletedRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityRecords(DatabaseHandler databaseHandler,  String accountId, String searchString) {

        //accountId = Globals.TryParseLongForDBId(accountId);

        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {
            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME},G.${ColumnsBase.KEY_CURRENCY_CURRENCYNAME},I.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},J.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME},K.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME},L.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} AS ${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME},M.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME} AS " + ColumnsBase.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length() > 0)
                selectQuery += "${" AND A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '" + searchString.replaceall("'","''")}%'";
            if (accountId.trim().length() > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME} COLLATE NOCASE ASC ";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityOnGoingRecords(DatabaseHandler databaseHandler, Context contextString, String accountId, String searchString, String sortString, String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime, String filterOppStage, String probability, String contactId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},D.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} FROM ${TablesBase.TABLE_OPPORTUNITY} A LEFT JOIN  ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTAGE} C ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTATUS} D ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NULL OR A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = '')";
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true') <> 'false' "; //Filter accessible records
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false') = 'false' ";  //Filter accessible records
            //Account
            if (accountId.trim().length() > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Search
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR C." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }
                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            if (!sortString.equals(""))
                selectQuery += " ORDER BY A.$sortString";
 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle(contextString, "OpportunityDataHandlerBase:GetOpportunityOnGoingRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityClosedRecords(DatabaseHandler databaseHandler, Context contextString, String accountId, String searchString, String sortString,
                                                                String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime,
                                                                String filterOppStage, String probability, String contactId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},D.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} FROM ${TablesBase.TABLE_OPPORTUNITY} A LEFT JOIN  ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTAGE} C ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTATUS} D ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NOT NULL AND  D.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} <> 'Won')";
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true') <> 'false' "; //Filter accessible records
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false') = 'false' ";  //Filter accessible records

            //Account
            if (accountId.trim().length() > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Search
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR D." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }

            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }

                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

            if (!sortString.equals(""))
                selectQuery += " ORDER BY A.$sortString";


          final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle(contextString, "OpportunityDataHandlerBase:GetOpportunityClosedRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static List<Opportunity> GetOpportunityWonRecords(DatabaseHandler databaseHandler, Context contextString, String accountId, String searchString, String sortString,
                                                             String filterOppDateTime, String filterOppStartDateTime, String filterOppEndDateTime,
                                                             String filterOppStage, String probability, String contactId) {
        List<Opportunity> dataList = new ArrayList<Opportunity>();
        try {

            String selectQuery = "SELECT A.*,B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},C.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME},D.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} FROM ${TablesBase.TABLE_OPPORTUNITY} A LEFT JOIN  ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTAGE} C ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN  ${TablesBase.TABLE_OPPORTUNITYSTATUS} D ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND (A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} IS NOT NULL AND D.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} = 'Won')";
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true') <> 'false' "; //Filter accessible records
            selectQuery += " AND IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false') = 'false' ";  //Filter accessible records

            //Account
            if (accountId.trim().length() > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";

            //Contact
            if (contactId != null && contactId.trim().length() > 0) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";
            }

            //Search
            if (searchString.trim().length() > 0) {
                selectQuery += "${" AND (A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR D." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " LIKE '%" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR A." + ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1 + " LIKE '" + searchString.replaceall("'","''")}%'";
                selectQuery += "${" OR B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " LIKE '%" + searchString.replaceall("'","''")}%')";
            }


            //Start and End Date
            if (filterOppStartDateTime != null && !filterOppStartDateTime.trim().equals("")
                    && filterOppEndDateTime != null && !filterOppEndDateTime.trim().equals("")) {

                String[] startDates = filterOppStartDateTime.split("T");
                String[] endDates = filterOppEndDateTime.split("T");

                if (startDates.length > 1 && endDates.length > 1) {
                    selectQuery += "${" AND (date(A.ClosureDate) >= date('" + startDates[0] + "') AND date(A.ClosureDate) <= date('" + endDates[0]}')) ";
                }
                //Date
            } else if (filterOppDateTime != null && !filterOppDateTime.trim().equals("")) {
                String[] dates = filterOppDateTime.split("T");
                if (dates.length > 1) {
                    selectQuery += "${" AND date(A.ClosureDate) = date('" + dates[0]}')";
                }
            }

            //Probability
            if (probability != null && !probability.trim().equals("")) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_PROBABILITY} = $probability";

            }

           /* if (filterOppStage != null && !filterOppStage.trim().equals("")) {
                selectQuery += " AND B. = '" + filterOppStage + "'";
            }*/


            if (!sortString.equals(""))
                selectQuery += " ORDER BY A.$sortString";

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    Opportunity dataItem = new Opportunity();
                    dataItem.opportunityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
                    dataItem.opportunityCode = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE];
                    dataItem.opportunityName = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.assignmentDetails = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS];
                    dataItem.opportunityDetail = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL];
                    dataItem.leadSource = element[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE];
                    dataItem.opportunityTypeID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID];
                    dataItem.accountID = element[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_OPPORTUNITY_CONTACTID];
                    dataItem.opportunityMeasure = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE];
                    dataItem.opportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE];
                    dataItem.currencyID = element[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID];
                    dataItem.grossProfit = element[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT];
                    dataItem.dealRegistrationNumber = element[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER];
                    dataItem.closureDate = element[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY];
                    dataItem.opportunityPriorityID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID];
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID];
                    dataItem.actualOpportunityValue = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE];
                    dataItem.lostToCompetitor = element[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR];
                    dataItem.reasonForOpportunityStatus = element[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS];
                    dataItem.plannedDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE];
                    dataItem.actualDeliveryDate = element[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE];
                    dataItem.currentActionOwner = element[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER];
                    dataItem.customerCallID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID];

                    dataItem.customerSatisfactionID = element[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID];
dataItem.referenceIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER];
dataItem.opportunityIdentifier = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER];
dataItem.purchaseOrderNumber = element[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER];
dataItem.quotationNumber = element[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER];
dataItem.isFinanceRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED];
dataItem.financeBy = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY];
dataItem.financeRemarks = element[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS];
dataItem.isApprovalRequired = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED];
dataItem.parentOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.isRecurringOpportunity = element[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY];
dataItem.recurrenceIntervalInDays = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS];
dataItem.recurrenceCount = element[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT];
dataItem.recurringOpportunityID = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.dateGeneratedForRecurring = element[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING];
dataItem.opportunityAssignmentID = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID];
dataItem.supplierAccountID = element[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID];
dataItem.tags = element[ColumnsBase.KEY_OPPORTUNITY_TAGS];
dataItem.freeTextField1 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1];
dataItem.freeTextField2 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2];
dataItem.freeTextField3 = element[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3];
dataItem.isAssigned = element[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED];
dataItem.assignedDate = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE];
dataItem.assignedByAppUserID = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID];
dataItem.assignmentRemarks = element[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS];
dataItem.opportunityFulfillmentStatus = element[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS];
dataItem.isOpportunityFulfilled = element[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED];
dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY];
dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITY_CREATEDON];
dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY];
dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON];
dataItem.isWonAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED];
dataItem.isNewAlerted = element[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED];
dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE];
dataItem.isLocked = element[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED];
dataItem.isApproved = element[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED];
dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITY_UID];
dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERID];
dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID];
dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED];
dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITY_ISDELETED];
dataItem.leadQualificationID = element[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID];

dataItem.opportunityTypeName = element[ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME];
dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];
dataItem.currencyName = element[ColumnsBase.KEY_CURRENCY_CURRENCYNAME];
dataItem.opportunityPriorityName = element[ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME];
dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];
dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
dataItem.parentOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME];
dataItem.recurringOpportunityName = element[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME];
dataItem.supplierAccountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
dataItem.workFlowDetails = element[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS];

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


            }
           
        } catch ( ex) {
            Globals.Handle(contextString, "OpportunityDataHandlerBase:GetOpportunityWonRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static int GetOpportunityRecordsByContactID(DatabaseHandler databaseHandler,  String contactId) {
        int itemCount = 0;
        try {
            String selectQuery = "SELECT COUNT(*)";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";

            if (contactId.trim().length() > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = $contactId";

            Final db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                itemCount = cursor.getInt(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityRecordsByContactID()", ex);
            throw ex;
        }
        return itemCount;
    }


     static int GetCountOpportunityForOverDue(DatabaseHandler databaseHandler, Context context) {
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";

            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) < date('now')";

            Final db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                itemCount = cursor.getInt(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandlerBase:GetOpportunityRecordsPagedForPending()", ex);
            throw ex;
        }
        return itemCount;
    }

     static int GetCountOpportunityForToday(DatabaseHandler databaseHandler, String dateNow) {
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";
            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) = '$dateNow'";

            final db = databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            // for(var element in result){

            //   itemCount = element[0];
            // }
            
            if (cursor.moveToFirst()) {
                itemCount = cursor.getInt(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecordsPagedForPending()", ex);
            throw ex;
        }
        return itemCount;
    }



     static int GetAllOpportunityCount(DatabaseHandler databaseHandler, String accountId) {
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
           // selectQuery += " AND COALESCE(A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + ",'') = '' ";

            if (Globals.IsIntegerString(accountId)) {
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = $accountId";
            }

            Final db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                itemCount = cursor.getInt(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandler:GetDueAllOpportunityCount()", ex);
            throw ex;
        }
        return itemCount;
    }


     static int GetCountOpportunityForWeek(DatabaseHandler databaseHandler,  String weekStartDate,String weekEndDate) {
        int itemCount = 0;
        try {

            String selectQuery = "SELECT COUNT(*) " ;
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITY} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_OPPORTUNITY_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CURRENCY} G ON A.${ColumnsBase.KEY_OPPORTUNITY_CURRENCYID} = G.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTAGE} I ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID} = I.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITYSTATUS} J ON A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID} = J.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} K ON A.${ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID} = K.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} L ON A.${ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID} = L.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} M ON A.${ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID} = M.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED},'false')) = 'false' ";
            selectQuery += " AND COALESCE(A.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID},'') = '' ";

            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) >= '$weekStartDate'";
            selectQuery += " AND date(A.${ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE}) <= '$weekEndDate'";


            Final db = databaseHandler.getWritableDatabase();
            Cursor cursor = db.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                itemCount = cursor.getInt(0);
            }
            cursor.close();
            //db.close();
        } catch ( ex) {
            Globals.Handle( "OpportunityDataHandler:GetCountOpportunityForWeek()", ex);
            throw ex;
        }
        return itemCount;
    }



    /*-------------------HAPPSALES-------------------*/

}