
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityFulfillmentStatus.dart';
import '../DataBaseHandler.dart';

class OpportunityFulfillmentStatusDataHandlerBase {

     static Future<List<OpportunityFulfillmentStatus>> GetOpportunityFulfillmentStatusRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<OpportunityFulfillmentStatus> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityFulfillmentStatus_Columns.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";

            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetOpportunityFulfillmentStatusRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<OpportunityFulfillmentStatus>> GetOpportunityFulfillmentStatusRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<OpportunityFulfillmentStatus> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME} COLLATE NOCASE ASC ";

          
            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetOpportunityFulfillmentStatusRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<OpportunityFulfillmentStatus?> GetOpportunityFulfillmentStatusRecord(DatabaseHandler databaseHandler,  String id)async {
        OpportunityFulfillmentStatus? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

        
            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetOpportunityFulfillmentStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<OpportunityFulfillmentStatus?> GetMasterOpportunityFulfillmentStatusRecord(DatabaseHandler databaseHandler,  String id) async{
        OpportunityFulfillmentStatus? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
            final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetMasterOpportunityFulfillmentStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddOpportunityFulfillmentStatusRecord(DatabaseHandler databaseHandler,  OpportunityFulfillmentStatus dataItem) async{
        int id = 0;
        try {
             final db = await databaseHandler.database;
            Map<String,dynamic> values = Map();
           if (dataItem.opportunityFulfillmentStatusID != null && dataItem.opportunityFulfillmentStatusID != "null") {
             values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID] = dataItem.opportunityFulfillmentStatusID;
           }
if (dataItem.opportunityFulfillmentStatusCode != null && dataItem.opportunityFulfillmentStatusCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE] = dataItem.opportunityFulfillmentStatusCode;
}
if (dataItem.opportunityFulfillmentStatusName != null && dataItem.opportunityFulfillmentStatusName != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME] = dataItem.opportunityFulfillmentStatusName;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.indicator != null && dataItem.indicator != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR] = dataItem.indicator;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED] = dataItem.isDeleted;
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

            values [ColumnsBase.KEY_UPSYNCINDEX] = 0;
            values[ColumnsBase.KEY_ISACTIVE] =  "true";
            values[ColumnsBase.KEY_ISDELETED] = "false";

            id = await db.insert(TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddOpportunityFulfillmentStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateOpportunityFulfillmentStatusRecord(DatabaseHandler databaseHandler,  String id1, OpportunityFulfillmentStatus dataItem)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String,dynamic> values = Map();
           if (dataItem.opportunityFulfillmentStatusID != null && dataItem.opportunityFulfillmentStatusID != "null") {
             values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID] = dataItem.opportunityFulfillmentStatusID;
           }
if (dataItem.opportunityFulfillmentStatusCode != null && dataItem.opportunityFulfillmentStatusCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE] = dataItem.opportunityFulfillmentStatusCode;
}
if (dataItem.opportunityFulfillmentStatusName != null && dataItem.opportunityFulfillmentStatusName != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME] = dataItem.opportunityFulfillmentStatusName;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.indicator != null && dataItem.indicator != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR] = dataItem.indicator;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED] = dataItem.isDeleted;
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

            id =await  db.update(TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateOpportunityFulfillmentStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteOpportunityFulfillmentStatusRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS,where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteOpportunityFulfillmentStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

               final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ID].toString();
            }
        } catch ( ex) {
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID} = $id";

            final db = await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);
            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }

            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<OpportunityFulfillmentStatus>> GetOpportunityFulfillmentStatusUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<OpportunityFulfillmentStatus> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

              final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
            Globals.handleException( "OpportunityFulfillmentStatusDataHandlerBase:GetOpportunityFulfillmentStatusUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<OpportunityFulfillmentStatus?> GetOpportunityFulfillmentStatusRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        OpportunityFulfillmentStatus ?dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYFULFILLMENTSTATUS} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

               final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
                    OpportunityFulfillmentStatus dataItem = new OpportunityFulfillmentStatus();
                    dataItem.opportunityFulfillmentStatusID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSID];
                    dataItem.opportunityFulfillmentStatusCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSCODE];
                    dataItem.opportunityFulfillmentStatusName = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_OPPORTUNITYFULFILLMENTSTATUSNAME];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_SEQUENTIALORDER];
                    dataItem.indicator = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INDICATOR];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_INTERNALCODE];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYFULFILLMENTSTATUS_ISARCHIVED];
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
	    Globals.handleException("OpportunityFulfillmentStatusDataHandlerBase:GetOpportunityFulfillmentStatusRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}