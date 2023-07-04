
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Reminder.dart';
import '../DataBaseHandler.dart';

class ReminderDataHandlerBase {

     static Future<List<Reminder>> GetReminderRecordsPaged(DatabaseHandler databaseHandler, String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<Reminder> dataList = [];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_REMINDERTITLE} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_Reminder_Columns.KEY_REMINDER_REMINDERTITLE + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += "${" LIMIT " + startRowIndex.toString()},$pageSize";



 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Reminder>> GetReminderRecords(DatabaseHandler databaseHandler, String searchString) async{
        List<Reminder> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISACTIVE},'true')) = 'true' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_REMINDERTITLE} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_REMINDER_REMINDERTITLE} COLLATE NOCASE ASC ";

           


 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<Reminder>> GetReminderRecordsForTheDay(DatabaseHandler databaseHandler, String dateString)async {
        List<Reminder> dataList = [];
        try {
            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_REMINDER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND date(${ColumnsBase.KEY_REMINDER_REMINDERDATE}) = '$dateString'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_ID} ASC ";



 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecordsForTheDay()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<Reminder?> GetReminderRecord(DatabaseHandler databaseHandler, String id)async {
        Reminder? dataItem ;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

            


 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<Reminder?> GetMasterReminderRecord(DatabaseHandler databaseHandler, String id)async {
        Reminder? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REMINDER_REMINDERID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           


 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetMasterReminderRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddReminderRecord(DatabaseHandler databaseHandler, Reminder dataItem)async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.reminderID != null && dataItem.reminderID != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERID] = dataItem.reminderID;
if (dataItem.reminderCode != null && dataItem.reminderCode != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERCODE] = dataItem.reminderCode;
if (dataItem.reminderTitle != null && dataItem.reminderTitle != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERTITLE] = dataItem.reminderTitle;
if (dataItem.reminderDescription != null && dataItem.reminderDescription != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION] = dataItem.reminderDescription;
if (dataItem.reminderDate != null && dataItem.reminderDate != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERDATE] = dataItem.reminderDate;
if (dataItem.reminderTime != null && dataItem.reminderTime != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERTIME] = dataItem.reminderTime;
if (dataItem.reminderRepeat != null && dataItem.reminderRepeat != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERREPEAT] = dataItem.reminderRepeat;
if (dataItem.repeatNumber != null && dataItem.repeatNumber != "null")
    values[ColumnsBase.KEY_REMINDER_REPEATNUMBER] = dataItem.repeatNumber;
if (dataItem.repeatType != null && dataItem.repeatType != "null")
    values[ColumnsBase.KEY_REMINDER_REPEATTYPE] = dataItem.repeatType;
if (dataItem.active != null && dataItem.active != "null")
    values[ColumnsBase.KEY_REMINDER_ACTIVE] = dataItem.active;
if (dataItem.activityID != null && dataItem.activityID != "null")
    values[ColumnsBase.KEY_REMINDER_ACTIVITYID] = dataItem.activityID;
if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
    values[ColumnsBase.KEY_REMINDER_OPPORTUNITYID] = dataItem.opportunityID;
if (dataItem.accountID != null && dataItem.accountID != "null")
    values[ColumnsBase.KEY_REMINDER_ACCOUNTID] = dataItem.accountID;
if (dataItem.isSetBySystem != null && dataItem.isSetBySystem != "null")
    values[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM] = dataItem.isSetBySystem;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_REMINDER_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_REMINDER_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_REMINDER_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_REMINDER_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_REMINDER_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_REMINDER_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_REMINDER_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_REMINDER_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_REMINDER_ISDELETED] = dataItem.isDeleted;
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
values[ColumnsBase.KEY_REMINDER_ISACTIVE] = true;
values[ColumnsBase.KEY_REMINDER_ISDELETED] = false;

 id = await db.insert(TablesBase.TABLE_REMINDER, values);

            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddReminderRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateReminderRecord(DatabaseHandler databaseHandler, String id1, Reminder dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;
            Map<String, dynamic> values = {};

if (dataItem.reminderID != null && dataItem.reminderID != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERID] = dataItem.reminderID;
if (dataItem.reminderCode != null && dataItem.reminderCode != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERCODE] = dataItem.reminderCode;
if (dataItem.reminderTitle != null && dataItem.reminderTitle != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERTITLE] = dataItem.reminderTitle;
if (dataItem.reminderDescription != null && dataItem.reminderDescription != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION] = dataItem.reminderDescription;
if (dataItem.reminderDate != null && dataItem.reminderDate != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERDATE] = dataItem.reminderDate;
if (dataItem.reminderTime != null && dataItem.reminderTime != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERTIME] = dataItem.reminderTime;
if (dataItem.reminderRepeat != null && dataItem.reminderRepeat != "null")
    values[ColumnsBase.KEY_REMINDER_REMINDERREPEAT] = dataItem.reminderRepeat;
if (dataItem.repeatNumber != null && dataItem.repeatNumber != "null")
    values[ColumnsBase.KEY_REMINDER_REPEATNUMBER] = dataItem.repeatNumber;
if (dataItem.repeatType != null && dataItem.repeatType != "null")
    values[ColumnsBase.KEY_REMINDER_REPEATTYPE] = dataItem.repeatType;
if (dataItem.active != null && dataItem.active != "null")
    values[ColumnsBase.KEY_REMINDER_ACTIVE] = dataItem.active;
if (dataItem.activityID != null && dataItem.activityID != "null")
    values[ColumnsBase.KEY_REMINDER_ACTIVITYID] = dataItem.activityID;
if (dataItem.opportunityID != null && dataItem.opportunityID != "null")
    values[ColumnsBase.KEY_REMINDER_OPPORTUNITYID] = dataItem.opportunityID;
if (dataItem.accountID != null && dataItem.accountID != "null")
    values[ColumnsBase.KEY_REMINDER_ACCOUNTID] = dataItem.accountID;
if (dataItem.isSetBySystem != null && dataItem.isSetBySystem != "null")
    values[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM] = dataItem.isSetBySystem;
if (dataItem.createdBy != null && dataItem.createdBy != "null")
    values[ColumnsBase.KEY_REMINDER_CREATEDBY] = dataItem.createdBy;
if (dataItem.createdOn != null && dataItem.createdOn != "null")
    values[ColumnsBase.KEY_REMINDER_CREATEDON] = dataItem.createdOn;
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null")
    values[ColumnsBase.KEY_REMINDER_MODIFIEDBY] = dataItem.modifiedBy;
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null")
    values[ColumnsBase.KEY_REMINDER_MODIFIEDON] = dataItem.modifiedOn;
if (dataItem.isActive != null && dataItem.isActive != "null")
    values[ColumnsBase.KEY_REMINDER_ISACTIVE] = dataItem.isActive;
if (dataItem.uid != null && dataItem.uid != "null")
    values[ColumnsBase.KEY_REMINDER_UID] = dataItem.uid;
if (dataItem.appUserID != null && dataItem.appUserID != "null")
    values[ColumnsBase.KEY_REMINDER_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null")
    values[ColumnsBase.KEY_REMINDER_APPUSERGROUPID] = dataItem.appUserGroupID;
if (dataItem.isDeleted != null && dataItem.isDeleted != "null")
    values[ColumnsBase.KEY_REMINDER_ISDELETED] = dataItem.isDeleted;
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
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null")
    values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;


            id = await db.update(TablesBase.TABLE_REMINDER, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateReminderRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteReminderRecord(DatabaseHandler databaseHandler, String id1)async {
        int id = 0;
        try {
            final db =await  databaseHandler.database;
            id = await  db.delete(TablesBase.TABLE_REMINDER, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs:null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteReminderRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler, String id) async{
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_REMINDER_REMINDERID}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db =await  databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_REMINDER_REMINDERID].toString();
            }
            
            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReminderDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler, String id)async {
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REMINDER_REMINDERID} = $id";

           
            final db = await databaseHandler.database;

            List<Map> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID].toString();
            }
        } catch ( ex) {
            Globals.handleException( "ReminderDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<Reminder>> GetReminderUpSyncRecords(DatabaseHandler databaseHandler, String changeType) async{
        List<Reminder> dataList =[];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_REMINDER} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_REMINDER + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_REMINDER + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           


 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<Reminder?> GetReminderRecordByUid(DatabaseHandler databaseHandler, String uid) async{
        Reminder? dataItem ;
        try
        {

            String selectQuery = 	"SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_REMINDER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REMINDER_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
            //selectQuery += " AND A." + ColumnsBase.KEY_REMINDER_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();



 final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var ele in result) {
                    Reminder dataItem = new Reminder();
                    dataItem.reminderID = ele[ColumnsBase.KEY_REMINDER_REMINDERID];
                    dataItem.reminderCode = ele[ColumnsBase.KEY_REMINDER_REMINDERCODE];
                    dataItem.reminderTitle = ele[ColumnsBase.KEY_REMINDER_REMINDERTITLE];
                    dataItem.reminderDescription = ele[ColumnsBase.KEY_REMINDER_REMINDERDESCRIPTION];
                    dataItem.reminderDate = ele[ColumnsBase.KEY_REMINDER_REMINDERDATE];
                    dataItem.reminderTime = ele[ColumnsBase.KEY_REMINDER_REMINDERTIME];
                    dataItem.reminderRepeat = ele[ColumnsBase.KEY_REMINDER_REMINDERREPEAT];
                    dataItem.repeatNumber = ele[ColumnsBase.KEY_REMINDER_REPEATNUMBER];
                    dataItem.repeatType = ele[ColumnsBase.KEY_REMINDER_REPEATTYPE];
                    dataItem.active = ele[ColumnsBase.KEY_REMINDER_ACTIVE];
                    dataItem.activityID = ele[ColumnsBase.KEY_REMINDER_ACTIVITYID];
                    dataItem.opportunityID = ele[ColumnsBase.KEY_REMINDER_OPPORTUNITYID];
                    dataItem.accountID = ele[ColumnsBase.KEY_REMINDER_ACCOUNTID];
                    dataItem.isSetBySystem = ele[ColumnsBase.KEY_REMINDER_ISSETBYSYSTEM];
                    dataItem.createdBy = ele[ColumnsBase.KEY_REMINDER_CREATEDBY];
                    dataItem.createdOn = ele[ColumnsBase.KEY_REMINDER_CREATEDON];
                    dataItem.modifiedBy = ele[ColumnsBase.KEY_REMINDER_MODIFIEDBY];
                    dataItem.modifiedOn = ele[ColumnsBase.KEY_REMINDER_MODIFIEDON];
                    dataItem.isActive = ele[ColumnsBase.KEY_REMINDER_ISACTIVE];
                    dataItem.uid = ele[ColumnsBase.KEY_REMINDER_UID];
                    dataItem.appUserGroupID = ele[ColumnsBase.KEY_REMINDER_APPUSERGROUPID];
                    dataItem.appUserID = ele[ColumnsBase.KEY_REMINDER_APPUSERID];

                    dataItem.isDeleted = ele[ColumnsBase.KEY_REMINDER_ISDELETED];
                    dataItem.activityTitle = ele[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
                    dataItem.opportunityName = ele[ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME];
                    dataItem.accountName = ele[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];
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
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}