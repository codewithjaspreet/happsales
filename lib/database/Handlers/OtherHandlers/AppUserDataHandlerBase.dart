
 import '../../AppTables/Columns.dart';
import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OtherModels/AppUser.dart';
import '../DataBaseHandler.dart';

class AppUserDataHandlerBase {

     static Future<List<AppUser>> GetAppUserRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) async{
        List<AppUser> dataList =[];
        try {
            int startRowIndex = ((pageIndex - 1) * pageSize);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSER_APPUSERNAME} LIKE '%$searchString%'";

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
				selectQuery += " AND A." + ColumnsBase.KEY_AppUser_Columns.KEY_APPUSER_APPUSERNAME + " IN(" + groupitem.trim() + ")";
			if (groups.trim().length() > 0)
				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
			if (tags.trim().length() > 0)
				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

            selectQuery += " ORDER BY A.$sortColumn COLLATE NOCASE $sortDirection";
            selectQuery += " LIMIT $startRowIndex,$pageSize";


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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
  // Add the dataItem to your list or perform further operations
}

           
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetAppUserRecordsPaged()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<List<AppUser>> GetAppUserRecords(DatabaseHandler databaseHandler,  String searchString) async{
        List<AppUser> dataList = [];
        try {
            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISDELETED},'false')) = 'false' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISDELETED},'false')) = 'false' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_ISACTIVE},'true')) = 'true' AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISACTIVE},'true')) = 'true' ";
            selectQuery += " AND LOWER(IFNULL(A.${ColumnsBase.KEY_APPUSER_ISARCHIVED},'false')) = 'false' ";
            if (searchString.trim().length > 0)
                selectQuery += " AND A.${ColumnsBase.KEY_APPUSER_APPUSERNAME} LIKE '$searchString%'";
            selectQuery += " ORDER BY A.${ColumnsBase.KEY_APPUSER_APPUSERNAME} COLLATE NOCASE ASC ";

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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
  // Add the dataItem to your list or perform further operations
}
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetAppUserRecords()", ex);
            throw ex;
        }
        return dataList;
    }

     static Future<AppUser?> GetAppUserRecord(DatabaseHandler databaseHandler,  String id) async{
        AppUser? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSER_APPUSERID} = $id";
            selectQuery += " AND A.${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND A.${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetAppUserRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<AppUser?> GetMasterAppUserRecord(DatabaseHandler databaseHandler,  String id)async {
        AppUser? dataItem;
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSER_APPUSERID} = $id";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_APPUSER_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetMasterAppUserRecord()", ex);
            throw ex;
        }
        return dataItem;
    }

     static Future<int> AddAppUserRecord(DatabaseHandler databaseHandler,  AppUser dataItem) async{
        int id = 0;
        try {
            final db = await databaseHandler.database;


        Map<String, dynamic> values = {};

        if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserCode != null && dataItem.appUserCode != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERCODE] = dataItem.appUserCode;
if (dataItem.appUserName != null && dataItem.appUserName != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERNAME] = dataItem.appUserName;
if (dataItem.appUserTypeID != null && dataItem.appUserTypeID != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERTYPEID] = dataItem.appUserTypeID;
if (dataItem.designation != null && dataItem.designation != "null")
  values[ColumnsBase.KEY_APPUSER_DESIGNATION] = dataItem.designation;
if (dataItem.mobileNumber != null && dataItem.mobileNumber != "null")
  values[ColumnsBase.KEY_APPUSER_MOBILENUMBER] = dataItem.mobileNumber;
if (dataItem.email != null && dataItem.email != "null")
  values[ColumnsBase.KEY_APPUSER_EMAIL] = dataItem.email;
if (dataItem.officialAddress != null && dataItem.officialAddress != "null")
  values[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS] = dataItem.officialAddress;
if (dataItem.employeeId != null && dataItem.employeeId != "null")
  values[ColumnsBase.KEY_APPUSER_EMPLOYEEID] = dataItem.employeeId;
if (dataItem.loginName != null && dataItem.loginName != "null")
  values[ColumnsBase.KEY_APPUSER_LOGINNAME] = dataItem.loginName;
if (dataItem.passCode != null && dataItem.passCode != "null")
  values[ColumnsBase.KEY_APPUSER_PASSCODE] = dataItem.passCode;
if (dataItem.reportingToAppUserID1 != null && dataItem.reportingToAppUserID1 != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1] = dataItem.reportingToAppUserID1;
if (dataItem.reportingTo1Email != null && dataItem.reportingTo1Email != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL1] = dataItem.reportingTo1Email;
if (dataItem.reportingTo1Phone != null && dataItem.reportingTo1Phone != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE1] = dataItem.reportingTo1Phone;
if (dataItem.reportingTo1Designation != null && dataItem.reportingTo1Designation != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION1] = dataItem.reportingTo1Designation;
if (dataItem.reportingToAppUserID2 != null && dataItem.reportingToAppUserID2 != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2] = dataItem.reportingToAppUserID2;
if (dataItem.reportingTo2Email != null && dataItem.reportingTo2Email != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL2] = dataItem.reportingTo2Email;
if (dataItem.reportingTo2Phone != null && dataItem.reportingTo2Phone != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE2] = dataItem.reportingTo2Phone;
if (dataItem.reportingTo2Designation != null && dataItem.reportingTo2Designation != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION2] = dataItem.reportingTo2Designation;

// Insert values into the database using the values map

if (dataItem.reportingToAppUserID3 != null && dataItem.reportingToAppUserID3 != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3] = dataItem.reportingToAppUserID3;
}
if (dataItem.reportingTo3Email != null && dataItem.reportingTo3Email != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL3] = dataItem.reportingTo3Email;
}
if (dataItem.reportingTo3Phone != null && dataItem.reportingTo3Phone != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE3] = dataItem.reportingTo3Phone;
}
if (dataItem.reportingTo3Designation != null && dataItem.reportingTo3Designation != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION3] = dataItem.reportingTo3Designation;
}
if (dataItem.profilePicture != null && dataItem.profilePicture != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILEPICTURE] = dataItem.profilePicture;
}
if (dataItem.profileCaption != null && dataItem.profileCaption != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILECAPTION] = dataItem.profileCaption;
}

