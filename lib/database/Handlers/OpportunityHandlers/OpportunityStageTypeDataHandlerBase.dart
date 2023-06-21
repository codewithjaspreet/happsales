

//  import '../DataBaseHandler.dart';

class OpportunityStageTypeDataHandlerBase {

//      static List<OpportunityStageType> GetOpportunityStageTypeRecordsPaged(DatabaseHandler databaseHandler, Context  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
//         List<OpportunityStageType> dataList = new ArrayList<OpportunityStageType>();
//         try {
//             int startRowIndex = ((pageIndex - 1) * pageSize);

//             String selectQuery = "SELECT A.* ";
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
//             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
//             selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED + ",'false')) = 'false' ";
//             selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE + ",'true')) = 'true' ";
//             if (searchString.trim().length() > 0)
//                 selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE + " LIKE '%" + searchString + "%'";

//             /* FILTER */
// 			/*String groups = "";
// 			String tags = "";
// 			String groupitem = "";
// 			for (Map.Entry<String, String> entry : filterHashMap.entrySet()) {
// 				String key1 = entry.getKey();
// 				String value1 = entry.getValue();
// 				if (entry.getKey().equals("XXXXX")) {
// 					groupitem = value1;
// 				} else {
// 					groups += (groups.equals("") ? "'" + key1 + "'" : ",'" + key1 + "'");
// 					tags += (tags.equals("") ? value1 : "," + value1);
// 				}
// 			}
// 			if (groupitem.trim().length() > 0)
// 				selectQuery += " AND A." + ColumnsBase.KEY_OpportunityStageType_ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE + " IN(" + groupitem.trim() + ")";
// 			if (groups.trim().length() > 0)
// 				selectQuery += " AND TG." + ColumnsBase.KEY_TAGGROUP_TAGGROUPNAME + " IN(" + groups.trim() + ")";
// 			if (tags.trim().length() > 0)
// 				selectQuery += " AND T." + ColumnsBase.KEY_TAG_TAGNAME + " IN(" + tags.trim() + ")";*/

//             selectQuery += " ORDER BY A." + sortColumn + " COLLATE NOCASE " + sortDirection;
//             selectQuery += " LIMIT " + startRowIndex + "," + pageSize;


//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     OpportunityStageType dataItem = new OpportunityStageType();
//                     dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
//                     dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
//                     dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
//                     dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
//                     dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
//                     dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
//                     dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
//                     dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
//                     dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
//                     dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
//                     dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
//                     dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
//                     dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
//                     dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));


//                     dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
//                     dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
//                     dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
//                     dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
//                     dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
//                     dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
//                     dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
//                     dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
//                     dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
//                     dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

//                     dataList.add(dataItem);
//                 } while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetOpportunityStageTypeRecordsPaged()", ex);
//             throw ex;
//         }
//         return dataList;
//     }

//      static List<OpportunityStageType> GetOpportunityStageTypeRecords(DatabaseHandler databaseHandler, Context  String searchString) {
//         List<OpportunityStageType> dataList = new ArrayList<OpportunityStageType>();
//         try {
//             String selectQuery = "SELECT A.* ";
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
//             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;
//             selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED + ",'false')) = 'false' ";
//             selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE + ",'true')) = 'true' ";
//             if (searchString.trim().length() > 0)
//                 selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE + " LIKE '" + searchString + "%'";
//             selectQuery += " ORDER BY A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE + " COLLATE NOCASE ASC ";

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     OpportunityStageType dataItem = new OpportunityStageType();
//                     dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
//                     dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
//                     dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
//                     dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
//                     dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
//                     dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
//                     dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
//                     dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
//                     dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
//                     dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
//                     dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
//                     dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
//                     dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
//                     dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));


//                     dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
//                     dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
//                     dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
//                     dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
//                     dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
//                     dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
//                     dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
//                     dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
//                     dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
//                     dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

//                     dataList.add(dataItem);
//                 } while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetOpportunityStageTypeRecords()", ex);
//             throw ex;
//         }
//         return dataList;
//     }

//      static OpportunityStageType GetOpportunityStageTypeRecord(DatabaseHandler databaseHandler, Context  String id) {
//         OpportunityStageType dataItem = null;
//         try {
//             id = Globals.TryParseLongForDBId(id);

//             String selectQuery = "SELECT A.* ";
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
//             selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
//             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     dataItem = new OpportunityStageType();
//                     dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
//                     dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
//                     dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
//                     dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
//                     dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
//                     dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
//                     dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
//                     dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
//                     dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
//                     dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
//                     dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
//                     dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
//                     dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
//                     dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));


//                     dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
//                     dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
//                     dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
//                     dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
//                     dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
//                     dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
//                     dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
//                     dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
//                     dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
//                     dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

//                 } while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetOpportunityStageTypeRecord()", ex);
//             throw ex;
//         }
//         return dataItem;
//     }

//      static OpportunityStageType GetMasterOpportunityStageTypeRecord(DatabaseHandler databaseHandler, Context  String id) {
//         OpportunityStageType dataItem = null;
//         try {
//             id = Globals.TryParseLongForDBId(id);

//             String selectQuery = "SELECT A.* ";
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID + " = " + id;
//             selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
//             selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     dataItem = new OpportunityStageType();
//                     dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
//                     dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
//                     dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
//                     dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
//                     dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
//                     dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
//                     dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
//                     dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
//                     dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
//                     dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
//                     dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
//                     dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
//                     dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
//                     dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));


//                     dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
//                     dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
//                     dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
//                     dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
//                     dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
//                     dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
//                     dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
//                     dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
//                     dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
//                     dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

//                 } while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetMasterOpportunityStageTypeRecord()", ex);
//             throw ex;
//         }
//         return dataItem;
//     }

//      static long AddOpportunityStageTypeRecord(DatabaseHandler databaseHandler, Context  OpportunityStageType dataItem) {
//         long id = 0;
//         try {
//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             ContentValues values = new ContentValues();
//             if (dataItem.getOpportunityStageTypeID() != null && !dataItem.getOpportunityStageTypeID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID, dataItem.getOpportunityStageTypeID());
//             if (dataItem.getOpportunityStageTypeCode() != null && !dataItem.getOpportunityStageTypeCode().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE, dataItem.getOpportunityStageTypeCode());
//             if (dataItem.getOpportunityStageID() != null && !dataItem.getOpportunityStageID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID, dataItem.getOpportunityStageID());
//             if (dataItem.getOpportunityTypeID() != null && !dataItem.getOpportunityTypeID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID, dataItem.getOpportunityTypeID());
//             if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY, dataItem.getCreatedBy());
//             if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON, dataItem.getCreatedOn());
//             if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY, dataItem.getModifiedBy());
//             if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON, dataItem.getModifiedOn());
//             if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE, dataItem.getIsActive());
//             if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID, dataItem.getUid());
//             if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID, dataItem.getAppUserID());
//             if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID, dataItem.getAppUserGroupID());
//             if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED, dataItem.getIsArchived());
//             if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED, dataItem.getIsDeleted());
//             if (dataItem.getId() != null && !dataItem.getId().equals("null"))
//                 values.put(ColumnsBase.KEY_ID, dataItem.getId());
//             if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
//                 values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
//             if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
//                 values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
//             if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
//                 values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
//             if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
//                 values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
//             if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
//             if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
//             if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
//                 values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
//             if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
//                 values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
//             if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
//                 values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
//             values.put(ColumnsBase.KEY_UPSYNCINDEX, 0);
//             values.put(ColumnsBase.KEY_ISACTIVE, "true");
//             values.put(ColumnsBase.KEY_ISDELETED, "false");

//             id = db.insert(TablesBase.TABLE_OPPORTUNITYSTAGETYPE, null, values);
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "DatabaseHandler:AddOpportunityStageTypeRecord()", ex);
//             throw ex;
//         }
//         return id;
//     }

