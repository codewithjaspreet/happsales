
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityStatus.dart';
import '../DataBaseHandler.dart';

class OpportunityStatusDataHandlerBase {

     static Future<List<OpportunityStatus>> GetOpportunityStatusRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async {
        List<OpportunityStatus> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityStatus_ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<OpportunityStatus>> GetOpportunityStatusRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<OpportunityStatus> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY COALESCE(A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER},1)";

        

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<OpportunityStatus?> GetOpportunityStatusRecord(DatabaseHandler databaseHandler,  String id) async {
        OpportunityStatus ?dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<OpportunityStatus?> GetMasterOpportunityStatusRecord(DatabaseHandler databaseHandler,  String id) async {
        OpportunityStatus? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetMasterOpportunityStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddOpportunityStatusRecord(DatabaseHandler databaseHandler,  OpportunityStatus dataItem) async {
        int id = 0;
        try {
          
          final db = await databaseHandler.database;
Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.opportunityStatusID != null && dataItem.opportunityStatusID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID] = dataItem.opportunityStatusID;
  }
  if (dataItem.opportunityStatusCode != null && dataItem.opportunityStatusCode != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE] = dataItem.opportunityStatusCode;
  }
  if (dataItem.opportunityStatusName != null && dataItem.opportunityStatusName != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME] = dataItem.opportunityStatusName;
  }
  if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER] = dataItem.sequentialOrder;
  }
  if (dataItem.probability != null && dataItem.probability != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY] = dataItem.probability;
  }
  if (dataItem.indicator != null && dataItem.indicator != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR] = dataItem.indicator;
  }
  if (dataItem.internalCode != null && dataItem.internalCode != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE] = dataItem.internalCode;
  }
  if (dataItem.workflowStageID != null && dataItem.workflowStageID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID] = dataItem.workflowStageID;
  }
  if (dataItem.createdOn != null && dataItem.createdOn != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON] = dataItem.createdOn;
  }
  if (dataItem.createdBy != null && dataItem.createdBy != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY] = dataItem.createdBy;
  }
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON] = dataItem.modifiedOn;
  }
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
  }
  if (dataItem.isActive != null && dataItem.isActive != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE] = dataItem.isActive;
  }
  if (dataItem.uid != null && dataItem.uid != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID] = dataItem.uid;
  }
  if (dataItem.appUserID != null && dataItem.appUserID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID] = dataItem.appUserID;
  }
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
  }
  if (dataItem.isArchived != null && dataItem.isArchived != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISARCHIVED] = dataItem.isArchived;
  }
  if (dataItem.isDeleted != null && dataItem.isDeleted != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED] = dataItem.isDeleted;
  }
  if (dataItem.id != null && dataItem.id != 'null') {
    values[ColumnsBase.KEY_ID] = dataItem.id;
  }
  if (dataItem.isDirty != null && dataItem.isDirty != 'null') {
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  }
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != 'null') {
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  }
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != 'null') {
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  }
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != 'null') {
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  }
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != 'null') {
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  }
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != 'null') {
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  }
  if (dataItem.createdByUser != null && dataItem.createdByUser != 'null') {
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  }
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != 'null') {
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  }
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != 'null') {
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
  }

  values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
  values[ColumnsBase.KEY_ISACTIVE] = 'true';
  values[ColumnsBase.KEY_ISDELETED] = 'false';

   id = await db.insert(TablesBase.TABLE_OPPORTUNITYSTATUS, values);
  return id;
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddOpportunityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateOpportunityStatusRecord(DatabaseHandler databaseHandler,  String id1, OpportunityStatus dataItem) async {
        int id = 0;
        try {
              final db = await databaseHandler.database;

Map<String, dynamic> values = Map<String, dynamic>();

  if (dataItem.opportunityStatusID != null && dataItem.opportunityStatusID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID] = dataItem.opportunityStatusID;
  }
  if (dataItem.opportunityStatusCode != null && dataItem.opportunityStatusCode != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE] = dataItem.opportunityStatusCode;
  }
  if (dataItem.opportunityStatusName != null && dataItem.opportunityStatusName != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME] = dataItem.opportunityStatusName;
  }
  if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER] = dataItem.sequentialOrder;
  }
  if (dataItem.probability != null && dataItem.probability != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY] = dataItem.probability;
  }
  if (dataItem.indicator != null && dataItem.indicator != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR] = dataItem.indicator;
  }
  if (dataItem.internalCode != null && dataItem.internalCode != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE] = dataItem.internalCode;
  }
  if (dataItem.workflowStageID != null && dataItem.workflowStageID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID] = dataItem.workflowStageID;
  }
  if (dataItem.createdOn != null && dataItem.createdOn != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON] = dataItem.createdOn;
  }
  if (dataItem.createdBy != null && dataItem.createdBy != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY] = dataItem.createdBy;
  }
  if (dataItem.modifiedOn != null && dataItem.modifiedOn != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON] = dataItem.modifiedOn;
  }
  if (dataItem.modifiedBy != null && dataItem.modifiedBy != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
  }
  if (dataItem.isActive != null && dataItem.isActive != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE] = dataItem.isActive;
  }
  if (dataItem.uid != null && dataItem.uid != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID] = dataItem.uid;
  }
  if (dataItem.appUserID != null && dataItem.appUserID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID] = dataItem.appUserID;
  }
  if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
  }
  if (dataItem.isArchived != null && dataItem.isArchived != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISARCHIVED] = dataItem.isArchived;
  }
  if (dataItem.isDeleted != null && dataItem.isDeleted != 'null') {
    values[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED] = dataItem.isDeleted;
  }
  if (dataItem.id != null && dataItem.id != 'null') {
    values[ColumnsBase.KEY_ID] = dataItem.id;
  }
  if (dataItem.isDirty != null && dataItem.isDirty != 'null') {
    values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
  }
  if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != 'null') {
    values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
  }
  if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != 'null') {
    values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
  }
  if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != 'null') {
    values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
  }
  if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != 'null') {
    values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
  }
  if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != 'null') {
    values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
  }
  if (dataItem.createdByUser != null && dataItem.createdByUser != 'null') {
    values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
  }
  if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != 'null') {
    values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
  }
  if (dataItem.ownerUserID != null && dataItem.ownerUserID != 'null') {
    values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
  }
            
            if(dataItem.upSyncIndex != null && dataItem.upSyncIndex != 'null'){
                values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
            }

            id =await  db.update(TablesBase.TABLE_OPPORTUNITYSTATUS, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateOpportunityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteOpportunityStatusRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id =  await db.delete(TablesBase.TABLE_OPPORTUNITYSTATUS, where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteOpportunityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await  databaseHandler.database;
            List <Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID].toString();
            }
          
        } catch ( ex) {
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID} = $id";

            final db =await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<OpportunityStatus>> GetOpportunityStatusUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async {
        List<OpportunityStatus> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityStatusDataHandlerBase:GetOpportunityStatusUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<OpportunityStatus?> GetOpportunityStatusRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        OpportunityStatus? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYSTATUS} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYSTATUS_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

            

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    OpportunityStatus dataItem = new OpportunityStatus();

                    dataItem.opportunityStatusID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSID];
                    dataItem.opportunityStatusCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSCODE];
                    dataItem.opportunityStatusName = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_OPPORTUNITYSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_SEQUENTIALORDER];
                    dataItem.probability = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_PROBABILITY];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_INTERNALCODE];
                    dataItem.workflowStageID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_WORKFLOWSTAGEID];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_MODIFIEDBY];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISDELETED];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_ISACTIVE];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_APPUSERID];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYSTATUS_UID];

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
        }
        catch( ex)
        {
	    Globals.handleException( "OpportunityStatusDataHandlerBase:GetOpportunityStatusRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}