if (dataItem.profileLocation != null && dataItem.profileLocation != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILELOCATION] = dataItem.profileLocation;
}
if (dataItem.companyLogo != null && dataItem.companyLogo != "null") {
  values[ColumnsBase.KEY_APPUSER_COMPANYLOGO] = dataItem.companyLogo;
}
if (dataItem.companyCaption != null && dataItem.companyCaption != "null") {
  values[ColumnsBase.KEY_APPUSER_COMPANYCAPTION] = dataItem.companyCaption;
}
if (dataItem.useCompanyLogo != null && dataItem.useCompanyLogo != "null") {
  values[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO] = dataItem.useCompanyLogo;
}
if (dataItem.timeZoneCode != null && dataItem.timeZoneCode != "null") {
  values[ColumnsBase.KEY_APPUSER_TIMEZONECODE] = dataItem.timeZoneCode;
}
if (dataItem.currecyCode != null && dataItem.currecyCode != "null") {
  values[ColumnsBase.KEY_APPUSER_CURRECYCODE] = dataItem.currecyCode;
}

if (dataItem.currentLoginOn != null && dataItem.currentLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_CURRENTLOGINON] = dataItem.currentLoginOn;
}
if (dataItem.lastLoginOn != null && dataItem.lastLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_LASTLOGINON] = dataItem.lastLoginOn;
}
if (dataItem.appLastLoginOn != null && dataItem.appLastLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_APPLASTLOGINON] = dataItem.appLastLoginOn;
}
if (dataItem.passCodeLastChangedOn != null && dataItem.passCodeLastChangedOn != "null") {
  values[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON] = dataItem.passCodeLastChangedOn;
}
if (dataItem.isMailSent != null && dataItem.isMailSent != "null") {
  values[ColumnsBase.KEY_APPUSER_ISMAILSENT] = dataItem.isMailSent;
}
if (dataItem.accountSort != null && dataItem.accountSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTSORT] = dataItem.accountSort;

}

