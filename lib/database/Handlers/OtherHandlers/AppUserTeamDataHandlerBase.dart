

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserTeam.dart';
import '../DataBaseHandler.dart';

class AppUserTeamDataHandlerBase {

     static Future<List<AppUserTeam>> GetAppUserTeamRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<AppUserTeam> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length> 0)
                selectQuery += "${" AND A." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME + " LIKE '%" + searchString.replaceAll("'","''")}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserTeam_Columns.KEY_APPUSERTEAM_APPUSERTEAMNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
            Globals.handleException( "AppUserTeamDataHandlerBase:GetAppUserTeamRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserTeam>> GetAppUserTeamRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<AppUserTeam> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME} LIKE '${searchString.replaceAll("'","''")}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME} COLLATE NOCASE ASC ";

            

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
            Globals.handleException( "AppUserTeamDataHandlerBase:GetAppUserTeamRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserTeam?> GetAppUserTeamRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUserTeam? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

           

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
            Globals.handleException( "AppUserTeamDataHandlerBase:GetAppUserTeamRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserTeam?> GetMasterAppUserTeamRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUserTeam? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID} = $id";
			selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
			selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

          

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
            Globals.handleException( "AppUserTeamDataHandlerBase:GetMasterAppUserTeamRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserTeamRecord(DatabaseHandler databaseHandler,  AppUserTeam dataItem) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserTeamID != null && dataItem.appUserTeamID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID] = dataItem.appUserTeamID;
}
if (dataItem.appUserTeamCode != null && dataItem.appUserTeamCode != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE] = dataItem.appUserTeamCode;
}
if (dataItem.appUserTeamName != null && dataItem.appUserTeamName != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME] = dataItem.appUserTeamName;
}
if (dataItem.appUserTeamDescription != null && dataItem.appUserTeamDescription != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION] = dataItem.appUserTeamDescription;
}
if (dataItem.teamLeadAppUserID != null && dataItem.teamLeadAppUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID] = dataItem.teamLeadAppUserID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERID] = dataItem.appUserID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISDELETED] = dataItem.isDeleted;
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

            id =  await db.insert(TablesBase.TABLE_APPUSERTEAM, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserTeamRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserTeamRecord(DatabaseHandler databaseHandler,  String id1, AppUserTeam dataItem)async {
        int id = 0;
        try {
            final db = await  databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUserTeamID != null && dataItem.appUserTeamID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID] = dataItem.appUserTeamID;
}
if (dataItem.appUserTeamCode != null && dataItem.appUserTeamCode != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE] = dataItem.appUserTeamCode;
}
if (dataItem.appUserTeamName != null && dataItem.appUserTeamName != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME] = dataItem.appUserTeamName;
}
if (dataItem.appUserTeamDescription != null && dataItem.appUserTeamDescription != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION] = dataItem.appUserTeamDescription;
}
if (dataItem.teamLeadAppUserID != null && dataItem.teamLeadAppUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID] = dataItem.teamLeadAppUserID;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_APPUSERID] = dataItem.appUserID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERTEAM_ISDELETED] = dataItem.isDeleted;
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
            id =  await db.update(TablesBase.TABLE_APPUSERTEAM, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserTeamRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserTeamRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPUSERTEAM, where:  "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserTeamRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =  await databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID].toString();
            }
          
        } catch ( ex) {
            Globals.handleException( "AppUserTeamDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "AppUserTeamDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserTeam>> GetAppUserTeamUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppUserTeam> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType ==(AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTEAM} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
			selectQuery += " AND ${ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
            Globals.handleException( "AppUserTeamDataHandlerBase:GetAppUserTeamUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUserTeam?> GetAppUserTeamRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AppUserTeam? dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_APPUSERTEAM} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAM_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            

 final db = await databaseHandler.database;
            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    AppUserTeam dataItem = new AppUserTeam();

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMID];
                    dataItem.appUserTeamCode = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMCODE];
                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];
                    dataItem.appUserTeamDescription = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMDESCRIPTION];
                    dataItem.teamLeadAppUserID = element[ColumnsBase.KEY_APPUSERTEAM_TEAMLEADAPPUSERID];
                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAM_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAM_MODIFIEDON];
                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAM_ISACTIVE];
                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAM_ISDELETED];
                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAM_ISARCHIVED];
                    dataItem.uid  = element[ColumnsBase.KEY_APPUSERTEAM_UID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERGROUPID];
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERID];
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
	    Globals.handleException( "AppUserTeamDataHandlerBase:GetAppUserTeamRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}