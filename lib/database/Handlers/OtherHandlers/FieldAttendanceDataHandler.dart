
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/FieldAttendance.dart';
import '../DataBaseHandler.dart';
import 'FieldAttendanceDataHandlerBase.dart';

class FieldAttendanceDataHandler extends FieldAttendanceDataHandlerBase {

     static Future<FieldAttendance?> GetFieldAttendanceRecordLastOneForTheDay(DatabaseHandler databaseHandler, String dateString)async {
        FieldAttendance? dataItem ;
        try
        {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE  date(${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE}) = '$dateString'";
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " ORDER BY ${ColumnsBase.KEY_ID} DESC LIMIT 1";




       
     final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
              FieldAttendance      dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            Globals.handleException( "FieldAttendanceDataHandler:GetFieldAttendanceRecordLastOneForTheDay()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<List<FieldAttendance>> GetFieldAttendanceRecordsForToday(DatabaseHandler databaseHandler, String dateString)async {
        List<FieldAttendance> dataList =[];
        try
        {
            String selectQuery = "SELECT *,  ((strftime('%s', ifnull(PunchOutTime,DATETIME('now', 'localtime'))) - strftime('%s', PunchInTime)) / 60)  AS 'InTimeInMinutes' FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE  date(${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE}) = '$dateString'";
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " ORDER BY ${ColumnsBase.KEY_ID}";

             
     final db = await databaseHandler.database;

      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
              FieldAttendance      dataItem = new FieldAttendance();
                    dataItem.fieldAttendanceID = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEID];
                    dataItem.fieldAttendanceCode = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCECODE];
                    dataItem.fieldAttendanceTitle = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCETITLE];
                    dataItem.fieldAttendanceDate = element[ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE];
                    dataItem.punchInTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINTIME];
                    dataItem.punchOutTime = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTTIME];
                    dataItem.punchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHINLOCATION];

                    dataItem.userSpecifiedPunchInLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHINLOCATION];
                    dataItem.punchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_PUNCHOUTLOCATION];
                    dataItem.userSpecifiedPunchOutLocation = element[ColumnsBase.KEY_FIELDATTENDANCE_USERSPECIFIEDPUNCHOUTLOCATION];
                    dataItem.remarks = element[ColumnsBase.KEY_FIELDATTENDANCE_REMARKS];
                    dataItem.createdBy = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDBY];
                    dataItem.createdOn = element[ColumnsBase.KEY_FIELDATTENDANCE_CREATEDON];
                    dataItem.modifiedBy = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDBY];
                    dataItem.modifiedOn = element[ColumnsBase.KEY_FIELDATTENDANCE_MODIFIEDON];
                    dataItem.deviceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_DEVICEIDENTIFIER];
                    dataItem.referenceIdentifier = element[ColumnsBase.KEY_FIELDATTENDANCE_REFERENCEIDENTIFIER];
                    dataItem.isActive = element[ColumnsBase.KEY_FIELDATTENDANCE_ISACTIVE];
                    dataItem.uid = element[ColumnsBase.KEY_FIELDATTENDANCE_UID];
                    dataItem.appUserID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERID];
                    dataItem.appUserGroupID = element[ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID];
                    dataItem.isArchived = element[ColumnsBase.KEY_FIELDATTENDANCE_ISARCHIVED];
                    dataItem.isDeleted = element[ColumnsBase.KEY_FIELDATTENDANCE_ISDELETED];

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
            Globals.handleException( "FieldAttendanceDataHandler:GetFieldAttendanceRecordsForToday()", ex);
            throw ex;
        }
        return dataList;
    }


    Future<int> getTotalAttendanceSecondsForToday(
    DatabaseHandler databaseHandler,
    String dateString,
) async {
  int totalSeconds = 0;
  try {
    String selectQuery =
        "SELECT (strftime('%s', ifnull(PunchOutTime,DATETIME('now', 'localtime'))) - strftime('%s', PunchInTime)) AS 'InTimeInSeconds' FROM ${TablesBase.TABLE_FIELDATTENDANCE} WHERE date(${ColumnsBase.KEY_FIELDATTENDANCE_FIELDATTENDANCEDATE}) = '$dateString'";
    selectQuery +=
        " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
    selectQuery +=
        " AND ${ColumnsBase.KEY_FIELDATTENDANCE_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
    selectQuery += " ORDER BY ${ColumnsBase.KEY_ID}";

    final db = await databaseHandler.database;
    List<Map<String, dynamic>> resultList = await db.rawQuery(selectQuery, null);
    for (Map<String, dynamic> row in resultList) {
      totalSeconds += row['InTimeInSeconds'];
    }
    //db.close();
  } catch (ex) {
    Globals.handleException(
      'FieldAttendanceDataHandler:GetTotalAttendanceSecondsForToday()',
      ex,
    );
    throw ex;
  }
  return totalSeconds;
}

	/*-------------------HAPPSALES-------------------*/

}