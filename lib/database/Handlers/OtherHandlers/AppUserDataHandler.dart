import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUser.dart';
import '../DataBaseHandler.dart';
import 'AppUserDataHandlerBase.dart';

class AppUserDataHandler extends AppUserDataHandlerBase {
  static Future<AppUser?> GetAppUserRecordOfCurrentUser(
    DatabaseHandler databaseHandler,
  ) async {
    AppUser? dataItem;
    try {
      String selectQuery =
          "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
      selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
      selectQuery +=
          " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
      selectQuery +=
          " WHERE A.${ColumnsBase.KEY_APPUSER_APPUSERID} = ${Globals.AppUserID}";
      selectQuery +=
          " AND A.${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

      final db = await databaseHandler.database;
      List<Map> list = await db.rawQuery(selectQuery, null);

      for (var element in list) {
        AppUser dataItem = new AppUser();

        dataItem.appUserID = element[ColumnsBase.KEY_APPUSER_APPUSERID];
        dataItem.appUserCode = element[ColumnsBase.KEY_APPUSER_APPUSERCODE];
        dataItem.appUserName = element[ColumnsBase.KEY_APPUSER_APPUSERNAME];
        dataItem.appUserTypeID = element[ColumnsBase.KEY_APPUSER_APPUSERTYPEID];
        dataItem.designation = element[ColumnsBase.KEY_APPUSER_DESIGNATION];
        dataItem.mobileNumber = element[ColumnsBase.KEY_APPUSER_MOBILENUMBER];
        dataItem.email = element[ColumnsBase.KEY_APPUSER_EMAIL];
        dataItem.officialAddress =
            element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
        dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
        dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
        dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
        dataItem.reportingToAppUserID1 =
            element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
        dataItem.reportingToAppUserID2 =
            element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
        dataItem.reportingToAppUserID3 =
            element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
        dataItem.profilePicture =
            element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
        dataItem.profileCaption =
            element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
        dataItem.profileLocation =
            element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
        dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
        dataItem.companyCaption =
            element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
        dataItem.useCompanyLogo =
            element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
        dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
        dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
        dataItem.currentLoginOn =
            element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
        dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
        dataItem.appLastLoginOn =
            element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
        dataItem.passCodeLastChangedOn =
            element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
        dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
        dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
        dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
        dataItem.activityPlannedSort =
            element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
        dataItem.activityInProcessSort =
            element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
        dataItem.activityCompletedSort =
            element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
        dataItem.opportunityOnGoingSort =
            element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
        dataItem.opportunityWonSort =
            element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
        dataItem.opportunityClosedSort =
            element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
        dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
        dataItem.accountAddressSort =
            element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
        dataItem.accountBuyingProcessSort =
            element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
        dataItem.accountBusinessPlanSort =
            element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
        dataItem.accountCompetitionActivitySort =
            element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
        dataItem.accountMediaSort =
            element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
        dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
        dataItem.isSystemDefined =
            element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
        dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
        dataItem.systemConfiguration =
            element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
        dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
        dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
        dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
        dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
        dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
        dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
        dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
        dataItem.deviceIdentifier =
            element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
        dataItem.referenceIdentifier =
            element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
        dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
        dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
        dataItem.appUserGroupID =
            element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
        dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
        dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

        dataItem.appUserTypeName =
            element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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

        // Add the dataItem to your list or perform further operations
      }
    } catch (ex) {
      Globals.handleException(
          "AppUserDataHandlerBase:GetMasterAppUserRecord()", ex);
      throw ex;
    }
    return dataItem;
  }

  static Future<String> GetSortValue(
      DatabaseHandler databaseHandler, String columnName) async {
    String data = "";
    try {
      final db = await databaseHandler.database;
      String sqlString = "SELECT $columnName FROM ${TablesBase.TABLE_APPUSER}";
      sqlString +=
          " WHERE ${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      sqlString +=
          " AND ${ColumnsBase.KEY_APPUSER_APPUSERID} = ${Globals.AppUserID}";

      List<Map<String, dynamic>> result = await db.rawQuery(sqlString, null);

      if (result.length > 0) {
        data = result[0][columnName];
      }
    } catch (ex) {
      Globals.handleException("AppUserDataHandler:GetSortValue()", ex);
      throw ex;
    }
    return data;
  }

  static Future<void> UpdateSortValue(DatabaseHandler databaseHandler,
      String columnName, String columnValue) async {
    try {
      final db = await databaseHandler.database;
      String sqlString =
          "UPDATE ${TablesBase.TABLE_APPUSER} SET $columnName = '$columnValue'";
      sqlString +=
          " WHERE ${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
      sqlString +=
          " AND ${ColumnsBase.KEY_APPUSER_APPUSERID} = ${Globals.AppUserID}";
      db.execute(sqlString);
    } catch (ex) {
      Globals.handleException("AppUserDataHandler:UpdateSortValue()", ex);
      throw ex;
    }
  }
  /*-------------------HAPPSALES-------------------*/
}
