

 import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../DataBaseHandler.dart';
import '../../models/OpportunityModels/Opportunity.dart';

class OpportunityDataHandlerBase {

     static Future<List<Opportunity>> GetOpportunityRecordsPaged(DatabaseHandler databaseHandler,   String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<Opportunity> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",L." + ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME + ",I." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + ",J." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + ",K." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + ",M." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME + ",N." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME + ",O." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_OPPORTUNITY_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CURRENCY + " G ON A." + ColumnsBase.KEY_OPPORTUNITY_CURRENCYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " I ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID + " = I." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTAGE + " J ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID + " = J." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTATUS + " K ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + " = K." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYTYPE + " L ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID + " = L." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " M ON A." + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID + " = M." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " N ON A." + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID + " = N." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " O ON A." + ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID + " = O." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITY_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '%" + searchString.replaceAll("'", "''") + "%'";

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

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();


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
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Opportunity>> GetOpportunityRecords(DatabaseHandler databaseHandler,   String searchString) async{
        List<Opportunity> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",L." + ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME + ",I." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + ",J." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + ",K." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + ",M." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME + ",N." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME + ",O." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_OPPORTUNITY_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CURRENCY + " G ON A." + ColumnsBase.KEY_OPPORTUNITY_CURRENCYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " I ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID + " = I." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTAGE + " J ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID + " = J." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTATUS + " K ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + " = K." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYTYPE + " L ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID + " = L." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " M ON A." + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID + " = M." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " N ON A." + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID + " = N." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " O ON A." + ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID + " = O." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITY_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " LIKE '" + searchString.replaceAll("'", "''") + "%'";
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " COLLATE NOCASE ASC ";

           
           
            final db = await  databaseHandler.database;
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
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Opportunity?> GetOpportunityRecord(DatabaseHandler databaseHandler,   String id) async{
        Opportunity? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",L." + ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME + ",I." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + ",J." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + ",K." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + ",M." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME + ",N." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME + ",O." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_OPPORTUNITY_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CURRENCY + " G ON A." + ColumnsBase.KEY_OPPORTUNITY_CURRENCYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " I ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID + " = I." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTAGE + " J ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID + " = J." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTATUS + " K ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + " = K." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYTYPE + " L ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID + " = L." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " M ON A." + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID + " = M." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " N ON A." + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID + " = N." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " O ON A." + ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID + " = O." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
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
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Opportunity?> GetMasterOpportunityRecord(DatabaseHandler databaseHandler,   String id)async {
        Opportunity? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",L." + ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME + ",I." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + ",J." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + ",K." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + ",M." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME + ",N." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME + ",O." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_OPPORTUNITY_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CURRENCY + " G ON A." + ColumnsBase.KEY_OPPORTUNITY_CURRENCYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " I ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID + " = I." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTAGE + " J ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID + " = J." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTATUS + " K ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + " = K." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYTYPE + " L ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID + " = L." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " M ON A." + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID + " = M." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " N ON A." + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID + " = N." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " O ON A." + ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID + " = O." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetMasterOpportunityRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddOpportunityRecord(DatabaseHandler databaseHandler,   Opportunity dataItem) async{
        int id = 0;
        try {

             final db =  await databaseHandler.database;
           
Map<String, dynamic> values = {};
if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID] = dataItem.opportunityID;
if (dataItem.opportunityCode != null && dataItem.opportunityCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE] = dataItem.opportunityCode;
if (dataItem.opportunityName != null && dataItem.opportunityName != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME] = dataItem.opportunityName;
if (dataItem.assignmentDetails != null && dataItem.assignmentDetails != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS] = dataItem.assignmentDetails;
if (dataItem.opportunityDetail != null && dataItem.opportunityDetail != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL] = dataItem.opportunityDetail;
if (dataItem.leadSource != null && dataItem.leadSource != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE] = dataItem.leadSource;
if (dataItem.opportunityTypeID != null && dataItem.opportunityTypeID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID] = dataItem.opportunityTypeID;
if (dataItem.accountID != null && dataItem.accountID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID] = dataItem.accountID;
if (dataItem.contactID != null && dataItem.contactID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CONTACTID] = dataItem.contactID;
if (dataItem.opportunityMeasure != null && dataItem.opportunityMeasure != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE] = dataItem.opportunityMeasure;
if (dataItem.opportunityValue != null && dataItem.opportunityValue != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE] = dataItem.opportunityValue;
if (dataItem.currencyID != null && dataItem.currencyID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID] = dataItem.currencyID;
if (dataItem.grossProfit != null && dataItem.grossProfit != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT] = dataItem.grossProfit;
if (dataItem.dealRegistrationNumber != null && dataItem.dealRegistrationNumber != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER] = dataItem.dealRegistrationNumber;
if (dataItem.closureDate != null && dataItem.closureDate != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE] = dataItem.closureDate;
if (dataItem.probability != null && dataItem.probability != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY] = dataItem.probability;
if (dataItem.opportunityPriorityID != null && dataItem.opportunityPriorityID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID] = dataItem.opportunityPriorityID;
            
           if (dataItem.opportunityStageID != null && dataItem.opportunityStageID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID] = dataItem.opportunityStageID;
}
if (dataItem.opportunityStatusID != null && dataItem.opportunityStatusID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID] = dataItem.opportunityStatusID;
}
if (dataItem.actualOpportunityValue != null && dataItem.actualOpportunityValue != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE] = dataItem.actualOpportunityValue;
}

if (dataItem.lostToCompetitor != null && dataItem.lostToCompetitor != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR] = dataItem.lostToCompetitor;
}
if (dataItem.reasonForOpportunityStatus != null && dataItem.reasonForOpportunityStatus != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS] = dataItem.reasonForOpportunityStatus;
}

if (dataItem.plannedDeliveryDate != null && dataItem.plannedDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE] = dataItem.plannedDeliveryDate;
}
if (dataItem.actualDeliveryDate != null && dataItem.actualDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE] = dataItem.actualDeliveryDate;
}
if (dataItem.requestedDeliveryDate != null && dataItem.requestedDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REQUESTEDDELIVERYDATE] = dataItem.requestedDeliveryDate;
}
if (dataItem.currentActionOwner != null && dataItem.currentActionOwner != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER] = dataItem.currentActionOwner;
}
if (dataItem.customerCallID != null && dataItem.customerCallID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID] = dataItem.customerCallID;
}
if (dataItem.customerSatisfactionID != null && dataItem.customerSatisfactionID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID] = dataItem.customerSatisfactionID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.opportunityIdentifier != null && dataItem.opportunityIdentifier != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER] = dataItem.opportunityIdentifier;
}
if (dataItem.purchaseOrderNumber != null && dataItem.purchaseOrderNumber != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER] = dataItem.purchaseOrderNumber;
}
if (dataItem.quotationNumber != null && dataItem.quotationNumber != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER] = dataItem.quotationNumber;
}
if (dataItem.isFinanceRequired != null && dataItem.isFinanceRequired != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED] = dataItem.isFinanceRequired;
}
if (dataItem.financeBy != null && dataItem.financeBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY] = dataItem.financeBy;
}
if (dataItem.financeRemarks != null && dataItem.financeRemarks != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS] = dataItem.financeRemarks;
}
if (dataItem.isApprovalRequired != null && dataItem.isApprovalRequired != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED] = dataItem.isApprovalRequired;
}
if (dataItem.parentOpportunityID != null && dataItem.parentOpportunityID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID] = dataItem.parentOpportunityID;
}
if (dataItem.isRecurringOpportunity != null && dataItem.isRecurringOpportunity != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY] = dataItem.isRecurringOpportunity;
}
if (dataItem.recurrenceIntervalInDays != null && dataItem.recurrenceIntervalInDays != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS] = dataItem.recurrenceIntervalInDays;
}
if (dataItem.recurrenceCount != null && dataItem.recurrenceCount != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT] = dataItem.recurrenceCount;
}
if (dataItem.recurringOpportunityID != null && dataItem.recurringOpportunityID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID] = dataItem.recurringOpportunityID;
}

         
            //if (dataItem.getRecurringOpportunityName() != null && !dataItem.getRecurringOpportunityName().equals("null"))
            //    values.put(ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME, dataItem.getRecurringOpportunityName());
            
          if (dataItem.dateGeneratedForRecurring != null && dataItem.dateGeneratedForRecurring != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING] = dataItem.dateGeneratedForRecurring;
}
if (dataItem.opportunityAssignmentID != null && dataItem.opportunityAssignmentID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID] = dataItem.opportunityAssignmentID;
}
if (dataItem.supplierAccountID != null && dataItem.supplierAccountID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID] = dataItem.supplierAccountID;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_TAGS] = dataItem.tags;
}
if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1] = dataItem.freeTextField1;
}
if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2] = dataItem.freeTextField2;
}
if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3] = dataItem.freeTextField3;
}
if (dataItem.isAssigned != null && dataItem.isAssigned != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED] = dataItem.isAssigned;
}
if (dataItem.assignedDate != null && dataItem.assignedDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE] = dataItem.assignedDate;
}
if (dataItem.assignedByAppUserID != null && dataItem.assignedByAppUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID] = dataItem.assignedByAppUserID;
}
if (dataItem.assignmentRemarks != null && dataItem.assignmentRemarks != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS] = dataItem.assignmentRemarks;
}
if (dataItem.opportunityFulfillmentStatus != null && dataItem.opportunityFulfillmentStatus != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS] = dataItem.opportunityFulfillmentStatus;
}
if (dataItem.isOpportunityFulfilled != null && dataItem.isOpportunityFulfilled != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED] = dataItem.isOpportunityFulfilled;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isWonAlerted != null && dataItem.isWonAlerted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED] = dataItem.isWonAlerted;
}
if (dataItem.isNewAlerted != null && dataItem.isNewAlerted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED] = dataItem.isNewAlerted;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isLocked != null && dataItem.isLocked != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED] = dataItem.isLocked;
}
if (dataItem.isApproved != null && dataItem.isApproved != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED] = dataItem.isApproved;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.leadQualificationID != null && dataItem.leadQualificationID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID] = dataItem.leadQualificationID;
}
if (dataItem.workFlowDetails != null && dataItem.workFlowDetails != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS] = dataItem.workFlowDetails;
}

           if (dataItem.id != null && dataItem.id != "null") {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}
