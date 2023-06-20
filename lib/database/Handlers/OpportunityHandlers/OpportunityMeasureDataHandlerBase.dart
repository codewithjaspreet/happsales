

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityMeasure.dart';
import '../DataBaseHandler.dart';

class OpportunityMeasureDataHandlerBase {

     static Future<List<OpportunityMeasure>> GetOpportunityMeasureRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<OpportunityMeasure> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().isNotEmpty) {
              selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME} LIKE '%${searchString.replaceAll("'","''")}%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityMeasure_Columns.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetOpportunityMeasureRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<OpportunityMeasure>> GetOpportunityMeasureRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<OpportunityMeasure> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().isNotEmpty) {
              selectQuery += "${" AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME} LIKE '${searchString.replaceAll("'","''")}"}%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME} COLLATE NOCASE ASC ";

           
            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetOpportunityMeasureRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<OpportunityMeasure?> GetOpportunityMeasureRecord(DatabaseHandler databaseHandler,  String id)async {
        OpportunityMeasure? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetOpportunityMeasureRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<OpportunityMeasure?> GetMasterOpportunityMeasureRecord(DatabaseHandler databaseHandler,  String id) async{
        OpportunityMeasure? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetMasterOpportunityMeasureRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddOpportunityMeasureRecord(DatabaseHandler databaseHandler,  OpportunityMeasure dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
           if (dataItem.opportunityMeasureID != null && dataItem.opportunityMeasureID != "null") {
             values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID] = dataItem.opportunityMeasureID;
           }
if (dataItem.opportunityMeasureCode != null && dataItem.opportunityMeasureCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE] = dataItem.opportunityMeasureCode;
}
if (dataItem.opportunityMeasureName != null && dataItem.opportunityMeasureName != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME] = dataItem.opportunityMeasureName;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.isDefault != null && dataItem.isDefault != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT] = dataItem.isDefault;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED] = dataItem.isDeleted;
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
values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.insert(TablesBase.TABLE_OPPORTUNITYMEASURE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddOpportunityMeasureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateOpportunityMeasureRecord(DatabaseHandler databaseHandler,  String id1, OpportunityMeasure dataItem) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
      Map<String, dynamic> values = new Map();
           if (dataItem.opportunityMeasureID != null && dataItem.opportunityMeasureID != "null") {
             values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID] = dataItem.opportunityMeasureID;
           }
if (dataItem.opportunityMeasureCode != null && dataItem.opportunityMeasureCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE] = dataItem.opportunityMeasureCode;
}
if (dataItem.opportunityMeasureName != null && dataItem.opportunityMeasureName != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME] = dataItem.opportunityMeasureName;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.isDefault != null && dataItem.isDefault != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT] = dataItem.isDefault;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED] = dataItem.isDeleted;
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
values[ColumnsBase.KEY_UPSYNCINDEX] = 0;
values[ColumnsBase.KEY_ISACTIVE] = "true";
values[ColumnsBase.KEY_ISDELETED] = "false";


            id = await db.update(TablesBase.TABLE_OPPORTUNITYMEASURE, values,where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateOpportunityMeasureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteOpportunityMeasureRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_OPPORTUNITYMEASURE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteOpportunityMeasureRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map  <String, dynamic>> result = await db.rawQuery(selectQuery, null);
            
            if (result.isNotEmpty) {
                serverId = result[0]["${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID}"].toString();
            }
        } catch ( ex) {
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID} = $id";

              final db = await databaseHandler.database;
            List<Map  <String, dynamic>> result = await db.rawQuery(selectQuery, null);
            
            if (result.isNotEmpty) {
                localId = result[0]["${ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID}"].toString();
            }

          
        } catch ( ex) {
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<OpportunityMeasure>> GetOpportunityMeasureUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<OpportunityMeasure> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
            Globals.handleException( "OpportunityMeasureDataHandlerBase:GetOpportunityMeasureUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<OpportunityMeasure?> GetOpportunityMeasureRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        OpportunityMeasure? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_OPPORTUNITYMEASURE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_OPPORTUNITYMEASURE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

           
            final db = await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){
                    OpportunityMeasure dataItem = new OpportunityMeasure();

                    dataItem.opportunityMeasureID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASUREID];
                    dataItem.opportunityMeasureCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURECODE];
                    dataItem.opportunityMeasureName = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_OPPORTUNITYMEASURENAME];
                    dataItem.internalCode = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_INTERNALCODE];
                    dataItem.isDefault = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDEFAULT];
                    dataItem.sequentialOrder = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_SEQUENTIALORDER];
                    dataItem.createdOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_MODIFIEDBY];
                    dataItem.uid = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_APPUSERGROUPID];
                    dataItem.isActive = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_OPPORTUNITYMEASURE_ISARCHIVED];
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
	    Globals.handleException( "OpportunityMeasureDataHandlerBase:GetOpportunityMeasureRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}