//      static long UpdateOpportunityStageTypeRecord(DatabaseHandler databaseHandler, Context  String id1, OpportunityStageType dataItem) {
//         long id = 0;
//         try {
//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             ContentValues values = new ContentValues();
//             if (dataItem.getOpportunityStageTypeID() != null && !dataItem.getOpportunityStageTypeID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID, dataItem.getOpportunityStageTypeID());
//             if (dataItem.getOpportunityStageTypeCode() != null && !dataItem.getOpportunityStageTypeCode().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE, dataItem.getOpportunityStageTypeCode());
//             if (dataItem.getOpportunityStageID() != null && !dataItem.getOpportunityStageID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID, dataItem.getOpportunityStageID());
//             if (dataItem.getOpportunityTypeID() != null && !dataItem.getOpportunityTypeID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID, dataItem.getOpportunityTypeID());
//             if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY, dataItem.getCreatedBy());
//             if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON, dataItem.getCreatedOn());
//             if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY, dataItem.getModifiedBy());
//             if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON, dataItem.getModifiedOn());
//             if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE, dataItem.getIsActive());
//             if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID, dataItem.getUid());
//             if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID, dataItem.getAppUserID());
//             if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID, dataItem.getAppUserGroupID());
//             if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED, dataItem.getIsArchived());
//             if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
//                 values.put(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED, dataItem.getIsDeleted());
//             if (dataItem.getId() != null && !dataItem.getId().equals("null"))
//                 values.put(ColumnsBase.KEY_ID, dataItem.getId());
//             if (dataItem.getIsDirty() != null && !dataItem.getIsDirty().equals("null"))
//                 values.put(ColumnsBase.KEY_ISDIRTY, dataItem.getIsDirty());
//             if (dataItem.getIsDeleted1() != null && !dataItem.getIsDeleted1().equals("null"))
//                 values.put(ColumnsBase.KEY_ISDELETED, dataItem.getIsDeleted1());
//             if (dataItem.getUpSyncMessage() != null && !dataItem.getUpSyncMessage().equals("null"))
//                 values.put(ColumnsBase.KEY_UPSYNCMESSAGE, dataItem.getUpSyncMessage());
//             if (dataItem.getDownSyncMessage() != null && !dataItem.getDownSyncMessage().equals("null"))
//                 values.put(ColumnsBase.KEY_DOWNSYNCMESSAGE, dataItem.getDownSyncMessage());
//             if (dataItem.getSCreatedOn() != null && !dataItem.getSCreatedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_SCREATEDON, dataItem.getSCreatedOn());
//             if (dataItem.getSModifiedOn() != null && !dataItem.getSModifiedOn().equals("null"))
//                 values.put(ColumnsBase.KEY_SMODIFIEDON, dataItem.getSModifiedOn());
//             if (dataItem.getCreatedByUser() != null && !dataItem.getCreatedByUser().equals("null"))
//                 values.put(ColumnsBase.KEY_CREATEDBYUSER, dataItem.getCreatedByUser());
//             if (dataItem.getModifiedByUser() != null && !dataItem.getModifiedByUser().equals("null"))
//                 values.put(ColumnsBase.KEY_MODIFIEDBYUSER, dataItem.getModifiedByUser());
//             if (dataItem.getOwnerUserID() != null && !dataItem.getOwnerUserID().equals("null"))
//                 values.put(ColumnsBase.KEY_OWNERUSERID, dataItem.getOwnerUserID());
//             if (dataItem.getUpSyncIndex() != null && !dataItem.getUpSyncIndex().equals("null"))
//                 values.put(ColumnsBase.KEY_UPSYNCINDEX, dataItem.getUpSyncIndex());