if (dataItem.isDirty != null && dataItem.isDirty != "null") {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}
if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}
if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}
if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}


            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE]  = "true";
            values[ColumnsBase.KEY_ISDELETED] =  "false";

            id = await db.insert(TablesBase.TABLE_OPPORTUNITY, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddOpportunityRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateOpportunityRecord(DatabaseHandler databaseHandler,   String id1, Opportunity dataItem) async {
        int id = 0;
        try {
            final db =  await databaseHandler.database;
           
Map<String, dynamic> values = {};
if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID] = dataItem.opportunityID;
if (dataItem.opportunityCode != null && dataItem.opportunityCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYCODE] = dataItem.opportunityCode;
if (dataItem.opportunityName != null && dataItem.opportunityName != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME] = dataItem.opportunityName;
if (dataItem.assignmentDetails != null && dataItem.assignmentDetails != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTDETAILS] = dataItem.assignmentDetails;
if (dataItem.opportunityDetail != null && dataItem.opportunityDetail != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYDETAIL] = dataItem.opportunityDetail;
if (dataItem.leadSource != null && dataItem.leadSource != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_LEADSOURCE] = dataItem.leadSource;
if (dataItem.opportunityTypeID != null && dataItem.opportunityTypeID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID] = dataItem.opportunityTypeID;
if (dataItem.accountID != null && dataItem.accountID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID] = dataItem.accountID;
if (dataItem.contactID != null && dataItem.contactID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CONTACTID] = dataItem.contactID;
if (dataItem.opportunityMeasure != null && dataItem.opportunityMeasure != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYMEASURE] = dataItem.opportunityMeasure;
if (dataItem.opportunityValue != null && dataItem.opportunityValue != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYVALUE] = dataItem.opportunityValue;
if (dataItem.currencyID != null && dataItem.currencyID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CURRENCYID] = dataItem.currencyID;
if (dataItem.grossProfit != null && dataItem.grossProfit != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_GROSSPROFIT] = dataItem.grossProfit;
if (dataItem.dealRegistrationNumber != null && dataItem.dealRegistrationNumber != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_DEALREGISTRATIONNUMBER] = dataItem.dealRegistrationNumber;
if (dataItem.closureDate != null && dataItem.closureDate != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_CLOSUREDATE] = dataItem.closureDate;
if (dataItem.probability != null && dataItem.probability != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_PROBABILITY] = dataItem.probability;
if (dataItem.opportunityPriorityID != null && dataItem.opportunityPriorityID != "null")
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID] = dataItem.opportunityPriorityID;
            
           if (dataItem.opportunityStageID != null && dataItem.opportunityStageID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID] = dataItem.opportunityStageID;
}
if (dataItem.opportunityStatusID != null && dataItem.opportunityStatusID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID] = dataItem.opportunityStatusID;
}
if (dataItem.actualOpportunityValue != null && dataItem.actualOpportunityValue != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ACTUALOPPORTUNITYVALUE] = dataItem.actualOpportunityValue;
}