if (dataItem.contactSort != null && dataItem.contactSort != "null") {
  values[ColumnsBase.KEY_APPUSER_CONTACTSORT] = dataItem.contactSort;
}
if (dataItem.activityPlannedSort != null && dataItem.activityPlannedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT] = dataItem.activityPlannedSort;
}
if (dataItem.activityInProcessSort != null && dataItem.activityInProcessSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT] = dataItem.activityInProcessSort;
}
if (dataItem.activityCompletedSort != null && dataItem.activityCompletedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT] = dataItem.activityCompletedSort;
}
if (dataItem.opportunityOnGoingSort != null && dataItem.opportunityOnGoingSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT] = dataItem.opportunityOnGoingSort;
}
if (dataItem.opportunityWonSort != null && dataItem.opportunityWonSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT] = dataItem.opportunityWonSort;
}


if (dataItem.opportunityClosedSort != null && dataItem.opportunityClosedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT] = dataItem.opportunityClosedSort;
}
if (dataItem.noteSort != null && dataItem.noteSort != "null") {
  values[ColumnsBase.KEY_APPUSER_NOTESORT] = dataItem.noteSort;
}
if (dataItem.accountAddressSort != null && dataItem.accountAddressSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT] = dataItem.accountAddressSort;
}
if (dataItem.accountBuyingProcessSort != null && dataItem.accountBuyingProcessSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT] = dataItem.accountBuyingProcessSort;
}
if (dataItem.accountBusinessPlanSort != null && dataItem.accountBusinessPlanSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT] = dataItem.accountBusinessPlanSort;
}
if (dataItem.accountCompetitionActivitySort != null && dataItem.accountCompetitionActivitySort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT] = dataItem.accountCompetitionActivitySort;
}
if (dataItem.accountMediaSort != null && dataItem.accountMediaSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT] = dataItem.accountMediaSort;
}

if (dataItem.userToken != null && dataItem.userToken != "null") {
  values[ColumnsBase.KEY_APPUSER_USERTOKEN] = dataItem.userToken;
}
if (dataItem.isSystemDefined != null && dataItem.isSystemDefined != "null") {
  values[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED] = dataItem.isSystemDefined;
}
if (dataItem.configuration != null && dataItem.configuration != "null") {
  values[Columns.KEY_APPUSER_CONFIGURATION] = dataItem.configuration;
}
if (dataItem.systemConfiguration != null && dataItem.systemConfiguration != "null") {
  values[Columns.KEY_APPUSER_SYSTEMCONFIGURATION] = dataItem.systemConfiguration;
}
if (dataItem.muteChat != null && dataItem.muteChat != "null") {
  values[Columns.KEY_APPUSER_MUTECHAT] = dataItem.muteChat;
}
if (dataItem.isWor != null && dataItem.isWor != "null") {
  values[ColumnsBase.KEY_APPUSER_ISWOR] = dataItem.isWor;
}

// ...

if (dataItem.isAppAllowed != null && dataItem.isAppAllowed != "null") {
  values[ColumnsBase.KEY_APPUSER_ISAPPALLOWED] = dataItem.isAppAllowed;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSER_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSER_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSER_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSER_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSER_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSER_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSER_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSER_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSER_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.id != null && dataItem.id != "null") {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}


          if (dataItem.isDirty != null && dataItem.isDirty != "null") {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}
