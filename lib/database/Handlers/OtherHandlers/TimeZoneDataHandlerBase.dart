
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/TimeZone.dart';
import '../DataBaseHandler.dart';

class TimeZoneDataHandlerBase {

     static Future<List<TimeZone>> GetTimeZoneRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<TimeZone> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_TIMEZONENAME + " LIKE '%" + searchString + "%'";
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
				selectQuery += " AND A." + ColumnsBase.KEY_TimeZone_Columns.KEY_TIMEZONE_TIMEZONENAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();


final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];


                    dataList.add(dataItem);

      }
           
            //db.close();
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetTimeZoneRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<TimeZone>> GetTimeZoneRecords(DatabaseHandler databaseHandler,  String searchString)async {
        List<TimeZone> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISACTIVE + ",'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_TIMEZONE_ISARCHIVED + ",'false')) = 'false' ";
            if (searchString.trim().length > 0) {
              selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_TIMEZONENAME + " LIKE '" + searchString + "%'";
            }
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_TIMEZONE_TIMEZONENAME + " COLLATE NOCASE ASC ";

           
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];


                    dataList.add(dataItem);

      }
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetTimeZoneRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<TimeZone?> GetTimeZoneRecord(DatabaseHandler databaseHandler,  String id) async {
        TimeZone? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
			selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetTimeZoneRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<TimeZone?> GetMasterTimeZoneRecord(DatabaseHandler databaseHandler,  String id) async{
        TimeZone? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_TIMEZONE_TIMEZONEID + " = " + id;
			selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetMasterTimeZoneRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddTimeZoneRecord(DatabaseHandler databaseHandler,  TimeZone dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.timeZoneID != null && dataItem.timeZoneID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONEID] = dataItem.timeZoneID;
}
if (dataItem.timeZoneCode != null && dataItem.timeZoneCode != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE] = dataItem.timeZoneCode;
}
if (dataItem.timeZoneName != null && dataItem.timeZoneName != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME] = dataItem.timeZoneName;
}
if (dataItem.gmtOffSet != null && dataItem.gmtOffSet != "null") {
  values[ColumnsBase.KEY_TIMEZONE_GMTOFFSET] = dataItem.gmtOffSet;
}
if (dataItem.gmtOffSetInMinutes != null && dataItem.gmtOffSetInMinutes != "null") {
  values[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES] = dataItem.gmtOffSetInMinutes;
}
if (dataItem.serverRelativeOffSet != null && dataItem.serverRelativeOffSet != "null") {
  values[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET] = dataItem.serverRelativeOffSet;
}
if (dataItem.dstCorrection != null && dataItem.dstCorrection != "null") {
  values[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION] = dataItem.dstCorrection;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_TIMEZONE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_TIMEZONE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_TIMEZONE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_TIMEZONE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISDELETED] = dataItem.isDeleted;
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

int id = await db.insert(TablesBase.TABLE_TIMEZONE, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddTimeZoneRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateTimeZoneRecord(DatabaseHandler databaseHandler,  String id1, TimeZone dataItem) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
           Map<String, dynamic> values = {};
if (dataItem.timeZoneID != null && dataItem.timeZoneID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONEID] = dataItem.timeZoneID;
}
if (dataItem.timeZoneCode != null && dataItem.timeZoneCode != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE] = dataItem.timeZoneCode;
}
if (dataItem.timeZoneName != null && dataItem.timeZoneName != "null") {
  values[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME] = dataItem.timeZoneName;
}
if (dataItem.gmtOffSet != null && dataItem.gmtOffSet != "null") {
  values[ColumnsBase.KEY_TIMEZONE_GMTOFFSET] = dataItem.gmtOffSet;
}
if (dataItem.gmtOffSetInMinutes != null && dataItem.gmtOffSetInMinutes != "null") {
  values[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES] = dataItem.gmtOffSetInMinutes;
}
if (dataItem.serverRelativeOffSet != null && dataItem.serverRelativeOffSet != "null") {
  values[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET] = dataItem.serverRelativeOffSet;
}
if (dataItem.dstCorrection != null && dataItem.dstCorrection != "null") {
  values[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION] = dataItem.dstCorrection;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_TIMEZONE_CREATEDON] = dataItem.createdOn;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_TIMEZONE_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_TIMEZONE_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_TIMEZONE_UID] = dataItem.uid;
}
if (dataItem.appUserID != null && dataItem.appUserID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_APPUSERID] = dataItem.appUserID;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_TIMEZONE_ISDELETED] = dataItem.isDeleted;
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
}if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}

 id = await db.update(
  TablesBase.TABLE_TIMEZONE,
  values,
  where : "${ColumnsBase.KEY_ID} = $id1",
  whereArgs: null,
);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateTimeZoneRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteTimeZoneRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_TIMEZONE, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteTimeZoneRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_TIMEZONE_TIMEZONEID;
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

             final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
            }
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_TIMEZONE_TIMEZONEID + " = " + id;

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
            
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<TimeZone>> GetTimeZoneUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<TimeZone> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_TIMEZONE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            if (changeType == (AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_TIMEZONE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_TIMEZONE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            }
			selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			selectQuery += " AND " + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
          
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];

