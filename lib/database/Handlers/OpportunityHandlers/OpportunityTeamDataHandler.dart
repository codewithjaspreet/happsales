

 import 'OpportunityTeamDataHandlerBase.dart';

class OpportunityTeamDataHandler extends OpportunityTeamDataHandlerBase {

    // public static List<OpportunityTeam> GetOpportunityTeamRecordsByOpportunityId(DatabaseHandler databaseHandler, Context context, String opportunityId) {
    //     List<OpportunityTeam> dataList = new ArrayList<OpportunityTeam>();
    //     try {
    //         String selectQuery = "SELECT A.* " + ",D." + Columns.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + Tables.TABLE_OPPORTUNITY + " D ON A." + Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + Columns.KEY_ID;
    //         selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
    //         selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTEAM_ISDELETED + ",'false')) = 'false' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTEAM_ISACTIVE + ",'true')) = 'true' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + Columns.KEY_OPPORTUNITYTEAM_ISARCHIVED + ",'false')) = 'false' ";
    //         selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = " + opportunityId;
    //         selectQuery += " ORDER BY A." + Columns.KEY_OPPORTUNITYTEAM_APPUSERNAME + " COLLATE NOCASE ASC ";

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 OpportunityTeam dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITY_OPPORTUNITYNAME)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

    //                 dataList.add(dataItem);
    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch (Exception ex) {
    //         Globals.HandleException(context, "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordsByOpportunityId()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }


    // public static List<OpportunityTeam> GetOpportunityTeamRecordsAllByOpportunityId(DatabaseHandler databaseHandler, Context context, String opportunityId) {
    //     List<OpportunityTeam> dataList = new ArrayList<OpportunityTeam>();
    //     try {
    //         String selectQuery = "SELECT A.* " + ",D." + Columns.KEY_OPPORTUNITY_OPPORTUNITYNAME;
    //         selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTEAM + " A ";
    //         selectQuery += " LEFT JOIN " + Tables.TABLE_OPPORTUNITY + " D ON A." + Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = D." + Columns.KEY_ID;
    //         selectQuery += " WHERE A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTEAM_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
    //         selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID + " = " + opportunityId;
    //         selectQuery += " ORDER BY A." + Columns.KEY_OPPORTUNITYTEAM_APPUSERNAME + " COLLATE NOCASE ASC ";

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 OpportunityTeam dataItem = new OpportunityTeam();
    //                 dataItem.setOpportunityTeamID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMID)));
    //                 dataItem.setOpportunityTeamCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMCODE)));
    //                 dataItem.setOpportunityID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYID)));
    //                 dataItem.setOpportunityTeamAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_OPPORTUNITYTEAMAPPUSERID)));
    //                 dataItem.setDescription(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_DESCRIPTION)));
    //                 dataItem.setAppUserName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERNAME)));
    //                 dataItem.setDesignation(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_DESIGNATION)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_UID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERGROUPID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_APPUSERID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTEAM_ISDELETED)));

    //                 dataItem.setOpportunityName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITY_OPPORTUNITYNAME)));

    //                 dataItem.setId(cursor.getString(cursor.getColumnIndex(Columns.KEY_ID)));
    //                 dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDIRTY)));
    //                 dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(Columns.KEY_ISDELETED)));
    //                 dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_UPSYNCMESSAGE)));
    //                 dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(Columns.KEY_DOWNSYNCMESSAGE)));
    //                 dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SCREATEDON)));
    //                 dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_SMODIFIEDON)));
    //                 dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_CREATEDBYUSER)));
    //                 dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(Columns.KEY_MODIFIEDBYUSER)));
    //                 dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OWNERUSERID)));

    //                 dataList.add(dataItem);
    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch (Exception ex) {
    //         Globals.HandleException(context, "OpportunityTeamDataHandlerBase:GetOpportunityTeamRecordsByOpportunityId()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }

    /*-------------------HAPPSALES-------------------*/

}