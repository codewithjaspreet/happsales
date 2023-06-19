
 import 'package:happsales_crm/database/AppConstants.dart';

import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityPriority.dart';
import '../DataBaseHandler.dart';

class ActivityPriorityDataHandlerBase {

     static Future<List<ActivityPriority>> GetActivityPriorityRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize)async {
        List<ActivityPriority> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME + " LIKE '%" + searchString + "%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_ActivityPriority_Columns.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
            selectQuery += " LIMIT " + startRowIndex.toString() + "," + pageSize.toString();

            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetActivityPriorityRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<ActivityPriority>> GetActivityPriorityRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<ActivityPriority> dataList = [];
        try {
            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED + ",'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE + ",'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME + " LIKE '" + searchString + "%'";
            selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER;

            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetActivityPriorityRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<ActivityPriority?> GetActivityPriorityRecord(DatabaseHandler databaseHandler,  String id) async{
        ActivityPriority? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetActivityPriorityRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<ActivityPriority?> GetMasterActivityPriorityRecord(DatabaseHandler databaseHandler,  String id) async{
        ActivityPriority? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID + " = " + id;
            selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

       
            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetMasterActivityPriorityRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddActivityPriorityRecord(DatabaseHandler databaseHandler,  ActivityPriority dataItem)async {
        int id = 0;
        try {
          final db = await databaseHandler.database;
          Map<String,dynamic> values= Map();
            if (dataItem.activityPriorityID != null && dataItem.activityPriorityID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID] = dataItem.activityPriorityID;
if (dataItem.activityPriorityCode != null && dataItem.activityPriorityCode != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE] = dataItem.activityPriorityCode;
if (dataItem.activityPriorityName != null && dataItem.activityPriorityName != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME] = dataItem.activityPriorityName;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION] = dataItem.description;
if (dataItem.isDefault != null && dataItem.isDefault != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT] = dataItem.isDefault;
if (dataItem.priorityOrder != null && dataItem.priorityOrder != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER] = dataItem.priorityOrder;
if (dataItem.alertOnScheduleSlippage != null && dataItem.alertOnScheduleSlippage != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE] = dataItem.alertOnScheduleSlippage;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED] = dataItem.isDeleted;

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


            id = await db.insert(TablesBase.TABLE_ACTIVITYPRIORITY, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddActivityPriorityRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateActivityPriorityRecord(DatabaseHandler databaseHandler,  String id1, ActivityPriority dataItem)async {
        int id = 0;
        try {
             final db = await databaseHandler.database;
          Map<String,dynamic> values= Map();
            if (dataItem.activityPriorityID != null && dataItem.activityPriorityID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID] = dataItem.activityPriorityID;
if (dataItem.activityPriorityCode != null && dataItem.activityPriorityCode != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE] = dataItem.activityPriorityCode;
if (dataItem.activityPriorityName != null && dataItem.activityPriorityName != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME] = dataItem.activityPriorityName;
if (dataItem.description != null && dataItem.description != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION] = dataItem.description;
if (dataItem.isDefault != null && dataItem.isDefault != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT] = dataItem.isDefault;
if (dataItem.priorityOrder != null && dataItem.priorityOrder != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER] = dataItem.priorityOrder;
if (dataItem.alertOnScheduleSlippage != null && dataItem.alertOnScheduleSlippage != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE] = dataItem.alertOnScheduleSlippage;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON] = dataItem.createdOn;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY] = dataItem.createdBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.isActive != null && dataItem.isActive != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
  values[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED] = dataItem.isDeleted;

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

            id = await db.update(TablesBase.TABLE_ACTIVITYPRIORITY, values, where : ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateActivityPriorityRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteActivityPriorityRecord(DatabaseHandler databaseHandler,  String id1) async{
        int id = 0;
        try {
             final db = await databaseHandler.database;
            id = await db.delete(TablesBase.TABLE_ACTIVITYPRIORITY, where: ColumnsBase.KEY_ID + " = " + id1, whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteActivityPriorityRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id)async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

            final db = await databaseHandler.database;
           
           List<Map<String,dynamic> > result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_ID];
            }
        } catch ( ex) {
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID + " = " + id;


           final db = await databaseHandler.database;
           
           List<Map<String,dynamic> > result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<ActivityPriority>> GetActivityPriorityUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) async{
        List<ActivityPriority> dataList = [];
        try {
            String selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            if (changeType ==(AppConstants.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            } else if (changeType == (AppConstants.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex.toString();
            }
            selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

           
            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetActivityPriorityUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<ActivityPriority?> GetActivityPriorityRecordByUid(DatabaseHandler databaseHandler,  String uid)async {
        ActivityPriority? dataItem;
        try {

            String selectQuery = "SELECT A.* ";
            selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
            selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYPRIORITY_UID + " = '" + uid + "'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

          
            final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {

                    ActivityPriority dataItem = new ActivityPriority();
                    dataItem.activityPriorityID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
                    dataItem.activityPriorityCode = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
                    dataItem.activityPriorityName = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
                    dataItem.description = element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
                    dataItem.isDefault = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
                    dataItem.priorityOrder = element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
                    dataItem.alertOnScheduleSlippage = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
                    dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
                    dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

                    dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
                    dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
                    dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
            Globals.handleException( "ActivityPriorityDataHandlerBase:GetActivityPriorityRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}