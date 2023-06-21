

 import '../../AppTables/ColumnsBase.dart';
import '../../AppTables/TablesBase.dart';
import '../../Globals.dart';
import '../../models/OpportunityModels/OpportunityTeam.dart';
import '../DataBaseHandler.dart';

class OpportunityTeamDataHandlerBase {

    //  static List<OpportunityTeam> GetOpportunityTeamRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
    //     List<OpportunityTeam> dataList = new ArrayList<OpportunityTeam>();
    //     try {
    //         int startRowIndex = ((pageIndex - 1) * pageSize);

    //         String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " D ON A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED + ",'false')) = 'false' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE + ",'true')) = 'true' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED + ",'false')) = 'false' ";
    //         if (searchString.trim().length > 0)
    //             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME + " LIKE '%" + searchString + "%'";

    //         /* FILTER */
		// 	/*String groups = "";
		// 	String tags = "";
		// 	String groupitem = "";
		// 	for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
		// 		String key1 = entry.getKey();
		// 		String value1 = entry.getValue();
		// 		if (entry.getKey().equals("XXXXX")) {
		// 			groupitem = value1;
		// 		} else {
		// 			groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
		// 			tags += (tags.equals("") ? value1 : "," + value1);
		// 		}
		// 	}
		// 	if (groupitem.trim().length() > 0)
		// 		selectQuery += " AND A." + ColumnsBase.KEY_OpportunityTeam_ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME + " IN(" + groupitem.trim() + ")";
		// 	if (groups.trim().length() > 0)
		// 		selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
		// 	if (tags.trim().length() > 0)
		// 		selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

