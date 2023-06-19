import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityPriority.dart';
import '../DataBaseHandler.dart';
import 'ActivityPriorityDataHandlerBase.dart';

class ActivityPriorityDataHandler extends ActivityPriorityDataHandlerBase {
  static Future<ActivityPriority?> GetDefaultActivityPriority(
      DatabaseHandler databaseHandler) async {
    ActivityPriority? dataItem;
    try {
      String selectQuery = "SELECT A.* ";
      selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYPRIORITY + " A ";
      selectQuery += " WHERE COALESCE(A." +
          ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT +
          ",'false') = 'true' ";
      selectQuery += " AND A." +
          ColumnsBase.KEY_OWNERUSERID +
          " = " +
          Globals.AppUserID.toString();
      selectQuery += " AND A." +
          ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID +
          " = " +
          Globals.AppUserGroupID.toString();

      final db = await databaseHandler.database;
      final List<Map<String, dynamic>> result =
          await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityPriority dataItem = new ActivityPriority();
        dataItem.activityPriorityID =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYID];
        dataItem.activityPriorityCode =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYCODE];
        dataItem.activityPriorityName =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ACTIVITYPRIORITYNAME];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_DESCRIPTION];
        dataItem.isDefault =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDEFAULT];
        dataItem.priorityOrder =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_PRIORITYORDER];
        dataItem.alertOnScheduleSlippage =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ALERTONSCHEDULESLIPPAGE];
        dataItem.createdOn =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDON];
        dataItem.createdBy =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_CREATEDBY];
        dataItem.modifiedOn =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDON];

        dataItem.modifiedBy =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_MODIFIEDBY];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYPRIORITY_UID];
        dataItem.appUserID =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_APPUSERGROUPID];
        dataItem.isDeleted =
            element[ColumnsBase.KEY_ACTIVITYPRIORITY_ISDELETED];
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
      Globals.handleException(
          "ActivityPriorityDataHandler:GetDefaultActivityPriority()", ex);
      throw ex;
    }
    return dataItem;
  }

  /*-------------------HAPPSALES-------------------*/
}
