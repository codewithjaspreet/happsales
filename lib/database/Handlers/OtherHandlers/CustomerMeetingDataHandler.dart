import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/CustomerMeeting.dart';
import '../DataBaseHandler.dart';
import 'CustomerMeetingDataHandlerBase.dart';

class CustomerMeetingDataHandler extends CustomerMeetingDataHandlerBase{

    static Future<CustomerMeeting?> GetCustomerMeetingRecordByActivityId(DatabaseHandler databaseHandler,  String id)async {
        CustomerMeeting ?dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,C.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},B.${ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME},F.${ColumnsBase.KEY_CONTACT_CONTACTNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_CUSTOMERMEETING} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACCOUNT} B ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} C ON A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_CONTACT} F ON A.${ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID} = F.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           
 final db =  await databaseHandler.database;


            List<Map<String, dynamic>> result =  await db.rawQuery(selectQuery, null);

            for(var element in result){
                    CustomerMeeting dataItem = new CustomerMeeting();

                    dataItem.customerMeetingID = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGID];
                    dataItem.customerMeetingCode = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGCODE];
                    dataItem.activityID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACTIVITYID];
                    dataItem.accountID = element[ColumnsBase.KEY_CUSTOMERMEETING_ACCOUNTID];
                    dataItem.contactID = element[ColumnsBase.KEY_CUSTOMERMEETING_CONTACTID];
                    dataItem.customerMeetingDate = element[ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_CUSTOMERMEETING_PUNCHINLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_CUSTOMERMEETING_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_CUSTOMERMEETING_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_CUSTOMERMEETING_MODIFIEDON];

                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_CUSTOMERMEETING_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_CUSTOMERMEETING_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_CUSTOMERMEETING_UID];

                    dataItem.appUserID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERID];

                    dataItem.appUserGroupID = element[ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID];

                    dataItem.isArchived = element[ColumnsBase.KEY_CUSTOMERMEETING_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_CUSTOMERMEETING_ISDELETED];

                    dataItem.activityTitle = element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];

                    dataItem.accountName = element[ColumnsBase.KEY_ACCOUNT_ACCOUNTNAME];

                    dataItem.contactName = element[ColumnsBase.KEY_CONTACT_CONTACTNAME];

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
        } catch (Exception ex) {
            Globals.HandleException( "CustomerMeetingDataHandlerBase:GetCustomerMeetingRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static int GetTotalCustomerMeetingSecondsForToday(DatabaseHandler databaseHandler,  String dateString) {
        int totalSeconds = 0;
        try
        {
            String selectQuery = "SELECT ((strftime('%s', ifnull(PunchOutTime,DATETIME('now', 'localtime'))) - strftime('%s', PunchInTime)))  AS 'InTimeInSeconds' FROM ${TablesBase.TABLE_CUSTOMERMEETING} WHERE  date(${ColumnsBase.KEY_CUSTOMERMEETING_CUSTOMERMEETINGDATE}) = '$dateString'";
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_CUSTOMERMEETING_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " ORDER BY ${ColumnsBase.KEY_ID}";

            final db = databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            for(var element in result){
                totalSeconds = totalSeconds + element[ColumnsBase.KEY_CUSTOMERMEETING_INTIMEINSECONDS];
            }
           
        }
        catch( ex)
        {
            Globals.handleException( "FieldAttendanceDataHandler:GetTotalAttendanceSecondsForToday()", ex);
            throw ex;
        }
        return totalSeconds;
    }

}