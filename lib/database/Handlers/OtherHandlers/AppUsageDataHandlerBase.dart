

 import 'package:happsales_crm/database/AppConstants.dart';
import 'package:happsales_crm/view/menu/items/accounts/add_account.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUsage.dart';
import '../DataBaseHandler.dart';

class AppUsageDataHandlerBase {

     static Future<List<AppUsage>> GetAppUsageRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppUsage> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSAGENAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUsage_Columns.KEY_APPUSAGE_APPUSAGENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


            final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
            Globals.handleException( "AppUsageDataHandlerBase:GetAppUsageRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUsage>> GetAppUsageRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<AppUsage> dataList =[];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSAGE_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSAGENAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSAGE_APPUSAGENAME} COLLATE NOCASE ASC ";

              final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
            Globals.handleException( "AppUsageDataHandlerBase:GetAppUsageRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUsage?> GetAppUsageRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUsage? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
            Globals.handleException( "AppUsageDataHandlerBase:GetAppUsageRecords()", ex);
            throw ex;
        }
        return dataItem;
     
        }


     static Future<AppUsage?> GetMasterAppUsageRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUsage? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSAGE_APPUSAGEID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

             final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
            Globals.handleException( "AppUsageDataHandlerBase:GetMasterAppUsageRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

      Future<int> AddAppUsageRecord(DatabaseHandler databaseHandler,  AppUsage dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUsageID != null && dataItem.appUsageID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGEID] = dataItem.appUsageID;
}
if (dataItem.appUsageCode != null && dataItem.appUsageCode != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE] = dataItem.appUsageCode;
}
if (dataItem.appUsageName != null && dataItem.appUsageName != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME] = dataItem.appUsageName;
}
if (dataItem.usageCount != null && dataItem.usageCount != "null") {
  values[ColumnsBase.KEY_APPUSAGE_USAGECOUNT] = dataItem.usageCount;
}
if (dataItem.operatingSystem != null && dataItem.operatingSystem != "null") {
  values[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM] = dataItem.operatingSystem;
}
if (dataItem.operatingSystemVersion != null && dataItem.operatingSystemVersion != "null") {
  values[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION] = dataItem.operatingSystemVersion;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSAGE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSAGE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSAGE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSAGE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSAGE_ISDELETED] = dataItem.isDeleted;
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


            id = await db.insert(TablesBase.TABLE_APPUSAGE, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUsageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUsageRecord(DatabaseHandler databaseHandler,  String id1, AppUsage dataItem)async{
        int id = 0;
        try {
             final db = await  databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appUsageID != null && dataItem.appUsageID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGEID] = dataItem.appUsageID;
}
if (dataItem.appUsageCode != null && dataItem.appUsageCode != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE] = dataItem.appUsageCode;
}
if (dataItem.appUsageName != null && dataItem.appUsageName != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME] = dataItem.appUsageName;
}
if (dataItem.usageCount != null && dataItem.usageCount != "null") {
  values[ColumnsBase.KEY_APPUSAGE_USAGECOUNT] = dataItem.usageCount;
}
if (dataItem.operatingSystem != null && dataItem.operatingSystem != "null") {
  values[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM] = dataItem.operatingSystem;
}
if (dataItem.operatingSystemVersion != null && dataItem.operatingSystemVersion != "null") {
  values[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION] = dataItem.operatingSystemVersion;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSAGE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSAGE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSAGE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSAGE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSAGE_ISDELETED] = dataItem.isDeleted;
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
            id = await db.update(TablesBase.TABLE_APPUSAGE, values,  where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUsageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUsageRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db =await  databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_APPUSAGE, where: "${ColumnsBase.KEY_ID} = $id1",whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUsageRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSAGE_APPUSAGEID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;
            List<Map  <String, dynamic>> result = await db.rawQuery(selectQuery, null);


            if (result != null && result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSAGE_APPUSAGEID].toString();
            }
        } catch ( ex) {
            Globals.handleException( "AppUsageDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSAGE_APPUSAGEID} = $id";

            final db = await  databaseHandler.database;

            List<Map  <String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result != null && result.isNotEmpty) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "AppUsageDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUsage>> GetAppUsageUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppUsage> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSAGE} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
            Globals.handleException( "AppUsageDataHandlerBase:GetAppUsageUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppUsage?> GetAppUsageRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AppUsage? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_APPUSAGE} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSAGE_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
			//selectQuery += " AND A." + ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
final db =await databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list){

                AppUsage dataItem = new AppUsage();
                dataItem.appUsageID = element[ColumnsBase.KEY_APPUSAGE_APPUSAGEID];

                dataItem.appUsageCode = element[ColumnsBase.KEY_APPUSAGE_APPUSAGECODE];

                dataItem.appUsageName = element[ColumnsBase.KEY_APPUSAGE_APPUSAGENAME];

                dataItem.usageCount = element[ColumnsBase.KEY_APPUSAGE_USAGECOUNT];

                dataItem.operatingSystem = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEM];

                dataItem.operatingSystemVersion = element[ColumnsBase.KEY_APPUSAGE_OPERATINGSYSTEMVERSION];

                dataItem.createdBy = element[ColumnsBase.KEY_APPUSAGE_CREATEDBY];

                dataItem.createdOn = element[ColumnsBase.KEY_APPUSAGE_CREATEDON];

                dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDBY];

                dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSAGE_MODIFIEDON];

                dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSAGE_DEVICEIDENTIFIER];

                dataItem.uid = element[ColumnsBase.KEY_APPUSAGE_UID];

                dataItem.appUserID = element[ColumnsBase.KEY_APPUSAGE_APPUSERID];

                dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSAGE_APPUSERGROUPID];

                dataItem.isDeleted = element[ColumnsBase.KEY_APPUSAGE_ISDELETED];

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
	    Globals.handleException( "AppUsageDataHandlerBase:GetAppUsageRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/
}