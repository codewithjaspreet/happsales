

 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppReport.dart';
import '../DataBaseHandler.dart';

class AppReportDataHandlerBase {

     static Future<List<AppReport>> GetAppReportRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<AppReport> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} LIKE '%$searchString%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_AppReport_Columns.KEY_APPREPORT_APPREPORTNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT $startRowIndex"},$pageSize";


            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetAppReportRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppReport>> GetAppReportRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AppReport> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPREPORT_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} LIKE '$searchString%'";
            }
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPREPORT_APPREPORTNAME} COLLATE NOCASE ASC ";

            
            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetAppReportRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppReport?> GetAppReportRecord(DatabaseHandler databaseHandler,  String id) async{
        AppReport? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetAppReportRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppReport?> GetMasterAppReportRecord(DatabaseHandler databaseHandler,  String id)async {
        AppReport? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPREPORT_APPREPORTID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

          
            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetMasterAppReportRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppReportRecord(DatabaseHandler databaseHandler,  AppReport dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String,dynamic> values = Map();
            
if (dataItem.appReportID != null && dataItem.appReportID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTID] = dataItem.appReportID;
}
if (dataItem.appReportCode != null && dataItem.appReportCode != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTCODE] = dataItem.appReportCode;
}
if (dataItem.appReportName != null && dataItem.appReportName != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTNAME] = dataItem.appReportName;
}
if (dataItem.appReportPath != null && dataItem.appReportPath != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTPATH] = dataItem.appReportPath;
}
if (dataItem.appReportType != null && dataItem.appReportType != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE] = dataItem.appReportType;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPREPORT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPREPORT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPREPORT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPREPORT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPREPORT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISDELETED] = dataItem.isDeleted;
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
            values[ColumnsBase.KEY_ISDELETED]  = "false";

            id = await db.insert(TablesBase.TABLE_APPREPORT, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppReportRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppReportRecord(DatabaseHandler databaseHandler,  String id1, AppReport dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};

if (dataItem.appReportID != null && dataItem.appReportID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTID] = dataItem.appReportID;
}
if (dataItem.appReportCode != null && dataItem.appReportCode != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTCODE] = dataItem.appReportCode;
}
if (dataItem.appReportName != null && dataItem.appReportName != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTNAME] = dataItem.appReportName;
}
if (dataItem.appReportPath != null && dataItem.appReportPath != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTPATH] = dataItem.appReportPath;
}
if (dataItem.appReportType != null && dataItem.appReportType != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE] = dataItem.appReportType;
}
if (dataItem.sequentialOrder != null && dataItem.sequentialOrder != "null") {
  values[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER] = dataItem.sequentialOrder;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPREPORT_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPREPORT_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPREPORT_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPREPORT_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPREPORT_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPREPORT_ISDELETED] = dataItem.isDeleted;
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

            id = await db.update(TablesBase.TABLE_APPREPORT, values,where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppReportRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppReportRecord(DatabaseHandler databaseHandler,  String id1)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_APPREPORT, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppReportRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPREPORT_APPREPORTID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPREPORT_APPREPORTID].toString();
            }
           
        } catch ( ex) {
            Globals.handleException( "AppReportDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPREPORT_APPREPORTID} = $id";

            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0]["${ColumnsBase.KEY_ID}"].toString();
            }
            
        } catch ( ex) {
            Globals.handleException( "AppReportDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppReport>> GetAppReportUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppReport> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPREPORT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPREPORT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'false'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPREPORT} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_ISDELETED} = 'true'  AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            }
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPREPORT_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
            Globals.handleException( "AppReportDataHandlerBase:GetAppReportUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<AppReport?> GetAppReportRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        AppReport? dataItem;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM ${TablesBase.TABLE_APPREPORT} A "; 
			selectQuery += " WHERE A.${ColumnsBase.KEY_APPREPORT_UID} = '$uid'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_APPREPORT_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString;

           
            final db =await  databaseHandler.database;
            List<Map> list = await db.rawQuery(selectQuery, null);

            for(var element in list ){
                    AppReport dataItem = new AppReport();

                    dataItem.appReportID = element[ColumnsBase.KEY_APPREPORT_APPREPORTID];

                    dataItem.appReportCode = element[ColumnsBase.KEY_APPREPORT_APPREPORTCODE];

                    dataItem.appReportName = element[ColumnsBase.KEY_APPREPORT_APPREPORTNAME];

                    dataItem.appReportPath = element[ColumnsBase.KEY_APPREPORT_APPREPORTPATH];


                    dataItem.appReportType = element[ColumnsBase.KEY_APPREPORT_APPREPORTTYPE];

                    dataItem.sequentialOrder = element[ColumnsBase.KEY_APPREPORT_SEQUENTIALORDER];

                    dataItem.createdOn = element[ColumnsBase.KEY_APPREPORT_CREATEDON];

                    dataItem.createdBy = element[ColumnsBase.KEY_APPREPORT_CREATEDBY];

                    dataItem.modifiedOn = element[ColumnsBase.KEY_APPREPORT_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_APPREPORT_MODIFIEDBY];

                    dataItem.isActive = element[ColumnsBase.KEY_APPREPORT_ISACTIVE];

                    dataItem.isDeleted = element[ColumnsBase.KEY_APPREPORT_ISDELETED];  

                    dataItem.uid = element[ColumnsBase.KEY_APPREPORT_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_APPREPORT_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_APPREPORT_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_APPREPORT_ISARCHIVED];

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
	    Globals.handleException( "AppReportDataHandlerBase:GetAppReportRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}