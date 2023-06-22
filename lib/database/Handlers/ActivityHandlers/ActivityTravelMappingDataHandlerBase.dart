

 class ActivityTravelMappingDataHandlerBase {

    //  static List<ActivityTravelMapping> GetActivityTravelMappingRecordsPaged(DatabaseHandler databaseHandler,  String searchString, String sortColumn, String sortDirection, Map<String, String> filterHashMap, int pageIndex, int pageSize) {
    //     List<ActivityTravelMapping> dataList = new ArrayList<ActivityTravelMapping>();
    //     try {
    //         int startRowIndex = ((pageIndex - 1) * pageSize);

    //         String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYTRAVEL + " C ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID + " = C." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED + ",'false')) = 'false' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE + ",'true')) = 'true' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED + ",'false')) = 'false' ";
    //         if (searchString.trim().length() > 0)
    //             selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE + " LIKE '%" + searchString + "%'";

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
		// 		selectQuery += " AND A." + ColumnsBase.KEY_ActivityTravelMapping_Columns.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE + " IN(" + groupitem.trim() + ")";
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
    //                 ActivityTravelMapping dataItem = new ActivityTravelMapping();
    //                 dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
    //                 dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
    //                 dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
    //                 dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

    //                 dataItem.setActivityTravelTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE)));
    //                 dataItem.setActivityTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE)));

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
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetActivityTravelMappingRecordsPaged()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }

    //  static List<ActivityTravelMapping> GetActivityTravelMappingRecords(DatabaseHandler databaseHandler,  String searchString) {
    //     List<ActivityTravelMapping> dataList = new ArrayList<ActivityTravelMapping>();
    //     try {
    //         String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYTRAVEL + " C ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID + " = C." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISDELETED + ",'false')) = 'false' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED + ",'false')) = 'false' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ISACTIVE + ",'true')) = 'true' AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE + ",'true')) = 'true' ";
    //         selectQuery += " AND LOWER(IFNULL(A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED + ",'false')) = 'false' ";
    //         if (searchString.trim().length() > 0)
    //             selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE + " LIKE '" + searchString + "%'";
    //         selectQuery += " ORDER BY A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE + " COLLATE NOCASE ASC ";

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 ActivityTravelMapping dataItem = new ActivityTravelMapping();
    //                 dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
    //                 dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
    //                 dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
    //                 dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

    //                 dataItem.setActivityTravelTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE)));
    //                 dataItem.setActivityTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE)));

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
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetActivityTravelMappingRecords()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }

    //  static ActivityTravelMapping GetActivityTravelMappingRecord(DatabaseHandler databaseHandler,  String id) {
    //     ActivityTravelMapping dataItem = null;
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYTRAVEL + " C ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID + " = C." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new ActivityTravelMapping();
    //                 dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
    //                 dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
    //                 dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
    //                 dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

    //                 dataItem.setActivityTravelTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE)));
    //                 dataItem.setActivityTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE)));


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
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetActivityTravelMappingRecord()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

    //  static ActivityTravelMapping GetMasterActivityTravelMappingRecord(DatabaseHandler databaseHandler,  String id) {
    //     ActivityTravelMapping dataItem = null;
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A.* " + ",C." + ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
    //         selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYTRAVEL + " C ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID + " = C." + ColumnsBase.KEY_ID;
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID + " = " + id;
    //         selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new ActivityTravelMapping();
    //                 dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
    //                 dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
    //                 dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
    //                 dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

    //                 dataItem.setActivityTravelTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE)));
    //                 dataItem.setActivityTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE)));

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
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetMasterActivityTravelMappingRecord()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

    //  static long AddActivityTravelMappingRecord(DatabaseHandler databaseHandler,  ActivityTravelMapping dataItem) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         ContentValues values = new ContentValues();
    //         if (dataItem.getActivityTravelMappingID() != null && !dataItem.getActivityTravelMappingID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID, dataItem.getActivityTravelMappingID());
    //         if (dataItem.getActivityTravelMappingCode() != null && !dataItem.getActivityTravelMappingCode().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE, dataItem.getActivityTravelMappingCode());
    //         if (dataItem.getActivityTravelID() != null && !dataItem.getActivityTravelID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID, dataItem.getActivityTravelID());
    //         if (dataItem.getActivityID() != null && !dataItem.getActivityID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID, dataItem.getActivityID());
    //         if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY, dataItem.getCreatedBy());
    //         if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON, dataItem.getCreatedOn());
    //         if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY, dataItem.getModifiedBy());
    //         if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON, dataItem.getModifiedOn());
    //         if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE, dataItem.getIsActive());
    //         if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID, dataItem.getUid());
    //         if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID, dataItem.getAppUserID());
    //         if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID, dataItem.getAppUserGroupID());
    //         if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED, dataItem.getIsArchived());
    //         if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED, dataItem.getIsDeleted());
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

    //         id = db.insert(TablesBase.TABLE_ACTIVITYTRAVELMAPPING, null, values);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.HandleException( "DatabaseHandler:AddActivityTravelMappingRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static long UpdateActivityTravelMappingRecord(DatabaseHandler databaseHandler,  String id1, ActivityTravelMapping dataItem) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         ContentValues values = new ContentValues();
    //         if (dataItem.getActivityTravelMappingID() != null && !dataItem.getActivityTravelMappingID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID, dataItem.getActivityTravelMappingID());
    //         if (dataItem.getActivityTravelMappingCode() != null && !dataItem.getActivityTravelMappingCode().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE, dataItem.getActivityTravelMappingCode());
    //         if (dataItem.getActivityTravelID() != null && !dataItem.getActivityTravelID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID, dataItem.getActivityTravelID());
    //         if (dataItem.getActivityID() != null && !dataItem.getActivityID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID, dataItem.getActivityID());
    //         if (dataItem.getCreatedBy() != null && !dataItem.getCreatedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY, dataItem.getCreatedBy());
    //         if (dataItem.getCreatedOn() != null && !dataItem.getCreatedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON, dataItem.getCreatedOn());
    //         if (dataItem.getModifiedBy() != null && !dataItem.getModifiedBy().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY, dataItem.getModifiedBy());
    //         if (dataItem.getModifiedOn() != null && !dataItem.getModifiedOn().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON, dataItem.getModifiedOn());
    //         if (dataItem.getIsActive() != null && !dataItem.getIsActive().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE, dataItem.getIsActive());
    //         if (dataItem.getUid() != null && !dataItem.getUid().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID, dataItem.getUid());
    //         if (dataItem.getAppUserID() != null && !dataItem.getAppUserID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID, dataItem.getAppUserID());
    //         if (dataItem.getAppUserGroupID() != null && !dataItem.getAppUserGroupID().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID, dataItem.getAppUserGroupID());
    //         if (dataItem.getIsArchived() != null && !dataItem.getIsArchived().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED, dataItem.getIsArchived());
    //         if (dataItem.getIsDeleted() != null && !dataItem.getIsDeleted().equals("null"))
    //             values.put(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED, dataItem.getIsDeleted());
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

    //         id = db.update(TablesBase.TABLE_ACTIVITYTRAVELMAPPING, values, ColumnsBase.KEY_ID + " = " + id1, null);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.HandleException( "DatabaseHandler:UpdateActivityTravelMappingRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static long DeleteActivityTravelMappingRecord(DatabaseHandler databaseHandler,  String id1) {
    //     long id = 0;
    //     try {
    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         id = db.delete(TablesBase.TABLE_ACTIVITYTRAVELMAPPING, ColumnsBase.KEY_ID + " = " + id1, null);
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.HandleException( "DatabaseHandler:DeleteActivityTravelMappingRecord()", ex);
    //         throw ex;
    //     }
    //     return id;
    // }

    //  static String GetServerId(DatabaseHandler databaseHandler,  String id) {
    //     String serverId = "-1";
    //     try {
    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ID + " = " + id;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             serverId = cursor.getString(0);
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetServerId()", ex);
    //         throw ex;
    //     }
    //     return serverId;
    // }

    //  static String GetLocalId(DatabaseHandler databaseHandler,  String id) {
    //     String localId = "";
    //     try {

    //         id = Globals.TryParseLongForDBId(id);

    //         String selectQuery = "SELECT A." + ColumnsBase.KEY_ID;
    //         selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A ";
    //         selectQuery += " WHERE A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID + " = " + id;

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             localId = cursor.getString(0);
    //         }
    //         cursor.close();
    //         //db.close();
    //     } catch ( ex) {
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetLocalId()", ex);
    //         throw ex;
    //     }
    //     return localId;
    // }

    //  static List<ActivityTravelMapping> GetActivityTravelMappingUpSyncRecords(DatabaseHandler databaseHandler,  String changeType) {
    //     List<ActivityTravelMapping> dataList = new ArrayList<ActivityTravelMapping>();
    //     try {
    //         String selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         if (changeType.equals(AppConstant.DB_RECORD_NEW_OR_MODIFIED)) {
    //             selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'false' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         } else if (changeType.equals(AppConstant.DB_RECORD_DELETED)) {
    //             selectQuery = "SELECT * FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " WHERE " + ColumnsBase.KEY_ISDIRTY + " = 'true' AND " + ColumnsBase.KEY_ISDELETED + " = 'true' " + " AND " + ColumnsBase.KEY_UPSYNCINDEX + " < " + Globals.SyncIndex;
    //         }
    //         selectQuery += " AND " + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
    //         selectQuery += " AND " + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 ActivityTravelMapping dataItem = new ActivityTravelMapping();
    //                 dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
    //                 dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
    //                 dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
    //                 dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
    //                 dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
    //                 dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
    //                 dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
    //                 dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
    //                 dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
    //                 dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
    //                 dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
    //                 dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
    //                 dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
    //                 dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

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
    //         Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetActivityTravelMappingUpSyncRecords()", ex);
    //         throw ex;
    //     }
    //     return dataList;
    // }


	  // static ActivityTravelMapping GetActivityTravelMappingRecordByUid(DatabaseHandler databaseHandler,  String uid) {
    //     ActivityTravelMapping dataItem = null;
    //     try
    //     {

		// 	String selectQuery = 	"SELECT A.* "  + ",C." + ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE + ",B." + ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE;
		// selectQuery += " FROM " + TablesBase.TABLE_ACTIVITYTRAVELMAPPING + " A "; 
		// selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITY + " B ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID + " = B." + ColumnsBase.KEY_ID;
		// selectQuery += " LEFT JOIN " + TablesBase.TABLE_ACTIVITYTRAVEL + " C ON A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID + " = C." + ColumnsBase.KEY_ID;
		// 	selectQuery += " WHERE A."  + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID + " = '" + uid + "'";
		// 	//selectQuery += " AND A." + ColumnsBase.KEY_OWNERUSERID + " = " + Globals.AppUserID.toString();
		// 	//selectQuery += " AND A." + ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID + " = " + Globals.AppUserGroupID.toString();

    //         SQLiteDatabase db = databaseHandler.getWritableDatabase();
    //         Cursor cursor = db.rawQuery(selectQuery, null);
    //         if (cursor.moveToFirst()) {
    //             do {
    //                 dataItem = new ActivityTravelMapping();
		// 					dataItem.setActivityTravelMappingID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGID)));
		// dataItem.setActivityTravelMappingCode(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELMAPPINGCODE)));
		// dataItem.setActivityTravelID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYTRAVELID)));
		// dataItem.setActivityID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ACTIVITYID)));
		// dataItem.setCreatedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDBY)));
		// dataItem.setCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_CREATEDON)));
		// dataItem.setModifiedBy(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDBY)));
		// dataItem.setModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_MODIFIEDON)));
		// dataItem.setIsActive(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISACTIVE)));
		// dataItem.setUid(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_UID)));
		// dataItem.setAppUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERID)));
		// dataItem.setAppUserGroupID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_APPUSERGROUPID)));
		// dataItem.setIsArchived(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISARCHIVED)));
		// dataItem.setIsDeleted(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVELMAPPING_ISDELETED)));

		// dataItem.setActivityTravelTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITYTRAVEL_ACTIVITYTRAVELTITLE)));
		// dataItem.setActivityTitle(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ACTIVITY_ACTIVITYTITLE)));

					
		// 			dataItem.setId(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ID)));
		// 			dataItem.setIsDirty(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDIRTY)));
		// 			dataItem.setIsDeleted1(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_ISDELETED)));
		// 			dataItem.setUpSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_UPSYNCMESSAGE)));				
		// 			dataItem.setDownSyncMessage(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_DOWNSYNCMESSAGE)));
		// 			dataItem.setSCreatedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SCREATEDON)));
		// 			dataItem.setSModifiedOn(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_SMODIFIEDON)));
		// 			dataItem.setCreatedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_CREATEDBYUSER)));
		// 			dataItem.setModifiedByUser(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_MODIFIEDBYUSER)));
		// 			dataItem.setOwnerUserID(cursor.getString(cursor.getColumnIndex(ColumnsBase.KEY_OWNERUSERID)));
					
		// 		} while (cursor.moveToNext());
    //         }
    //         cursor.close();
    //         //db.close();
    //     }
    //     catch( ex)
    //     {
	  //   Globals.HandleException( "ActivityTravelMappingDataHandlerBase:GetActivityTravelMappingRecordByUid()", ex);
    //         throw ex;
    //     }
    //     return dataItem;
    // }

	/*-------------------HAPPSALES-------------------*/

}