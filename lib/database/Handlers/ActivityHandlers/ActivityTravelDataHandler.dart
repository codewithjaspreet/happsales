
 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityTravel.dart';
import '../DataBaseHandler.dart';
import 'ActivityTravelDataHandlerBase.dart';

class ActivityTravelDataHandler extends ActivityTravelDataHandlerBase {


     static Future<ActivityTravel?> GetActivityTravelRecordByActivityId(DatabaseHandler databaseHandler, String id)async {
        ActivityTravel? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* ,B.${ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE},E.${ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME}";
            selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTRAVEL} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_MODEOFTRAVEL} E ON A.${ColumnsBase.KEY_ACTIVITYTRAVEL_MODEOFTRAVELID} = E.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ACTIVITY_ACTIVITYID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_ACTIVITYTRAVEL_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

           final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTravel dataItem = new ActivityTravel();

        dataItem.activityTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELID];
        dataItem.activityTravelCode =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELCODE];
        dataItem.activityTravelTitle =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE];
        dataItem.activityID =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYID];
        dataItem.activityTravelDate =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELDATE];
        dataItem.activityTravelEndDate =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELENDDATE];
        dataItem.travelPurposeName =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_TRAVELPURPOSENAME];
        dataItem.startLocation =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_STARTLOCATION];
        dataItem.endLocation =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ENDLOCATION];
        dataItem.startLocationCoordinate =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_STARTLOCATIONCOORDINATE];
        dataItem.endLocationCoordinate =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ENDLOCATIONCOORDINATE];
        dataItem.actualDistance =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ACTUALDISTANCE];
        dataItem.distanceTravelled =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_DISTANCETRAVELLED];
        dataItem.modeOfTravelID =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_MODEOFTRAVELID];
        dataItem.travelExpense =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_TRAVELEXPENSE];
        dataItem.reasonForDeviation =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_REASONFORDEVIATION];
        dataItem.otherExpense =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_OTHEREXPENSE];
        dataItem.totalExpense =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_TOTALEXPENSE];
        dataItem.tags = element[ColumnsBase.KEY_ACTIVITYTRAVEL_TAGS];
        dataItem.isSubmitted =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ISSUBMITTED];
        dataItem.remarks = element[ColumnsBase.KEY_ACTIVITYTRAVEL_REMARKS];
        dataItem.approvalStatus =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVALSTATUS];
        dataItem.approvedByAppUserName =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDBYAPPUSERNAME];
        dataItem.approvedTime =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVEDTIME];
        dataItem.approverRemarks =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPROVERREMARKS];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTRAVEL_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTRAVEL_CREATEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_MODIFIEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_REFERENCEIDENTIFIER];
        dataItem.location = element[ColumnsBase.KEY_ACTIVITYTRAVEL_LOCATION];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTRAVEL_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTRAVEL_UID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_APPUSERGROUPID];
        dataItem.isArchived =
            element[ColumnsBase.KEY_ACTIVITYTRAVEL_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTRAVEL_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
        dataItem.modeOfTravelName =
            element[ColumnsBase.KEY_MODEOFTRAVEL_MODEOFTRAVELNAME];
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
            Globals.handleException( "ActivityTravelDataHandlerBase:GetActivityTravelRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

	/*-------------------HAPPSALES-------------------*/

}