dataList.add(dataItem);

      }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "TimeZoneDataHandlerBase:GetTimeZoneUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


	  static Future<TimeZone?> GetTimeZoneRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        TimeZone ?dataItem ;
        try
        {

			String selectQuery = 	"SELECT A.* " ;
		selectQuery += " FROM " + TablesBase.TABLE_TIMEZONE + " A "; 
			selectQuery += " WHERE A."  + ColumnsBase.KEY_TIMEZONE_UID + " = '" + uid + "'";
			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
			//selectQuery += " AND A." + ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

          
final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    TimeZone dataItem = new TimeZone();
                    dataItem.timeZoneID = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONEID];
                    dataItem.timeZoneCode = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONECODE];
                    dataItem.timeZoneName = ele[ColumnsBase.KEY_TIMEZONE_TIMEZONENAME];
                    dataItem.gmtOffSet = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSET];

                    dataItem.gmtOffSetInMinutes = ele[ColumnsBase.KEY_TIMEZONE_GMTOFFSETINMINUTES];
                    dataItem.serverRelativeOffSet = ele[ColumnsBase.KEY_TIMEZONE_SERVERRELATIVEOFFSET];
                    dataItem.dstCorrection = ele[ColumnsBase.KEY_TIMEZONE_DSTCORRECTION];
                    dataItem.createdOn = ele[ColumnsBase.KEY_TIMEZONE_CREATEDON];
                    dataItem.createdBy = ele[ColumnsBase.KEY_TIMEZONE_CREATEDBY];

                    dataItem.modifiedOn = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_TIMEZONE_MODIFIEDBY];
                    dataItem.isDeleted = ele[ColumnsBase.KEY_TIMEZONE_ISDELETED];
                    dataItem.isActive = ele[ColumnsBase.KEY_TIMEZONE_ISACTIVE];
                    dataItem.isArchived = ele[ColumnsBase.KEY_TIMEZONE_ISARCHIVED];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_TIMEZONE_APPUSERID];
                    dataItem.uid = ele[ColumnsBase.KEY_TIMEZONE_UID];

                       dataItem.id = ele[ColumnsBase.KEY_ID];
        dataItem.isDirty = ele[ColumnsBase.KEY_ISDIRTY];
        dataItem.isDeleted1 = ele[ColumnsBase.KEY_ISDELETED];
        dataItem.upSyncMessage = ele[ColumnsBase.KEY_UPSYNCMESSAGE];

        dataItem.downSyncMessage = ele[ColumnsBase.KEY_DOWNSYNCMESSAGE];
        dataItem.sCreatedOn = ele[ColumnsBase.KEY_SCREATEDON];
        dataItem.sModifiedOn = ele[ColumnsBase.KEY_SMODIFIEDON];

        dataItem.createdByUser = ele[ColumnsBase.KEY_CREATEDBYUSER];
        dataItem.modifiedByUser = ele[ColumnsBase.KEY_MODIFIEDBYUSER];
        dataItem.ownerUserID = ele[ColumnsBase.KEY_OWNERUSERID];



      }
        }
        catch( ex)
        {
	    Globals.handleException( "TimeZoneDataHandlerBase:GetTimeZoneRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}