

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityStage.dart';
import '../DataBaseHandler.dart';

class OpportunityStageDataHandlerBase {

     static Future<List<OpportunityStage>> GetOpportunityStageRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<OpportunityStage> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityStage_ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db =  await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetOpportunityStageRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<OpportunityStage>> GetOpportunityStageRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<OpportunityStage> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY CAST(COALESCE(A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER},1) AS INTEGER)";

   final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetOpportunityStageRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<OpportunityStage?> GetOpportunityStageRecord(DatabaseHandler databaseHandler,  String id) async{
        OpportunityStage? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetOpportunityStageRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<OpportunityStage?> GetMasterOpportunityStageRecord(DatabaseHandler databaseHandler,  String id) async{
        OpportunityStage? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

              final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetMasterOpportunityStageRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddOpportunityStageRecord(DatabaseHandler databaseHandler,  OpportunityStage dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String,dynamic> values  = Map();
            if (dataItem.opportunityStageID != null && dataItem.opportunityStageID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID] = dataItem.opportunityStageID;
if (dataItem.opportunityStageCode != null && dataItem.opportunityStageCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE] = dataItem.opportunityStageCode;
if (dataItem.opportunityStageName != null && dataItem.opportunityStageName != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME] = dataItem.opportunityStageName;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION] = dataItem.description;
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER] = dataItem.sequentialOrder;
if (dataItem.isPipeline != null && dataItem.isPipeline != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE] = dataItem.isPipeline;
if (dataItem.probability != null && dataItem.probability != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY] = dataItem.probability;
if (dataItem.indicator != null && dataItem.indicator != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR] = dataItem.indicator;
if (dataItem.stagnantAlertDays != null && dataItem.stagnantAlertDays != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS] = dataItem.stagnantAlertDays;
if (dataItem.workflowStageID != null && dataItem.workflowStageID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID] = dataItem.workflowStageID;
if (dataItem.workflowStageName != null && dataItem.workflowStageName != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME] = dataItem.workflowStageName;
if (dataItem.alertMessage != null && dataItem.alertMessage != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE] = dataItem.alertMessage;
if (dataItem.opportunityStageType != null && dataItem.opportunityStageType != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE] = dataItem.opportunityStageType;
if (dataItem.actionOnSelection != null && dataItem.actionOnSelection != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION] = dataItem.actionOnSelection;
if (dataItem.internalCode != null && dataItem.internalCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE] = dataItem.internalCode;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED] = dataItem.isDeleted;
if (dataItem.id != null && dataItem.id != "null")
  values[ColumnsBase.KEY_ID] = dataItem.id;
if (dataItem.isDirty != null && dataItem.isDirty != "null")
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
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


            id = await db.insert(TablesBase.TABLE_OPPORTUNITYSTAGE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddOpportunityStageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateOpportunityStageRecord(DatabaseHandler databaseHandler,  String id1, OpportunityStage dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String,dynamic> values  = Map();
            if (dataItem.opportunityStageID != null && dataItem.opportunityStageID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID] = dataItem.opportunityStageID;
if (dataItem.opportunityStageCode != null && dataItem.opportunityStageCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE] = dataItem.opportunityStageCode;
if (dataItem.opportunityStageName != null && dataItem.opportunityStageName != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME] = dataItem.opportunityStageName;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION] = dataItem.description;
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER] = dataItem.sequentialOrder;
if (dataItem.isPipeline != null && dataItem.isPipeline != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE] = dataItem.isPipeline;
if (dataItem.probability != null && dataItem.probability != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY] = dataItem.probability;
if (dataItem.indicator != null && dataItem.indicator != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR] = dataItem.indicator;
if (dataItem.stagnantAlertDays != null && dataItem.stagnantAlertDays != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS] = dataItem.stagnantAlertDays;
if (dataItem.workflowStageID != null && dataItem.workflowStageID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID] = dataItem.workflowStageID;
if (dataItem.workflowStageName != null && dataItem.workflowStageName != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME] = dataItem.workflowStageName;
if (dataItem.alertMessage != null && dataItem.alertMessage != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE] = dataItem.alertMessage;
if (dataItem.opportunityStageType != null && dataItem.opportunityStageType != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE] = dataItem.opportunityStageType;
if (dataItem.actionOnSelection != null && dataItem.actionOnSelection != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION] = dataItem.actionOnSelection;
if (dataItem.internalCode != null && dataItem.internalCode != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE] = dataItem.internalCode;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED] = dataItem.isDeleted;
if (dataItem.id != null && dataItem.id != "null")
  values[ColumnsBase.KEY_ID] = dataItem.id;
if (dataItem.isDirty != null && dataItem.isDirty != "null")
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null")
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null")
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null")
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

            id = await  db.update(TablesBase.TABLE_OPPORTUNITYSTAGE, values,where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateOpportunityStageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteOpportunityStageRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_OPPORTUNITYSTAGE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteOpportunityStageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

           final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0]["${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID}"].toString();
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityStageDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0]["${ColumnsBase.KEY_ID}"].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "OpportunityStageDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<OpportunityStage>> GetOpportunityStageUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<OpportunityStage> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYSTAGE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYSTAGE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND ${ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
   final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetOpportunityStageUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<OpportunityStage?> GetOpportunityStageRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        OpportunityStage? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTAGE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

              final db =await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                    OpportunityStage dataItem = new OpportunityStage();
                    dataItem.opportunityStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGEID];
                    dataItem.opportunityStageCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGECODE];
                    dataItem.opportunityStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGENAME];

                    dataItem.description = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_DESCRIPTION];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_SEQUENTIALORDER];
                    dataItem.isPipeline = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISPIPELINE];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INDICATOR];
                    dataItem.stagnantAlertDays = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_STAGNANTALERTDAYS];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGEID];
                    dataItem.alertMessage = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ALERTMESSAGE];
                    dataItem.opportunityStageType = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_OPPORTUNITYSTAGETYPE];
                    dataItem.actionOnSelection = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ACTIONONSELECTION];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_UID];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_ISDELETED];
                    dataItem.workflowStageName = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_WORKFLOWSTAGENAME];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTAGE_APPUSERGROUPID];
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
            Globals.handleException( "OpportunityStageDataHandlerBase:GetOpportunityStageRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/
}