if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}
if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}
if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}


            values[ColumnsBase.KEY_UPSYNCINDEX] =  0;
            values[ColumnsBase.KEY_ISACTIVE]  ="true";
            values[ColumnsBase.KEY_ISDELETED] =  "false";

            id = await db.insert(TablesBase.TABLE_APPUSER, values);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:AddAppUserRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> UpdateAppUserRecord(DatabaseHandler databaseHandler,  String id1, AppUser dataItem) async{
        int id = 0;
        try {
            final db = await  databaseHandler.database;
            Map<String, dynamic> values = {};

// Add all properties to the values map
if (dataItem.appUserID != null && dataItem.appUserID != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERID] = dataItem.appUserID;
if (dataItem.appUserCode != null && dataItem.appUserCode != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERCODE] = dataItem.appUserCode;
if (dataItem.appUserName != null && dataItem.appUserName != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERNAME] = dataItem.appUserName;
if (dataItem.appUserTypeID != null && dataItem.appUserTypeID != "null")
  values[ColumnsBase.KEY_APPUSER_APPUSERTYPEID] = dataItem.appUserTypeID;
if (dataItem.designation != null && dataItem.designation != "null")
  values[ColumnsBase.KEY_APPUSER_DESIGNATION] = dataItem.designation;
if (dataItem.mobileNumber != null && dataItem.mobileNumber != "null")
  values[ColumnsBase.KEY_APPUSER_MOBILENUMBER] = dataItem.mobileNumber;
if (dataItem.email != null && dataItem.email != "null")
  values[ColumnsBase.KEY_APPUSER_EMAIL] = dataItem.email;
if (dataItem.officialAddress != null && dataItem.officialAddress != "null")
  values[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS] = dataItem.officialAddress;
if (dataItem.employeeId != null && dataItem.employeeId != "null")
  values[ColumnsBase.KEY_APPUSER_EMPLOYEEID] = dataItem.employeeId;
if (dataItem.loginName != null && dataItem.loginName != "null")
  values[ColumnsBase.KEY_APPUSER_LOGINNAME] = dataItem.loginName;
if (dataItem.passCode != null && dataItem.passCode != "null")
  values[ColumnsBase.KEY_APPUSER_PASSCODE] = dataItem.passCode;
if (dataItem.reportingToAppUserID1 != null && dataItem.reportingToAppUserID1 != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1] = dataItem.reportingToAppUserID1;
if (dataItem.reportingTo1Email != null && dataItem.reportingTo1Email != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL1] = dataItem.reportingTo1Email;
if (dataItem.reportingTo1Phone != null && dataItem.reportingTo1Phone != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE1] = dataItem.reportingTo1Phone;
if (dataItem.reportingTo1Designation != null && dataItem.reportingTo1Designation != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION1] = dataItem.reportingTo1Designation;
if (dataItem.reportingToAppUserID2 != null && dataItem.reportingToAppUserID2 != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2] = dataItem.reportingToAppUserID2;
if (dataItem.reportingTo2Email != null && dataItem.reportingTo2Email != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL2] = dataItem.reportingTo2Email;
if (dataItem.reportingTo2Phone != null && dataItem.reportingTo2Phone != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE2] = dataItem.reportingTo2Phone;
if (dataItem.reportingTo2Designation != null && dataItem.reportingTo2Designation != "null")
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION2] = dataItem.reportingTo2Designation;

// Insert values into the database using the values map

if (dataItem.reportingToAppUserID3 != null && dataItem.reportingToAppUserID3 != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3] = dataItem.reportingToAppUserID3;
}
if (dataItem.reportingTo3Email != null && dataItem.reportingTo3Email != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSEREMAIL3] = dataItem.reportingTo3Email;
}
if (dataItem.reportingTo3Phone != null && dataItem.reportingTo3Phone != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERPHONE3] = dataItem.reportingTo3Phone;
}
if (dataItem.reportingTo3Designation != null && dataItem.reportingTo3Designation != "null") {
  values[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERDESIGNATION3] = dataItem.reportingTo3Designation;
}
if (dataItem.profilePicture != null && dataItem.profilePicture != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILEPICTURE] = dataItem.profilePicture;
}
if (dataItem.profileCaption != null && dataItem.profileCaption != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILECAPTION] = dataItem.profileCaption;
}

if (dataItem.profileLocation != null && dataItem.profileLocation != "null") {
  values[ColumnsBase.KEY_APPUSER_PROFILELOCATION] = dataItem.profileLocation;
}
if (dataItem.companyLogo != null && dataItem.companyLogo != "null") {
  values[ColumnsBase.KEY_APPUSER_COMPANYLOGO] = dataItem.companyLogo;
}
if (dataItem.companyCaption != null && dataItem.companyCaption != "null") {
  values[ColumnsBase.KEY_APPUSER_COMPANYCAPTION] = dataItem.companyCaption;
}
if (dataItem.useCompanyLogo != null && dataItem.useCompanyLogo != "null") {
  values[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO] = dataItem.useCompanyLogo;
}
if (dataItem.timeZoneCode != null && dataItem.timeZoneCode != "null") {
  values[ColumnsBase.KEY_APPUSER_TIMEZONECODE] = dataItem.timeZoneCode;
}
if (dataItem.currecyCode != null && dataItem.currecyCode != "null") {
  values[ColumnsBase.KEY_APPUSER_CURRECYCODE] = dataItem.currecyCode;
}

