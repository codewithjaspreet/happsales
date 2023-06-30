
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUserType.dart';
import '../DataBaseHandler.dart';

class AppUserTypeDataHandlerBase {

     static Future<List<AppUserType>> GetAppUserTypeRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppUserType> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTYPE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUserType_Columns.KEY_APPUSERTYPE_APPUSERTYPENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";
 
 
          final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetAppUserTypeRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUserType>> GetAppUserTypeRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<AppUserType> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTYPE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSERTYPE_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME} COLLATE NOCASE ASC ";

         
          final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetAppUserTypeRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUserType?> GetAppUserTypeRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUserType? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

           
          final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetAppUserTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUserType?> GetMasterAppUserTypeRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUserType? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

            
          final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetMasterAppUserTypeRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserTypeRecord(DatabaseHandler databaseHandler,  AppUserType dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserTypeID != null && dataItem.appUserTypeID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID] = dataItem.appUserTypeID;
}
if (dataItem.appUserTypeCode != null && dataItem.appUserTypeCode != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE] = dataItem.appUserTypeCode;
}
if (dataItem.appUserTypeName != null && dataItem.appUserTypeName != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME] = dataItem.appUserTypeName;
}
if (dataItem.isExternalUser != null && dataItem.isExternalUser != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER] = dataItem.isExternalUser;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISDELETED] = dataItem.isDeleted;
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

            id =  await db.insert(TablesBase.TABLE_APPUSERTYPE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserTypeRecord(DatabaseHandler databaseHandler,  String id1, AppUserType dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.appUserTypeID != null && dataItem.appUserTypeID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID] = dataItem.appUserTypeID;
}
if (dataItem.appUserTypeCode != null && dataItem.appUserTypeCode != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE] = dataItem.appUserTypeCode;
}
if (dataItem.appUserTypeName != null && dataItem.appUserTypeName != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME] = dataItem.appUserTypeName;
}
if (dataItem.isExternalUser != null && dataItem.isExternalUser != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER] = dataItem.isExternalUser;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSERTYPE_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_APPUSERTYPE, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserTypeRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPUSERTYPE, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserTypeRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";


   final db = await  databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID].toString();
            }
        } catch ( ex) {
            Globals.handleException( "AppUserTypeDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID} = $id";

            final db = await  databaseHandler.database;
            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "AppUserTypeDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUserType>> GetAppUserTypeUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppUserType> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSERTYPE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetAppUserTypeUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<AppUserType?> GetAppUserTypeRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        AppUserType ?dataItem ;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSERTYPE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSERTYPE_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

            final db = await  databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){

                AppUserType dataItem = new AppUserType();

                dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPEID];
                dataItem.appUserTypeCode = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPECODE];
                dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];
                dataItem.isExternalUser = element[ColumnsBase.KEY_APPUSERTYPE_ISEXTERNALUSER];
                dataItem.createdBy = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDBY];
                dataItem.createdOn = element[ColumnsBase.KEY_APPUSERTYPE_CREATEDON];
                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDBY];
                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSERTYPE_MODIFIEDON];
                dataItem.isActive = element[ColumnsBase.KEY_APPUSERTYPE_ISACTIVE];
                dataItem.uid = element[ColumnsBase.KEY_APPUSERTYPE_UID];
                dataItem.appUserID  = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERID];
                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERGROUPID];
                dataItem.isDeleted  = element[ColumnsBase.KEY_APPUSERTYPE_ISDELETED];
                
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
            Globals.handleException( "AppUserTypeDataHandlerBase:GetAppUserTypeRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}