//             id = db.update(TablesBase.TABLE_OPPORTUNITYSTAGETYPE, values, ColumnsBase.KEY_ID + " = " + id1, null);
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "DatabaseHandler:UpdateOpportunityStageTypeRecord()", ex);
//             throw ex;
//         }
//         return id;
//     }

//      static long DeleteOpportunityStageTypeRecord(DatabaseHandler databaseHandler, Context  String id1) {
//         long id = 0;
//         try {
//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             id = db.delete(TablesBase.TABLE_OPPORTUNITYSTAGETYPE, ColumnsBase.KEY_ID + " = " + id1, null);
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "DatabaseHandler:DeleteOpportunityStageTypeRecord()", ex);
//             throw ex;
//         }
//         return id;
//     }

//      static String GetServerId(DatabaseHandler databaseHandler, Context  String id) {
//         String serverId = "-1";
//         try {
//             id = Globals.TryParseLongForDBId(id);

//             String selectQuery = "SELECT A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID;
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 serverId = cursor.getString(0);
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetServerId()", ex);
//             throw ex;
//         }
//         return serverId;
//     }

//      static String GetLocalId(DatabaseHandler databaseHandler, Context  String id) {
//         String localId = "";
//         try {

//             id = Globals.TryParseLongForDBId(id);