if (dataItem.currentLoginOn != null && dataItem.currentLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_CURRENTLOGINON] = dataItem.currentLoginOn;
}
if (dataItem.lastLoginOn != null && dataItem.lastLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_LASTLOGINON] = dataItem.lastLoginOn;
}
if (dataItem.appLastLoginOn != null && dataItem.appLastLoginOn != "null") {
  values[ColumnsBase.KEY_APPUSER_APPLASTLOGINON] = dataItem.appLastLoginOn;
}
if (dataItem.passCodeLastChangedOn != null && dataItem.passCodeLastChangedOn != "null") {
  values[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON] = dataItem.passCodeLastChangedOn;
}
if (dataItem.isMailSent != null && dataItem.isMailSent != "null") {
  values[ColumnsBase.KEY_APPUSER_ISMAILSENT] = dataItem.isMailSent;
}
if (dataItem.accountSort != null && dataItem.accountSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTSORT] = dataItem.accountSort;

}

if (dataItem.contactSort != null && dataItem.contactSort != "null") {
  values[ColumnsBase.KEY_APPUSER_CONTACTSORT] = dataItem.contactSort;
}
if (dataItem.activityPlannedSort != null && dataItem.activityPlannedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT] = dataItem.activityPlannedSort;
}
if (dataItem.activityInProcessSort != null && dataItem.activityInProcessSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT] = dataItem.activityInProcessSort;
}
if (dataItem.activityCompletedSort != null && dataItem.activityCompletedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT] = dataItem.activityCompletedSort;
}
if (dataItem.opportunityOnGoingSort != null && dataItem.opportunityOnGoingSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT] = dataItem.opportunityOnGoingSort;
}
if (dataItem.opportunityWonSort != null && dataItem.opportunityWonSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT] = dataItem.opportunityWonSort;
}


if (dataItem.opportunityClosedSort != null && dataItem.opportunityClosedSort != "null") {
  values[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT] = dataItem.opportunityClosedSort;
}
if (dataItem.noteSort != null && dataItem.noteSort != "null") {
  values[ColumnsBase.KEY_APPUSER_NOTESORT] = dataItem.noteSort;
}
if (dataItem.accountAddressSort != null && dataItem.accountAddressSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT] = dataItem.accountAddressSort;
}
if (dataItem.accountBuyingProcessSort != null && dataItem.accountBuyingProcessSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT] = dataItem.accountBuyingProcessSort;
}
if (dataItem.accountBusinessPlanSort != null && dataItem.accountBusinessPlanSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT] = dataItem.accountBusinessPlanSort;
}
if (dataItem.accountCompetitionActivitySort != null && dataItem.accountCompetitionActivitySort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT] = dataItem.accountCompetitionActivitySort;
}
if (dataItem.accountMediaSort != null && dataItem.accountMediaSort != "null") {
  values[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT] = dataItem.accountMediaSort;
}

if (dataItem.userToken != null && dataItem.userToken != "null") {
  values[ColumnsBase.KEY_APPUSER_USERTOKEN] = dataItem.userToken;
}
if (dataItem.isSystemDefined != null && dataItem.isSystemDefined != "null") {
  values[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED] = dataItem.isSystemDefined;
}
if (dataItem.configuration != null && dataItem.configuration != "null") {
  values[Columns.KEY_APPUSER_CONFIGURATION] = dataItem.configuration;
}
if (dataItem.systemConfiguration != null && dataItem.systemConfiguration != "null") {
  values[Columns.KEY_APPUSER_SYSTEMCONFIGURATION] = dataItem.systemConfiguration;
}
if (dataItem.muteChat != null && dataItem.muteChat != "null") {
  values[Columns.KEY_APPUSER_MUTECHAT] = dataItem.muteChat;
}
if (dataItem.isWor != null && dataItem.isWor != "null") {
  values[ColumnsBase.KEY_APPUSER_ISWOR] = dataItem.isWor;
}

// ...

