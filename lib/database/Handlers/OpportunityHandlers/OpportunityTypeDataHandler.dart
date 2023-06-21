
 import 'OpportunityTypeDataHandlerBase.dart';

class OpportunityTypeDataHandler extends OpportunityTypeDataHandlerBase {

    // public static OpportunityType GetDefaultOpportunityType(DatabaseHandler databaseHandler, Context context) {
    //     OpportunityType dataItem = null;
    //     try {

    //         String selectQuery = "SELECT A.* ";
    //         selectQuery += " FROM " + Tables.TABLE_OPPORTUNITYTYPE + " A ";
    //         selectQuery += " WHERE COALESCE(A." + Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT + ",'false') = 'true' ";
    //         selectQuery += " AND A." + Columns.KEY_OWNERUSERID + " = " + Globals.AppUserID;
    //         selectQuery += " AND A." + Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new OpportunityType();
    //                 dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPEID)));
    //                 dataItem.setOpportunityTypeCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPECODE)));
    //                 dataItem.setOpportunityTypeName(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_OPPORTUNITYTYPENAME)));
    //                 dataItem.setInternalCode(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_INTERNALCODE)));
    //                 dataItem.setIsDefault(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDEFAULT)));
    //                 dataItem.setSequentialOrder(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_SEQUENTIALORDER)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDON)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_CREATEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_MODIFIEDBY)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISARCHIVED)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISACTIVE)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(Columns.KEY_OPPORTUNITYTYPE_ISDELETED)));


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

    //             } while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch (Exception ex) {
    //         Globals.HandleException(context, "OpportunityTypeDataHandlerBase:GetOpportunityTypeRecord()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }
	/*-------------------HAPPSALES-------------------*/

}