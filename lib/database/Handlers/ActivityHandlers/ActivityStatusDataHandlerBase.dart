

 import '../../AppConstants.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityStatus.dart';
import '../DataBaseHandler.dart';

class ActivityStatusDataHandlerBase {

     static Future<List<ActivityStatus>> GetActivityStatusRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<ActivityStatus> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length> 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityStatus_Columns.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
            Globals.handleException( "ActivityStatusDataHandlerBase:GetActivityStatusRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityStatus>> GetActivityStatusRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<ActivityStatus> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP},'false')) = 'true'";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY CAST(COALESCE(A.${ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE},100) AS INTEGER) ASC";

           
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
            Globals.handleException( "ActivityStatusDataHandlerBase:GetActivityStatusRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityStatus?> GetActivityStatusRecord(DatabaseHandler databaseHandler,  String id)async {
        ActivityStatus? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

           
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
            Globals.handleException( "ActivityStatusDataHandlerBase:GetActivityStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityStatus?> GetMasterActivityStatusRecord(DatabaseHandler databaseHandler,  String id)async {
        ActivityStatus? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ActivityStatusDataHandlerBase:GetMasterActivityStatusRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityStatusRecord(DatabaseHandler databaseHandler,  ActivityStatus dataItem)async {
        int id = 0;
        try {
          final db  =await databaseHandler.database;
          Map<String,dynamic> values = Map();
          if (dataItem.activityStatusID != null && dataItem.activityStatusID != "null") {
            values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID] = dataItem.activityStatusID;
          }
if (dataItem.activityStatusCode != null && dataItem.activityStatusCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE] = dataItem.activityStatusCode;
}
if (dataItem.activityStatusName != null && dataItem.activityStatusName != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME] = dataItem.activityStatusName;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED] = dataItem.isDeleted;
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

id = await db.insert(TablesBase.TABLE_ACTIVITYSTATUS, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityStatusRecord(DatabaseHandler databaseHandler,  String id1, ActivityStatus dataItem)async {
        int id = 0;
        try {
          final db  =await databaseHandler.database;
          Map<String,dynamic> values = Map();
          if (dataItem.activityStatusID != null && dataItem.activityStatusID != "null") {
            values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID] = dataItem.activityStatusID;
          }
if (dataItem.activityStatusCode != null && dataItem.activityStatusCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE] = dataItem.activityStatusCode;
}
if (dataItem.activityStatusName != null && dataItem.activityStatusName != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME] = dataItem.activityStatusName;
}
if (dataItem.internalCode != null && dataItem.internalCode != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE] = dataItem.internalCode;
}
if (dataItem.displayInApp != null && dataItem.displayInApp != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP] = dataItem.displayInApp;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_ACTIVITYSTATUS, values, where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteActivityStatusRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
          final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACTIVITYSTATUS, where : "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteActivityStatusRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
            }

           
        } catch ( ex) {
            Globals.handleException( "ActivityStatusDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID} = $id";

           final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
            }
        } catch ( ex) {
            Globals.handleException( "ActivityStatusDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ActivityStatus>> GetActivityStatusUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<ActivityStatus> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_ACTIVITYSTATUS} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
            Globals.handleException( "ActivityStatusDataHandlerBase:GetActivityStatusUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<ActivityStatus?> GetActivityStatusRecordByUid(DatabaseHandler databaseHandler,  String uid)async{
        ActivityStatus? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITYSTATUS_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            
            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                                  ActivityStatus dataItem = new ActivityStatus();
                                  dataItem.activityStatusID = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
                                  dataItem.activityStatusCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
                                  dataItem.activityStatusName = element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
                                  dataItem.internalCode = element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
                                  dataItem.displayInApp = element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
                                  dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
                                  dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
                                  dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
                                  dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
                                  dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
                                  dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
                                  dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
                                  dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
	    Globals.handleException( "ActivityStatusDataHandlerBase:GetActivityStatusRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}