//             String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
//             selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A ";
//             selectQuery += " WHERE A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID + " = " + id;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 localId = cursor.getString(0);
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetLocalId()", ex);
//             throw ex;
//         }
//         return localId;
//     }

//      static List<OpportunityStageType> GetOpportunityStageTypeUpSyncRecords(DatabaseHandler databaseHandler, Context  String changeType) {
//         List<OpportunityStageType> dataList = new ArrayList<OpportunityStageType>();
//         try {
//             String selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
//             if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
//                 selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
//             } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
//                 selectQuery = "SELECT * FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
//             }
//             selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
//             selectQuery += " AND " + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     OpportunityStageType dataItem = new OpportunityStageType();
//                     dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
//                     dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
//                     dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
//                     dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
//                     dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
//                     dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
//                     dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
//                     dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
//                     dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
//                     dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
//                     dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
//                     dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
//                     dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
//                     dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));

//                     dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
//                     dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
//                     dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
//                     dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));
//                     dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
//                     dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
//                     dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
//                     dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
//                     dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
//                     dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));

//                     dataList.add(dataItem);
//                 } while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         } catch ( ex) {
//             Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetOpportunityStageTypeUpSyncRecords()", ex);
//             throw ex;
//         }
//         return dataList;
//     }


// 	  static OpportunityStageType GetOpportunityStageTypeRecordByUid(DatabaseHandler databaseHandler, Context  String uid) {
//         OpportunityStageType dataItem = null;
//         try
//         {

// 			String selectQuery = 	"SELECT A.* " ;
// 		selectQuery += " FROM " + TablesBase.TABLE_OPPORTUNITYSTAGETYPE + " A "; 
// 			selectQuery += " WHERE A."  + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID + " = '" + uid + "'";
// 			//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID;
// 			//selectQuery += " AND A." + ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID + " = " + Globals.AppUserGroupID;

//             SQLiteDatabase db = databaseHandler.getWritableDatabase();
//             Cursor cursor = db.rawQuery(selectQuery, null);
//             if (cursor.moveToFirst()) {
//                 do {
//                     dataItem = new OpportunityStageType();
// 							dataItem.setOpportunityStageTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPEID)));
// 		dataItem.setOpportunityStageTypeCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGETYPECODE)));
// 		dataItem.setOpportunityStageID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYSTAGEID)));
// 		dataItem.setOpportunityTypeID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_OPPORTUNITYTYPEID)));
// 		dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDBY)));
// 		dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_CREATEDON)));
// 		dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDBY)));
// 		dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_MODIFIEDON)));
// 		dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISACTIVE)));
// 		dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_UID)));
// 		dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERID)));
// 		dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_APPUSERGROUPID)));
// 		dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISARCHIVED)));
// 		dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OPPORTUNITYSTAGETYPE_ISDELETED)));


					
// 					dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
// 					dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
// 					dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
// 					dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));				
// 					dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
// 					dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
// 					dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
// 					dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
// 					dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
// 					dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));
					
// 				} while (cursor.moveToNext());
//             }
//             cursor.close();
//             //db.close();
//         }
//         catch( ex)
//         {
// 	    Globals.Handle( "OpportunityStageTypeDataHandlerBase:GetOpportunityStageTypeRecordByUid()", ex);
//             throw ex;
//         }
//         return dataItem;
//     }

// 	/*-------------------HAPPSALES-------------------*/

}