if (dataItem.isAppAllowed != null && dataItem.isAppAllowed != "null") {
  values[ColumnsBase.KEY_APPUSER_ISAPPALLOWED] = dataItem.isAppAllowed;
}
if (dataItem.createdBy != null && dataItem.createdBy != "null") {
  values[ColumnsBase.KEY_APPUSER_CREATEDBY] = dataItem.createdBy;
}
if (dataItem.createdOn != null && dataItem.createdOn != "null") {
  values[ColumnsBase.KEY_APPUSER_CREATEDON] = dataItem.createdOn;
}
if (dataItem.modifiedBy != null && dataItem.modifiedBy != "null") {
  values[ColumnsBase.KEY_APPUSER_MODIFIEDBY] = dataItem.modifiedBy;
}
if (dataItem.modifiedOn != null && dataItem.modifiedOn != "null") {
  values[ColumnsBase.KEY_APPUSER_MODIFIEDON] = dataItem.modifiedOn;
}
if (dataItem.deviceIdentifier != null && dataItem.deviceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER] = dataItem.deviceIdentifier;
}if (dataItem.referenceIdentifier != null && dataItem.referenceIdentifier != "null") {
  values[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER] = dataItem.referenceIdentifier;
}
if (dataItem.isActive != null && dataItem.isActive != "null") {
  values[ColumnsBase.KEY_APPUSER_ISACTIVE] = dataItem.isActive;
}
if (dataItem.uid != null && dataItem.uid != "null") {
  values[ColumnsBase.KEY_APPUSER_UID] = dataItem.uid;
}
if (dataItem.appUserGroupID != null && dataItem.appUserGroupID != "null") {
  values[ColumnsBase.KEY_APPUSER_APPUSERGROUPID] = dataItem.appUserGroupID;
}
if (dataItem.isArchived != null && dataItem.isArchived != "null") {
  values[ColumnsBase.KEY_APPUSER_ISARCHIVED] = dataItem.isArchived;
}
if (dataItem.isDeleted != null && dataItem.isDeleted != "null") {
  values[ColumnsBase.KEY_APPUSER_ISDELETED] = dataItem.isDeleted;
}
if (dataItem.id != null && dataItem.id != "null") {
  values[ColumnsBase.KEY_ID] = dataItem.id;
}


          if (dataItem.isDirty != null && dataItem.isDirty != "null") {
  values[ColumnsBase.KEY_ISDIRTY] = dataItem.isDirty;
}
if (dataItem.isDeleted1 != null && dataItem.isDeleted1 != "null") {
  values[ColumnsBase.KEY_ISDELETED] = dataItem.isDeleted1;
}
if (dataItem.upSyncMessage != null && dataItem.upSyncMessage != "null") {
  values[ColumnsBase.KEY_UPSYNCMESSAGE] = dataItem.upSyncMessage;
}
if (dataItem.downSyncMessage != null && dataItem.downSyncMessage != "null") {
  values[ColumnsBase.KEY_DOWNSYNCMESSAGE] = dataItem.downSyncMessage;
}
if (dataItem.sCreatedOn != null && dataItem.sCreatedOn != "null") {
  values[ColumnsBase.KEY_SCREATEDON] = dataItem.sCreatedOn;
}
if (dataItem.sModifiedOn != null && dataItem.sModifiedOn != "null") {
  values[ColumnsBase.KEY_SMODIFIEDON] = dataItem.sModifiedOn;
}
if (dataItem.createdByUser != null && dataItem.createdByUser != "null") {
  values[ColumnsBase.KEY_CREATEDBYUSER] = dataItem.createdByUser;
}
if (dataItem.modifiedByUser != null && dataItem.modifiedByUser != "null") {
  values[ColumnsBase.KEY_MODIFIEDBYUSER] = dataItem.modifiedByUser;
}
if (dataItem.ownerUserID != null && dataItem.ownerUserID != "null") {
  values[ColumnsBase.KEY_OWNERUSERID] = dataItem.ownerUserID;
}
if (dataItem.upSyncIndex != null && dataItem.upSyncIndex != "null") {
  values[ColumnsBase.KEY_UPSYNCINDEX] = dataItem.upSyncIndex;
}

            id = await  db.update(TablesBase.TABLE_APPUSER, values, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs  : null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:UpdateAppUserRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<int> DeleteAppUserRecord(DatabaseHandler databaseHandler,  String id1) async {
        int id = 0;
        try {
            final db = await databaseHandler.database;
            id =await  db.delete(TablesBase.TABLE_APPUSER, where: "${ColumnsBase.KEY_ID} = $id1", whereArgs: null);
            //db.close();
        } catch ( ex) {
            Globals.handleException( "DatabaseHandler:DeleteAppUserRecord()", ex);
            throw ex;
        }
        return id;
    }

     static Future<String> GetServerId(DatabaseHandler databaseHandler,  String id) async {
        String serverId = "-1";
        try {
            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_APPUSER_APPUSERID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_ID} = $id";

            final db = await  databaseHandler.database;
            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                serverId = result[0][ColumnsBase.KEY_APPUSER_APPUSERID];
            }
        
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetServerId()", ex);
            throw ex;
        }
        return serverId;
    }

     static Future<String> GetLocalId(DatabaseHandler databaseHandler,  String id) async{
        String localId = "";
        try {

            id = Globals.tryParseLongForDBId(id);

            String selectQuery = "SELECT A.${ColumnsBase.KEY_ID}";
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSER_APPUSERID} = $id";

            final db = await databaseHandler.database;

            List<Map<String, dynamic>> result = await db.rawQuery(selectQuery, null);

            if (result.length > 0) {
                localId = result[0][ColumnsBase.KEY_ID];
            }


        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetLocalId()", ex);
            throw ex;
        }
        return localId;
    }

     static Future<List<AppUser>> GetAppUserUpSyncRecords(DatabaseHandler databaseHandler,  String changeType)async {
        List<AppUser> dataList = [];
        try {
            String selectQuery = "SELECT * FROM ${TablesBase.TABLE_APPUSER} WHERE ${ColumnsBase.KEY_ISDIRTY} = 'true' AND ${ColumnsBase.KEY_UPSYNCINDEX} < ${Globals.SyncIndex}";
            /*if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_APPUSER + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
                selectQuery = "SELECT * FROM " + TablesBase.TABLE_APPUSER + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
            }*/
            selectQuery += " AND ${ColumnsBase.KEY_OWNERUSERID} = ${Globals.AppUserID}";
            selectQuery += " AND ${ColumnsBase.KEY_APPUSER_APPUSERGROUPID} = ${Globals.AppUserGroupID}";

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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
  // Add the dataItem to your list or perform further operations
}
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetAppUserUpSyncRecords()", ex);
            throw ex;
        }
        return dataList;
    }


     static Future<AppUser?> GetAppUserRecordByUid(DatabaseHandler databaseHandler,  String uid) async{
        AppUser? dataItem ;
        try {

            String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME;
            selectQuery += " FROM ${TablesBase.TABLE_APPUSER} A ";
            selectQuery += " LEFT JOIN ${TablesBase.TABLE_APPUSERTYPE} C ON A.${ColumnsBase.KEY_APPUSER_APPUSERTYPEID} = C.${ColumnsBase.KEY_ID}";
            selectQuery += " WHERE A.${ColumnsBase.KEY_APPUSER_UID} = '$uid'";
            //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
            //selectQuery += " AND A." + ColumnsBase.KEY_APPUSER_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

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
  dataItem.officialAddress = element[ColumnsBase.KEY_APPUSER_OFFICIALADDRESS];
  dataItem.employeeId = element[ColumnsBase.KEY_APPUSER_EMPLOYEEID];
  dataItem.loginName = element[ColumnsBase.KEY_APPUSER_LOGINNAME];
  dataItem.passCode = element[ColumnsBase.KEY_APPUSER_PASSCODE];
  dataItem.reportingToAppUserID1 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID1];
  dataItem.reportingToAppUserID2 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID2];
  dataItem.reportingToAppUserID3 = element[ColumnsBase.KEY_APPUSER_REPORTINGTOAPPUSERID3];
  dataItem.profilePicture = element[ColumnsBase.KEY_APPUSER_PROFILEPICTURE];
  dataItem.profileCaption = element[ColumnsBase.KEY_APPUSER_PROFILECAPTION];
  dataItem.profileLocation = element[ColumnsBase.KEY_APPUSER_PROFILELOCATION];
  dataItem.companyLogo = element[ColumnsBase.KEY_APPUSER_COMPANYLOGO];
  dataItem.companyCaption = element[ColumnsBase.KEY_APPUSER_COMPANYCAPTION];
  dataItem.useCompanyLogo = element[ColumnsBase.KEY_APPUSER_USECOMPANYLOGO];
  dataItem.timeZoneCode = element[ColumnsBase.KEY_APPUSER_TIMEZONECODE];
  dataItem.currecyCode = element[ColumnsBase.KEY_APPUSER_CURRECYCODE];
  dataItem.currentLoginOn = element[ColumnsBase.KEY_APPUSER_CURRENTLOGINON];
  dataItem.lastLoginOn = element[ColumnsBase.KEY_APPUSER_LASTLOGINON];
  dataItem.appLastLoginOn = element[ColumnsBase.KEY_APPUSER_APPLASTLOGINON];
  dataItem.passCodeLastChangedOn = element[ColumnsBase.KEY_APPUSER_PASSCODELASTCHANGEDON];
  dataItem.isMailSent = element[ColumnsBase.KEY_APPUSER_ISMAILSENT];
  dataItem.accountSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTSORT];
  dataItem.contactSort = element[ColumnsBase.KEY_APPUSER_CONTACTSORT];
  dataItem.activityPlannedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYPLANNEDSORT];
  dataItem.activityInProcessSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYINPROCESSSORT];
  dataItem.activityCompletedSort = element[ColumnsBase.KEY_APPUSER_ACTIVITYCOMPLETEDSORT];
  dataItem.opportunityOnGoingSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYONGOINGSORT];
  dataItem.opportunityWonSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYWONSORT];
  dataItem.opportunityClosedSort = element[ColumnsBase.KEY_APPUSER_OPPORTUNITYCLOSEDSORT];
  dataItem.noteSort = element[ColumnsBase.KEY_APPUSER_NOTESORT];
  dataItem.accountAddressSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTADDRESSSORT];
  dataItem.accountBuyingProcessSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUYINGPROCESSSORT];
  dataItem.accountBusinessPlanSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTBUSINESSPLANSORT];
  dataItem.accountCompetitionActivitySort = element[ColumnsBase.KEY_APPUSER_ACCOUNTCOMPETITIONACTIVITYSORT];
  dataItem.accountMediaSort = element[ColumnsBase.KEY_APPUSER_ACCOUNTMEDIASORT];
  dataItem.userToken = element[ColumnsBase.KEY_APPUSER_USERTOKEN];
  dataItem.isSystemDefined = element[ColumnsBase.KEY_APPUSER_ISSYSTEMDEFINED];
  dataItem.configuration = element[Columns.KEY_APPUSER_CONFIGURATION];
  dataItem.systemConfiguration = element[Columns.KEY_APPUSER_SYSTEMCONFIGURATION];
  dataItem.muteChat = element[Columns.KEY_APPUSER_MUTECHAT];
  dataItem.isWor = element[ColumnsBase.KEY_APPUSER_ISWOR];
  dataItem.isAppAllowed = element[ColumnsBase.KEY_APPUSER_ISAPPALLOWED];
  dataItem.createdBy = element[ColumnsBase.KEY_APPUSER_CREATEDBY];
  dataItem.createdOn = element[ColumnsBase.KEY_APPUSER_CREATEDON];
  dataItem.modifiedBy = element[ColumnsBase.KEY_APPUSER_MODIFIEDBY];
  dataItem.modifiedOn = element[ColumnsBase.KEY_APPUSER_MODIFIEDON];
  dataItem.deviceIdentifier = element[ColumnsBase.KEY_APPUSER_DEVICEIDENTIFIER];
  dataItem.referenceIdentifier = element[ColumnsBase.KEY_APPUSER_REFERENCEIDENTIFIER];
  dataItem.isActive = element[ColumnsBase.KEY_APPUSER_ISACTIVE];
  dataItem.uid = element[ColumnsBase.KEY_APPUSER_UID];
  dataItem.appUserGroupID = element[ColumnsBase.KEY_APPUSER_APPUSERGROUPID];
  dataItem.isArchived = element[ColumnsBase.KEY_APPUSER_ISARCHIVED];
  dataItem.isDeleted = element[ColumnsBase.KEY_APPUSER_ISDELETED];

  dataItem.appUserTypeName = element[ColumnsBase.KEY_APPUSERTYPE_APPUSERTYPENAME];

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
        } catch ( ex) {
            Globals.handleException( "AppUserDataHandlerBase:GetAppUserRecordByUid()", ex);
            throw ex;
        }
        return dataItem;
    }

    /*-------------------HAPPSALES-------------------*/

}