if (dataItem.lostToCompetitor != null && dataItem.lostToCompetitor != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_LOSTTOCOMPETITOR] = dataItem.lostToCompetitor;
}
if (dataItem.reasonForOpportunityStatus != null && dataItem.reasonForOpportunityStatus != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REASONFOROPPORTUNITYSTATUS] = dataItem.reasonForOpportunityStatus;
}

if (dataItem.plannedDeliveryDate != null && dataItem.plannedDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PLANNEDDELIVERYDATE] = dataItem.plannedDeliveryDate;
}
if (dataItem.actualDeliveryDate != null && dataItem.actualDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ACTUALDELIVERYDATE] = dataItem.actualDeliveryDate;
}
if (dataItem.requestedDeliveryDate != null && dataItem.requestedDeliveryDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REQUESTEDDELIVERYDATE] = dataItem.requestedDeliveryDate;
}
if (dataItem.currentActionOwner != null && dataItem.currentActionOwner != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CURRENTACTIONOWNER] = dataItem.currentActionOwner;
}
if (dataItem.customerCallID != null && dataItem.customerCallID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERCALLID] = dataItem.customerCallID;
}
if (dataItem.customerSatisfactionID != null && dataItem.customerSatisfactionID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CUSTOMERSATISFACTIONID] = dataItem.customerSatisfactionID;
}
if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.opportunityIdentifier != null && dataItem.opportunityIdentifier != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYIDENTIFIER] = dataItem.opportunityIdentifier;
}
if (dataItem.purchaseOrderNumber != null && dataItem.purchaseOrderNumber != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PURCHASEORDERNUMBER] = dataItem.purchaseOrderNumber;
}
if (dataItem.quotationNumber != null && dataItem.quotationNumber != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_QUOTATIONNUMBER] = dataItem.quotationNumber;
}
if (dataItem.isFinanceRequired != null && dataItem.isFinanceRequired != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISFINANCEREQUIRED] = dataItem.isFinanceRequired;
}
if (dataItem.financeBy != null && dataItem.financeBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FINANCEBY] = dataItem.financeBy;
}
if (dataItem.financeRemarks != null && dataItem.financeRemarks != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FINANCEREMARKS] = dataItem.financeRemarks;
}
if (dataItem.isApprovalRequired != null && dataItem.isApprovalRequired != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVALREQUIRED] = dataItem.isApprovalRequired;
}
if (dataItem.parentOpportunityID != null && dataItem.parentOpportunityID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID] = dataItem.parentOpportunityID;
}
if (dataItem.isRecurringOpportunity != null && dataItem.isRecurringOpportunity != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISRECURRINGOPPORTUNITY] = dataItem.isRecurringOpportunity;
}
if (dataItem.recurrenceIntervalInDays != null && dataItem.recurrenceIntervalInDays != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRENCEINTERVALINDAYS] = dataItem.recurrenceIntervalInDays;
}
if (dataItem.recurrenceCount != null && dataItem.recurrenceCount != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRENCECOUNT] = dataItem.recurrenceCount;
}
if (dataItem.recurringOpportunityID != null && dataItem.recurringOpportunityID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID] = dataItem.recurringOpportunityID;
}

         
            //if (dataItem.getRecurringOpportunityName() != null && !dataItem.getRecurringOpportunityName().equals("null"))
            //    values.put(ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME, dataItem.getRecurringOpportunityName());
            
          if (dataItem.dateGeneratedForRecurring != null && dataItem.dateGeneratedForRecurring != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_DATEGENERATEDFORRECURRING] = dataItem.dateGeneratedForRecurring;
}
if (dataItem.opportunityAssignmentID != null && dataItem.opportunityAssignmentID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYASSIGNMENTID] = dataItem.opportunityAssignmentID;
}
if (dataItem.supplierAccountID != null && dataItem.supplierAccountID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID] = dataItem.supplierAccountID;
}
if (dataItem.tags != null && dataItem.tags != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_TAGS] = dataItem.tags;
}
if (dataItem.freeTextField1 != null && dataItem.freeTextField1 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD1] = dataItem.freeTextField1;
}
if (dataItem.freeTextField2 != null && dataItem.freeTextField2 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD2] = dataItem.freeTextField2;
}
if (dataItem.freeTextField3 != null && dataItem.freeTextField3 != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_FREETEXTFIELD3] = dataItem.freeTextField3;
}
if (dataItem.isAssigned != null && dataItem.isAssigned != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISASSIGNED] = dataItem.isAssigned;
}
if (dataItem.assignedDate != null && dataItem.assignedDate != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDDATE] = dataItem.assignedDate;
}
if (dataItem.assignedByAppUserID != null && dataItem.assignedByAppUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNEDBYAPPUSERID] = dataItem.assignedByAppUserID;
}
if (dataItem.assignmentRemarks != null && dataItem.assignmentRemarks != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ASSIGNMENTREMARKS] = dataItem.assignmentRemarks;
}
if (dataItem.opportunityFulfillmentStatus != null && dataItem.opportunityFulfillmentStatus != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYFULFILLMENTSTATUS] = dataItem.opportunityFulfillmentStatus;
}
if (dataItem.isOpportunityFulfilled != null && dataItem.isOpportunityFulfilled != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISOPPORTUNITYFULFILLED] = dataItem.isOpportunityFulfilled;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isWonAlerted != null && dataItem.isWonAlerted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISWONALERTED] = dataItem.isWonAlerted;
}
if (dataItem.isNewAlerted != null && dataItem.isNewAlerted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISNEWALERTED] = dataItem.isNewAlerted;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isLocked != null && dataItem.isLocked != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISLOCKED] = dataItem.isLocked;
}
if (dataItem.isApproved != null && dataItem.isApproved != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISAPPROVED] = dataItem.isApproved;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.leadQualificationID != null && dataItem.leadQualificationID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_LEADQUALIFICATIONID] = dataItem.leadQualificationID;
}
if (dataItem.workFlowDetails != null && dataItem.workFlowDetails != "null") {
  values[ColumnsBase.KEY_OPPORTUNITY_WORKFLOWDETAILS] = dataItem.workFlowDetails;
}

           if (dataItem.id != null && dataItem.id != "null") {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}
