

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserTeamMember.dart';
import '../DataBaseHandler.dart';

class AppUserTeamMemberDataHandlerBase {

     static Future<List<AppUserTeamMember>> GetAppUserTeamMemberRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppUserTeamMember> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_APPUSERTEAM}"} D ON A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE} LIKE '%${searchString.replaceAll("'","''")}"}%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserTeamMember_Columns.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";

  final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                  AppUserTeamMember  dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetAppUserTeamMemberRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserTeamMember>> GetAppUserTeamMemberRecords(DatabaseHandler databaseHandler, String searchString)async {
        List<AppUserTeamMember> dataList =[];
        try {
            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_APPUSERTEAM}"} D ON A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += "${" AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE} LIKE '${searchString.replaceAll("'","''")}"}%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE} COLLATE NOCASE ASC ";

           final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                  AppUserTeamMember  dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetAppUserTeamMemberRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserTeamMember?> GetAppUserTeamMemberRecord(DatabaseHandler databaseHandler, String id)async {
        AppUserTeamMember? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_APPUSERTEAM}"} D ON A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetAppUserTeamMemberRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserTeamMember?> GetMasterAppUserTeamMemberRecord(DatabaseHandler databaseHandler, String id) async{
        AppUserTeamMember? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME;
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_APPUSERTEAM}"} D ON A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} = D.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                    dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetMasterAppUserTeamMemberRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserTeamMemberRecord(DatabaseHandler databaseHandler, AppUserTeamMember dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserTeamMemberID != null && dataItem.appUserTeamMemberID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID] = dataItem.appUserTeamMemberID;
if (dataItem.appUserTeamMemberCode != null && dataItem.appUserTeamMemberCode != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE] = dataItem.appUserTeamMemberCode;
if (dataItem.appUserTeamID != null && dataItem.appUserTeamID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID] = dataItem.appUserTeamID;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID] = dataItem.appUserID;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID] = dataItem.uid;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE] = dataItem.isActive;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_APPUSERTEAMMEMBER, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserTeamMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserTeamMemberRecord(DatabaseHandler databaseHandler, String id1, AppUserTeamMember dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserTeamMemberID != null && dataItem.appUserTeamMemberID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID] = dataItem.appUserTeamMemberID;
if (dataItem.appUserTeamMemberCode != null && dataItem.appUserTeamMemberCode != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE] = dataItem.appUserTeamMemberCode;
if (dataItem.appUserTeamID != null && dataItem.appUserTeamID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID] = dataItem.appUserTeamID;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID] = dataItem.appUserID;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID] = dataItem.uid;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isArchived != null && dataItem.isArchived != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED] = dataItem.isArchived;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE] = dataItem.isActive;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED] = dataItem.isDeleted;
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
            id = await  db.update(TablesBase.TABLE_APPUSERTEAMMEMBER, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserTeamMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserTeamMemberRecord(DatabaseHandler databaseHandler, String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPUSERTEAMMEMBER, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserTeamMemberRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler, String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];
            }
          
        } catch ( ex) {
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler, String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID} = $id";

           final db =await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }

           
        } catch ( ex) {
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserTeamMember>> GetAppUserTeamMemberUpSyncRecords(DatabaseHandler databaseHandler, String changeType) async{
        List<AppUserTeamMember> dataList =[];
        try {
            String selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_APPUSERTEAMMEMBER} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_APPUSERTEAMMEMBER} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "${"SELECT * FROM " + TablesBase.TABLE_APPUSERTEAMMEMBER} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                  AppUserTeamMember  dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
            Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetAppUserTeamMemberUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUserTeamMember?> GetAppUserTeamMemberRecordByUid(DatabaseHandler databaseHandler, String uid) async{
        AppUserTeamMember? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* "  + ",D." + ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME;
		selectQuery += "${" FROM ${TablesBase.TABLE_APPUSERTEAMMEMBER}"} A "; 
		selectQuery += "${" LEFT JOIN ${TablesBase.TABLE_APPUSERTEAM}"} D ON A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID} = D.${ColumnsBase.KEY_ID}";
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTEAMMEMBER_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

         
          final db =  await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                  AppUserTeamMember  dataItem = new AppUserTeamMember();

                    dataItem.appUserTeamMemberID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERID];

                    dataItem.appUserTeamMemberCode = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMMEMBERCODE];

                    dataItem.appUserTeamID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERTEAMID];
                    
                    dataItem.appUserID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERID];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDBY];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_CREATEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_MODIFIEDON];

                    dataItem.uid = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_UID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISARCHIVED];

                    dataItem.isActive = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPUSERTEAMMEMBER_ISDELETED];

                    dataItem.appUserTeamName = element[ColumnsBase.KEY_APPUSERTEAM_APPUSERTEAMNAME];

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
	    Globals.handleException( "AppUserTeamMemberDataHandlerBase:GetAppUserTeamMemberRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}