
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/Reminder.dart';
import '../DataBaseHandler.dart';
import 'ReminderDataHandlerBase.dart';

class ReminderDataHandler extends ReminderDataHandlerBase {


     static Future<Reminder?> GetReminderActivityRecord(DatabaseHandler databaseHandler,  String activityId) async{
        Reminder? dataItem ;
        try {
            activityId = Globals.tryParseLongForDBId(activityId);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},F.${ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME}";
            selectQuery += "${" FROM " + TablesBase.TABLE_REMINDER} A ";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_REMINDER_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += "${" LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY} F ON A.${ColumnsBase.KEY_REMINDER_OPPORTUNITYID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_REMINDER_ACTIVITYID} = $activityId";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = " + Globals.AppUserID.toString();
            selectQuery += " AND A.${ColumnsBase.KEY_REMINDER_APPUSERGROUPID} = " + Globals.AppUserGroupID.toString();

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

            //db.close();
        } catch ( ex) {
            Globals.handleException( "ReminderDataHandlerBase:GetReminderRecord()", ex);
            throw ex;
        }
        return dataItem;
        /*-------------------HAPPSALES-------------------*/

    }
}