if (dataItem.isDirty != null && dataItem.isDirty != "null") {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}
if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}
if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}
if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}

            id = await db.update(TablesBase.TABLE_OPPORTUNITY, values, where : ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateOpportunityRecord()", ex);
            throw ex;
        }
        return id;
    }


     static Future<int> DeleteOpportunityRecord(DatabaseHandler databaseHandler,   String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_OPPORTUNITY, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteOpportunityRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,   String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

            final  db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID];
            }
           
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,   String id) async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID + " = " + id;

            final  db =  await databaseHandler.database;  
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Opportunity>> GetOpportunityUpSyncRecords(DatabaseHandler databaseHandler,   String changeType)async {
        List<Opportunity> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " IN (SELECT  " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_ACCOUNT + " WHERE CAST(COALESCE(" + ColumnsBase.KEY_ACCOUNT_ACCOUNTID + ",'0') AS long) > 0)";

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
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<Opportunity?> GetOpportunityRecordByUid(DatabaseHandler databaseHandler,   String uid) async{
        Opportunity ?dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",L." + ColumnsBase.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME + ",B." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + ",F." + ColumnsBase.KEY_CONTACT_CONTACTNAME + ",G." + ColumnsBase.KEY_CURRENCY_CURRENCYNAME + ",I." + ColumnsBase.KEY_OPPORTUNITYPRIORITY_OPPORTUNITYPRIORITYNAME + ",J." + ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + ",K." + ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + ",M." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYNAME + ",N." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME + " AS " + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYNAME + ",O." + ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME + " AS " + Columns.KEY_ACCOUNT_SUPPLIERACCOUNTNAME;
            selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITY + " A ";
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " B ON A." + ColumnsBase.KEY_OPPORTUNITY_ACCOUNTID + " = B." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CONTACT + " F ON A." + ColumnsBase.KEY_OPPORTUNITY_CONTACTID + " = F." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_CURRENCY + " G ON A." + ColumnsBase.KEY_OPPORTUNITY_CURRENCYID + " = G." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYPRIORITY + " I ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYPRIORITYID + " = I." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTAGE + " J ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTAGEID + " = J." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYSTATUS + " K ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYSTATUSID + " = K." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITYTYPE + " L ON A." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYTYPEID + " = L." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " M ON A." + ColumnsBase.KEY_OPPORTUNITY_PARENTOPPORTUNITYID + " = M." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " N ON A." + ColumnsBase.KEY_OPPORTUNITY_RECURRINGOPPORTUNITYID + " = N." + ColumnsBase.KEY_ID;
            selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACCOUNT + " O ON A." + ColumnsBase.KEY_OPPORTUNITY_SUPPLIERACCOUNTID + " = O." + ColumnsBase.KEY_ID;
            selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITY_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
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
            Globals.handleException( "OpportunityDataHandlerBase:GetOpportunityRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}