import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityStatus.dart';
import '../DataBaseHandler.dart';
import 'ActivityStatusDataHandlerBase.dart';

class ActivityStatusDataHandler extends ActivityStatusDataHandlerBase {
  static Future<ActivityStatus?> GetActivityStatusByName(
      DatabaseHandler databaseHandler, String activityStatusName) async {
    ActivityStatus? dataItem;
    try {
      String selectQuery =
          "SELECT A.*  FROM ${TablesBase.TABLE_ACTIVITYSTATUS} A  WHERE A.${ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME} = '$activityStatusName'";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityStatus dataItem = ActivityStatus();
        dataItem.activityStatusID =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSID];
        dataItem.activityStatusCode =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSCODE];
        dataItem.activityStatusName =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_ACTIVITYSTATUSNAME];
        dataItem.internalCode =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_INTERNALCODE];
        dataItem.displayInApp =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_DISPLAYINAPP];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDON];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYSTATUS_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDON];
        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_MODIFIEDBY];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISDELETED];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYSTATUS_ISACTIVE];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYSTATUS_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYSTATUS_APPUSERGROUPID];

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
    } catch (ex) {
      Globals.handleException("DatabaseHandler:GetActivityStatusByName()", ex);
      throw ex;
    }
    return dataItem;
  }
  /*-------------------HAPPSALES-------------------*/
}