    //         selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
    //         selectQuery += " LIMIT " + startRowIndex + "," + pageSize;


    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 OpportunityTeam dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //                 dataList.add(dataItem);
    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordsPaged()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }

    //  static List<OpportunityTeam> GetOpportunityTeamRecords(DatabaseHandler databaseHandler,  String searchString) {
    //     List<OpportunityTeam> dataList = new ArrayList<OpportunityTeam>();
    //     try {
    //         String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " D ON A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED + ",'false')) = 'false' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE + ",'true')) = 'true' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED + ",'false')) = 'false' ";
    //         if (searchString.trim().length() > 0)
    //             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME + " LIKE '" + searchString + "%'";
    //         selectQuery += " ORDER BY A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME + " COLLATE NOCASE ASC ";

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 OpportunityTeam dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //                 dataList.add(dataItem);
    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecords()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }

    //  static OpportunityTeam GetOpportunityTeamRecord(DatabaseHandler databaseHandler,  String id) {
    //     OpportunityTeam dataItem = null;
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " D ON A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));


    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecord()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

    //  static OpportunityTeam GetOpportunityTeamRecordByUid(DatabaseHandler databaseHandler,  String uid) {
    //     OpportunityTeam dataItem = null;
    //     try {

    //         String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " D ON A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITYTEAM_UID + " = '" + uid + "'";
    //         //selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         //selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));


    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordByUid()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

    //  static OpportunityTeam GetMasterOpportunityTeamRecord(DatabaseHandler databaseHandler,  String id) {
    //     OpportunityTeam dataItem = null;
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A.* " + ",D." + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_OPPORTUNITY + " D ON A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID + " = " + id;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYNAME)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetMasterOpportunityTeamRecord()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

    //  static long AddOpportunityTeamRecord(DatabaseHandler databaseHandler,  OpportunityTeam dataItem) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         ContentValues values = new ContentValues();
    //         if (dataItem.getOpportunityTeamID() != null && !dataItem.getOpportunityTeamID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID, dataItem.getOpportunityTeamID());
    //         if (dataItem.getOpportunityTeamCode() != null && !dataItem.getOpportunityTeamCode().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE, dataItem.getOpportunityTeamCode());
    //         if (dataItem.getOpportunityID() != null && !dataItem.getOpportunityID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID, dataItem.getOpportunityID());
    //         if (dataItem.getOpportunityTeamAppUserID() != null && !dataItem.getOpportunityTeamAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID, dataItem.getOpportunityTeamAppUserID());
    //         if (dataItem.getDescription() != null && !dataItem.getDescription().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION, dataItem.getDescription());
    //         if (dataItem.getAppUserName() != null && !dataItem.getAppUserName().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME, dataItem.getAppUserName());
    //         if (dataItem.getDesignation() != null && !dataItem.getDesignation().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION, dataItem.getDesignation());
    //         if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY, dataItem.getCreatedBy());
    //         if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON, dataItem.getCreatedOn());
    //         if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY, dataItem.getModifiedBy());
    //         if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON, dataItem.getModifiedOn());
    //         if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE, dataItem.getIsActive());
    //         if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_UID, dataItem.getUid());
    //         if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID, dataItem.getAppUserGroupID());
    //         if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID, dataItem.getAppUserID());
    //         if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED, dataItem.getIsArchived());
    //         if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED, dataItem.getIsDeleted());
    //         if (dataItem.getId() != null && !dataItem.getId().equals("null"))
    //             values.put(ColumnsBase.KEY_ID, dataItem.getId());
    //         if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
    //             values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
    //         if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
    //             values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
    //         if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
    //             values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
    //         if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
    //             values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
    //         if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
    //         if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
    //         if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
    //             values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
    //         if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
    //             values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
    //         if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
    //         values.put(ColumnsBase.KEY_UPSYNCINDEX, 0);
    //         values.put(ColumnsBase.KEY_ISACTIVE, "true");
    //         values.put(ColumnsBase.KEY_ISDELETED, "false");

    //         id = db.insert(TablesBase.TABLE_OPPORTUNITYTEAM, null, values);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "DatabaseHandler:AddOpportunityTeamRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static long UpdateOpportunityTeamRecord(DatabaseHandler databaseHandler,  String id1, OpportunityTeam dataItem) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         ContentValues values = new ContentValues();
    //         if (dataItem.getOpportunityTeamID() != null && !dataItem.getOpportunityTeamID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID, dataItem.getOpportunityTeamID());
    //         if (dataItem.getOpportunityTeamCode() != null && !dataItem.getOpportunityTeamCode().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE, dataItem.getOpportunityTeamCode());
    //         if (dataItem.getOpportunityID() != null && !dataItem.getOpportunityID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID, dataItem.getOpportunityID());
    //         if (dataItem.getOpportunityTeamAppUserID() != null && !dataItem.getOpportunityTeamAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID, dataItem.getOpportunityTeamAppUserID());
    //         if (dataItem.getDescription() != null && !dataItem.getDescription().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION, dataItem.getDescription());
    //         if (dataItem.getAppUserName() != null && !dataItem.getAppUserName().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME, dataItem.getAppUserName());
    //         if (dataItem.getDesignation() != null && !dataItem.getDesignation().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION, dataItem.getDesignation());
    //         if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY, dataItem.getCreatedBy());
    //         if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON, dataItem.getCreatedOn());
    //         if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY, dataItem.getModifiedBy());
    //         if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON, dataItem.getModifiedOn());
    //         if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE, dataItem.getIsActive());
    //         if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_UID, dataItem.getUid());
    //         if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID, dataItem.getAppUserGroupID());
    //         if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID, dataItem.getAppUserID());
    //         if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED, dataItem.getIsArchived());
    //         if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
    //             values.put(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED, dataItem.getIsDeleted());
    //         if (dataItem.getId() != null && !dataItem.getId().equals("null"))
    //             values.put(ColumnsBase.KEY_ID, dataItem.getId());
    //         if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
    //             values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
    //         if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
    //             values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
    //         if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
    //             values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
    //         if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
    //             values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
    //         if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
    //         if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
    //         if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
    //             values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
    //         if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
    //             values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
    //         if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
    //         if (dataItem.getUpSyncIndex() != null && !dataItem.getUpSyncIndex().equals("null"))
    //             values.put(ColumnsBase.KEY_UPSYNCINDEX, dataItem.getUpSyncIndex());

    //         id = db.update(TablesBase.TABLE_OPPORTUNITYTEAM, values, ColumnsBase.KEY_ID + " = " + id1, null);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "DatabaseHandler:UpdateOpportunityTeamRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static long DeleteOpportunityTeamRecord(DatabaseHandler databaseHandler,  String id1) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         id = db.delete(TablesBase.TABLE_OPPORTUNITYTEAM, ColumnsBase.KEY_ID + " = " + id1, null);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "DatabaseHandler:DeleteOpportunityTeamRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static String GetServerId(DatabaseHandler databaseHandler,  String id) {
    //     String serverId = "-1";
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             serverId = cursor.getString(0);
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetServerId()", ex);
    //         throw ex;
    //     }
    //     return serverId;
    // }

    //  static String GetLocalId(DatabaseHandler databaseHandler,  String id) {
    //     String localId = "";
    //     try {

    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
    //         selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID + " = " + id;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             localId = cursor.getString(0);
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetLocalId()", ex);
    //         throw ex;
    //     }
    //     return localId;
    // }

    //  static List<OpportunityTeam> GetOpportunityTeamUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) {
    //     List<OpportunityTeam> dataList = new ArrayList<OpportunityTeam>();
    //     try {
    //         String selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
    //             selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND "  + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         }
    //     /*    if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
    //             selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
    //             selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYTEAM + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         }*/
    //         selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
    //         selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " IN (SELECT  " + ColumnsBase.KEY_ID + " FROM " + TablesBase.TABLE_OPPORTUNITY + " WHERE coalesce(" + ColumnsBase.KEY_OPPORTUNITY_OPPORTUNITYID + ",'') <> '')";

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 OpportunityTeam dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

    //                 dataList.add(dataItem);
    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.Handle( "OpportunityTeamDataHandlerBase:GetOpportunityTeamUpSyncRecords()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }


}
