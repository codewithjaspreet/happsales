import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/ActivityModels/ActivityTeam.dart';
import '../DataBaseHandler.dart';
import 'ActivityTeamDataHandlerBase.dart';

class ActivityTeamDataHandler extends ActivityTeamDataHandlerBase {
  static Future<List<ActivityTeam>> GetActivityTeamRecordsByActivityId(
      DatabaseHandler databaseHandler, String activityId) async {
    List<ActivityTeam> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED},'false')) = 'false' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE},'true')) = 'true' ";
      selectQuery +=
          " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED},'false')) = 'false' ";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = $activityId";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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

      //db.close();
    } catch (ex) {
      Globals.handleException(
          "ActivityTeamDataHandlerBase:GetActivityTeamRecordsByActivityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  static Future<List<ActivityTeam>> GetActivityTeamRecordsAllByActivityId(
      DatabaseHandler databaseHandler, String activityId) async {
    List<ActivityTeam> dataList = [];
    try {
      String selectQuery =
          "SELECT A.* " + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
      selectQuery += " FROM ${TablesBase.TABLE_ACTIVITYTEAM} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_ACTIVITY} B ON A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = B.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID} = $activityId";
      selectQuery +=
          " ORDER BY A.${ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME} COLLATE NOCASE ASC ";

      final db = await databaseHandler.database;
      List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

      for (var element in result) {
        ActivityTeam dataItem = new ActivityTeam();
        dataItem.activityTeamID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMID];
        dataItem.activityTeamCode =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMCODE];
        dataItem.activityID = element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYID];
        dataItem.activityTeamAppUserID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_ACTIVITYTEAMAPPUSERID];
        dataItem.description =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESCRIPTION];
        dataItem.appUserName =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERNAME];
        dataItem.Designation =
            element[ColumnsBase.KEY_ACTIVITYTEAM_DESIGNATION];
        dataItem.createdBy = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_ACTIVITYTEAM_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_ACTIVITYTEAM_MODIFIEDON];
        dataItem.isActive = element[ColumnsBase.KEY_ACTIVITYTEAM_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_ACTIVITYTEAM_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERGROUPID];
        dataItem.appUserID = element[ColumnsBase.KEY_ACTIVITYTEAM_APPUSERID];
        dataItem.isArchived = element[ColumnsBase.KEY_ACTIVITYTEAM_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_ACTIVITYTEAM_ISDELETED];
        dataItem.activityTitle =
            element[ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE];
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
    } catch (ex) {
      Globals.handleException(
          "ActivityTeamDataHandlerBase:GetActivityTeamRecordsByActivityId()",
          ex);
      throw ex;
    }
    return dataList;
  }

  /*-------------------HAPPSALES-------------------*/
}
